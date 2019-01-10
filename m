Received: from eggs.gnu.org ([209.51.188.92]:33921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOh-0004lf-5V
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOf-0008SG-VZ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:39 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gheOf-0007he-Nr
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:37 -0500
Received: by mail-wr1-x442.google.com with SMTP id p4so12369577wrt.7
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:45:25 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 10 Jan 2019 17:45:05 +0000
Message-Id: <20190110174516.21586-9-alex.bennee@linaro.org>
In-Reply-To: <20190110174516.21586-1-alex.bennee@linaro.org>
References: <20190110174516.21586-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 08/19] travis: define all the build matrix
 entries in one place
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

The current build matrix is constructed from entries listed under the
environment variable config section, as well as the general purpose
build matrix section. Move everything under the general purpose section
so it is clear at a glance what is in the matrix.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index bb43792627..96917df9c5 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -61,14 +61,6 @@ env:
     - BUILD_DIR="."
     - TEST_CMD="make check"
     - MAKEFLAGS="-j3"
-  matrix:
-    - CONFIG="--disable-system"
-    - CONFIG="--disable-user"
-    - CONFIG="--enable-debug --enable-debug-tcg"
-    - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-uuid --disable-libusb --disable-user"
-    - CONFIG="--enable-modules --disable-linux-user"
-    - CONFIG="--with-coroutine=ucontext --disable-linux-user"
-    - CONFIG="--with-coroutine=sigaltstack --disable-linux-user"
 
 
 git:
@@ -89,6 +81,27 @@ script:
 
 matrix:
   include:
+    - env: CONFIG="--disable-system"
+
+
+    - env: CONFIG="--disable-user"
+
+
+    - env: CONFIG="--enable-debug --enable-debug-tcg"
+
+
+    - env: CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-uuid --disable-libusb --disable-user"
+
+
+    - env: CONFIG="--enable-modules --disable-linux-user"
+
+
+    - env: CONFIG="--with-coroutine=ucontext --disable-linux-user"
+
+
+    - env: CONFIG="--with-coroutine=sigaltstack --disable-linux-user"
+
+
     # Test out-of-tree builds
     - env: CONFIG="--enable-debug --enable-debug-tcg"
            BUILD_DIR="out-of-tree/build/dir" SRC_DIR="../../.."
-- 
2.17.1
