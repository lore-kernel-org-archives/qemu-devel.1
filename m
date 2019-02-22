Received: from eggs.gnu.org ([209.51.188.92]:56958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx3iq-0005NR-RL
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:50:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx3io-0007rK-L7
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:50:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gx3io-0007fW-C3
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:50:06 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 22 Feb 2019 06:49:36 +0100
Message-Id: <20190222054939.19739-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/3] vfio/display: add edid support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, intel-gvt-dev@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>

The 5.0 linux kernel header update finally landed in master.  So this
series has no unmerged dependencies any more.  Rebasing and re-sending
for merge.

This series adds EDID support to the qemu vfio display code.  Various
display-reladed information -- most importantly the display resolution
which should be used -- is passed to the guest that way.  The (initial)
display resolution can be set using the new xres and yres properties.
When supported by the UI it will also be updated on window resizes.

v3:
 - change xres+yres property error handling.
 - swap one leftover fprintf for a tracepoint.

Gerd Hoffmann (3):
  vfio/display: add edid support.
  vfio/display: add xres + yres properties
  vfio/display: delay link up event

 hw/vfio/pci.h                 |   2 +
 include/hw/vfio/vfio-common.h |   4 ++
 hw/vfio/display.c             | 155 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                 |  12 ++++
 hw/vfio/trace-events          |   7 ++
 5 files changed, 180 insertions(+)

-- 
2.9.3
