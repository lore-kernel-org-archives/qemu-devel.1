Received: from eggs.gnu.org ([2001:4830:134:3::10]:50324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dxt2T-0007Gk-Vu
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dxt2P-0001Qb-QK
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:01:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dxt2P-0001Q5-Ka
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:00:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7BE481DE1
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 11:00:56 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 29 Sep 2017 13:00:49 +0200
Message-Id: <20170929110052.6111-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] Usb 20170929 patches
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
List-ID: <qemu-devel.nongnu.org>

The following changes since commit ab161529261928ae7f3556e3220829c34b2686ec:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20170927a' into staging (2017-09-27 22:44:51 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20170929-pull-request

for you to fetch changes up to 13787d59cf86bac230c4d3eec3580110f53ac113:

  usb: Use angle brackets for cacard include directive (2017-09-29 12:28:26 +0200)

----------------------------------------------------------------
usb fixes.

----------------------------------------------------------------

Fam Zheng (1):
  usb: Use angle brackets for cacard include directive

Gerd Hoffmann (1):
  usb: fix libusb config variable name.

Thomas Huth (1):
  hw/usb/bus: Remove bad object_unparent() from usb_try_create_simple()

 hw/usb/bus.c                | 4 +---
 hw/usb/ccid-card-passthru.c | 2 +-
 hw/usb/Makefile.objs        | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.9.3
