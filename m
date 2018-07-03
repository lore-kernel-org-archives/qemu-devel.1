Received: from eggs.gnu.org ([2001:4830:134:3::10]:47894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faGgF-0000a1-L3
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faGgC-0001Vo-EW
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:28:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1faGgC-0001VQ-8X
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:28:56 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com
	[10.5.11.25])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51CCDC0587D2
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 08:28:55 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  3 Jul 2018 10:28:49 +0200
Message-Id: <20180703082851.17959-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Usb 20180703 patches
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

The following changes since commit ab08440a4ee09032d1a9cb22fdcab23bc7e1c656:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180702' into staging (2018-07-02 17:57:46 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20180703-pull-request

for you to fetch changes up to 8f36ec708834dfad58af6feb0b69bb0be6077f0f:

  xhci: fix guest-triggerable assert (2018-07-03 09:50:39 +0200)

----------------------------------------------------------------
usb: bugfixes for ehci and xhci.

----------------------------------------------------------------

Gerd Hoffmann (1):
  xhci: fix guest-triggerable assert

Sebastian Bauer (1):
  ehci: Don't fetch a NULL current qtd but advance the queue instead.

 hw/usb/hcd-ehci.c | 3 ++-
 hw/usb/hcd-xhci.c | 7 ++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.9.3
