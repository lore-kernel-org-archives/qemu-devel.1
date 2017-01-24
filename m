Received: from eggs.gnu.org ([2001:4830:134:3::10]:55299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68B-0001Gh-LV
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW688-0006mX-Rq
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cW688-0006li-Je
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:44 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AAA9C05490A
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 18:47:44 +0000 (UTC)
Received: from dgilbert-t530.redhat.com (ovpn-116-204.ams2.redhat.com
	[10.36.116.204])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0OIlhUm020536
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 13:47:44 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jan 2017 18:47:27 +0000
Message-Id: <20170124184742.1639-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 00/15] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit a678502e4f7580a6f143f680404aaee57ac3f4b5:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging (2017-01-24 15:39:09 +0000)

are available in the git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20170124b

for you to fetch changes up to 46a02a745176e1ef30de41706b5da4f1bc7fc495:

  migration/tracing: Add tracing on save (2017-01-24 18:00:32 +0000)

----------------------------------------------------------------
Migration

1 My maintainer change
2 Jianjun's qtailq
3 Ashijeet's only-migratable
4 Zhanghailiang's re-active images
5 Pankaj's change name of migration thread
6 My PCI migration merge
7 Juan's debug to tracing
8 My tracing on save

----------------------------------------------------------------
Ashijeet Acharya (5):
      block/vvfat: Remove the undesirable comment
      migration: Add a new option to enable only-migratable
      migration: Allow "device add" options to only add migratable devices
      migration: disallow migrate_add_blocker during migration
      migration: Fail migration blocker for --only-migratable

Dr. David Alan Gilbert (3):
      MAINTAINERS: Add myself as a migration submaintainer
      PCI/migration merge vmstate_pci_device and vmstate_pcie_device
      migration/tracing: Add tracing on save

Jianjun Duan (4):
      migration: extend VMStateInfo
      migration: migrate QTAILQ
      tests/migration: Add test for QTAILQ migration
      migration: add error_report

Juan Quintela (1):
      migration: transform remaining DPRINTF into trace_

Pankaj Gupta (1):
      migration: Change name of live migration thread

zhanghailiang (1):
      migration: re-active images while migration been canceled after inactive them

 MAINTAINERS                        |   1 +
 block/qcow.c                       |   8 +-
 block/vdi.c                        |   8 +-
 block/vhdx.c                       |  17 ++--
 block/vmdk.c                       |   9 +-
 block/vpc.c                        |  11 +-
 block/vvfat.c                      |  20 ++--
 hw/9pfs/9p.c                       |  33 ++++--
 hw/display/virtio-gpu.c            |  40 +++++---
 hw/intc/arm_gic_kvm.c              |  17 ++--
 hw/intc/arm_gicv3_its_kvm.c        |  20 ++--
 hw/intc/arm_gicv3_kvm.c            |  19 ++--
 hw/intc/s390_flic_kvm.c            |   8 +-
 hw/misc/ivshmem.c                  |  14 ++-
 hw/net/e1000e.c                    |   2 +-
 hw/net/vmxnet3.c                   |  26 +++--
 hw/nvram/eeprom93xx.c              |   8 +-
 hw/nvram/fw_cfg.c                  |   8 +-
 hw/pci-bridge/ioh3420.c            |   2 +-
 hw/pci-bridge/xio3130_downstream.c |   2 +-
 hw/pci-bridge/xio3130_upstream.c   |   2 +-
 hw/pci/msix.c                      |   8 +-
 hw/pci/pci.c                       |  57 ++++++-----
 hw/pci/shpc.c                      |   7 +-
 hw/scsi/megasas.c                  |   2 +-
 hw/scsi/scsi-bus.c                 |   8 +-
 hw/scsi/vhost-scsi.c               |  25 +++--
 hw/scsi/vmw_pvscsi.c               |   2 +-
 hw/timer/twl92230.c                |   8 +-
 hw/usb/bus.c                       |  19 ++++
 hw/usb/hcd-xhci.c                  |   2 +-
 hw/usb/redirect.c                  |  26 +++--
 hw/virtio/vhost.c                  |   8 +-
 hw/virtio/virtio-pci.c             |   8 +-
 hw/virtio/virtio.c                 |  15 ++-
 include/hw/pci/pcie.h              |  10 --
 include/migration/migration.h      |  13 ++-
 include/migration/vmstate.h        |  39 ++++++-
 include/qemu/queue.h               |  60 +++++++++++
 migration/migration.c              |  61 ++++++++++-
 migration/ram.c                    |  18 +---
 migration/savevm.c                 |   7 +-
 migration/trace-events             |  12 +++
 migration/vmstate.c                | 203 +++++++++++++++++++++++++++++--------
 qdev-monitor.c                     |   9 ++
 qemu-options.hx                    |   9 ++
 stubs/migr-blocker.c               |   3 +-
 target/alpha/machine.c             |   6 +-
 target/arm/machine.c               |  14 ++-
 target/i386/kvm.c                  |  16 ++-
 target/i386/machine.c              |  26 +++--
 target/mips/machine.c              |  14 ++-
 target/ppc/machine.c               |  12 ++-
 target/sparc/machine.c             |   6 +-
 tests/test-vmstate.c               | 147 +++++++++++++++++++++++++++
 vl.c                               |   4 +
 56 files changed, 910 insertions(+), 249 deletions(-)
