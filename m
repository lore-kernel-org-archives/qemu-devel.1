Received: from eggs.gnu.org ([209.51.188.92]:33945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOh-0004lt-Id
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOf-0008S8-T8
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:39 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:38296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gheOf-0007ky-Ld
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:37 -0500
Received: by mail-wm1-x32e.google.com with SMTP id m22so12976606wml.3
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:45:27 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 10 Jan 2019 17:45:06 +0000
Message-Id: <20190110174516.21586-10-alex.bennee@linaro.org>
In-Reply-To: <20190110174516.21586-1-alex.bennee@linaro.org>
References: <20190110174516.21586-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 09/19] travis: standardize the syntax used
 for env variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ymankad@redhat.com, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Daniel P. Berrangé <berrange@redhat.com>

Matrix entries are defining env variables using two different syntax
styles:

   - env: FOO=bar
          WIZZ=bang

and

   - env:
       - FOO=bar
       - WIZZ=bang

Switch everything to use the latter style as the more normal indentation
approach.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 77 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 96917df9c5..f539f8b556 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -81,102 +81,123 @@ script:
 
 matrix:
   include:
-    - env: CONFIG="--disable-system"
+    - env:
+        - CONFIG="--disable-system"
 
 
-    - env: CONFIG="--disable-user"
+    - env:
+        - CONFIG="--disable-user"
 
 
-    - env: CONFIG="--enable-debug --enable-debug-tcg"
+    - env:
+        - CONFIG="--enable-debug --enable-debug-tcg"
 
 
-    - env: CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-uuid --disable-libusb --disable-user"
+    - env:
+        - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-uuid --disable-libusb --disable-user"
 
 
-    - env: CONFIG="--enable-modules --disable-linux-user"
+    - env:
+        - CONFIG="--enable-modules --disable-linux-user"
 
 
-    - env: CONFIG="--with-coroutine=ucontext --disable-linux-user"
+    - env:
+        - CONFIG="--with-coroutine=ucontext --disable-linux-user"
 
 
-    - env: CONFIG="--with-coroutine=sigaltstack --disable-linux-user"
+    - env:
+        - CONFIG="--with-coroutine=sigaltstack --disable-linux-user"
 
 
     # Test out-of-tree builds
-    - env: CONFIG="--enable-debug --enable-debug-tcg"
-           BUILD_DIR="out-of-tree/build/dir" SRC_DIR="../../.."
+    - env:
+        - CONFIG="--enable-debug --enable-debug-tcg"
+        - BUILD_DIR="out-of-tree/build/dir" SRC_DIR="../../.."
 
 
     # Test with Clang for compile portability (Travis uses clang-5.0)
-    - env: CONFIG="--disable-system"
+    - env:
+        - CONFIG="--disable-system"
       compiler: clang
 
 
-    - env: CONFIG="--disable-user"
+    - env:
+        - CONFIG="--disable-user"
       compiler: clang
 
 
     # gprof/gcov are GCC features
-    - env: CONFIG="--enable-gprof --enable-gcov --disable-pie --target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
+    - env:
+        - CONFIG="--enable-gprof --enable-gcov --disable-pie --target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
       after_success:
         - ${SRC_DIR}/scripts/travis/coverage-summary.sh
       compiler: gcc
 
 
     # We manually include builds which we disable "make check" for
-    - env: CONFIG="--enable-debug --enable-tcg-interpreter"
-           TEST_CMD=""
+    - env:
+        - CONFIG="--enable-debug --enable-tcg-interpreter"
+        - TEST_CMD=""
       compiler: gcc
 
 
     # We don't need to exercise every backend with every front-end
-    - env: CONFIG="--enable-trace-backends=log,simple,syslog --disable-system"
-           TEST_CMD=""
+    - env:
+        - CONFIG="--enable-trace-backends=log,simple,syslog --disable-system"
+        - TEST_CMD=""
       compiler: gcc
 
 
-    - env: CONFIG="--enable-trace-backends=ftrace --target-list=x86_64-softmmu"
-           TEST_CMD=""
+    - env:
+        - CONFIG="--enable-trace-backends=ftrace --target-list=x86_64-softmmu"
+        - TEST_CMD=""
       compiler: gcc
 
 
-    - env: CONFIG="--enable-trace-backends=ust --target-list=x86_64-softmmu"
-           TEST_CMD=""
+    - env:
+        - CONFIG="--enable-trace-backends=ust --target-list=x86_64-softmmu"
+        - TEST_CMD=""
       compiler: gcc
 
 
-    - env: CONFIG="--disable-tcg"
-           TEST_CMD=""
+    - env:
+        - CONFIG="--disable-tcg"
+        - TEST_CMD=""
       compiler: gcc
 
 
     # MacOSX builds
-    - env: CONFIG="--target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
+    - env:
+        - CONFIG="--target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
       os: osx
       osx_image: xcode9.4
       compiler: clang
 
 
-    - env: CONFIG="--target-list=i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu"
+    - env:
+        - CONFIG="--target-list=i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu"
       os: osx
       osx_image: xcode10
       compiler: clang
 
 
     # Python builds
-    - env: CONFIG="--target-list=x86_64-softmmu"
+    - env:
+        - CONFIG="--target-list=x86_64-softmmu"
       python:
         - "3.0"
 
 
-    - env: CONFIG="--target-list=x86_64-softmmu"
+    - env:
+        - CONFIG="--target-list=x86_64-softmmu"
       python:
         - "3.6"
 
 
     # Acceptance (Functional) tests
-    - env: CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu"
-           TEST_CMD="make AVOCADO_SHOW=app check-acceptance"
+    - env:
+        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu"
+        - TEST_CMD="make AVOCADO_SHOW=app check-acceptance"
       addons:
         apt:
           packages:
-- 
2.17.1
