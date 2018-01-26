Received: from eggs.gnu.org ([2001:4830:134:3::10]:53279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ef0DJ-0001lm-TM
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:22:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ef0DG-0005Tm-Py
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:22:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ef0DG-0005TW-L1
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:22:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB6D2394C5B
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 08:05:20 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 26 Jan 2018 09:05:10 +0100
Message-Id: <20180126080515.26108-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Usb 20180126 v3 patches
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

The following changes since commit 2077fef91d5eb8e3745a84fabd87a5ee7d2b53=
5d:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80125' into staging (2018-01-25 17:04:47 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20180126-v3-pull-request

for you to fetch changes up to 80ae865468bde918363a123aa26c6fc4385023ac:

  usb-ccid: convert CCIDCardClass::exitfn() -> unrealize() (2018-01-26 07=
:59:33 +0100)

----------------------------------------------------------------
usb: -usbdevice cleanups, storage fix, QOMify ccid.

----------------------------------------------------------------

Fam Zheng (1):
  usb-storage: Fix share-rw option parsing

Mao Zhongyi (1):
  hw/usb/ccid: Make ccid_card_init() take an error parameter

Philippe Mathieu-Daud=C3=A9 (2):
  usb-ccid: inline ccid_card_initfn() in ccid_card_realize()
  usb-ccid: convert CCIDCardClass::exitfn() -> unrealize()

Thomas Huth (1):
  usb: Remove legacy -usbdevice options (host, serial, disk and net)

 hw/usb/ccid.h                 |   6 +-
 include/hw/scsi/scsi.h        |   1 +
 include/hw/usb.h              |   1 -
 hw/scsi/scsi-bus.c            |   9 ++-
 hw/usb/ccid-card-emulated.c   |  48 +++++++-------
 hw/usb/ccid-card-passthru.c   |  13 ++--
 hw/usb/dev-network.c          |  26 --------
 hw/usb/dev-serial.c           |  30 ---------
 hw/usb/dev-smartcard-reader.c |  63 ++++++++----------
 hw/usb/dev-storage.c          |  61 +-----------------
 hw/usb/host-legacy.c          | 144 ------------------------------------=
------
 hw/usb/host-stub.c            |   6 --
 vl.c                          |  15 -----
 hw/usb/Makefile.objs          |   2 +-
 qemu-options.hx               |  19 ------
 15 files changed, 74 insertions(+), 370 deletions(-)
 delete mode 100644 hw/usb/host-legacy.c

--=20
2.9.3
