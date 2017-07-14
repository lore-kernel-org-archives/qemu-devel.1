Received: from eggs.gnu.org ([2001:4830:134:3::10]:59065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Bharat.Bhushan@nxp.com>) id 1dVv0m-0002X5-F7
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Bharat.Bhushan@nxp.com>) id 1dVv0j-0002fG-CP
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:27:40 -0400
From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Date: Fri, 14 Jul 2017 12:55:02 +0530
Message-ID: <1500017104-3574-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v2 PATCH 0/2] VFIO integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: wei@redhat.com, kevin.tian@intel.com, marc.zyngier@arm.com, tn@semihalf.com, will.deacon@arm.com, drjones@redhat.com, robin.murphy@arm.com, christoffer.dall@linaro.org, Bharat Bhushan <Bharat.Bhushan@nxp.com>

This patch series allows PCI pass-through using
virtio-iommu.

This series is based on:
 - virtio-iommu specification written by Jean-Philippe Brucker
   [RFC 0/3] virtio-iommu: a paravirtualized IOMMU,
 
 - virtio-iommu driver by Jean-Philippe Brucker
   [RFC PATCH linux] iommu: Add virtio-iommu driver
 
 - virtio-iommu device emulation by Eric Augur.
   [RFC v2 0/8] VIRTIO-IOMMU device

PCI device pass-through and virtio-net-pci is tested
with these chages using dma-ops

This patch series does not implement RESV_MEM changes proposal by
Jean-Philippe "https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg01796.html"

v1-v2:
  - Added trace events
  - removed vSMMU3 link in patch description

Bharat Bhushan (2):
  target/arm/kvm: Translate the MSI doorbell in kvm_arch_fixup_msi_route
  virtio-iommu: vfio integration with virtio-iommu

 hw/virtio/trace-events           |   5 ++
 hw/virtio/virtio-iommu.c         | 133 +++++++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-iommu.h |   6 ++
 target/arm/kvm.c                 |  25 ++++++++
 target/arm/trace-events          |   3 +
 5 files changed, 172 insertions(+)

-- 
1.9.3
