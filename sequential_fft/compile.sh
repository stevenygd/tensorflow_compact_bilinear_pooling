# TF_INC=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')
# TF_LIB=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_lib())')

TF_INC=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')
TF_LIB=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_lib())')

# TF_CFLAGS=( $(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_compile_flags()))') )
# TF_LFLAGS=( $(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_link_flags()))') )

nvcc -std=c++11 -c -o sequential_batch_fft_kernel.cu.o \
  sequential_batch_fft_kernel.cu.cc \
  -I $TF_INC -I$TF_INC/external/nsync/public -D GOOGLE_CUDA=1 -x cu -Xcompiler -fPIC


# nvcc -std=c++11 -c -o sequential_batch_fft_kernel.cu.o \
#   sequential_batch_fft_kernel.cu.cc \
#   -I $TF_INC -D GOOGLE_CUDA=1 -x cu -Xcompiler -fPIC \
#   -I $TF_INC/external/nsync/public \
#   -L$TF_LIB -ltensorflow_framework

# g++ -std=c++11 -shared -o ./build/sequential_batch_fft.so \
#   sequential_batch_fft_kernel.cu.o \
#   sequential_batch_fft.cc \
#   # -I $TF_INC -fPIC \
#   # -I $TF_INC/external/nsync/public \
#   -lcudart -lcufft -L/usr/local/cuda/lib64 \
#   # -L$TF_LIB -ltensorflow_framework
#   -fPIC  \
#   -I$TF_INC \
#   -I$TF_INC/external/nsync/public \
#   -L$TF_LIB -ltensorflow_framework -O2

# g++ -std=c++11 -shared -o ./build/sequential_batch_fft.so \
#   sequential_batch_fft_kernel.cu.o \
#   sequential_batch_fft.cc \
#   -lcudart -lcufft -L/usr/local/cuda/lib64 \
#   -fPIC  \
#   -I$TF_INC \
#   -I$TF_INC/external/nsync/public \
#   -L$TF_LIB -ltensorflow_framework -O2

g++ -std=c++11 -shared -o ./build/sequential_batch_fft.so \
  sequential_batch_fft_kernel.cu.o \
  sequential_batch_fft.cc \
  -I $TF_INC -I$TF_INC/external/nsync/public -fPIC -L$TF_LIB -ltensorflow_framework \
  -lcudart -lcufft -L/usr/local/cuda/lib64 \



# g++ -std=c++11 -shared -o ./build/sequential_batch_fft.so \
#   sequential_batch_fft_kernel.cu.o \
#   sequential_batch_fft.cc \
#   -fPIC  \
#   ${TF_CFLAGS[@]} \
#   ${TF_LFLAGS[@]} \
#   -O2 \
#   -lcudart -lcufft -L/usr/local/cuda/lib64

rm -rf sequential_batch_fft_kernel.cu.o
