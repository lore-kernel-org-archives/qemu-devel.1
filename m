Received: from eggs.gnu.org ([2001:4830:134:3::10]:46569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amit.shah@redhat.com>) id 1cPAxl-0007Ga-IF
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amit.shah@redhat.com>) id 1cPAxg-0002qK-Io
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:32:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amit.shah@redhat.com>)
	id 1cPAxg-0002q7-DH
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:32:20 -0500
From: Amit Shah <amit.shah@redhat.com>
Date: Thu,  5 Jan 2017 22:02:06 +0530
Message-Id: <1483633930-7103-1-git-send-email-amit.shah@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] migration: QTAILQ migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu list <qemu-devel@nongnu.org>, duanj@linux.vnet.ibm.com, Amit Shah <amit.shah@redhat.com>

The following changes since commit dbe2b65566e76d3c3a0c3358285c0336ac61e757:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.9-pull-request' into staging (2016-12-28 17:11:11 +0000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/virt/qemu/amit/migration.git tags/migration-for-2.9-1

for you to fetch changes up to 8d0c57697abcc57166e918064d9a7f6c7316d01b:

  migration: add error_report (2017-01-04 19:21:26 +0530)

----------------------------------------------------------------
Migration: migrate QTAILQ infrastructure for vmstate

----------------------------------------------------------------



Jianjun Duan (4):
  migration: extend VMStateInfo
  migration: migrate QTAILQ
  tests/migration: Add test for QTAILQ migration
  migration: add error_report

 hw/display/virtio-gpu.c     |   8 +-
 hw/intc/s390_flic_kvm.c     |   8 +-
 hw/net/vmxnet3.c            |  24 ++++--
 hw/nvram/eeprom93xx.c       |   8 +-
 hw/nvram/fw_cfg.c           |   8 +-
 hw/pci/msix.c               |   8 +-
 hw/pci/pci.c                |  16 +++-
 hw/pci/shpc.c               |   7 +-
 hw/scsi/scsi-bus.c          |   8 +-
 hw/timer/twl92230.c         |   8 +-
 hw/usb/redirect.c           |  26 ++++--
 hw/virtio/virtio-pci.c      |   8 +-
 hw/virtio/virtio.c          |  15 +++-
 include/migration/vmstate.h |  39 +++++++--
 include/qemu/queue.h        |  60 ++++++++++++++
 migration/savevm.c          |   7 +-
 migration/trace-events      |   4 +
 migration/vmstate.c         | 188 +++++++++++++++++++++++++++++++++++---------
 target/alpha/machine.c      |   6 +-
 target/arm/machine.c        |  14 +++-
 target/i386/machine.c       |  26 ++++--
 target/mips/machine.c       |  14 +++-
 target/ppc/machine.c        |  12 ++-
 target/sparc/machine.c      |   6 +-
 tests/test-vmstate.c        | 147 ++++++++++++++++++++++++++++++++++
 25 files changed, 569 insertions(+), 106 deletions(-)

-- 
2.9.3
