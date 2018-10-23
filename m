Received: from eggs.gnu.org ([2001:4830:134:3::10]:51427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JF-0003CB-9L
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JC-00088s-JV
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:00 -0400
Received: from [185.30.24.106] (port=13102
	helo=hotspot.internet-for-guests.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JB-0007ZA-O6
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:41:58 -0400
Date: Tue, 23 Oct 2018 19:41:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181023234112.188140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/28] pci, pc, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 13399aad4fa87b2878c49d02a5d3bafa6c966b=
a3:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-10-22=
' into staging (2018-10-23 17:20:23 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 57b279df457c2c4ef66ce9e1b813df35abde69f7:

  vhost-scsi: prevent using uninitialized vqs (2018-10-23 19:29:58 -0400)

----------------------------------------------------------------
pci, pc, virtio: fixes, features

AMD IOMMU VAPIC support + fixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Gerd Hoffmann (1):
      pci-testdev: add optional memory bar

Laszlo Ersek (4):
      MAINTAINERS: list "tests/acpi-test-data" files in ACPI/SMBIOS secti=
on
      hw/pci-host/x86: extract get_pci_hole64_start_value() helpers
      hw/pci-host/x86: extend the 64-bit PCI hole relative to the fw-assi=
gned base
      tests/bios-tables-test: add 64-bit PCI MMIO aperture round-up test =
on Q35

Li Qiang (3):
      i440fx: use ARRAY_SIZE for pam_regions
      piix: use TYPE_FOO constants than string constats
      piix_pci: fix i440fx data sheet link

Mao Zhongyi (1):
      pci_bridge: fix typo in comment

Peter Xu (4):
      intel_iommu: introduce vtd_reset_caches()
      intel_iommu: better handling of dmar state switch
      intel_iommu: move ce fetching out when sync shadow
      intel_iommu: handle invalid ce for shadow sync

Philippe Mathieu-Daud=C3=A9 (3):
      hw/pci-bridge/xio3130: Remove unused functions
      hw/pci-bridge/ioh3420: Remove unuseful header
      hw/pci: Add missing include

Singh, Brijesh (9):
      x86_iommu: move the kernel-irqchip check in common code
      x86_iommu: move vtd_generate_msi_message in common file
      x86_iommu/amd: remove V=3D1 check from amdvi_validate_dte()
      x86_iommu/amd: make the address space naming consistent with intel-=
iommu
      x86_iommu/amd: Prepare for interrupt remap support
      x86_iommu/amd: Add interrupt remap support when VAPIC is not enable=
d
      i386: acpi: add IVHD device entry for IOAPIC
      x86_iommu/amd: Add interrupt remap support when VAPIC is enabled
      x86_iommu/amd: Enable Guest virtual APIC support

Yaowei Bai (1):
      virtio-blk: fix comment for virtio_blk_rw_complete

Yongji Xie (1):
      vhost-user-blk: start vhost when guest kicks

yuchenlin (1):
      vhost-scsi: prevent using uninitialized vqs

 docs/specs/pci-testdev.txt           |  15 +-
 hw/i386/amd_iommu.h                  |  96 +++++++-
 hw/pci-bridge/ioh3420.h              |   6 -
 hw/pci-bridge/xio3130_downstream.h   |  11 -
 hw/pci-bridge/xio3130_upstream.h     |  10 -
 include/hw/i386/intel_iommu.h        |  59 -----
 include/hw/i386/x86-iommu.h          |  66 ++++++
 include/hw/pci/pci_bus.h             |   2 +
 hw/block/vhost-user-blk.c            |  25 +++
 hw/block/virtio-blk.c                |   4 +-
 hw/i386/acpi-build.c                 |  31 ++-
 hw/i386/amd_iommu.c                  | 414 +++++++++++++++++++++++++++++=
+++++-
 hw/i386/intel_iommu.c                | 131 +++++------
 hw/i386/x86-iommu.c                  |  33 +++
 hw/misc/pci-testdev.c                |  19 ++
 hw/pci-bridge/ioh3420.c              |   2 +-
 hw/pci-bridge/xio3130_downstream.c   |  28 +--
 hw/pci-bridge/xio3130_upstream.c     |  24 +-
 hw/pci-host/piix.c                   |  34 ++-
 hw/pci-host/q35.c                    |  17 +-
 hw/pci/pci_bridge.c                  |   2 +-
 hw/scsi/vhost-scsi.c                 |   2 +-
 tests/bios-tables-test.c             |  16 ++
 MAINTAINERS                          |   2 +
 dtc                                  |   2 +-
 hw/i386/trace-events                 |  14 ++
 tests/acpi-test-data/q35/DSDT.mmio64 | Bin 0 -> 8947 bytes
 tests/acpi-test-data/q35/SRAT.mmio64 | Bin 0 -> 224 bytes
 28 files changed, 812 insertions(+), 253 deletions(-)
 delete mode 100644 hw/pci-bridge/ioh3420.h
 delete mode 100644 hw/pci-bridge/xio3130_downstream.h
 delete mode 100644 hw/pci-bridge/xio3130_upstream.h
 create mode 100644 tests/acpi-test-data/q35/DSDT.mmio64
 create mode 100644 tests/acpi-test-data/q35/SRAT.mmio64
