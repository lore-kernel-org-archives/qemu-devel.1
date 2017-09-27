Received: from eggs.gnu.org ([2001:4830:134:3::10]:35460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Bharat.Bhushan@nxp.com>) id 1dx5xF-0000z8-Dn
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 02:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Bharat.Bhushan@nxp.com>) id 1dx5xE-00087n-Ag
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 02:36:21 -0400
From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Date: Wed, 27 Sep 2017 12:03:15 +0530
Message-ID: <1506494000-31982-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 0/5] virtio-iommu: VFIO integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: wei@redhat.com, kevin.tian@intel.com, marc.zyngier@arm.com, tn@semihalf.com, will.deacon@arm.com, drjones@redhat.com, robin.murphy@arm.com, christoffer.dall@linaro.org, bharatb.yadav@gmail.com, Bharat Bhushan <Bharat.Bhushan@nxp.com>

This patch series integrates VFIO/VHOST with virtio-iommu.

This version is mainly about rebasing on v4 version on
virtio-iommu device framework from Eric Augur and
addresing review comments.

This patch series allows PCI pass-through using virtio-iommu.
  
This series is based on:
 - virtio-iommu kernel driver by Jean-Philippe Brucker
    [1] [RFC] virtio-iommu version 0.4
    git://linux-arm.org/virtio-iommu.git branch viommu/v0.4

 - virtio-iommu device emulation by Eric Augur.
   [RFC v4 00/16] VIRTIO-IOMMU device
   https://github.com/eauger/qemu/tree/v2.10.0-virtio-iommu-v4

Changes are available at : https://github.com/bharaty/qemu.git virtio-iommu-vfio-integration-v4

v3->v4:
 - Rebase to v4 version from Eric
 - Fixes from Eric with DPDK in VM
 - Logical division in multiple patches

v2->v3:
 - This series is based on "[RFC v3 0/8] VIRTIO-IOMMU device"
   Which is based on top of v2.10-rc0 that
 - Fixed issue with two PCI devices
 - Addressed review comments

v1->v2:
  - Added trace events
  - removed vSMMU3 link in patch description

Bharat Bhushan (5):
  target/arm/kvm: Translate the MSI doorbell in kvm_arch_fixup_msi_route
  virtio-iommu: Add iommu notifier for map/unmap
  virtio-iommu: Call iommu notifier for attach/detach
  virtio-iommu: add iommu replay
  virtio-iommu: add iommu notifier memory-region

 hw/virtio/trace-events           |   5 ++
 hw/virtio/virtio-iommu.c         | 181 ++++++++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-iommu.h |   6 ++
 target/arm/kvm.c                 |  27 ++++++
 target/arm/trace-events          |   3 +
 5 files changed, 219 insertions(+), 3 deletions(-)

-- 
1.9.3
