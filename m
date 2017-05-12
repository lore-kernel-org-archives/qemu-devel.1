Received: from eggs.gnu.org ([2001:4830:134:3::10]:43760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d9CsH-0003h5-9V
	for qemu-devel@nongnu.org; Fri, 12 May 2017 11:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d9CsE-0006fi-6K
	for qemu-devel@nongnu.org; Fri, 12 May 2017 11:53:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d9CsD-0006dU-Vn
	for qemu-devel@nongnu.org; Fri, 12 May 2017 11:52:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B302E7AE90
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 15:52:55 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 12 May 2017 17:52:44 +0200
Message-Id: <20170512155249.8853-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 0/5] Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Hi

This pull contains:
- Fix regression with compression threads (mea culpa)
- start of includes migration (creating of blocker.h header)
- Use Error** correctly after several iterations
- Rename of RAM_SAVE_FLAG_COMPRESS
- Create block capabilities for shared and enable

Please, apply.



The following changes since commit ecc1f5adeec4e3324d1b695a7c54e3967c526949:

  maintainers: Add myself as linux-user reviewer (2017-05-11 13:31:11 -0400)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20170512

for you to fetch changes up to f15e5850905dea6a09e29ef14df508ec236321d9:

  migration: Create migration/blocker.h (2017-05-12 17:10:57 +0200)

----------------------------------------------------------------
migration/next for 20170512

----------------------------------------------------------------
Juan Quintela (5):
      migration: Fix regression with compression threads
      migration: Pass Error ** argument to {save,load}_vmstate
      ram: Rename RAM_SAVE_FLAG_COMPRESS to RAM_SAVE_FLAG_ZERO
      migration: Create block capabilities for shared and enable
      migration: Create migration/blocker.h

 block/qcow.c                  |  2 +-
 block/vdi.c                   |  2 +-
 block/vhdx.c                  |  2 +-
 block/vmdk.c                  |  2 +-
 block/vpc.c                   |  2 +-
 block/vvfat.c                 |  2 +-
 hmp.c                         |  9 ++++++--
 hw/9pfs/9p.c                  |  2 +-
 hw/display/qxl.c              |  2 +-
 hw/display/virtio-gpu.c       |  2 +-
 hw/intc/arm_gic_kvm.c         |  2 +-
 hw/intc/arm_gicv3_its_kvm.c   |  2 +-
 hw/intc/arm_gicv3_kvm.c       |  2 +-
 hw/misc/ivshmem.c             |  2 +-
 hw/scsi/vhost-scsi.c          |  2 +-
 hw/virtio/vhost.c             |  2 +-
 include/migration/block.h     |  3 +++
 include/migration/blocker.h   | 35 +++++++++++++++++++++++++++++
 include/migration/migration.h | 21 +++---------------
 include/sysemu/sysemu.h       |  4 ++--
 migration/migration.c         | 37 +++++++++++++++++++++++++++++++
 migration/ram.c               | 35 +++++++++++++++++------------
 migration/savevm.c            | 51 +++++++++++++++++++++----------------------
 qapi-schema.json              |  7 +++++-
 replay/replay-snapshot.c      |  8 +++++--
 stubs/migr-blocker.c          |  2 +-
 target/i386/kvm.c             |  2 +-
 vl.c                          |  4 +++-
 28 files changed, 165 insertions(+), 83 deletions(-)
 create mode 100644 include/migration/blocker.h
