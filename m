Received: from eggs.gnu.org ([209.51.188.92]:45729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlb-00029W-1z
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlX-0001DT-MF
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghGlX-0001Ca-Cm
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:39 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  9 Jan 2019 16:31:09 +0000
Message-Id: <20190109163114.17010-9-berrange@redhat.com>
In-Reply-To: <20190109163114.17010-1-berrange@redhat.com>
References: <20190109163114.17010-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/13] travis: don't clone git submodules
 upfront
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

The configure script & Makefile are already capable of figuring out
which git submodules are required for a given build platform, and
cloning them at the right time.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 .travis.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index f539f8b556..fa70429459 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -71,7 +71,6 @@ git:
 before_install:
   - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ]; then brew update ; fi
   - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ]; then brew install libffi gett=
ext glib pixman ; fi
-  - git submodule update --init --recursive capstone dtc ui/keycodemapdb
 before_script:
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${CONFIG} || { cat config.log && exit 1; }
--=20
2.19.2
