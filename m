Received: from eggs.gnu.org ([2001:4830:134:3::10]:43422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1evrjS-0003lb-RU
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1evrjP-00078t-O9
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:45:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36212 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1evrjP-00078U-Iw
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:45:15 -0400
Date: Tue, 13 Mar 2018 23:45:06 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1520977432-187679-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/22] virtio,vhost,pci,pc: features, cleanups
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

The following changes since commit 026aaf47c02b79036feb830206cfebb2a72651=
0d:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-re=
quest' into staging (2018-03-13 16:26:44 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 8750b78fcfcb6f49bf037242624953195ada69a8:

  test/acpi-test-data: add ACPI tables for dimmpxm test (2018-03-13 23:09=
:51 +0200)

----------------------------------------------------------------
virtio,vhost,pci,pc: features, cleanups

SRAT tables for DIMM devices
new virtio net flags for speed/duplex
cleanups in pci and vhost

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Haozhong Zhang (5):
      pc-dimm: make qmp_pc_dimm_device_list() sort devices by address
      qmp: distinguish PC-DIMM and NVDIMM in MemoryDeviceInfoList
      hw/acpi-build: build SRAT memory affinity structures for DIMM devic=
es
      tests/bios-tables-test: add test cases for DIMM proximity
      test/acpi-test-data: add ACPI tables for dimmpxm test

Igor Mammedov (10):
      acpi: remove unused acpi-dsdt.aml
      pc: replace pm object initialization with one-liner in acpi_get_pm_=
info()
      acpi: reuse AcpiGenericAddress instead of Acpi20GenericAddress
      acpi: add build_append_gas() helper for Generic Address Structure
      acpi: move ACPI_PORT_SMI_CMD define to header it belongs to
      pc: acpi: isolate FADT specific data into AcpiFadtData structure
      pc: acpi: use build_append_foo() API to construct FADT
      acpi: move build_fadt() from i386 specific to generic ACPI source
      virt_arm: acpi: reuse common build_fadt()
      tests: acpi: don't read all fields in test_acpi_fadt_table()

Jason Baron (3):
      scripts/update-linux-headers: add ethtool.h and update to 4.16.0-rc=
4
      virtio-net: use 64-bit values for feature flags
      virtio-net: add linkspeed and duplex settings to virtio-net

Jay Zhou (1):
      vhost: used_memslots refactoring

Michael S. Tsirkin (2):
      qemu-options-wrapper.h: fix include patch
      standard-headers: update virtio_net.h

Philippe Mathieu-Daud=C3=A9 (1):
      hw/pci: remove obsolete PCIDevice->init()

 Makefile                                    |    1 -
 qapi/misc.json                              |    6 +-
 include/hw/acpi/acpi-defs.h                 |  136 +-
 include/hw/acpi/aml-build.h                 |   23 +
 include/hw/isa/apm.h                        |    3 +
 include/hw/mem/pc-dimm.h                    |    2 +-
 include/hw/pci/pci.h                        |    1 -
 include/hw/virtio/vhost-backend.h           |    6 +-
 include/hw/virtio/virtio-net.h              |    5 +-
 include/standard-headers/linux/ethtool.h    | 1821 +++++++++++++++++++++=
++++++
 include/standard-headers/linux/kernel.h     |   15 +
 include/standard-headers/linux/sysinfo.h    |   25 +
 include/standard-headers/linux/virtio_net.h |   13 +
 qemu-options-wrapper.h                      |    2 +-
 hmp.c                                       |   14 +-
 hw/acpi/aml-build.c                         |  140 ++
 hw/arm/virt-acpi-build.c                    |   39 +-
 hw/i386/acpi-build.c                        |  252 ++--
 hw/isa/apm.c                                |    1 -
 hw/mem/pc-dimm.c                            |   91 +-
 hw/net/virtio-net.c                         |   81 +-
 hw/pci/pci.c                                |   14 -
 hw/ppc/spapr.c                              |    3 +-
 hw/virtio/vhost-backend.c                   |   15 +-
 hw/virtio/vhost-user.c                      |   77 +-
 hw/virtio/vhost.c                           |   13 +-
 numa.c                                      |   23 +-
 qmp.c                                       |    7 +-
 stubs/qmp_pc_dimm.c                         |    4 +-
 tests/bios-tables-test.c                    |  120 +-
 pc-bios/acpi-dsdt.aml                       |  Bin 4405 -> 0 bytes
 scripts/update-linux-headers.sh             |   11 +-
 tests/acpi-test-data/pc/APIC.dimmpxm        |  Bin 0 -> 144 bytes
 tests/acpi-test-data/pc/DSDT.dimmpxm        |  Bin 0 -> 6803 bytes
 tests/acpi-test-data/pc/NFIT.dimmpxm        |  Bin 0 -> 224 bytes
 tests/acpi-test-data/pc/SRAT.dimmpxm        |  Bin 0 -> 472 bytes
 tests/acpi-test-data/pc/SSDT.dimmpxm        |  Bin 0 -> 685 bytes
 tests/acpi-test-data/q35/APIC.dimmpxm       |  Bin 0 -> 144 bytes
 tests/acpi-test-data/q35/DSDT.dimmpxm       |  Bin 0 -> 9487 bytes
 tests/acpi-test-data/q35/NFIT.dimmpxm       |  Bin 0 -> 224 bytes
 tests/acpi-test-data/q35/SRAT.dimmpxm       |  Bin 0 -> 472 bytes
 tests/acpi-test-data/q35/SSDT.dimmpxm       |  Bin 0 -> 685 bytes
 42 files changed, 2489 insertions(+), 475 deletions(-)
 create mode 100644 include/standard-headers/linux/ethtool.h
 create mode 100644 include/standard-headers/linux/kernel.h
 create mode 100644 include/standard-headers/linux/sysinfo.h
 delete mode 100644 pc-bios/acpi-dsdt.aml
 create mode 100644 tests/acpi-test-data/pc/APIC.dimmpxm
 create mode 100644 tests/acpi-test-data/pc/DSDT.dimmpxm
 create mode 100644 tests/acpi-test-data/pc/NFIT.dimmpxm
 create mode 100644 tests/acpi-test-data/pc/SRAT.dimmpxm
 create mode 100644 tests/acpi-test-data/pc/SSDT.dimmpxm
 create mode 100644 tests/acpi-test-data/q35/APIC.dimmpxm
 create mode 100644 tests/acpi-test-data/q35/DSDT.dimmpxm
 create mode 100644 tests/acpi-test-data/q35/NFIT.dimmpxm
 create mode 100644 tests/acpi-test-data/q35/SRAT.dimmpxm
 create mode 100644 tests/acpi-test-data/q35/SSDT.dimmpxm
