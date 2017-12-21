Received: from eggs.gnu.org ([2001:4830:134:3::10]:45087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1pI-0006jQ-66
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1pH-0004nQ-4Y
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS1pG-0004n3-Rg
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:27:59 -0500
Date: Thu, 21 Dec 2017 16:27:56 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/25] pc, pci, virtio: features, fixes, cleanups
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

The following changes since commit 2babfe0c9241c239272a03fec785165a50e828=
8c:

  Update version for v2.11.0-rc4 release (2017-12-05 16:36:46 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 664ed92706ff6e66fa278c3163b5387f11d6daca:

  smbus: do not immediately complete commands (2017-12-21 16:24:44 +0200)

----------------------------------------------------------------
pc, pci, virtio: features, fixes, cleanups

A bunch of fixes, cleanus and new features all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Daniel P. Berrange (1):
      smbios: support setting OEM strings table

David Gibson (9):
      pci: Rename root bus initialization functions for clarity
      pci: Move bridge data structures from pci_bus.h to pci_bridge.h
      pci: Add pci_dev_bus_num() helper
      pci: Eliminate redundant PCIDevice::bus pointer
      pci: Eliminate pci_find_primary_bus()
      tests/pxe-test: Remove unnecessary special case test functions
      tests/pxe-test: Use table of testcases rather than open-coding
      tests/pxe-test: Test net booting over IPv6 in some cases
      tests/pxe-test: Add some extra tests

Herv=C3=A9 Poussineau (1):
      smbus: do not immediately complete commands

Ladi Prosek (1):
      virtio-pci: Don't force Subsystem Vendor ID =3D Vendor ID

Marc-Andr=C3=A9 Lureau (1):
      dump-guest-memory.py: fix "You can't do that without a process to d=
ebug"

Michael S. Tsirkin (1):
      virtio_error: don't invoke status callbacks

Peter Xu (2):
      intel_iommu: remove X86_IOMMU_PCI_DEVFN_MAX
      intel_iommu: fix error param in string

Philippe Mathieu-Daud=C3=A9 (4):
      hw/block/nvme: QOM'ify PCI NVME
      hw/pci-host/piix: QOM'ify the IGD Passthrough host bridge
      hw/pci-host/xilinx: QOM'ify the AXI-PCIe host bridge
      hw/pci: remove obsolete PCIDevice->init()

Prasad J Pandit (1):
      tests: add test to check VirtQueue object

Roman Kagan (2):
      qdev-properties: add UUID property type
      vmgenid: use UUID property type

Stefan Hajnoczi (2):
      vhost-user: fix indentation in protocol specification
      vhost-user: document memory accesses

 docs/interop/vhost-user.txt         |  37 +++++++--
 hw/smbios/smbios_build.h            |  12 +++
 include/hw/i386/x86-iommu.h         |   1 -
 include/hw/pci-host/xilinx-pcie.h   |   2 +-
 include/hw/pci/pci.h                |  39 +++++----
 include/hw/pci/pci_bridge.h         |  48 +++++++++++
 include/hw/pci/pci_bus.h            |  51 +-----------
 include/hw/qdev-properties.h        |   9 +++
 include/hw/smbios/smbios.h          |   6 ++
 include/hw/xen/xen_common.h         |   8 +-
 hw/acpi/pcihp.c                     |   4 +-
 hw/acpi/piix4.c                     |   7 +-
 hw/acpi/vmgenid.c                   |  30 ++-----
 hw/alpha/typhoon.c                  |   8 +-
 hw/block/nvme.c                     |  32 ++++----
 hw/core/qdev-properties.c           |  61 ++++++++++++++
 hw/i2c/pm_smbus.c                   |  16 +++-
 hw/i386/intel_iommu.c               |  12 +--
 hw/i386/pc_piix.c                   |   8 +-
 hw/i386/xen/xen_platform.c          |  12 +--
 hw/isa/lpc_ich9.c                   |  10 +--
 hw/mips/gt64xxx_pci.c               |  12 +--
 hw/misc/vmcoreinfo.c                |   3 +
 hw/net/vmxnet3.c                    |   2 +-
 hw/pci-bridge/pci_expander_bridge.c |  21 ++---
 hw/pci-host/apb.c                   |  10 +--
 hw/pci-host/bonito.c                |   8 +-
 hw/pci-host/gpex.c                  |   6 +-
 hw/pci-host/grackle.c               |  14 ++--
 hw/pci-host/piix.c                  |  59 +++++++-------
 hw/pci-host/ppce500.c               |   6 +-
 hw/pci-host/prep.c                  |   4 +-
 hw/pci-host/q35.c                   |   7 +-
 hw/pci-host/uninorth.c              |  24 +++---
 hw/pci-host/versatile.c             |   8 +-
 hw/pci-host/xilinx-pcie.c           |  27 +++----
 hw/pci/pci.c                        | 155 +++++++++++++++---------------=
------
 hw/pci/pci_bridge.c                 |   6 +-
 hw/pci/pcie.c                       |   5 +-
 hw/pci/pcie_aer.c                   |   4 +-
 hw/ppc/ppc4xx_pci.c                 |   6 +-
 hw/ppc/spapr_pci.c                  |  10 +--
 hw/s390x/s390-pci-bus.c             |  18 ++---
 hw/scsi/megasas.c                   |   2 +-
 hw/scsi/mptsas.c                    |   2 +-
 hw/scsi/vmw_pvscsi.c                |   2 +-
 hw/sh4/sh_pci.c                     |  12 +--
 hw/smbios/smbios.c                  |  72 +++++++++++++++++
 hw/usb/hcd-xhci.c                   |   2 +-
 hw/vfio/pci.c                       |  10 +--
 hw/virtio/virtio-pci.c              |  12 +--
 hw/virtio/virtio.c                  |   2 +-
 hw/xen/xen_pt.c                     |  10 +--
 tests/pxe-test.c                    |  99 +++++++++++++++++------
 tests/virtio-blk-test.c             |  25 ++++++
 scripts/dump-guest-memory.py        |   3 +-
 56 files changed, 663 insertions(+), 418 deletions(-)
