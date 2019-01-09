Received: from eggs.gnu.org ([209.51.188.92]:45731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlb-00029X-2p
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlX-0001D4-FL
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghGlV-0001AG-D9
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:39 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  9 Jan 2019 16:31:08 +0000
Message-Id: <20190109163114.17010-8-berrange@redhat.com>
In-Reply-To: <20190109163114.17010-1-berrange@redhat.com>
References: <20190109163114.17010-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/13] travis: standardize the syntax used for
 env variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Matrix entries are defining env variables using two different syntax
styles:

   - env: FOO=3Dbar
          WIZZ=3Dbang

and

   - env:
       - FOO=3Dbar
       - WIZZ=3Dbang

Switch everything to use the latter style as the more normal indentation
approach.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 .travis.yml | 77 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 96917df9c5..f539f8b556 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -81,102 +81,123 @@ script:
=20
 matrix:
   include:
-    - env: CONFIG=3D"--disable-system"
+    - env:
+        - CONFIG=3D"--disable-system"
=20
=20
-    - env: CONFIG=3D"--disable-user"
+    - env:
+        - CONFIG=3D"--disable-user"
=20
=20
-    - env: CONFIG=3D"--enable-debug --enable-debug-tcg"
+    - env:
+        - CONFIG=3D"--enable-debug --enable-debug-tcg"
=20
=20
-    - env: CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-attr=
 --disable-brlapi --disable-uuid --disable-libusb --disable-user"
+    - env:
+        - CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-attr =
--disable-brlapi --disable-uuid --disable-libusb --disable-user"
=20
=20
-    - env: CONFIG=3D"--enable-modules --disable-linux-user"
+    - env:
+        - CONFIG=3D"--enable-modules --disable-linux-user"
=20
=20
-    - env: CONFIG=3D"--with-coroutine=3Ducontext --disable-linux-user"
+    - env:
+        - CONFIG=3D"--with-coroutine=3Ducontext --disable-linux-user"
=20
=20
-    - env: CONFIG=3D"--with-coroutine=3Dsigaltstack --disable-linux-user=
"
+    - env:
+        - CONFIG=3D"--with-coroutine=3Dsigaltstack --disable-linux-user"
=20
=20
     # Test out-of-tree builds
-    - env: CONFIG=3D"--enable-debug --enable-debug-tcg"
-           BUILD_DIR=3D"out-of-tree/build/dir" SRC_DIR=3D"../../.."
+    - env:
+        - CONFIG=3D"--enable-debug --enable-debug-tcg"
+        - BUILD_DIR=3D"out-of-tree/build/dir" SRC_DIR=3D"../../.."
=20
=20
     # Test with Clang for compile portability (Travis uses clang-5.0)
-    - env: CONFIG=3D"--disable-system"
+    - env:
+        - CONFIG=3D"--disable-system"
       compiler: clang
=20
=20
-    - env: CONFIG=3D"--disable-user"
+    - env:
+        - CONFIG=3D"--disable-user"
       compiler: clang
=20
=20
     # gprof/gcov are GCC features
-    - env: CONFIG=3D"--enable-gprof --enable-gcov --disable-pie --target=
-list=3Daarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-soft=
mmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
+    - env:
+        - CONFIG=3D"--enable-gprof --enable-gcov --disable-pie --target-=
list=3Daarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softm=
mu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
       after_success:
         - ${SRC_DIR}/scripts/travis/coverage-summary.sh
       compiler: gcc
=20
=20
     # We manually include builds which we disable "make check" for
-    - env: CONFIG=3D"--enable-debug --enable-tcg-interpreter"
-           TEST_CMD=3D""
+    - env:
+        - CONFIG=3D"--enable-debug --enable-tcg-interpreter"
+        - TEST_CMD=3D""
       compiler: gcc
=20
=20
     # We don't need to exercise every backend with every front-end
-    - env: CONFIG=3D"--enable-trace-backends=3Dlog,simple,syslog --disab=
le-system"
-           TEST_CMD=3D""
+    - env:
+        - CONFIG=3D"--enable-trace-backends=3Dlog,simple,syslog --disabl=
e-system"
+        - TEST_CMD=3D""
       compiler: gcc
=20
=20
-    - env: CONFIG=3D"--enable-trace-backends=3Dftrace --target-list=3Dx8=
6_64-softmmu"
-           TEST_CMD=3D""
+    - env:
+        - CONFIG=3D"--enable-trace-backends=3Dftrace --target-list=3Dx86=
_64-softmmu"
+        - TEST_CMD=3D""
       compiler: gcc
=20
=20
-    - env: CONFIG=3D"--enable-trace-backends=3Dust --target-list=3Dx86_6=
4-softmmu"
-           TEST_CMD=3D""
+    - env:
+        - CONFIG=3D"--enable-trace-backends=3Dust --target-list=3Dx86_64=
-softmmu"
+        - TEST_CMD=3D""
       compiler: gcc
=20
=20
-    - env: CONFIG=3D"--disable-tcg"
-           TEST_CMD=3D""
+    - env:
+        - CONFIG=3D"--disable-tcg"
+        - TEST_CMD=3D""
       compiler: gcc
=20
=20
     # MacOSX builds
-    - env: CONFIG=3D"--target-list=3Daarch64-softmmu,arm-softmmu,i386-so=
ftmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-sof=
tmmu,x86_64-softmmu"
+    - env:
+        - CONFIG=3D"--target-list=3Daarch64-softmmu,arm-softmmu,i386-sof=
tmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-soft=
mmu,x86_64-softmmu"
       os: osx
       osx_image: xcode9.4
       compiler: clang
=20
=20
-    - env: CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-soft=
mmu,m68k-softmmu,x86_64-softmmu"
+    - env:
+        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softm=
mu,m68k-softmmu,x86_64-softmmu"
       os: osx
       osx_image: xcode10
       compiler: clang
=20
=20
     # Python builds
-    - env: CONFIG=3D"--target-list=3Dx86_64-softmmu"
+    - env:
+        - CONFIG=3D"--target-list=3Dx86_64-softmmu"
       python:
         - "3.0"
=20
=20
-    - env: CONFIG=3D"--target-list=3Dx86_64-softmmu"
+    - env:
+        - CONFIG=3D"--target-list=3Dx86_64-softmmu"
       python:
         - "3.6"
=20
=20
     # Acceptance (Functional) tests
-    - env: CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-=
softmmu"
-           TEST_CMD=3D"make AVOCADO_SHOW=3Dapp check-acceptance"
+    - env:
+        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu"
+        - TEST_CMD=3D"make AVOCADO_SHOW=3Dapp check-acceptance"
       addons:
         apt:
           packages:
--=20
2.19.2
