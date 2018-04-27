Received: from eggs.gnu.org ([2001:4830:134:3::10]:57301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1fBzUL-0005pc-5y
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1fBzUI-0006r9-Cz
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:16:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:31924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tina.zhang@intel.com>)
	id 1fBzUI-0006my-4h
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:16:18 -0400
From: Tina Zhang <tina.zhang@intel.com>
Date: Fri, 27 Apr 2018 17:11:04 +0800
Message-Id: <1524820266-27079-1-git-send-email-tina.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v4 0/2] Add vfio dma-buf based display reset
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com, kraxel@redhat.com, zhenyuw@linux.intel.com, hang.yuan@intel.com
Cc: Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, qemu-devel@nongnu.org

vfio display needs to release the invalid display resource and disable
the scanout mode during guest OS reboot, otherwise bugs come out.

Thanks hang.yuan@intel.com for helping root cause the issue.

v3->v4:
 - Move dma-buf based display check into the vfio_display_reset().
   (Gerd)

v2->v3:
 - Limit vfio_display_reset to dma-buf based vfio display. (Gerd)

v1->v2:
 - remove dpy_gfx_switch_surface. (Gerd)
 - add dpy_gfx_update_full. (Gerd)

Tina Zhang (2):
  console: introduce dpy_gfx_update_full
  ui: introduce vfio_display_reset

 hw/vfio/display.c    | 11 +++++++++++
 hw/vfio/pci.c        |  4 ++++
 hw/vfio/pci.h        |  1 +
 include/ui/console.h |  1 +
 ui/console.c         | 10 ++++++++++
 5 files changed, 27 insertions(+)

-- 
2.7.4
