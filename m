Received: from eggs.gnu.org ([2001:4830:134:3::10]:54413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Bharat.Bhushan@nxp.com>) id 1dVXoP-0001LM-Az
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Bharat.Bhushan@nxp.com>) id 1dVXoK-0004pX-F0
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:41:21 -0400
From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Date: Thu, 13 Jul 2017 12:08:40 +0530
Message-ID: <1499927922-32303-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 0/2] VFIO integration
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

Bharat Bhushan (2):
  target/arm/kvm: Translate the MSI doorbell in kvm_arch_fixup_msi_route
  virtio-iommu: vfio integration with virtio-iommu

 hw/virtio/virtio-iommu.c         | 127 +++++++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-iommu.h |   6 ++
 target/arm/kvm.c                 |  21 +++++++
 3 files changed, 154 insertions(+)

-- 
1.9.3
