Received: from eggs.gnu.org ([2001:4830:134:3::10]:50294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cahtc-0006mH-Nj
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cahtZ-00043V-LX
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:55:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cahtZ-00043A-G5
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:55:45 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 961C9FAF4D
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 11:55:45 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  6 Feb 2017 12:55:35 +0100
Message-Id: <1486382139-30630-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] xhci: cleanups, add qemu-xhci device.
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

  Hi,

This series adds a new qemu-xhci device.  It is pretty much identical to
the existing nec-usb-xhci device, except that some quirks needed to make
the nec/renesas windows driver work will be disabled for the qemu-xhci
device.  And qemu-xhci gets a PCI ID from the qemu PCi ID range.

please review,
  Gerd

Gerd Hoffmann (4):
  xhci: drop ER_FULL_HACK workaround
  xhci: add qemu xhci controller
  xhci: fix nec vendor quirk handling
  xhci: drop via vendor command handling

 docs/specs/pci-ids.txt |   1 +
 hw/usb/hcd-xhci.c      | 232 ++++++++++++++++---------------------------------
 include/hw/pci/pci.h   |   1 +
 3 files changed, 78 insertions(+), 156 deletions(-)

-- 
1.8.3.1
