Received: from eggs.gnu.org ([2001:4830:134:3::10]:59457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ckr7r-0007hJ-QN
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 06:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ckr7r-0006EG-4B
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 06:48:27 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  6 Mar 2017 12:48:11 +0100
Message-Id: <1488800894-22421-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v2 0/3] vITS save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, drjones@redhat.com, peterx@redhat.com, quintela@redhat.com, dgilbert@redhat.com, christoffer.dall@linaro.org

This series allows ITS save/restore and migration use cases.
It relies on not upstreamed kernel series [1].

ITS tables are flushed into guest RAM on VM stop while registers
are save on pre_save() callback. Tables and registers are restored
on ITS post_load().

That work was tested on Cavium ThunderX using virsh save/restore and
virt-manager live migration.

Best Regards

Eric

Host Kernel dependencies:
- [1] [PATCH v3 00/19] vITS save/restore

History:

v1 -> v2:
- rebase on 2.9 soft release code
- handle case where migrate_add_blocker fails
- add comments along with ITS and GICv3 migration priorities

Eric Auger (3):
  linux-headers: Update for vITS save/restore
  hw/intc/arm_gicv3_its: Implement state save/restore
  hw/intc/arm_gicv3_its: Allow save/restore

 hw/intc/arm_gicv3_common.c                  |   1 +
 hw/intc/arm_gicv3_its_common.c              |  11 ++-
 hw/intc/arm_gicv3_its_kvm.c                 | 109 +++++++++++++++++++++++++---
 include/hw/intc/arm_gicv3_its_common.h      |   6 ++
 include/migration/vmstate.h                 |   2 +
 include/standard-headers/linux/virtio_pci.h |   2 +-
 linux-headers/asm-arm/kvm.h                 |   2 +
 linux-headers/asm-arm64/kvm.h               |   2 +
 linux-headers/linux/userfaultfd.h           |  16 ++--
 9 files changed, 132 insertions(+), 19 deletions(-)

-- 
2.5.5
