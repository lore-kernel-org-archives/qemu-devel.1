Received: from eggs.gnu.org ([2001:4830:134:3::10]:34516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gXks3-0008TW-9Y
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:39:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gXks0-00055x-3R
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:39:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gXkrz-00055K-RA
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:38:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3499BDC1
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 10:38:57 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 14 Dec 2018 11:38:49 +0100
Message-Id: <20181214103854.13820-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/5] Usb 20181214 patches
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

The following changes since commit 4f818e7b7f8ecb5c166d093b8859fec2ddeca2ef:

  Update version for v3.1.0-rc5 release (2018-12-06 17:07:12 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20181214-pull-request

for you to fetch changes up to 90c1a74271ce4667d16eeca575dfa78a6c7d465c:

  usb-mtp: Limit filename to object information size (2018-12-14 08:57:17 +0100)

----------------------------------------------------------------
usb: fixes for mtp, ehci, usb-host and pvusb (xen).

----------------------------------------------------------------

Gerd Hoffmann (2):
  ehci: fix fetch qtd race
  usb-mtp: use O_NOFOLLOW and O_CLOEXEC.

Juergen Gross (1):
  pvusb: set max grants only in initialise

Michael Hanselmann (1):
  usb-mtp: Limit filename to object information size

linzhecheng (1):
  usb-host: reset and close libusb_device_handle before qemu exit

 hw/usb/dev-mtp.c     | 22 ++++++++++++++--------
 hw/usb/hcd-ehci.c    | 12 ++++++++++--
 hw/usb/host-libusb.c |  2 ++
 hw/usb/xen-usb.c     | 12 ++++++------
 4 files changed, 32 insertions(+), 16 deletions(-)

-- 
2.9.3
