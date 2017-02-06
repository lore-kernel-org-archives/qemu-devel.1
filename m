Received: from eggs.gnu.org ([2001:4830:134:3::10]:43111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cahTN-0002LF-C5
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cahTJ-0002wB-DA
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:28:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cahTJ-0002v9-5d
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:28:37 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0BF019D053
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 11:28:36 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  6 Feb 2017 12:28:12 +0100
Message-Id: <1486380501-13431-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/9] usb: various bugfixes, mostly xhci.
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

Here is the usb patch queue, with a collection of xhci bugfixes,
also some other usb fixes in various places.

please pull,
  Gerd

The following changes since commit a951316b8a5c3c63254f20a826afeed940dd4cba:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-02-03 14:41:49 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-usb-20170206-1

for you to fetch changes up to 7da76e12cc5cc902dda4c168d8d608fd4e61cbc5:

  xhci: fix event queue IRQ handling (2017-02-06 12:12:26 +0100)

----------------------------------------------------------------
usb: various bugfixes, mostly xhci.

----------------------------------------------------------------
Gerd Hoffmann (7):
      usb/uas: more verbose error message
      usb: accept usb3 control requests
      xhci: only free completed transfers
      xhci: rename xhci_complete_packet to xhci_try_complete_packet
      xhci: don't kick in xhci_submit and xhci_fire_ctl_transfer
      xhci: guard xhci_kick_epctx against recursive calls
      xhci: fix event queue IRQ handling

Phil Dennis-Jordan (1):
      hw/usb/dev-hid: Improve guest compatibility of usb-tablet

Prasad J Pandit (1):
      usb: ccid: check ccid apdu length

 hw/usb/desc.c                 |  7 +++++++
 hw/usb/dev-hid.c              |  6 +++---
 hw/usb/dev-smartcard-reader.c |  2 +-
 hw/usb/dev-uas.c              |  3 ++-
 hw/usb/hcd-xhci.c             | 44 ++++++++++++++++++++++++++++---------------
 include/hw/usb.h              |  2 ++
 6 files changed, 44 insertions(+), 20 deletions(-)
