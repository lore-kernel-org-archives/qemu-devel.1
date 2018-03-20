Received: from eggs.gnu.org ([2001:4830:134:3::10]:56070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyITc-0003zR-SN
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyITZ-00080v-Mz
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:43:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58958 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eyITZ-00080Y-Fm
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:42:57 -0400
Date: Tue, 20 Mar 2018 16:42:52 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521556868-37974-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 00/51] virtio, vhost, pci, pc: features,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Note: only patch 39/51 is attached.
The rest are unchanged from v2.

The following changes since commit 026aaf47c02b79036feb830206cfebb2a72651=
0d:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-re=
quest' into staging (2018-03-13 16:26:44 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 1dc61e7b37d339c42ec9bd7a7eec1ef2c22f351c:

  postcopy shared docs (2018-03-20 16:40:37 +0200)

----------------------------------------------------------------
virtio,vhost,pci,pc: features, cleanups

SRAT tables for DIMM devices
new virtio net flags for speed/duplex
post-copy migration support in vhost
cleanups in pci

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dr. David Alan Gilbert (29):
      migrate: Update ram_block_discard_range for shared
      qemu_ram_block_host_offset
      postcopy: use UFFDIO_ZEROPAGE only when available
      postcopy: Add notifier chain
      postcopy: Add vhost-user flag for postcopy and check it
      vhost-user: Add 'VHOST_USER_POSTCOPY_ADVISE' message
      libvhost-user: Support sending fds back to qemu
      libvhost-user: Open userfaultfd
      postcopy: Allow registering of fd handler
      vhost+postcopy: Register shared ufd with postcopy
      vhost+postcopy: Transmit 'listen' to slave
      postcopy+vhost-user: Split set_mem_table for postcopy
      migration/ram: ramblock_recv_bitmap_test_byte_offset
      libvhost-user+postcopy: Register new regions with the ufd
      vhost+postcopy: Send address back to qemu
      vhost+postcopy: Stash RAMBlock and offset
      vhost+postcopy: Helper to send requests to source for shared pages
      vhost+postcopy: Resolve client address
      postcopy: helper for waking shared
      postcopy: postcopy_notify_shared_wake
      vhost+postcopy: Add vhost waker
      vhost+postcopy: Call wakeups
      libvhost-user: mprotect & madvises for postcopy
      vhost-user: Add VHOST_USER_POSTCOPY_END message
      vhost+postcopy: Wire up POSTCOPY_END notify
      vhost: Huge page align and merge
      postcopy: Allow shared memory
      libvhost-user: Claim support for postcopy
      postcopy shared docs

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

Michael S. Tsirkin (3):
      standard-headers: update virtio_net.h
      Makefile: add target to print generated files
      postcopy-ram: add a stub for postcopy_request_shared_page

Philippe Mathieu-Daud=C3=A9 (1):
      hw/pci: remove obsolete PCIDevice->init()

 docs/interop/vhost-user.txt                 |   52 +
 Makefile                                    |    4 +-
 qapi/misc.json                              |    6 +-
 contrib/libvhost-user/libvhost-user.h       |   11 +
 include/exec/cpu-common.h                   |    4 +
 include/hw/acpi/acpi-defs.h                 |  136 +-
 include/hw/acpi/aml-build.h                 |   23 +
 include/hw/isa/apm.h                        |    3 +
 include/hw/mem/pc-dimm.h                    |    2 +-
 include/hw/pci/pci.h                        |    1 -
 include/hw/virtio/virtio-net.h              |    5 +-
 include/standard-headers/linux/ethtool.h    | 1821 +++++++++++++++++++++=
++++++
 include/standard-headers/linux/kernel.h     |   15 +
 include/standard-headers/linux/sysinfo.h    |   25 +
 include/standard-headers/linux/virtio_net.h |   13 +
 migration/migration.h                       |    4 +
 migration/postcopy-ram.h                    |   73 ++
 migration/ram.h                             |    1 +
 contrib/libvhost-user/libvhost-user.c       |  302 ++++-
 exec.c                                      |   86 +-
 hmp.c                                       |   14 +-
 hw/acpi/aml-build.c                         |  140 ++
 hw/arm/virt-acpi-build.c                    |   39 +-
 hw/i386/acpi-build.c                        |  252 ++--
 hw/isa/apm.c                                |    1 -
 hw/mem/pc-dimm.c                            |   91 +-
 hw/net/virtio-net.c                         |   81 +-
 hw/pci/pci.c                                |   14 -
 hw/ppc/spapr.c                              |    3 +-
 hw/virtio/vhost-user.c                      |  411 +++++-
 hw/virtio/vhost.c                           |   66 +-
 migration/migration.c                       |    6 +
 migration/postcopy-ram.c                    |  360 +++++-
 migration/ram.c                             |    5 +
 migration/savevm.c                          |   13 +
 numa.c                                      |   23 +-
 qmp.c                                       |    7 +-
 stubs/qmp_pc_dimm.c                         |    4 +-
 tests/bios-tables-test.c                    |  120 +-
 vl.c                                        |    2 +
 docs/devel/migration.rst                    |   41 +
 hw/virtio/trace-events                      |   16 +-
 migration/trace-events                      |    6 +
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
 trace-events                                |    3 +-
 56 files changed, 3780 insertions(+), 536 deletions(-)
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
