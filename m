Received: from eggs.gnu.org ([2001:4830:134:3::10]:48315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eekd6-0006c7-De
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eekd3-0000wh-7N
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:44:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eekd3-0000wD-27
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:43:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF4D8916D7
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 16:43:55 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 25 Jan 2018 17:43:48 +0100
Message-Id: <20180125164351.17154-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Usb 20180125 v2 patches
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

The following changes since commit 834a336eb911db8a8ca00e760ee6a85faca194=
14:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2018-01-24 19:24:26 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20180125-v2-pull-request

for you to fetch changes up to 112d9cb43c70658b890559ff6dcfc5d9e821f368:

  usb-storage: Fix share-rw option parsing (2018-01-25 17:26:07 +0100)

----------------------------------------------------------------
usb: -usbdevice cleanups, storage fix, ccid cleanup.

----------------------------------------------------------------

Fam Zheng (1):
  usb-storage: Fix share-rw option parsing

Mao Zhongyi (1):
  hw/usb/ccid: Make ccid_card_init() take an error parameter

Thomas Huth (1):
  usb: Remove legacy -usbdevice options (host, serial, disk and net)

 hw/usb/ccid.h                 |   2 +-
 include/hw/scsi/scsi.h        |   1 +
 include/hw/usb.h              |   1 -
 hw/scsi/scsi-bus.c            |   9 ++-
 hw/usb/ccid-card-emulated.c   |  44 ++++++-------
 hw/usb/ccid-card-passthru.c   |  12 ++--
 hw/usb/dev-network.c          |  26 --------
 hw/usb/dev-serial.c           |  30 ---------
 hw/usb/dev-smartcard-reader.c |  34 +++++-----
 hw/usb/dev-storage.c          |  61 +-----------------
 hw/usb/host-legacy.c          | 144 ------------------------------------=
------
 hw/usb/host-stub.c            |   6 --
 vl.c                          |  15 -----
 hw/usb/Makefile.objs          |   2 +-
 qemu-options.hx               |  19 ------
 15 files changed, 60 insertions(+), 346 deletions(-)
 delete mode 100644 hw/usb/host-legacy.c

--=20
2.9.3
