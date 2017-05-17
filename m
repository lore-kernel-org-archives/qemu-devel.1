Received: from eggs.gnu.org ([2001:4830:134:3::10]:36485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAwtx-00029q-Ku
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAwtu-00024P-EM
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:13:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dAwtu-00023I-5U
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:13:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA2C35D5E9
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 11:13:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 17 May 2017 13:13:39 +0200
Message-Id: <20170517111346.21450-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 0/7] Migration pull request
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

This pull request:
- drop block capability patch (now they is being reviewed)
- add following patches that got reviewed:
  * page_cache.c into migration
  * postcopy stuff into postocpy-ram.c
  * check_migratable change

Please apply.

Thanks, Juan.

The following changes since commit cdece0467c00007cf8e3f4b3c3f0b13bf2c4fea9:

  block/win32: fix 'ret not initialized' warning (2017-05-16 15:34:18 +0100)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20170517

for you to fetch changes up to 1bfe5f0586083747f1602931713111673849cd9d:

  migration: Move check_migratable() into qdev.c (2017-05-17 12:04:59 +0200)

----------------------------------------------------------------
migration/next for 20170517

----------------------------------------------------------------
Juan Quintela (7):
      migration: Fix regression with compression threads
      migration: Pass Error ** argument to {save,load}_vmstate
      ram: Rename RAM_SAVE_FLAG_COMPRESS to RAM_SAVE_FLAG_ZERO
      migration: Create migration/blocker.h
      migration: Move page_cache.c to migration/
      migration: Move postcopy stuff to postcopy-ram.c
      migration: Move check_migratable() into qdev.c

 Makefile.objs                                 |  1 -
 block/qcow.c                                  |  2 +-
 block/vdi.c                                   |  2 +-
 block/vhdx.c                                  |  2 +-
 block/vmdk.c                                  |  2 +-
 block/vpc.c                                   |  2 +-
 block/vvfat.c                                 |  2 +-
 hmp.c                                         |  9 +++-
 hw/9pfs/9p.c                                  |  2 +-
 hw/core/qdev.c                                | 20 +++++++--
 hw/display/qxl.c                              |  2 +-
 hw/display/virtio-gpu.c                       |  2 +-
 hw/intc/arm_gic_kvm.c                         |  2 +-
 hw/intc/arm_gicv3_its_kvm.c                   |  2 +-
 hw/intc/arm_gicv3_kvm.c                       |  2 +-
 hw/misc/ivshmem.c                             |  2 +-
 hw/scsi/vhost-scsi.c                          |  2 +-
 hw/virtio/vhost.c                             |  2 +-
 include/migration/blocker.h                   | 35 +++++++++++++++
 include/migration/migration.h                 | 50 ----------------------
 include/migration/vmstate.h                   |  2 +
 include/sysemu/sysemu.h                       |  6 +--
 migration/Makefile.objs                       |  2 +-
 migration/migration.c                         | 34 +--------------
 page_cache.c => migration/page_cache.c        |  0
 {include/migration => migration}/page_cache.h |  0
 migration/postcopy-ram.c                      | 18 ++++++++
 migration/postcopy-ram.h                      | 26 ++++++++++++
 migration/ram.c                               | 35 +++++++++------
 migration/savevm.c                            | 61 +++++++++++++++------------
 replay/replay-snapshot.c                      |  8 +++-
 stubs/migr-blocker.c                          |  2 +-
 stubs/vmstate.c                               |  5 +--
 target/i386/kvm.c                             |  2 +-
 tests/Makefile.include                        |  2 +-
 vl.c                                          |  4 +-
 36 files changed, 194 insertions(+), 158 deletions(-)
 create mode 100644 include/migration/blocker.h
 rename page_cache.c => migration/page_cache.c (100%)
 rename {include/migration => migration}/page_cache.h (100%)
