Received: from eggs.gnu.org ([2001:4830:134:3::10]:41579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1v8R-0001l4-Ce
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1v8L-0004A4-KG
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:03:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e1v8L-00049L-Ew
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:03:45 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Oct 2017 16:03:28 +0200
Message-Id: <20171010140334.8231-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RfC PATCH 0/6] vfio: add display support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>

This RfC series adds support for a vgpu display to the qemu vfio code.
The region display is completely untested.  The dmabuf support has some
debug code left in for now which will be removed for the final version.

Patches 1-5 apply fine to qemu git master.
Patch 6 depends on the dma-buf series sent a few minutes ago.

Gerd Hoffmann (6):
  headers: update linux-headers/linux/vfio.h (intel-gvt kernel patches,
    v15)
  headers: add drm/drm_fourcc.h to standard-headers
  ui/pixman: add qemu_drm_format_to_pixman()
  vfio/display: core & wireup
  vfio/display: adding region support
  vfio/display: add dmabuf support (v15)

 hw/vfio/pci.h                             |  22 ++
 include/standard-headers/drm/drm_fourcc.h | 382 ++++++++++++++++++++++++++++++
 include/ui/qemu-pixman.h                  |   1 +
 linux-headers/linux/vfio.h                |  62 +++++
 hw/vfio/display.c                         | 317 +++++++++++++++++++++++++
 hw/vfio/pci.c                             |   9 +
 ui/qemu-pixman.c                          |  20 ++
 hw/vfio/Makefile.objs                     |   2 +-
 scripts/update-linux-headers.sh           |   4 +
 9 files changed, 818 insertions(+), 1 deletion(-)
 create mode 100644 include/standard-headers/drm/drm_fourcc.h
 create mode 100644 hw/vfio/display.c

-- 
2.9.3
