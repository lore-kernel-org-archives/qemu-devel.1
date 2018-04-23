Received: from eggs.gnu.org ([2001:4830:134:3::10]:49021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1fAWhi-0006uV-H1
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 04:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1fAWhe-0001Lf-L9
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 04:20:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:30758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tina.zhang@intel.com>)
	id 1fAWhe-0001K7-Bs
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 04:20:02 -0400
From: Tina Zhang <tina.zhang@intel.com>
Date: Mon, 23 Apr 2018 16:14:36 +0800
Message-Id: <1524471278-22546-1-git-send-email-tina.zhang@intel.com>
Subject: [Qemu-devel] [PATCH 0/2] Add vfio display reset handling
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

Tina Zhang (2):
  console: introduce dpy_gfx_switch_surface
  ui: introduce vfio_display_reset

 hw/vfio/display.c    | 20 ++++++++++++++++++++
 hw/vfio/pci.c        |  4 ++++
 hw/vfio/pci.h        |  1 +
 include/ui/console.h |  2 ++
 ui/console.c         | 16 ++++++++++++++++
 5 files changed, 43 insertions(+)

-- 
2.7.4
