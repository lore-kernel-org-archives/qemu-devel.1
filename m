Received: from eggs.gnu.org ([209.51.188.92]:45619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlS-00022K-UG
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlQ-00017k-VR
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghGlQ-00016V-NV
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:32 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  9 Jan 2019 16:31:06 +0000
Message-Id: <20190109163114.17010-6-berrange@redhat.com>
In-Reply-To: <20190109163114.17010-1-berrange@redhat.com>
References: <20190109163114.17010-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/13] travis: add whitespace between each
 major section & matrix entry
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

Improve the readability of the travis config by adding two blank lines
between each major section and matrix entry.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 .travis.yml | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index d472fd650b..bb43792627 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,6 +1,7 @@
 # The current Travis default is a container based 14.04 Trust on EC2
 # Additional builds with specific requirements for a full VM need to
 # be added as additional matrix: entries later on
+
 sudo: false
 dist: trusty
 language: c
@@ -9,6 +10,8 @@ python:
 compiler:
   - gcc
 cache: ccache
+
+
 addons:
   apt:
     packages:
@@ -40,6 +43,7 @@ addons:
       - uuid-dev
       - gcovr
=20
+
 # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
 # to prevent IRC notifications from forks. This was created using:
 # $ travis encrypt -r "qemu/qemu" "irc.oftc.net#qemu"
@@ -49,6 +53,8 @@ notifications:
       - secure: "F7GDRgjuOo5IUyRLqSkmDL7kvdU4UcH3Lm/W2db2JnDHTGCqgEdaYEY=
KciyCLZ57vOTsTsOgesN8iUT7hNHBd1KWKjZe9KDTZWppWRYVwAwQMzVeSOsbbU4tRoJ6Pp+3=
qhH1Z0eGYR9ZgKYAoTumDFgSAYRp4IscKS8jkoedOqM=3D"
     on_success: change
     on_failure: always
+
+
 env:
   global:
     - SRC_DIR=3D"."
@@ -63,9 +69,13 @@ env:
     - CONFIG=3D"--enable-modules --disable-linux-user"
     - CONFIG=3D"--with-coroutine=3Ducontext --disable-linux-user"
     - CONFIG=3D"--with-coroutine=3Dsigaltstack --disable-linux-user"
+
+
 git:
   # we want to do this ourselves
   submodules: false
+
+
 before_install:
   - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ]; then brew update ; fi
   - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ]; then brew install libffi gett=
ext glib pixman ; fi
@@ -75,54 +85,82 @@ before_script:
   - ${SRC_DIR}/configure ${CONFIG} || { cat config.log && exit 1; }
 script:
   - make ${MAKEFLAGS} && ${TEST_CMD}
+
+
 matrix:
   include:
     # Test out-of-tree builds
     - env: CONFIG=3D"--enable-debug --enable-debug-tcg"
            BUILD_DIR=3D"out-of-tree/build/dir" SRC_DIR=3D"../../.."
+
+
     # Test with Clang for compile portability (Travis uses clang-5.0)
     - env: CONFIG=3D"--disable-system"
       compiler: clang
+
+
     - env: CONFIG=3D"--disable-user"
       compiler: clang
+
+
     # gprof/gcov are GCC features
     - env: CONFIG=3D"--enable-gprof --enable-gcov --disable-pie --target=
-list=3Daarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-soft=
mmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
       after_success:
         - ${SRC_DIR}/scripts/travis/coverage-summary.sh
       compiler: gcc
+
+
     # We manually include builds which we disable "make check" for
     - env: CONFIG=3D"--enable-debug --enable-tcg-interpreter"
            TEST_CMD=3D""
       compiler: gcc
+
+
     # We don't need to exercise every backend with every front-end
     - env: CONFIG=3D"--enable-trace-backends=3Dlog,simple,syslog --disab=
le-system"
            TEST_CMD=3D""
       compiler: gcc
+
+
     - env: CONFIG=3D"--enable-trace-backends=3Dftrace --target-list=3Dx8=
6_64-softmmu"
            TEST_CMD=3D""
       compiler: gcc
+
+
     - env: CONFIG=3D"--enable-trace-backends=3Dust --target-list=3Dx86_6=
4-softmmu"
            TEST_CMD=3D""
       compiler: gcc
+
+
     - env: CONFIG=3D"--disable-tcg"
            TEST_CMD=3D""
       compiler: gcc
+
+
     # MacOSX builds
     - env: CONFIG=3D"--target-list=3Daarch64-softmmu,arm-softmmu,i386-so=
ftmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-sof=
tmmu,x86_64-softmmu"
       os: osx
       osx_image: xcode9.4
       compiler: clang
+
+
     - env: CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-soft=
mmu,m68k-softmmu,x86_64-softmmu"
       os: osx
       osx_image: xcode10
       compiler: clang
+
+
     # Python builds
     - env: CONFIG=3D"--target-list=3Dx86_64-softmmu"
       python:
         - "3.0"
+
+
     - env: CONFIG=3D"--target-list=3Dx86_64-softmmu"
       python:
         - "3.6"
+
+
     # Acceptance (Functional) tests
     - env: CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-=
softmmu"
            TEST_CMD=3D"make AVOCADO_SHOW=3Dapp check-acceptance"
@@ -131,6 +169,8 @@ matrix:
           packages:
             - python3-pip
             - python3.4-venv
+
+
     # Using newer GCC with sanitizers
     - addons:
         apt:
@@ -175,6 +215,8 @@ matrix:
         - TEST_CMD=3D""
       before_script:
         - ./configure ${CONFIG} --extra-cflags=3D"-g3 -O0 -fsanitize=3Dt=
hread -fuse-ld=3Dgold" || { cat config.log && exit 1; }
+
+
     - env:
         - CONFIG=3D"--disable-system --disable-docs"
         - TEST_CMD=3D"make check-tcg"
--=20
2.19.2
