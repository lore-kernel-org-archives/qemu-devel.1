Received: from eggs.gnu.org ([2001:4830:134:3::10]:48584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXa0-0006E3-OC
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZz-0002QP-Pd
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:48 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZz-0002QF-Kt
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:47 -0400
Received: by mail-qk0-x244.google.com with SMTP id d136so6740894qkg.3
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 13:27:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 Aug 2017 17:27:09 -0300
Message-Id: <20170809202712.6951-14-f4bug@amsat.org>
In-Reply-To: <20170809202712.6951-1-f4bug@amsat.org>
References: <20170809202712.6951-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for-2.11 v3 13/16] travis: use gcc-6
 sanitizers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 24f62fb7cf..1da542f99f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -185,8 +185,8 @@ matrix:
             - ubuntu-toolchain-r-test
           packages:
             # Extra toolchains
-            - gcc-5
-            - g++-5
+            - gcc-6
+            - g++-6
             # Build dependencies
             - glusterfs-common
             - libaio-dev
@@ -228,8 +228,8 @@ matrix:
       language: generic
       compiler: none
       env:
-        - COMPILER_NAME=gcc CXX=g++-5 CC=gcc-5
-        - CONFIG="--cc=gcc-5 --cxx=g++-5 --disable-pie --disable-linux-user"
+        - COMPILER_NAME=gcc CXX=g++-6 CC=gcc-6
+        - CONFIG="--disable-pie --disable-linux-user"
         - TEST_CMD=""
       before_script:
         - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || (cat config.log; exit 1)
-- 
2.13.3
