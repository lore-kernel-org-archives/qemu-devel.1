Received: from eggs.gnu.org ([2001:4830:134:3::10]:56180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrv-0005hb-5T
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrs-0004yU-G8
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:17 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrs-0004xc-CO
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:16 -0400
Received: by mail-qt0-x242.google.com with SMTP id c20so595608qte.0
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 20:33:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 22 Jun 2017 00:32:18 -0300
Message-Id: <20170622033231.19344-9-f4bug@amsat.org>
In-Reply-To: <20170622033231.19344-1-f4bug@amsat.org>
References: <20170622033231.19344-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 08/21] travis: use gcc-6 sanitizers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index e60a5cd8e6..61394b4764 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -172,8 +172,8 @@ matrix:
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
@@ -215,8 +215,8 @@ matrix:
       language: generic
       compiler: none
       env:
-        - COMPILER_NAME=gcc CXX=g++-5 CC=gcc-5
-        - CONFIG="--cc=gcc-5 --cxx=g++-5 --disable-pie --disable-linux-user"
+        - COMPILER_NAME=gcc CXX=g++-6 CC=gcc-6
+        - CONFIG="--disable-pie --disable-linux-user"
         - TEST_CMD=""
       before_script:
         - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || cat config.log
-- 
2.11.0
