Received: from eggs.gnu.org ([2001:4830:134:3::10]:50198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eWF7Z-0006EJ-4s
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 00:28:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eWF7W-00006e-0f
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 00:28:17 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue,  2 Jan 2018 16:28:02 +1100
Message-Id: <20180102052805.20498-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH qemu 0/3] spapr/iommu: Enable in-kernel TCE
 acceleration via VFIO KVM device
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

This is my current queue of the in-kernel TCE acceleration
enablement.

Changes since https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg01=
918.html :
* 3 patches instead of one, one per maintainership area;
* added memory_region_iommu_get_attr();
* removed set_attr() as there is no use for it now;
* folded the chunk in vfio_listener_region_add() under
VFIO_SPAPR_TCE_v2_IOMMU branch as the acceleration is only
enabled when DMA memory is preregistered and this is only supported
by the v2 IOMMU.

This is based on sha1
ad59cde C=C3=A9dric Le Goater "target/ppc: more use of the PPC_*() macros=
".

Please comment. Thanks.



Alexey Kardashevskiy (3):
  memory/iommu: Add get_attr()
  vfio/spapr: Use iommu memory region's get_attr()
  spapr/iommu: Enable in-kernel TCE acceleration via VFIO KVM device

 include/exec/memory.h | 22 ++++++++++++++++++++++
 target/ppc/kvm_ppc.h  |  6 ++++++
 hw/ppc/spapr_iommu.c  | 19 +++++++++++++++++++
 hw/vfio/common.c      | 26 ++++++++++++++++++++++++++
 memory.c              | 13 +++++++++++++
 target/ppc/kvm.c      |  7 ++++++-
 hw/vfio/trace-events  |  1 +
 7 files changed, 93 insertions(+), 1 deletion(-)

--=20
2.11.0
