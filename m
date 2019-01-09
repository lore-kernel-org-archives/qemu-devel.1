Received: from eggs.gnu.org ([209.51.188.92]:45674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlV-00024D-Dq
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlT-0001As-IO
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghGlS-00017g-Vr
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:35 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  9 Jan 2019 16:31:07 +0000
Message-Id: <20190109163114.17010-7-berrange@redhat.com>
In-Reply-To: <20190109163114.17010-1-berrange@redhat.com>
References: <20190109163114.17010-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/13] travis: define all the build matrix
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The current build matrix is constructed from entries listed under the
environment variable config section, as well as the general purpose
build matrix section. Move everything under the general purpose section
so it is clear at a glance what is in the matrix.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 .travis.yml | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index bb43792627..96917df9c5 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -61,14 +61,6 @@ env:
     - BUILD_DIR=3D"."
     - TEST_CMD=3D"make check"
     - MAKEFLAGS=3D"-j3"
-  matrix:
-    - CONFIG=3D"--disable-system"
-    - CONFIG=3D"--disable-user"
-    - CONFIG=3D"--enable-debug --enable-debug-tcg"
-    - CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-attr --di=
sable-brlapi --disable-uuid --disable-libusb --disable-user"
-    - CONFIG=3D"--enable-modules --disable-linux-user"
-    - CONFIG=3D"--with-coroutine=3Ducontext --disable-linux-user"
-    - CONFIG=3D"--with-coroutine=3Dsigaltstack --disable-linux-user"
=20
=20
 git:
@@ -89,6 +81,27 @@ script:
=20
 matrix:
   include:
+    - env: CONFIG=3D"--disable-system"
+
+
+    - env: CONFIG=3D"--disable-user"
+
+
+    - env: CONFIG=3D"--enable-debug --enable-debug-tcg"
+
+
+    - env: CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-attr=
 --disable-brlapi --disable-uuid --disable-libusb --disable-user"
+
+
+    - env: CONFIG=3D"--enable-modules --disable-linux-user"
+
+
+    - env: CONFIG=3D"--with-coroutine=3Ducontext --disable-linux-user"
+
+
+    - env: CONFIG=3D"--with-coroutine=3Dsigaltstack --disable-linux-user=
"
+
+
     # Test out-of-tree builds
     - env: CONFIG=3D"--enable-debug --enable-debug-tcg"
            BUILD_DIR=3D"out-of-tree/build/dir" SRC_DIR=3D"../../.."
--=20
2.19.2
