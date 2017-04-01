Received: from eggs.gnu.org ([2001:4830:134:3::10]:38460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cuIHw-0006Ri-Jn
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 08:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cuIHt-0000Lz-IV
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 08:37:52 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Sat,  1 Apr 2017 23:37:37 +1100
Message-Id: <20170401123741.38469-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [RFC PATCH qemu v3 0/4] vfio-pci,
 spapr: Allow in-kernel acceleration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is my current working tree to support kernel's
"powerpc/kvm/vfio: Enable in-kernel acceleration".

Changes:
v3:
* fixed multiple architectures with respect to IOMMU MR
* removed sPAPRIOMMUMemoryRegion

v2:
* QOM'fy of IOMMUMemoryRegion
* fix comments from v1 review

Please comment. Thanks.



Alexey Kardashevskiy (4):
  memory/iommu: QOM'fy IOMMU MemoryRegion
  vfio-pci: Reorder group-to-container attaching
  vfio/spapr: Add a notifier for PPC64 HV/PR KVM about new group
    attached to LIOBN
  spapr/iommu: Enable in-kernel TCE acceleration via VFIO KVM device

 hw/s390x/s390-pci-bus.h       |   2 +-
 include/exec/memory.h         |  64 ++++++++++++++++++------
 include/hw/i386/intel_iommu.h |   2 +-
 include/hw/ppc/spapr.h        |   4 +-
 include/hw/vfio/vfio-common.h |   4 +-
 include/qemu/typedefs.h       |   1 +
 target/ppc/kvm_ppc.h          |   6 +++
 exec.c                        |  16 +++---
 hw/dma/sun4m_iommu.c          |   2 +-
 hw/i386/amd_iommu.c           |  11 ++--
 hw/i386/intel_iommu.c         |  14 +++---
 hw/ppc/spapr_iommu.c          |  29 ++++++++---
 hw/s390x/s390-pci-bus.c       |   6 +--
 hw/s390x/s390-pci-inst.c      |   8 +--
 hw/vfio/common.c              |  41 ++++++++++-----
 hw/vfio/spapr.c               |  34 ++++++++++++-
 memory.c                      | 114 +++++++++++++++++++++++++++++-------------
 target/ppc/kvm.c              |   7 ++-
 hw/vfio/trace-events          |   1 +
 19 files changed, 265 insertions(+), 101 deletions(-)

-- 
2.11.0
