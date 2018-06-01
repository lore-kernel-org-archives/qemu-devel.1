Received: from eggs.gnu.org ([2001:4830:134:3::10]:38496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmt3-0001vt-4E
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmsz-00072m-UC
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:26:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60106 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fOmsz-000728-Ma
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:26:41 -0400
Date: Fri, 1 Jun 2018 19:26:40 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601162620.32362-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 00/31] acpi, vhost, misc: fixes, features
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

The following changes since commit 63b88968f139b6a77f2f81e6f1eedf70c0170a85:

  intel-iommu: rework the page walk logic (2018-05-23 17:34:05 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 25b1d45a1975fd8624c37b5bf42e8502ccf53460:

  vhost-blk: turn on pre-defined RO feature bit (2018-06-01 19:20:38 +0300)

----------------------------------------------------------------
acpi, vhost, misc: fixes, features

vDPA support, fix to vhost blk RO bit handling, some include path
cleanups, NFIT ACPI table.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Changpeng Liu (1):
      vhost-blk: turn on pre-defined RO feature bit

Michael S. Tsirkin (21):
      osdep: add wait.h compat macros
      libqtest: fail if child coredumps
      block: use local path for local headers
      crypto: use local path for local headers
      hppa: use local path for local headers
      migration: drop an unused include
      trace: use local path for local headers
      display: use local path for local headers
      ide: use local path for local headers
      ioapic: fix up includes
      e1000e: use local path for local headers
      rocker: drop an unused include
      ppc: use local path for local headers
      vhost-scsi: drop an unused include
      sd: fix up include
      usb: use local path for local headers
      migration: use local path for local headers
      colo: use local path for local headers
      qga: use local path for local headers
      ui: use local path for local headers
      arch_init: sort architectures

Ross Zwisler (3):
      tests/.gitignore: add entry for generated file
      nvdimm, acpi: support NFIT platform capabilities
      ACPI testing: test NFIT platform capabilities

Tiwei Bie (6):
      vhost: allow backends to filter memory sections
      vhost-user: allow slave to send fds via slave channel
      vhost-user: introduce shared vhost-user state
      vhost-user: support registering external host notifiers
      libvhost-user: support host notifier
      vhost-user-bridge: support host notifier

 docs/interop/vhost-user.txt             |  38 +++++++
 docs/nvdimm.txt                         |  27 +++++
 contrib/libvhost-user/libvhost-user.h   |  32 ++++++
 crypto/block-luks.h                     |   2 +-
 crypto/block-qcow.h                     |   2 +-
 crypto/ivgen-essiv.h                    |   2 +-
 crypto/ivgen-plain.h                    |   2 +-
 crypto/ivgen-plain64.h                  |   2 +-
 hw/hppa/hppa_sys.h                      |   2 +-
 include/hw/i386/pc.h                    |   1 +
 include/hw/mem/nvdimm.h                 |   5 +
 include/hw/virtio/vhost-backend.h       |   4 +
 include/hw/virtio/vhost-user-blk.h      |   3 +-
 include/hw/virtio/vhost-user-scsi.h     |   2 +
 include/hw/virtio/vhost-user.h          |  28 +++++
 include/migration/vmstate.h             |   2 +-
 include/qemu/osdep.h                    |  10 ++
 trace/control.h                         |   2 +-
 arch_init.c                             |  16 +--
 backends/cryptodev-vhost-user.c         |  20 +++-
 block/crypto.c                          |   2 +-
 block/nbd.c                             |   2 +-
 block/qcow.c                            |   2 +-
 block/qcow2-bitmap.c                    |   2 +-
 block/qcow2-cluster.c                   |   2 +-
 block/qcow2-refcount.c                  |   2 +-
 block/qcow2-snapshot.c                  |   2 +-
 block/qcow2.c                           |   4 +-
 block/vhdx-endian.c                     |   2 +-
 block/vhdx-log.c                        |   2 +-
 block/vhdx.c                            |   2 +-
 contrib/libvhost-user/libvhost-user.c   |  81 ++++++++++++--
 contrib/vhost-user-blk/vhost-user-blk.c |  48 ++++++---
 crypto/block-luks.c                     |   2 +-
 crypto/block-qcow.c                     |   2 +-
 crypto/block.c                          |   6 +-
 crypto/cipher.c                         |   6 +-
 crypto/ivgen-essiv.c                    |   2 +-
 crypto/ivgen-plain.c                    |   2 +-
 crypto/ivgen-plain64.c                  |   2 +-
 crypto/ivgen.c                          |   8 +-
 crypto/tlscreds.c                       |   2 +-
 crypto/tlscredsanon.c                   |   2 +-
 crypto/tlscredsx509.c                   |   2 +-
 hw/acpi/nvdimm.c                        |  45 +++++++-
 hw/block/vhost-user-blk.c               |  27 ++++-
 hw/display/bcm2835_fb.c                 |   2 +-
 hw/hppa/machine.c                       |   2 +-
 hw/i386/pc.c                            |  31 ++++++
 hw/ide/ahci-allwinner.c                 |   2 +-
 hw/ide/ahci.c                           |   2 +-
 hw/ide/ich.c                            |   2 +-
 hw/intc/ioapic.c                        |   3 +-
 hw/net/e1000e.c                         |   2 +-
 hw/net/rocker/rocker_fp.c               |   1 -
 hw/ppc/ppc440_uc.c                      |   2 +-
 hw/ppc/sam460ex.c                       |   4 +-
 hw/scsi/vhost-scsi-common.c             |   1 -
 hw/scsi/vhost-user-scsi.c               |  20 +++-
 hw/sd/milkymist-memcard.c               |   2 +-
 hw/usb/desc-msos.c                      |   2 +-
 hw/usb/desc.c                           |   2 +-
 hw/usb/dev-audio.c                      |   2 +-
 hw/usb/dev-bluetooth.c                  |   2 +-
 hw/usb/dev-hid.c                        |   2 +-
 hw/usb/dev-hub.c                        |   2 +-
 hw/usb/dev-mtp.c                        |   2 +-
 hw/usb/dev-network.c                    |   2 +-
 hw/usb/dev-serial.c                     |   2 +-
 hw/usb/dev-smartcard-reader.c           |   2 +-
 hw/usb/dev-storage.c                    |   2 +-
 hw/usb/dev-uas.c                        |   2 +-
 hw/usb/dev-wacom.c                      |   2 +-
 hw/virtio/vhost-stub.c                  |  10 ++
 hw/virtio/vhost-user.c                  | 182 ++++++++++++++++++++++++++++----
 hw/virtio/vhost.c                       |   9 +-
 migration/block-dirty-bitmap.c          |   2 +-
 migration/page_cache.c                  |   2 +-
 migration/ram.c                         |   4 +-
 migration/savevm.c                      |   1 +
 migration/vmstate.c                     |   2 +-
 net/colo-compare.c                      |   2 +-
 net/colo.c                              |   2 +-
 net/filter-rewriter.c                   |   2 +-
 net/vhost-user.c                        |  44 ++++++--
 qga/channel-posix.c                     |   2 +-
 qga/channel-win32.c                     |   4 +-
 qga/commands-posix.c                    |   2 +-
 qga/commands-win32.c                    |   4 +-
 qga/commands.c                          |   2 +-
 qga/guest-agent-command-state.c         |   2 +-
 qga/main.c                              |   4 +-
 qga/vss-win32.c                         |   6 +-
 tests/bios-tables-test.c                |   2 +-
 tests/libqtest.c                        |   9 +-
 tests/vhost-user-bridge.c               |  98 ++++++++++++++++-
 trace/qmp.c                             |   2 +-
 ui/gtk.c                                |   2 +-
 ui/input-keymap.c                       |   2 +-
 ui/input-legacy.c                       |   2 +-
 ui/spice-input.c                        |   2 +-
 hw/virtio/Makefile.objs                 |   2 +-
 tests/.gitignore                        |   1 +
 tests/acpi-test-data/pc/NFIT.dimmpxm    | Bin 224 -> 240 bytes
 tests/acpi-test-data/q35/NFIT.dimmpxm   | Bin 224 -> 240 bytes
 105 files changed, 808 insertions(+), 167 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user.h
