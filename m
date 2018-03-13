Received: from eggs.gnu.org ([2001:4830:134:3::10]:34634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrFx-0000lJ-9D
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrFt-0005js-9H
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1evrFt-0005je-4V
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:45 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 13 Mar 2018 17:14:28 -0400
Message-Id: <20180313211441.5179-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 00/13] Bitmaps patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com

The following changes since commit 026aaf47c02b79036feb830206cfebb2a726510d:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2018-03-13 16:26:44 +0000)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request

for you to fetch changes up to ac8bd439bb7b5dffeb5ff8a17317ca2b192044b6:

  iotests: add dirty bitmap postcopy test (2018-03-13 17:06:32 -0400)

----------------------------------------------------------------

PR touching migration sent with permission (and reviews) from
David Gilbert.

----------------------------------------------------------------

Vladimir Sementsov-Ogievskiy (13):
  block/dirty-bitmap: add bdrv_dirty_bitmap_enable_successor()
  block/dirty-bitmap: fix locking in bdrv_reclaim_dirty_bitmap
  block/dirty-bitmap: add _locked version of bdrv_reclaim_dirty_bitmap
  dirty-bitmap: add locked state
  migration: introduce postcopy-only pending
  qapi: add dirty-bitmaps migration capability
  migration: include migrate_dirty_bitmaps in migrate_postcopy
  migration/qemu-file: add qemu_put_counted_string()
  migration: add is_active_iterate handler
  migration: allow qmp command migrate-start-postcopy for any postcopy
  migration: add postcopy migration of dirty bitmaps
  iotests: add dirty bitmap migration test
  iotests: add dirty bitmap postcopy test

 block/dirty-bitmap.c           | 123 +++++--
 blockdev.c                     |  19 ++
 hw/s390x/s390-stattrib.c       |   7 +-
 include/block/dirty-bitmap.h   |   7 +
 include/migration/misc.h       |   3 +
 include/migration/register.h   |  26 +-
 migration/Makefile.objs        |   1 +
 migration/block-dirty-bitmap.c | 746 +++++++++++++++++++++++++++++++++++++++++
 migration/block.c              |   7 +-
 migration/migration.c          |  30 +-
 migration/migration.h          |   4 +
 migration/qemu-file.c          |  13 +
 migration/qemu-file.h          |   2 +
 migration/ram.c                |   9 +-
 migration/savevm.c             |  20 +-
 migration/savevm.h             |   5 +-
 migration/trace-events         |  16 +-
 qapi/block-core.json           |   5 +-
 qapi/migration.json            |   6 +-
 tests/qemu-iotests/169         | 156 +++++++++
 tests/qemu-iotests/169.out     |   5 +
 tests/qemu-iotests/199         | 118 +++++++
 tests/qemu-iotests/199.out     |   5 +
 tests/qemu-iotests/group       |   2 +
 tests/qemu-iotests/iotests.py  |   7 +-
 vl.c                           |   1 +
 26 files changed, 1277 insertions(+), 66 deletions(-)
 create mode 100644 migration/block-dirty-bitmap.c
 create mode 100755 tests/qemu-iotests/169
 create mode 100644 tests/qemu-iotests/169.out
 create mode 100755 tests/qemu-iotests/199
 create mode 100644 tests/qemu-iotests/199.out

-- 
2.14.3
