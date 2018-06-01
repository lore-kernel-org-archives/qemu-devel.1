Received: from eggs.gnu.org ([2001:4830:134:3::10]:37089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOmnf-0005s0-UJ
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOmne-0003qx-Ul
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:21:11 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:52098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fOmne-0003qL-Nr
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:21:10 -0400
Received: by mail-wm0-x22d.google.com with SMTP id r15-v6so4057923wmc.1
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 09:21:10 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  1 Jun 2018 17:21:01 +0100
Message-Id: <20180601162101.895-8-alex.bennee@linaro.org>
In-Reply-To: <20180601162101.895-1-alex.bennee@linaro.org>
References: <20180601162101.895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 7/7] .travis.yml: update GCC sanitizer build to
 GCC 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

GCC has moved on and so should we. We also enable apt update to ensure
we get the latest build from the toolchain PPA.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/.travis.yml b/.travis.yml
index 7197247a34..814be151f4 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -111,13 +111,14 @@ matrix:
     # Using newer GCC with sanitizers
     - addons:
         apt:
+          update: true
           sources:
             # PPAs for newer toolchains
             - ubuntu-toolchain-r-test
           packages:
             # Extra toolchains
-            - gcc-5
-            - g++-5
+            - gcc-7
+            - g++-7
             # Build dependencies
             - libaio-dev
             - libattr1-dev
@@ -146,8 +147,8 @@ matrix:
       language: generic
       compiler: none
       env:
-        - COMPILER_NAME=gcc CXX=g++-5 CC=gcc-5
-        - CONFIG="--cc=gcc-5 --cxx=g++-5 --disable-pie --disable-linux-user"
+        - COMPILER_NAME=gcc CXX=g++-7 CC=gcc-7
+        - CONFIG="--cc=gcc-7 --cxx=g++-7 --disable-pie --disable-linux-user"
         - TEST_CMD=""
       before_script:
         - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || cat config.log
-- 
2.17.0
