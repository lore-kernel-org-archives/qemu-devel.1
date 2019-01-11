Received: from eggs.gnu.org ([209.51.188.92]:34527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghtAB-0000fZ-Fm
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghtA7-0003EF-5P
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:31:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghtA3-00034n-1K
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:31:33 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 11 Jan 2019 10:31:11 +0100
Message-Id: <20190111093116.17188-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] vfio/display: add edid support.
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

The 5.0-rc1 linux kernel header update -- which contains the vfio api
update for edid support -- is about to land in qemu master.  Intel just
posted patches implementing EDID support.  Time to undust the test
patches, polish them and post them for review & merge.

This series adds EDID support to the qemu vfio display code.  Various
display-reladed information -- most importantly the display resolution
which should be used -- is passed to the guest that way.  The (initial)
display resolution can be set using the new xres and yres properties.
When supported by the UI it will also be updated on window resizes.

Gerd Hoffmann (5):
  vfio: update kernel headers.
  vfio/display: add edid support.
  vfio/display: add xres + yres properties
  vfio/display: delay link up event
  [debug] some logging

 hw/vfio/pci.h                 |   2 +
 include/hw/vfio/vfio-common.h |   4 ++
 linux-headers/linux/vfio.h    |  50 +++++++++++++
 hw/vfio/display.c             | 158 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                 |   2 +
 5 files changed, 216 insertions(+)

-- 
2.9.3
