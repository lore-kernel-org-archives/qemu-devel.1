Received: from eggs.gnu.org ([209.51.188.92]:45901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlq-0002L2-69
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlo-0001NL-Gy
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghGlo-0001Ms-9l
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:56 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  9 Jan 2019 16:31:13 +0000
Message-Id: <20190109163114.17010-13-berrange@redhat.com>
In-Reply-To: <20190109163114.17010-1-berrange@redhat.com>
References: <20190109163114.17010-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/13] travis: run tests in verbose mode
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

Travis sometimes fails a build because it produces no console output for
over 10 minutes. If this is due to a genuine hang, it would be useful to
have used verbose test output to see where it failed. If this is just
due to tests being very slow, having verbose output might allow the
build to succeed.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index dc8b37db80..a632fc0b3a 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -55,7 +55,7 @@ env:
   global:
     - SRC_DIR=3D"."
     - BUILD_DIR=3D"."
-    - TEST_CMD=3D"make check -j3"
+    - TEST_CMD=3D"make check -j3 V=3D1"
=20
=20
 git:
@@ -248,6 +248,6 @@ matrix:
=20
     - env:
         - CONFIG=3D"--disable-system --disable-docs"
-        - TEST_CMD=3D"make -j3 check-tcg"
+        - TEST_CMD=3D"make -j3 check-tcg V=3D1"
       dist: trusty
       compiler: gcc
--=20
2.19.2
