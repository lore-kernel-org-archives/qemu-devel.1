Received: from eggs.gnu.org ([2001:4830:134:3::10]:39136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egrFp-0004dj-RO
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 07:12:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egrFk-00084q-06
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 07:12:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egrFj-00084E-Q5
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 07:12:35 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 31 Jan 2018 13:12:12 +0100
Message-Id: <20180131121217.13557-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RfC PATCH v2 0/5] vfio: add display support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>

This series adds support for a vgpu display to the qemu vfio code.
For now only regions are supported, dmabufs will follow later.

The vfio API update is done, queued in drm-next, should land in the
upstream kernel during the 4.16 merge window.  So the 4.16-rc1 kernel
header sync should bring the header changes needed for this series.

Patch #1 of this series has the vfio.h updates too, for testing
convinience, but I don't plan to include that patch in the final
patch submission.

plese test and review,
  Gerd

Gerd Hoffmann (5):
  headers: update linux-headers/linux/vfio.h (intel-gvt kernel patches,
    v17)
  headers: add drm/drm_fourcc.h to standard-headers
  ui/pixman: add qemu_drm_format_to_pixman()
  vfio/display: core & wireup
  vfio/display: adding region support

 hw/vfio/pci.h                             |   4 +
 include/hw/vfio/vfio-common.h             |   8 +
 include/standard-headers/drm/drm_fourcc.h | 382 ++++++++++++++++++++++++++++++
 include/ui/qemu-pixman.h                  |   5 +
 linux-headers/linux/vfio.h                |  64 +++++
 hw/vfio/display.c                         | 149 ++++++++++++
 hw/vfio/pci.c                             |   9 +
 ui/qemu-pixman.c                          |  22 ++
 hw/vfio/Makefile.objs                     |   2 +-
 scripts/update-linux-headers.sh           |   4 +
 10 files changed, 648 insertions(+), 1 deletion(-)
 create mode 100644 include/standard-headers/drm/drm_fourcc.h
 create mode 100644 hw/vfio/display.c

-- 
2.9.3
