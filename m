Received: from eggs.gnu.org ([2001:4830:134:3::10]:50814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ctZUO-0000kK-5E
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ctZUN-00068X-DE
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:47:44 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 30 Mar 2017 23:47:02 +1100
Message-Id: <20170330124707.28142-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [RFC PATCH qemu 0/5] vfio-pci,
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
v2:
* QOM'fy of IOMMUMemoryRegion
* fix comments from v1 review

Please comment. Thanks.



Alexey Kardashevskiy (5):
  memory/iommu: QOM'fy IOMMU MemoryRegion
  spapr-iommu: Subclass TYPE_IOMMU_MEMORY_REGION
  vfio-pci: Reorder group-to-container attaching
  vfio/spapr: Add a notifier for PPC64 HV/PR KVM about new group
    attached to LIOBN
  spapr/iommu: Enable in-kernel TCE acceleration via VFIO KVM device

 include/exec/memory.h         |  50 ++++++++++++++++----
 include/hw/ppc/spapr.h        |  25 +++++++++-
 include/hw/vfio/vfio-common.h |   3 +-
 include/qemu/typedefs.h       |   1 +
 target/ppc/kvm_ppc.h          |   6 +++
 exec.c                        |  16 +++++--
 hw/ppc/spapr_iommu.c          |  47 +++++++++++++++----
 hw/vfio/common.c              |  41 ++++++++++------
 hw/vfio/spapr.c               |  35 +++++++++++++-
 memory.c                      | 106 ++++++++++++++++++++++++++++--------------
 target/ppc/kvm.c              |   7 ++-
 hw/vfio/trace-events          |   1 +
 12 files changed, 264 insertions(+), 74 deletions(-)

-- 
2.11.0
