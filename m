Received: from eggs.gnu.org ([2001:4830:134:3::10]:56362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ78Y-0005Z9-TU
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ78X-0007Ej-ME
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:37:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZ78X-0007EZ-DK
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:37:41 -0500
Date: Mon, 17 Dec 2018 23:37:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181217233725-mutt-send-email-mst@kernel.org>
References: <20181218041625.24969-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181218041625.24969-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/31] pci, pc, virtio: fixes, features
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

On Mon, Dec 17, 2018 at 11:16:42PM -0500, Michael S. Tsirkin wrote:
> The following changes since commit f163448536e5f7ae8905b14547eab37a41a7=
5f6c:
>=20
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20181216' int=
o staging (2018-12-17 13:04:25 +0000)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>=20
> for you to fetch changes up to 562774d542e9be84411de0233308da380256f631=
:
>=20
>   hw/i386: Remove deprecated machines pc-0.10 and pc-0.11 (2018-12-17 2=
2:45:59 -0500)

oops issue found.
Pls ignore.
Will resend tomorrow.

> ----------------------------------------------------------------
> pci, pc, virtio: fixes, features
>=20
> VTD fixes
> ACPI refactoring
> new names for virtio devices
> multiple pcie link width/speeds
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> ----------------------------------------------------------------
> Alex Williamson (8):
>       pcie: Create enums for link speed and width
>       pci: Sync PCIe downstream port LNKSTA on read
>       qapi: Define PCIe link speed and width properties
>       pcie: Add link speed and width fields to PCIESlot
>       pcie: Fill PCIESlot link fields to support higher speeds and widt=
hs
>       pcie: Allow generic PCIe root port to specify link speed and widt=
h
>       vfio/pci: Remove PCIe Link Status emulation
>       pcie: Fast PCIe root ports for new machines
>=20
> Corey Minyard (1):
>       pc:piix4: Update smbus I/O space after a migration
>=20
> Eduardo Habkost (2):
>       virtio: Helper for registering virtio device types
>       virtio: Provide version-specific variants of virtio PCI devices
>=20
> Igor Mammedov (2):
>       hw: arm: acpi: Fix incorrect checksums in RSDP
>       hw: i386: Use correct RSDT length for checksum
>=20
> Matthias Weckbecker (1):
>       hw/pci-bridge: Fix invalid free()
>=20
> Peter Xu (5):
>       intel_iommu: dump correct iova when failed
>       intel_iommu: convert invalid traces into error reports
>       intel_iommu: dma read/write draining support
>       intel_iommu: remove "x-" prefix for "aw-bits"
>       intel_iommu: turn on IR by default
>=20
> Philippe Mathieu-Daud=E9 (4):
>       tests: Remove unused include
>       hw/smbios: Restrict access to "hw/smbios/ipmi.h"
>       hw/smbios: Remove "smbios_ipmi.h"
>       hw/smbios: Move to the hw/firmware/ subdirectory
>=20
> Samuel Ortiz (6):
>       hw: acpi: The RSDP build API can return void
>       hw: arm: Carry RSDP specific data through AcpiRsdpData
>       hw: arm: Convert the RSDP build to the buid_append_foo() API
>       hw: arm: Support both legacy and current RSDP build
>       hw: acpi: Export and share the ARM RSDP build
>       hw: acpi: Remove AcpiRsdpDescriptor and fix tests
>=20
> Thomas Huth (1):
>       hw/i386: Remove deprecated machines pc-0.10 and pc-0.11
>=20
> Zheng Xiang (1):
>       pcie: set link state inactive/active after hot unplug/plug
>=20
>  qapi/common.json                         |  42 +++++
>  hw/i386/intel_iommu_internal.h           |   3 +
>  hw/smbios/smbios_build.h                 |   4 +
>  hw/virtio/virtio-pci.h                   |  78 +++++++--
>  include/hw/acpi/acpi-defs.h              |  19 +--
>  include/hw/acpi/aml-build.h              |   2 +
>  include/hw/compat.h                      |  10 +-
>  include/hw/{smbios =3D> firmware}/smbios.h |   0
>  include/hw/i386/intel_iommu.h            |   1 +
>  include/hw/i386/pc.h                     |   9 +
>  include/hw/pci/pci.h                     |  13 ++
>  include/hw/pci/pcie.h                    |   1 +
>  include/hw/pci/pcie_port.h               |   4 +
>  include/hw/pci/pcie_regs.h               |  23 ++-
>  include/hw/qdev-properties.h             |   8 +
>  include/hw/smbios/ipmi.h                 |  15 --
>  tests/acpi-utils.h                       |   4 +-
>  hw/acpi/aml-build.c                      |  68 ++++++++
>  hw/acpi/piix4.c                          |   1 +
>  hw/arm/virt-acpi-build.c                 |  40 +----
>  hw/arm/virt.c                            |   2 +-
>  hw/core/qdev-properties.c                | 176 ++++++++++++++++++++
>  hw/display/virtio-gpu-pci.c              |   7 +-
>  hw/display/virtio-vga.c                  |   7 +-
>  hw/i386/acpi-build.c                     |  46 +++---
>  hw/i386/intel_iommu.c                    |  66 ++++++--
>  hw/i386/pc.c                             |   2 +-
>  hw/i386/pc_piix.c                        |  72 +-------
>  hw/i386/pc_q35.c                         |   2 +-
>  hw/i386/x86-iommu.c                      |   2 +-
>  hw/pci-bridge/gen_pcie_root_port.c       |   4 +
>  hw/pci-bridge/pcie_root_port.c           |  14 ++
>  hw/pci/pci.c                             |   4 +
>  hw/pci/pci_bridge.c                      |   2 +-
>  hw/pci/pcie.c                            | 132 ++++++++++++++-
>  hw/smbios/smbios-stub.c                  |   2 +-
>  hw/smbios/smbios.c                       |   3 +-
>  hw/smbios/smbios_type_38-stub.c          |   2 +-
>  hw/smbios/smbios_type_38.c               |   3 +-
>  hw/vfio/pci.c                            |   9 +-
>  hw/virtio/virtio-crypto-pci.c            |   7 +-
>  hw/virtio/virtio-pci.c                   | 271 +++++++++++++++++++++++=
--------
>  tests/acpi-utils.c                       |  47 +++++-
>  tests/bios-tables-test.c                 |  24 ++-
>  tests/cpu-plug-test.c                    |   4 +-
>  tests/vmgenid-test.c                     |   8 +-
>  vl.c                                     |   2 +-
>  MAINTAINERS                              |   2 +-
>  hw/i386/trace-events                     |   6 -
>  qemu-deprecated.texi                     |   2 +-
>  tests/acceptance/virtio_version.py       | 176 ++++++++++++++++++++
>  51 files changed, 1133 insertions(+), 318 deletions(-)
>  rename include/hw/{smbios =3D> firmware}/smbios.h (100%)
>  delete mode 100644 include/hw/smbios/ipmi.h
>  create mode 100644 tests/acceptance/virtio_version.py
>=20
