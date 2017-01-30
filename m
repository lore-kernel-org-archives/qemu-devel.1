Received: from eggs.gnu.org ([2001:4830:134:3::10]:40019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYE0l-0006N5-PC
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYE0i-0005bM-VH
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:36:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYE0i-0005aS-PE
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:36:52 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 30 Jan 2017 16:36:43 +0100
Message-Id: <1485790607-31399-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] xhci: fix misc regressions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: 1653384@bugs.launchpad.net, fabian@lesniak-it.de, Gerd Hoffmann <kraxel@redhat.com>

  Hi,

Commit 94b037f2a451b3dc855f9f2c346e5049a361bd55 caused some regressions,
partly plain bugs in that commit, partly it seems to have uncovered
other issues lurking in the xhci code.  This series fixes the isses
which poped up so far.

cheers,
  Gerd

Gerd Hoffmann (4):
  xhci: only free completed transfers
  xhci: rename xhci_complete_packet to xhci_try_complete_packet
  xhci: don't kick in xhci_submit and xhci_fire_ctl_transfer
  xhci: guard xhci_kick_epctx against recursive calls

 hw/usb/hcd-xhci.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

-- 
1.8.3.1
