Received: from eggs.gnu.org ([2001:4830:134:3::10]:45052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL35M-0001ek-K0
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL35L-0008P5-CQ
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:51:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dL35L-0008OY-6C
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:51:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A6728046F
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 07:51:26 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 14 Jun 2017 09:51:09 +0200
Message-Id: <20170614075111.24886-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] usb: bugfixes for ehci and xhci
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

Here is the usb patch queue with two bugfixes.

please pull,
  Gerd

The following changes since commit 475df9d809b1f3a7ebe8b15abd208216591f0143:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-06-12 10:43:32 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/pull-usb-20170614-1

for you to fetch changes up to ad3c5412f2704672bb212bb82035c9b1a72db782:

  ehci: stop recursive calls to ehci_work_bh (2017-06-13 12:17:33 +0200)

----------------------------------------------------------------
usb: bugfixes for ehci and xhci

----------------------------------------------------------------
Gerd Hoffmann (2):
      xhci: only update dequeue ptr on completed transfers
      ehci: stop recursive calls to ehci_work_bh

 hw/usb/hcd-ehci.h | 1 +
 hw/usb/hcd-ehci.c | 7 +++++++
 hw/usb/hcd-xhci.c | 6 ++++--
 3 files changed, 12 insertions(+), 2 deletions(-)
