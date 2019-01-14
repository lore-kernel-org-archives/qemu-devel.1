Received: from eggs.gnu.org ([209.51.188.92]:35494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3kG-0006L2-Rg
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3kB-0005Kh-8x
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:44 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:55486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj3kB-0005KB-2R
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:39 -0500
Received: by mail-wm1-x331.google.com with SMTP id y139so9172102wmc.5
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 07:01:38 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 15:01:16 +0000
Message-Id: <20190114150129.1013-9-alex.bennee@linaro.org>
In-Reply-To: <20190114150129.1013-1-alex.bennee@linaro.org>
References: <20190114150129.1013-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/21] travis: define all the build matrix
 entries in one place
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

The current build matrix is constructed from entries listed under the
environment variable config section, as well as the general purpose
build matrix section. Move everything under the general purpose section
so it is clear at a glance what is in the matrix.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
