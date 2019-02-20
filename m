Received: from eggs.gnu.org ([209.51.188.92]:56213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpM-0008Iy-22
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpG-00085z-Ft
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwPp7-0007Si-09
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5DC2A7867
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 11:13:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 20 Feb 2019 12:13:37 +0100
Message-Id: <20190220111346.13669-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/9] Usb 20190220 patches
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

The following changes since commit 2e68b8620637a4ee8c79b5724144b726af1e261b:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-20190219' into staging (2019-02-18 16:20:13 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20190220-pull-request

for you to fetch changes up to 7011baece29d0e197c54c4e57326ba88e67a4949:

  usb: remove unnecessary NULL device check from usb_ep_get() (2019-02-20 09:41:23 +0100)

----------------------------------------------------------------
usb: usb_ep_get() fixes

----------------------------------------------------------------

Liam Merwick (9):
  usb: rearrange usb_ep_get()
  xhci: add asserts to help with static code analysis
  xhci: check device is not NULL before calling usb_ep_get()
  ehci: check device is not NULL before calling usb_ep_get()
  ohci: check device is not NULL before calling usb_ep_get()
  uhci: check device is not NULL before calling usb_ep_get()
  usb: check device is not NULL before calling usb_ep_get()
  usb: add device checks before redirector calls to usb_ep_get()
  usb: remove unnecessary NULL device check from usb_ep_get()

 hw/usb/core.c     | 6 ++----
 hw/usb/hcd-ehci.c | 7 +++++--
 hw/usb/hcd-musb.c | 8 ++++----
 hw/usb/hcd-ohci.c | 8 ++++++++
 hw/usb/hcd-uhci.c | 8 +++++---
 hw/usb/hcd-xhci.c | 8 +++++---
 hw/usb/redirect.c | 3 ++-
 7 files changed, 31 insertions(+), 17 deletions(-)

-- 
2.9.3
