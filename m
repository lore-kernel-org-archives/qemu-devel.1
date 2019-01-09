Received: from eggs.gnu.org ([209.51.188.92]:45756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGle-0002Af-QJ
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlc-0001Fc-VV
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghGlb-0001Dh-2T
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:43 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  9 Jan 2019 16:31:10 +0000
Message-Id: <20190109163114.17010-10-berrange@redhat.com>
In-Reply-To: <20190109163114.17010-1-berrange@redhat.com>
References: <20190109163114.17010-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/13] travis: move macOS brew setup into the
 macOS matrix entries
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

There is no need to use shell conditionals to run commands when they can
simply be listed under the appropriate matrix entry.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 .travis.yml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index fa70429459..b5f520034f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -68,9 +68,6 @@ git:
   submodules: false
=20
=20
-before_install:
-  - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ]; then brew update ; fi
-  - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ]; then brew install libffi gett=
ext glib pixman ; fi
 before_script:
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${CONFIG} || { cat config.log && exit 1; }
@@ -171,6 +168,8 @@ matrix:
       os: osx
       osx_image: xcode9.4
       compiler: clang
+      before_install:
+        - brew update && brew install libffi gettext glib pixman
=20
=20
     - env:
@@ -178,6 +177,8 @@ matrix:
       os: osx
       osx_image: xcode10
       compiler: clang
+      before_install:
+        - brew update && brew install libffi gettext glib pixman
=20
=20
     # Python builds
--=20
2.19.2
