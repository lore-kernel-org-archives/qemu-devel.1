Received: from eggs.gnu.org ([209.51.188.92]:38136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hMSAq-0003n3-T9
	for qemu-devel@nongnu.org; Fri, 03 May 2019 03:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hMSAp-0006EU-Mp
	for qemu-devel@nongnu.org; Fri, 03 May 2019 03:00:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hMSAp-0006Dr-F9
	for qemu-devel@nongnu.org; Fri, 03 May 2019 02:59:59 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  3 May 2019 08:59:47 +0200
Message-Id: <20190503065954.17069-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] Usb 20190503 v2 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

The following changes since commit f75d15231e56cb0f2bafe19faf1229c459a607=
31:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2019-04-30 17:06:57 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/usb-20190503-v2-pull-request

for you to fetch changes up to ccb799313a5926a6aa49018bbc67fe6165fad7f3:

  hw/usb: avoid format truncation warning when formatting port name (2019=
-05-03 08:56:58 +0200)

----------------------------------------------------------------
usb: bugfixes for mtp and xhci, split ohci-pci.

----------------------------------------------------------------

Bandan Das (1):
  usb-mtp: change default to success for usb_mtp_update_object

Daniel P. Berrang=C3=A9 (3):
  usb-mtp: fix string length for filename when writing metadata
  usb-mtp: fix alignment of access of ObjectInfo filename field
  hw/usb: avoid format truncation warning when formatting port name

Longpeng (1):
  usb/xhci: avoid trigger assertion if guest write wrong epid

Thomas Huth (2):
  hw/usb/hcd-ohci: Do not use PCI functions with sysbus devices in
    ohci_die()
  hw/usb/hcd-ohci: Move PCI-related code into a separate file

 hw/usb/hcd-ohci.h     | 104 ++++++++++++++++++++
 hw/usb/dev-mtp.c      |  10 +-
 hw/usb/hcd-ohci-pci.c | 163 +++++++++++++++++++++++++++++++
 hw/usb/hcd-ohci.c     | 219 ++++--------------------------------------
 hw/usb/hcd-xhci.c     |   6 +-
 hw/sh4/Kconfig        |   2 +-
 hw/usb/Kconfig        |   6 +-
 hw/usb/Makefile.objs  |   1 +
 8 files changed, 302 insertions(+), 209 deletions(-)
 create mode 100644 hw/usb/hcd-ohci.h
 create mode 100644 hw/usb/hcd-ohci-pci.c

--=20
2.18.1
