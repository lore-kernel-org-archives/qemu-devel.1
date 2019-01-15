Received: from eggs.gnu.org ([209.51.188.92]:32873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUwO-0005lm-Oy
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUwM-0001vk-PW
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:04:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUwI-0001qP-FZ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:04:00 -0500
Date: Tue, 15 Jan 2019 15:03:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/49] pci, pc, virtio: fixes, features
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

Changes from v1:
- fix an out of tree build by unmangling a patch I mangled when applying
- fix a gcc 8 build by applying philippe's patches


The following changes since commit 89bd861c2b470e3fb45596945509079c72af3a=
c2:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-reque=
st' into staging (2019-01-14 17:35:00 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 64ed76db175f7ccb5f47195a7617d0106bf01245:

  migration: Use strnlen() for fixed-size string (2019-01-15 14:56:57 -05=
00)

----------------------------------------------------------------
pci, pc, virtio: fixes, features

tpm physical presence interface
rsc support in virtio net
ivshmem is removed
misc cleanups and fixes all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
David Hildenbrand (1):
      pci/pcie: stop plug/unplug if the slot is locked

Dongli Zhang (1):
      msix: make pba size math more uniform

Eduardo Habkost (2):
      globals: Allow global properties to be optional
      virtio: Make disable-legacy/disable-modern compat properties option=
al

Fei Li (1):
      hw/misc/edu: add msi_uninit() for pci_edu_uninit()

Igor Mammedov (8):
      tests: acpi: use AcpiSdtTable::aml in consistent way
      tests: acpi: make sure FADT is fetched only once
      tests: acpi: simplify rsdt handling
      tests: acpi: reuse fetch_table() for fetching FACS and DSDT
      tests: acpi: reuse fetch_table() in vmgenid-test
      tests: smbios: fetch whole table in one step instead of reading it =
step by step
      tests: acpi: squash sanitize_fadt_ptrs() into test_acpi_fadt_table(=
)
      tests: acpi: use AcpiSdtTable::aml instead of AcpiSdtTable::header:=
:signature

Jian Wang (1):
      qemu: avoid memory leak while remove disk

Juan Quintela (16):
      virtio: split vhost vsock bits from virtio-pci
      virtio: split virtio input host bits from virtio-pci
      virtio: split virtio input bits from virtio-pci
      virtio: split virtio rng bits from virtio-pci
      virtio: split virtio balloon bits from virtio-pci
      virtio: split virtio 9p bits from virtio-pci
      virtio: split vhost user blk bits from virtio-pci
      virtio: split vhost user scsi bits from virtio-pci
      virtio: split vhost scsi bits from virtio-pci
      virtio: split virtio scsi bits from virtio-pci
      virtio: split virtio blk bits from virtio-pci
      virtio: split virtio net bits from virtio-pci
      virtio: split virtio serial bits from virtio-pci
      virtio: split virtio gpu bits from virtio-pci.h
      virtio: split virtio crypto bits from virtio-pci.h
      virtio: virtio 9p really requires CONFIG_VIRTFS to work

Li Qiang (3):
      tests: vhost-user-test: initialize 'fd' in chr_read
      vhost-user: fix ioeventfd_enabled
      util: check the return value of fcntl in qemu_set_{block, nonblock}

Marc-Andr=C3=A9 Lureau (4):
      tpm: add a "ppi" boolean property
      acpi: add ACPI memory clear interface
      tpm: clear RAM when "memory overwrite" requested
      migration: Fix stringop-truncation warning

Michael S. Tsirkin (1):
      acpi: update expected files

Philippe Mathieu-Daud=C3=A9 (4):
      qemu/compiler: Define QEMU_NONSTRING
      block/sheepdog: Use QEMU_NONSTRING for non NUL-terminated arrays
      hw/acpi: Use QEMU_NONSTRING for non NUL-terminated arrays
      migration: Use strnlen() for fixed-size string

Stefan Berger (3):
      tpm: allocate/map buffer for TPM Physical Presence interface
      acpi: expose TPM/PPI configuration parameters to firmware via fw_cf=
g
      acpi: build TPM Physical Presence interface

Thomas Huth (1):
      hw/misc/ivshmem: Remove deprecated "ivshmem" legacy device

Yang Zhong (1):
      hw: acpi: Fix memory hotplug AML generation error

Yuri Benditovich (2):
      virtio-net: support RSC v4/v6 tcp traffic for Windows HCK
      virtio-net: changed VIRTIO_NET_F_RSC_EXT to be 61

 docs/specs/ivshmem-spec.txt       |   8 +-
 docs/specs/tpm.txt                | 104 +++++
 default-configs/virtio.mak        |   3 +-
 hw/tpm/tpm_ppi.h                  |  46 +++
 hw/virtio/virtio-pci.h            | 234 -----------
 include/hw/acpi/acpi-defs.h       |  13 +-
 include/hw/acpi/tpm.h             |  21 +
 include/hw/pci/pcie.h             |   2 +
 include/hw/qdev-core.h            |   3 +
 include/hw/virtio/virtio-net.h    |  83 ++++
 include/net/eth.h                 |   2 +
 include/qemu/compiler.h           |  15 +
 tests/acpi-utils.h                |  44 +--
 block/sheepdog.c                  |   2 +-
 hw/acpi/core.c                    |  12 +-
 hw/acpi/memory_hotplug.c          |  10 +-
 hw/acpi/tpm.c                     | 459 +++++++++++++++++++++
 hw/block/vhost-user-blk.c         |   7 +-
 hw/core/machine.c                 |   7 +-
 hw/display/virtio-gpu-pci.c       |  14 +
 hw/display/virtio-vga.c           |   1 +
 hw/i386/acpi-build.c              |  29 +-
 hw/i386/pc_piix.c                 |   1 -
 hw/misc/edu.c                     |   1 +
 hw/misc/ivshmem.c                 | 210 +---------
 hw/net/virtio-net.c               | 667 ++++++++++++++++++++++++++++++-
 hw/pci/msix.c                     |   2 +-
 hw/pci/pcie.c                     |  25 +-
 hw/pci/pcie_port.c                |   1 +
 hw/scsi/vhost-scsi.c              |   3 +-
 hw/scsi/vhost-user-scsi.c         |   3 +-
 hw/tpm/tpm_crb.c                  |  13 +
 hw/tpm/tpm_ppi.c                  |  53 +++
 hw/tpm/tpm_tis.c                  |  13 +
 hw/virtio/vhost-scsi-pci.c        |  97 +++++
 hw/virtio/vhost-user-blk-pci.c    | 103 +++++
 hw/virtio/vhost-user-scsi-pci.c   | 103 +++++
 hw/virtio/vhost-user.c            |   2 +-
 hw/virtio/vhost-vsock-pci.c       |  86 ++++
 hw/virtio/virtio-9p-pci.c         |  88 +++++
 hw/virtio/virtio-balloon-pci.c    |  95 +++++
 hw/virtio/virtio-blk-pci.c        | 100 +++++
 hw/virtio/virtio-crypto-pci.c     |  14 +
 hw/virtio/virtio-input-host-pci.c |  48 +++
 hw/virtio/virtio-input-pci.c      | 157 ++++++++
 hw/virtio/virtio-net-pci.c        |  98 +++++
 hw/virtio/virtio-pci.c            | 811 +-------------------------------=
------
 hw/virtio/virtio-rng-pci.c        |  88 +++++
 hw/virtio/virtio-scsi-pci.c       | 107 +++++
 hw/virtio/virtio-serial-pci.c     | 115 ++++++
 migration/global_state.c          |  15 +-
 qom/object.c                      |   3 +
 stubs/tpm.c                       |   5 +
 tests/acpi-utils.c                |  35 +-
 tests/bios-tables-test.c          | 271 ++++---------
 tests/ivshmem-test.c              |  67 ++--
 tests/vhost-user-test.c           |   2 +-
 tests/vmgenid-test.c              |  64 +--
 util/oslib-posix.c                |   8 +-
 hw/acpi/Makefile.objs             |   1 +
 hw/tpm/Makefile.objs              |   1 +
 hw/tpm/trace-events               |   3 +
 hw/virtio/Makefile.objs           |  15 +
 qemu-deprecated.texi              |   5 -
 scripts/device-crash-test         |   1 -
 tests/Makefile.include            |  20 +-
 tests/data/acpi/pc/DSDT.dimmpxm   | Bin 6790 -> 6784 bytes
 tests/data/acpi/pc/DSDT.memhp     | Bin 6496 -> 6490 bytes
 tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9474 -> 9468 bytes
 tests/data/acpi/q35/DSDT.memhp    | Bin 9180 -> 9174 bytes
 tests/data/acpi/q35/DSDT.mmio64   | Bin 8947 -> 8945 bytes
 71 files changed, 3101 insertions(+), 1638 deletions(-)
 create mode 100644 hw/tpm/tpm_ppi.h
 create mode 100644 hw/acpi/tpm.c
 create mode 100644 hw/tpm/tpm_ppi.c
 create mode 100644 hw/virtio/vhost-scsi-pci.c
 create mode 100644 hw/virtio/vhost-user-blk-pci.c
 create mode 100644 hw/virtio/vhost-user-scsi-pci.c
 create mode 100644 hw/virtio/vhost-vsock-pci.c
 create mode 100644 hw/virtio/virtio-9p-pci.c
 create mode 100644 hw/virtio/virtio-balloon-pci.c
 create mode 100644 hw/virtio/virtio-blk-pci.c
 create mode 100644 hw/virtio/virtio-input-host-pci.c
 create mode 100644 hw/virtio/virtio-input-pci.c
 create mode 100644 hw/virtio/virtio-net-pci.c
 create mode 100644 hw/virtio/virtio-rng-pci.c
 create mode 100644 hw/virtio/virtio-scsi-pci.c
 create mode 100644 hw/virtio/virtio-serial-pci.c
