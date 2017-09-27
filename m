Received: from eggs.gnu.org ([2001:4830:134:3::10]:39602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxCqX-0000z8-5t
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxCqT-0002Jr-8m
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:57:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24547)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dxCqT-0002Hb-05
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:57:49 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 27 Sep 2017 14:57:35 +0100
Message-Id: <20170927135742.19724-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 0/7] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pl@kamp.de, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 31bc1d8481af414cfa2857f905e40f7d8e6d5b2e:

  Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2017-09-26 19:49:08 +0100)

are available in the git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20170927a

for you to fetch changes up to 2f168d0708581c33baf6c78d75a89e8cd705f9f6:

  migration: Route more error paths (2017-09-27 11:44:18 +0100)

----------------------------------------------------------------
Migration pull 2017-09-27

----------------------------------------------------------------
Dr. David Alan Gilbert (6):
      migration: pre_save return int
      migration: check pre_save return in vmstate_save_state
      migration: Check field save returns
      migration: wire vmstate_save_state errors up to vmstate_subsection_save
      migration: Route errors up through vmstate_save
      migration: Route more error paths

Peter Lieven (1):
      migration: disable auto-converge during bulk block migration

 docs/devel/migration.txt       |  2 +-
 hw/arm/pxa2xx.c                |  4 +++-
 hw/arm/strongarm.c             |  4 +++-
 hw/audio/wm8750.c              |  4 +++-
 hw/block/fdc.c                 |  4 +++-
 hw/block/m25p80.c              |  4 +++-
 hw/block/nand.c                |  4 +++-
 hw/block/onenand.c             |  4 +++-
 hw/char/serial.c               |  4 +++-
 hw/display/qxl.c               |  4 +++-
 hw/display/virtio-gpu.c        |  4 +---
 hw/i2c/core.c                  |  4 +++-
 hw/i386/kvm/clock.c            |  4 +++-
 hw/ide/core.c                  |  4 +++-
 hw/ide/pci.c                   |  4 +++-
 hw/input/ps2.c                 |  8 ++++++--
 hw/input/tsc210x.c             |  4 +++-
 hw/intc/apic_common.c          |  4 +++-
 hw/intc/arm_gic_common.c       |  4 +++-
 hw/intc/arm_gicv3_common.c     |  4 +++-
 hw/intc/arm_gicv3_its_common.c |  4 +++-
 hw/intc/i8259_common.c         |  4 +++-
 hw/intc/ioapic_common.c        |  4 +++-
 hw/intc/s390_flic_kvm.c        |  6 ++++--
 hw/intc/xics.c                 |  8 ++++++--
 hw/net/e1000.c                 |  4 +++-
 hw/net/e1000e.c                |  4 +++-
 hw/net/rtl8139.c               |  4 +++-
 hw/net/virtio-net.c            | 16 ++++++++++++----
 hw/net/vmxnet3.c               |  4 +++-
 hw/pci-host/piix.c             |  4 +++-
 hw/ppc/ppc.c                   |  4 +++-
 hw/ppc/spapr_iommu.c           |  4 +++-
 hw/ppc/spapr_pci.c             |  6 ++++--
 hw/s390x/css.c                 | 10 +++++++---
 hw/s390x/virtio-ccw.c          |  4 +++-
 hw/scsi/lsi53c895a.c           |  4 +++-
 hw/scsi/vmw_pvscsi.c           |  4 +++-
 hw/timer/cadence_ttc.c         |  4 +++-
 hw/timer/hpet.c                |  4 +++-
 hw/timer/i8254_common.c        |  4 +++-
 hw/timer/mc146818rtc.c         |  4 +++-
 hw/timer/pl031.c               |  4 +++-
 hw/timer/twl92230.c            |  4 +++-
 hw/usb/dev-smartcard-reader.c  |  4 +++-
 hw/usb/hcd-ehci.c              |  4 +++-
 hw/usb/redirect.c              |  4 +++-
 hw/virtio/vhost-vsock.c        |  4 +++-
 hw/virtio/virtio.c             | 13 +++++++------
 include/hw/virtio/virtio.h     |  2 +-
 include/migration/vmstate.h    |  6 +++---
 migration/block.c              |  5 +++++
 migration/block.h              |  7 +++++++
 migration/colo-comm.c          |  4 +++-
 migration/global_state.c       |  4 +++-
 migration/ram.c                |  6 +++++-
 migration/savevm.c             | 23 ++++++++++++++++------
 migration/trace-events         |  1 +
 migration/vmstate-types.c      | 11 ++++++++---
 migration/vmstate.c            | 43 +++++++++++++++++++++++++++++++-----------
 replay/replay-snapshot.c       |  4 +++-
 slirp/slirp.c                  |  8 ++++++--
 target/arm/machine.c           |  4 +++-
 target/i386/machine.c          |  7 +++++--
 target/ppc/machine.c           |  4 +++-
 target/s390x/machine.c         |  4 +++-
 target/sparc/machine.c         |  4 +++-
 tests/test-vmstate.c           | 13 +++++++++----
 68 files changed, 288 insertions(+), 105 deletions(-)
