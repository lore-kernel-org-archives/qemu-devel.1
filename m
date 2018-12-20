Received: from eggs.gnu.org ([2001:4830:134:3::10]:58889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3Cf-0003GB-Mc
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3Ca-0006R7-Rd
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:37:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ga3Ca-0006PV-Ii
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:37:44 -0500
Date: Thu, 20 Dec 2018 13:37:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181220183059.20726-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 00/44] pci, pc, virtio: fixes, features
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

The following changes since commit b72566a4ffaddbc0c0c1f6f5ee91b42ab13ff4=
29:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull=
-request' into staging (2018-12-19 15:31:02 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 47748bbba24d4f4680b77da3dc5b4da531cd17d4:

  x86-iommu: turn on IR by default if proper (2018-12-20 13:25:11 -0500)

----------------------------------------------------------------
pci, pc, virtio: fixes, features

VTD fixes
IR and split irqchip are now the default for Q35
ACPI refactoring
hotplug refactoring
new names for virtio devices
multiple pcie link width/speeds
PCI fixes

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alex Williamson (9):
      pcie: Create enums for link speed and width
      pci: Sync PCIe downstream port LNKSTA on read
      qapi: Define PCIe link speed and width properties
      pcie: Add link speed and width fields to PCIESlot
      pcie: Fill PCIESlot link fields to support higher speeds and widths
      pcie: Allow generic PCIe root port to specify link speed and width
      vfio/pci: Remove PCIe Link Status emulation
      pcie: Fast PCIe root ports for new machines
      pci: Adjust PCI config limit based on bus topology

Corey Minyard (1):
      pc:piix4: Update smbus I/O space after a migration

David Hildenbrand (10):
      pci/pcie: rename hotplug handler callbacks
      pci/shpc: rename hotplug handler callbacks
      s390x/pci: rename hotplug handler callbacks
      pci/pcihp: perform check for bus capability in pre_plug handler
      pci/pcihp: overwrite hotplug handler recursively from the start
      pci/pcihp: perform unplug via the hotplug handler
      pci/pcie: perform unplug via the hotplug handler
      pci: Reuse pci-bridge hotplug handler handlers for pcie-pci-bridge
      pci/shpc: perform unplug via the hotplug handler
      spapr_pci: perform unplug via the hotplug handler

Eduardo Habkost (2):
      virtio: Helper for registering virtio device types
      virtio: Provide version-specific variants of virtio PCI devices

Igor Mammedov (2):
      hw: arm: acpi: Fix incorrect checksums in RSDP
      hw: i386: Use correct RSDT length for checksum

Matthias Weckbecker (1):
      hw/pci-bridge: Fix invalid free()

Peter Xu (7):
      intel_iommu: dump correct iova when failed
      intel_iommu: convert invalid traces into error reports
      intel_iommu: dma read/write draining support
      intel_iommu: remove "x-" prefix for "aw-bits"
      q35: set split kernel irqchip as default
      x86-iommu: switch intr_supported to OnOffAuto type
      x86-iommu: turn on IR by default if proper

Philippe Mathieu-Daud=C3=A9 (4):
      tests: Remove unused include
      hw/smbios: Restrict access to "hw/smbios/ipmi.h"
      hw/smbios: Remove "smbios_ipmi.h"
      hw/smbios: Move to the hw/firmware/ subdirectory

Samuel Ortiz (6):
      hw: acpi: The RSDP build API can return void
      hw: arm: Carry RSDP specific data through AcpiRsdpData
      hw: arm: Convert the RSDP build to the buid_append_foo() API
      hw: arm: Support both legacy and current RSDP build
      hw: acpi: Export and share the ARM RSDP build
      hw: acpi: Remove AcpiRsdpDescriptor and fix tests

Thomas Huth (1):
      hw/i386: Remove deprecated machines pc-0.10 and pc-0.11

Zheng Xiang (1):
      pcie: set link state inactive/active after hot unplug/plug

 qapi/common.json                         |  42 +++++
 hw/i386/intel_iommu_internal.h           |   3 +
 hw/smbios/smbios_build.h                 |   4 +
 hw/virtio/virtio-pci.h                   |  78 +++++++--
 include/hw/acpi/acpi-defs.h              |  19 +--
 include/hw/acpi/aml-build.h              |   2 +
 include/hw/acpi/pcihp.h                  |   5 +
 include/hw/boards.h                      |   1 +
 include/hw/compat.h                      |  10 +-
 include/hw/{smbios =3D> firmware}/smbios.h |   0
 include/hw/i386/intel_iommu.h            |   1 +
 include/hw/i386/pc.h                     |   5 +
 include/hw/i386/x86-iommu.h              |   4 +-
 include/hw/pci/pci.h                     |  13 ++
 include/hw/pci/pci_bridge.h              |   6 +
 include/hw/pci/pcie.h                    |  11 +-
 include/hw/pci/pcie_port.h               |   4 +
 include/hw/pci/pcie_regs.h               |  23 ++-
 include/hw/pci/shpc.h                    |  10 +-
 include/hw/qdev-properties.h             |   8 +
 include/hw/smbios/ipmi.h                 |  15 --
 tests/acpi-utils.h                       |   5 +-
 hw/acpi/aml-build.c                      |  68 ++++++++
 hw/acpi/pcihp.c                          |  47 +++++-
 hw/acpi/piix4.c                          |  40 ++---
 hw/arm/virt-acpi-build.c                 |  40 +----
 hw/arm/virt.c                            |   2 +-
 hw/core/machine.c                        |   2 +
 hw/core/qdev-properties.c                | 176 ++++++++++++++++++++
 hw/display/virtio-gpu-pci.c              |   7 +-
 hw/display/virtio-vga.c                  |   7 +-
 hw/i386/acpi-build.c                     |  52 +++---
 hw/i386/amd_iommu.c                      |   2 +-
 hw/i386/intel_iommu.c                    |  72 +++++---
 hw/i386/pc.c                             |   4 +-
 hw/i386/pc_piix.c                        |  72 +-------
 hw/i386/pc_q35.c                         |   4 +-
 hw/i386/x86-iommu.c                      |  18 +-
 hw/pci-bridge/gen_pcie_root_port.c       |   4 +
 hw/pci-bridge/pci_bridge_dev.c           |  47 +++---
 hw/pci-bridge/pcie_pci_bridge.c          |  32 +---
 hw/pci-bridge/pcie_root_port.c           |  14 ++
 hw/pci/pci.c                             |   4 +
 hw/pci/pci_bridge.c                      |   2 +-
 hw/pci/pci_host.c                        |  26 +++
 hw/pci/pcie.c                            | 159 ++++++++++++++++--
 hw/pci/pcie_port.c                       |   5 +-
 hw/pci/shpc.c                            |  25 ++-
 hw/ppc/spapr_pci.c                       |  33 ++--
 hw/s390x/s390-pci-bus.c                  |  12 +-
 hw/smbios/smbios-stub.c                  |   2 +-
 hw/smbios/smbios.c                       |   3 +-
 hw/smbios/smbios_type_38-stub.c          |   2 +-
 hw/smbios/smbios_type_38.c               |   3 +-
 hw/vfio/pci.c                            |   9 +-
 hw/virtio/virtio-crypto-pci.c            |   7 +-
 hw/virtio/virtio-pci.c                   | 271 +++++++++++++++++++++++--=
------
 tests/acpi-utils.c                       |  48 ++++--
 tests/bios-tables-test.c                 |  24 ++-
 tests/cpu-plug-test.c                    |   4 +-
 tests/vmgenid-test.c                     |   8 +-
 vl.c                                     |   2 +-
 MAINTAINERS                              |   2 +-
 hw/i386/trace-events                     |   6 -
 qemu-deprecated.texi                     |   2 +-
 tests/acceptance/virtio_version.py       | 176 ++++++++++++++++++++
 66 files changed, 1363 insertions(+), 451 deletions(-)
 rename include/hw/{smbios =3D> firmware}/smbios.h (100%)
 delete mode 100644 include/hw/smbios/ipmi.h
 create mode 100644 tests/acceptance/virtio_version.py
