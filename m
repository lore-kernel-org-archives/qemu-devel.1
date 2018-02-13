Received: from eggs.gnu.org ([2001:4830:134:3::10]:38972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eldIL-0002GS-AH
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:19:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eldIH-000683-8k
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:19:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49020 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eldIH-00067l-3e
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:18:57 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 13 Feb 2018 17:18:41 +0100
Message-Id: <20180213161846.26914-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RfC PATCH v3 0/5] vfio: add display support
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

This version comes with a full linux kernel header sync to 4.16-rc1
(patch #1) and a small buildfix needed due to the qapi error header
rework.  Otherwise unchanged compared to the previous version.

cheers,
  Gerd

Gerd Hoffmann (5):
  linux-headers: update to 4.16-rc1
  standard-headers: add drm/drm_fourcc.h
  ui/pixman: add qemu_drm_format_to_pixman()
  vfio/display: core & wireup
  vfio/display: adding region support

 hw/vfio/pci.h                                      |   4 +
 include/hw/vfio/vfio-common.h                      |   8 +
 include/standard-headers/drm/drm_fourcc.h          | 411 +++++++++++++++++++++
 include/standard-headers/linux/input-event-codes.h |   1 +
 include/standard-headers/linux/input.h             |  11 +
 include/standard-headers/linux/pci_regs.h          |  30 +-
 include/standard-headers/linux/virtio_balloon.h    |   3 +-
 include/standard-headers/linux/virtio_net.h        |  13 +
 include/ui/qemu-pixman.h                           |   5 +
 linux-headers/asm-powerpc/kvm.h                    |   2 +
 linux-headers/asm-powerpc/unistd.h                 |   3 +
 linux-headers/asm-s390/unistd.h                    | 401 +-------------------
 linux-headers/asm-s390/unistd_32.h                 | 364 ++++++++++++++++++
 linux-headers/asm-s390/unistd_64.h                 | 331 +++++++++++++++++
 linux-headers/asm-x86/kvm_para.h                   |   4 +
 linux-headers/linux/kvm.h                          |  90 +++++
 linux-headers/linux/psci.h                         |   3 +
 linux-headers/linux/vfio.h                         |  72 ++++
 hw/vfio/display.c                                  | 150 ++++++++
 hw/vfio/pci.c                                      |   9 +
 ui/qemu-pixman.c                                   |  22 ++
 hw/vfio/Makefile.objs                              |   2 +-
 scripts/update-linux-headers.sh                    |   7 +
 23 files changed, 1534 insertions(+), 412 deletions(-)
 create mode 100644 include/standard-headers/drm/drm_fourcc.h
 create mode 100644 linux-headers/asm-s390/unistd_32.h
 create mode 100644 linux-headers/asm-s390/unistd_64.h
 create mode 100644 hw/vfio/display.c

-- 
2.9.3
