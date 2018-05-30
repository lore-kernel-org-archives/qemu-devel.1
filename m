Received: from eggs.gnu.org ([2001:4830:134:3::10]:37372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fNywd-0008Qb-8a
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fNywc-00020O-9R
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:07 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:41236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fNywc-000202-2I
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:06 -0400
Received: by mail-wr0-x22c.google.com with SMTP id u12-v6so29063082wrn.8
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 04:07:06 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 30 May 2018 12:06:54 +0100
Message-Id: <20180530110655.22022-8-alex.bennee@linaro.org>
In-Reply-To: <20180530110655.22022-1-alex.bennee@linaro.org>
References: <20180530110655.22022-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 7/8] .travis.yml: update GCC sanitizer build
 to GCC 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

GCC has moved on and so should we. We also enable apt update to ensure
we get the latest build from the toolchain PPA.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index e99af6f357..ecc4367036 100644
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
