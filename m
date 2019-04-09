Received: from eggs.gnu.org ([209.51.188.92]:48983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDsvX-0005lj-2T
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDsvV-00041Y-Ue
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:44:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDsvV-00040r-MM
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:44:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 25B3430B96D0
	for <qemu-devel@nongnu.org>; Tue,  9 Apr 2019 15:44:40 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 Apr 2019 17:44:35 +0200
Message-Id: <20190409154435.28807-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] docs: replace min-glib with fedora
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>

min-glib.docker was removed in commit
e7b3af81597db1a6b55f2c15d030d703c6b2c6ac ("glib: bump min required
glib library version to 2.40").

Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/testing.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 60f897d915..cec7d56c57 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -317,17 +317,17 @@ the container, with parameters defined by the make =
target):
=20
 .. code::
=20
-  make docker-test-build@min-glib
+  make docker-test-build@fedora
=20
-This will create a container instance using the ``min-glib`` image (the =
image
+This will create a container instance using the ``fedora`` image (the im=
age
 is downloaded and initialized automatically), in which the ``test-build`=
` job
 is executed.
=20
 Images
 ------
=20
-Along with many other images, the ``min-glib`` image is defined in a Doc=
kerfile
-in ``tests/docker/dockefiles/``, called ``min-glib.docker``. ``make dock=
er``
+Along with many other images, the ``fedora`` image is defined in a Docke=
rfile
+in ``tests/docker/dockefiles/``, called ``fedora.docker``. ``make docker=
``
 command will list all the available images.
=20
 To add a new image, simply create a new ``.docker`` file under the
--=20
2.21.0.196.g041f5ea1cf
