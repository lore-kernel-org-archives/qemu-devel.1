Received: from eggs.gnu.org ([209.51.188.92]:35446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3kE-0006Io-LT
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3k9-0005Ji-J1
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:42 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:38367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj3k9-0005HC-9I
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:37 -0500
Received: by mail-wr1-x42e.google.com with SMTP id v13so23223089wrw.5
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 07:01:36 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 15:01:15 +0000
Message-Id: <20190114150129.1013-8-alex.bennee@linaro.org>
In-Reply-To: <20190114150129.1013-1-alex.bennee@linaro.org>
References: <20190114150129.1013-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/21] travis: add whitespace between each major
 section & matrix entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Daniel P. Berrangé <berrange@redhat.com>

Improve the readability of the travis config by adding two blank lines
between each major section and matrix entry.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
 
+
 # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
 # to prevent IRC notifications from forks. This was created using:
 # $ travis encrypt -r "qemu/qemu" "irc.oftc.net#qemu"
@@ -49,6 +53,8 @@ notifications:
       - secure: "F7GDRgjuOo5IUyRLqSkmDL7kvdU4UcH3Lm/W2db2JnDHTGCqgEdaYEYKciyCLZ57vOTsTsOgesN8iUT7hNHBd1KWKjZe9KDTZWppWRYVwAwQMzVeSOsbbU4tRoJ6Pp+3qhH1Z0eGYR9ZgKYAoTumDFgSAYRp4IscKS8jkoedOqM="
     on_success: change
     on_failure: always
+
+
 env:
   global:
     - SRC_DIR="."
@@ -63,9 +69,13 @@ env:
     - CONFIG="--enable-modules --disable-linux-user"
     - CONFIG="--with-coroutine=ucontext --disable-linux-user"
     - CONFIG="--with-coroutine=sigaltstack --disable-linux-user"
+
+
 git:
   # we want to do this ourselves
   submodules: false
+
+
 before_install:
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew update ; fi
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ; fi
@@ -75,54 +85,82 @@ before_script:
   - ${SRC_DIR}/configure ${CONFIG} || { cat config.log && exit 1; }
 script:
   - make ${MAKEFLAGS} && ${TEST_CMD}
+
+
 matrix:
   include:
     # Test out-of-tree builds
     - env: CONFIG="--enable-debug --enable-debug-tcg"
            BUILD_DIR="out-of-tree/build/dir" SRC_DIR="../../.."
+
+
     # Test with Clang for compile portability (Travis uses clang-5.0)
     - env: CONFIG="--disable-system"
       compiler: clang
+
+
     - env: CONFIG="--disable-user"
       compiler: clang
+
+
     # gprof/gcov are GCC features
     - env: CONFIG="--enable-gprof --enable-gcov --disable-pie --target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
       after_success:
         - ${SRC_DIR}/scripts/travis/coverage-summary.sh
       compiler: gcc
+
+
     # We manually include builds which we disable "make check" for
     - env: CONFIG="--enable-debug --enable-tcg-interpreter"
            TEST_CMD=""
       compiler: gcc
+
+
     # We don't need to exercise every backend with every front-end
     - env: CONFIG="--enable-trace-backends=log,simple,syslog --disable-system"
            TEST_CMD=""
       compiler: gcc
+
+
     - env: CONFIG="--enable-trace-backends=ftrace --target-list=x86_64-softmmu"
            TEST_CMD=""
       compiler: gcc
+
+
     - env: CONFIG="--enable-trace-backends=ust --target-list=x86_64-softmmu"
            TEST_CMD=""
       compiler: gcc
+
+
     - env: CONFIG="--disable-tcg"
            TEST_CMD=""
       compiler: gcc
+
+
     # MacOSX builds
     - env: CONFIG="--target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
       os: osx
       osx_image: xcode9.4
       compiler: clang
+
+
     - env: CONFIG="--target-list=i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu"
       os: osx
       osx_image: xcode10
       compiler: clang
+
+
     # Python builds
     - env: CONFIG="--target-list=x86_64-softmmu"
       python:
         - "3.0"
+
+
     - env: CONFIG="--target-list=x86_64-softmmu"
       python:
         - "3.6"
+
+
     # Acceptance (Functional) tests
     - env: CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu"
            TEST_CMD="make AVOCADO_SHOW=app check-acceptance"
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
         - TEST_CMD=""
       before_script:
         - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || { cat config.log && exit 1; }
+
+
     - env:
         - CONFIG="--disable-system --disable-docs"
         - TEST_CMD="make check-tcg"
-- 
2.17.1
