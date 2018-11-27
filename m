Received: from eggs.gnu.org ([2001:4830:134:3::10]:39319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1gRXEp-0004Pa-V5
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1gRXEm-0003fa-Pn
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:52:51 -0500
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Date: Tue, 27 Nov 2018 06:52:44 +0000
Message-ID: <20181127064101.25887-1-Bharat.Bhushan@nxp.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH RFC v5 0/5] virtio-iommu: VFIO integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "mst@redhat.com" <mst@redhat.com>, "tn@semihalf.com" <tn@semihalf.com>, "drjones@redhat.com" <drjones@redhat.com>, "linu.cherian@cavium.com" <linu.cherian@cavium.com>, "linuc.decode@gmail.com" <linuc.decode@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peterx@redhat.com" <peterx@redhat.com>, "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>, Bharat Bhushan <bharat.bhushan@nxp.com>

This patch series integrates VFIO with virtio-iommu. This is
tested with assigning 2 pci devices to Virtual Machine.

This version is mainly about rebasing on v9 version on
virtio-iommu device framework from Eric Augur.

This patch series allows PCI pass-through using virtio-iommu.

This series is based on:
 - virtio-iommu kernel driver by Jean-Philippe Brucker
    [PATCH v5 0/7] Add virtio-iommu driver
    git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9

 - virtio-iommu device emulation by Eric Augur.
   [RFC,v9,00/17] VIRTIO-IOMMU device
   https://github.com/eauger/qemu/tree/v3.1.0-rc2-virtio-iommu-v0.9

v4->v5:
 - Rebase to v9 version from Eric
 - PCIe device hotplug fix
 - Added Patch 1/5 from Eric previous series (Eric somehow dropped in
   last version.
 - Patch "Translate the MSI doorbell in kvm_arch_fixup_msi_route"
   already integrated with vsmmu3

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

Bharat Bhushan (4):
  virtio-iommu: Add iommu notifier for iommu-map/unmap
  virtio-iommu: Call iommu notifier on attach/detach
  virtio-iommu: add virtio-iommu replay
  virtio-iommu: handle IOMMU Notifier flag changes

Eric Auger (1):
  hw/vfio/common: Do not print error when viommu translates into an mmio
    region

 hw/vfio/common.c                 |   2 -
 hw/virtio/trace-events           |   5 +
 hw/virtio/virtio-iommu.c         | 190 ++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-iommu.h |   6 +
 4 files changed, 198 insertions(+), 5 deletions(-)

--=20
2.19.1
