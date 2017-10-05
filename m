Received: from eggs.gnu.org ([2001:4830:134:3::10]:52980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e025N-0007K8-Hl
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 05:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e025I-00048B-OR
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 05:04:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e025I-00047O-J2
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 05:04:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ABC45C9D2D
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 09:04:47 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  5 Oct 2017 11:04:39 +0200
Message-Id: <20171005090443.26889-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] Usb 20171005 patches
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

The following changes since commit ab161529261928ae7f3556e3220829c34b2686ec:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20170927a' into staging (2017-09-27 22:44:51 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20171005-pull-request

for you to fetch changes up to eea6ae20379dca837631d603c3bed03e5128189f:

  usb: fix host-stub.c build race (2017-10-05 11:03:25 +0200)

----------------------------------------------------------------
usb bugfixes.

----------------------------------------------------------------

Fam Zheng (1):
  usb: Use angle brackets for cacard include directive

Gerd Hoffmann (2):
  usb: fix libusb config variable name.
  usb: fix host-stub.c build race

Thomas Huth (1):
  hw/usb/bus: Remove bad object_unparent() from usb_try_create_simple()

 hw/usb/bus.c                | 4 +---
 hw/usb/ccid-card-passthru.c | 2 +-
 hw/usb/Makefile.objs        | 3 ++-
 3 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.9.3
