Received: from eggs.gnu.org ([209.51.188.92]:39354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goRk0-0001wh-2p
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goRjw-0001dJ-67
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1goRjq-0001aV-Gs
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:36 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 29 Jan 2019 11:39:16 +0000
Message-Id: <20190129113921.21599-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/5] misc fixes to deal with icon location
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Adam Baxter <voltagex@voltagex.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This is a few misc fixes identified after the icon location changes
were merged. Most importantly it deals with the nsis installer file
manifest.

Daniel P. Berrang=C3=A9 (5):
  nsis: don't install files into /tmp
  make: don't insert a '/' after $(DESTDIR)
  nsis: ensure we always pass -W64 flag to nsis installer script
  nsis: fix location of icons to be bundled in the installer
  configure: stop trying to link non-existant bmp file from bios dir

 Makefile  | 23 +++++++++++++----------
 configure |  1 -
 qemu.nsi  |  4 ++--
 3 files changed, 15 insertions(+), 13 deletions(-)

--=20
2.20.1
