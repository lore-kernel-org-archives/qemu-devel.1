Received: from eggs.gnu.org ([2001:4830:134:3::10]:39868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih5U-0007v6-At
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih5R-00004u-4h
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cih5Q-0008WB-Lt
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:00 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Feb 2017 12:40:29 +0000
Message-Id: <20170228124056.5074-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/27] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, lvivier@redhat.com, marcandre.lureau@redhat.com, vsementsov@virtuozzo.com, danielhb@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, ashijeetacharya@gmail.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 6181478f6395cdd9d6ffd99623d0c9f39ea536=
06:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2017-02-28 08:46:03 +0000)

are available in the git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20170228a

for you to fetch changes up to 665414ad06aa1bc92e615db9641e58fb13d07de1:

  postcopy: Add extra check for COPY function (2017-02-28 11:30:24 +0000)

----------------------------------------------------------------
Migration pull

Note: The 'postcopy: Update userfaultfd.h header' is part of
Paolo's header update and will disappear if applied after it.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

----------------------------------------------------------------
Ashijeet Acharya (1):
      migrate: Introduce a 'dc->vmsd' check to avoid segfault for --only-=
migratable

Daniel Henrique Barboza (1):
      Changing error message of QMP 'migrate_set_downtime' to seconds

Dr. David Alan Gilbert (17):
      migration: Update docs to discourage version bumps
      postcopy: Transmit ram size summary word
      postcopy: Transmit and compare individual page sizes
      postcopy: Chunk discards for hugepages
      exec: ram_block_discard_range
      postcopy: enhance ram_block_discard_range for hugepages
      postcopy: Record largest page size
      postcopy: Plumb pagesize down into place helpers
      postcopy: Use temporary for placing zero huge pages
      postcopy: Load huge pages in one go
      postcopy: Mask fault addresses to huge page boundary
      postcopy: Send whole huge pages
      postcopy: Allow hugepages
      postcopy: Update userfaultfd.h header
      postcopy: Check for userfault+hugepage feature
      postcopy: Add doc about hugepages and postcopy
      postcopy: Add extra check for COPY function

Halil Pasic (5):
      migration/vmstate: renames in (load|save)_state
      migration/vmstate: split up vmstate_base_addr
      migration/vmstate: fix array of ptr with nullptrs
      tests/test-vmstate.c: test array of ptr with null
      tests/test-vmstate.c: test array of ptr to primitive

Laurent Vivier (1):
      vmstate-static-checker: update white list with spapr_pci

Marc-Andr=C3=A9 Lureau (1):
      migration: fix id leak regression

Vladimir Sementsov-Ogievskiy (1):
      migration: fix use-after-free of to_dst_file

 docs/migration.txt                |  71 +++++++++++++++++++
 exec.c                            |  83 ++++++++++++++++++++++
 hw/core/qdev.c                    |   7 ++
 hw/usb/bus.c                      |  19 -----
 include/exec/cpu-common.h         |   2 +
 include/migration/migration.h     |   6 ++
 include/migration/postcopy-ram.h  |  13 ++--
 include/migration/vmstate.h       |   4 ++
 linux-headers/linux/userfaultfd.h |  67 +++++++++++++++---
 migration/migration.c             |  36 ++++++++--
 migration/postcopy-ram.c          | 142 ++++++++++++++++++--------------=
------
 migration/ram.c                   | 109 ++++++++++++++++++-----------
 migration/savevm.c                |  38 +++++++---
 migration/trace-events            |   2 +-
 migration/vmstate.c               |  97 +++++++++++++++++---------
 qdev-monitor.c                    |   9 ---
 scripts/vmstate-static-checker.py |   5 ++
 stubs/vmstate.c                   |   6 ++
 tests/test-vmstate.c              | 122 +++++++++++++++++++++++++++-----
 19 files changed, 608 insertions(+), 230 deletions(-)
