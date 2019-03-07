Received: from eggs.gnu.org ([209.51.188.92]:35009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1pjj-0005a7-1G
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1pji-0007rQ-7b
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:54:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h1pjh-0007r4-UU
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:54:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13A9D81F18
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 09:54:45 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  7 Mar 2019 10:54:37 +0100
Message-Id: <20190307095441.31921-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] Usb 20190307 patches
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

The following changes since commit 32694e98b8d7a246345448a8f707d2e11d6c65e2:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2019-03-06 18:52:19 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/usb-20190307-pull-request

for you to fetch changes up to ba4c735b4fc74e309ce4b2551d258e442ef513a5:

  Introduce new "no_guest_reset" parameter for usb-host device (2019-03-07 10:03:54 +0100)

----------------------------------------------------------------
usb: mtp fixes, guest-reset switch for usb-host.

----------------------------------------------------------------

Alexander Kappner (1):
  Introduce new "no_guest_reset" parameter for usb-host device

Bandan Das (3):
  usb-mtp: return incomplete transfer on a lstat failure
  usb-mtp: fix some usb_mtp_write_data return paths
  usb-mtp: prevent null dereference while deleting objects

 hw/usb/dev-mtp.c     | 41 +++++++++++++++++++++++++----------------
 hw/usb/host-libusb.c |  7 ++++++-
 2 files changed, 31 insertions(+), 17 deletions(-)

-- 
2.18.1
