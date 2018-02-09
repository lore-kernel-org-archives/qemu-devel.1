Received: from eggs.gnu.org ([2001:4830:134:3::10]:47305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ek3Wg-0002E5-Qk
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 02:55:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ek3Wd-0004mG-P1
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 02:55:18 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri,  9 Feb 2018 18:54:59 +1100
Message-Id: <20180209075503.16996-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v7 0/4] vfio-pci: Allow mmap of MSIX BAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Here is my latest patchset to allow mapping of MSIX BAR to the guest
in order to accelerate MMIO on certains devices.

This is based on sha1
008a51b Peter Maydell "Merge remote-tracking branch 'remotes/famz/tags/staging-pull-request' into staging".

Please comment. Thanks.

Changes:
v7:
* split into many patches
* test iova/llsize against pgmask in vfio_listener_region_add/del
* s/vfio_is_cap_present/vfio_has_region_cap/
* added comments here and there
* s/vdev->msix->table_bar/region->nr/


Alexey Kardashevskiy (4):
  linux-headers: update to f1517df8701c
  vfio/pci: Relax DMA map errors for MMIO regions
  vfio-pci: Allow mmap of MSIX BAR
  ppc/spapr, vfio: Turn off MSIX emulation for VFIO devices

 include/hw/vfio/vfio-common.h                      |   1 +
 include/standard-headers/linux/input-event-codes.h |   1 +
 include/standard-headers/linux/input.h             |  11 +
 include/standard-headers/linux/pci_regs.h          |  30 +-
 include/standard-headers/linux/virtio_balloon.h    |   3 +-
 include/standard-headers/linux/virtio_net.h        |  13 +
 linux-headers/asm-powerpc/unistd.h                 |   3 +
 linux-headers/asm-s390/unistd.h                    | 401 +--------------------
 linux-headers/linux/psci.h                         |   3 +
 linux-headers/linux/vfio.h                         |  72 ++++
 hw/ppc/spapr.c                                     |   7 +
 hw/vfio/common.c                                   |  70 +++-
 hw/vfio/pci.c                                      |  22 ++
 13 files changed, 220 insertions(+), 417 deletions(-)

-- 
2.11.0
