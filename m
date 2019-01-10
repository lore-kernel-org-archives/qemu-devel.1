Received: from eggs.gnu.org ([209.51.188.92]:35599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghWZF-00028F-VM
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghWZF-0001Xs-5O
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:24:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36971)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghWZE-0001XQ-V1
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:24:01 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0BD4FC04959C
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:24:00 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 10 Jan 2019 10:23:53 +0100
Message-Id: <20190110092355.7121-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Audio 20190110 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit e59dbbac0364344a3ad84c3497a98c56003d3f=
b8:

  Merge remote-tracking branch 'remotes/philmd/tags/fw_cfg-20190104-pull-=
request' into staging (2019-01-04 18:23:13 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/audio-20190110-pull-request

for you to fetch changes up to a7fde1c1706a93c304eb301cc290d71c9426493b:

  usb-audio: ignore usb packages with wrong size (2019-01-10 09:56:19 +01=
00)

----------------------------------------------------------------
audio: two fixes.

----------------------------------------------------------------

Gerd Hoffmann (1):
  usb-audio: ignore usb packages with wrong size

Thomas Huth (1):
  hw/audio/marvell: Don't include unnecessary i2c.h header file

 hw/audio/marvell_88w8618.c | 1 -
 hw/usb/dev-audio.c         | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

--=20
2.9.3
