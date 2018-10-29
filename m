Received: from eggs.gnu.org ([2001:4830:134:3::10]:45188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF27-000410-7t
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF23-0002FM-3N
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gHF22-0002Ex-TM
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:07 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 29 Oct 2018 17:24:42 -0400
Message-Id: <20181029212501.5897-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 00/19] Bitmaps patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

The following changes since commit 62b658db1df7c6fa574caae038144f24bf6ca495:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2018-10-29 17:03:27 +0000)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request

for you to fetch changes up to 3e6d88f280a53b5b399e73b1f80efe4c3db306f1:

  iotests: 169: add cases for source vm resuming (2018-10-29 16:23:17 -0400)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Eric Blake (1):
  bitmap: Update count after a merge

John Snow (7):
  blockdev-backup: add bitmap argument
  block/dirty-bitmaps: add user_locked status checker
  block/dirty-bitmaps: fix merge permissions
  block/dirty-bitmaps: allow clear on disabled bitmaps
  block/dirty-bitmaps: prohibit enable/disable on locked/frozen bitmaps
  block/backup: prohibit backup from using in use bitmaps
  nbd: forbid use of frozen bitmaps

Vladimir Sementsov-Ogievskiy (11):
  dirty-bitmap: switch assert-fails to errors in bdrv_merge_dirty_bitmap
  dirty-bitmap: rename bdrv_undo_clear_dirty_bitmap
  dirty-bitmap: make it possible to restore bitmap after merge
  blockdev: rename block-dirty-bitmap-clear transaction handlers
  qapi: add transaction support for x-block-dirty-bitmap-merge
  iotests: 169: drop deprecated 'autoload' parameter
  block/qcow2: improve error message in qcow2_inactivate
  bloc/qcow2: drop dirty_bitmaps_loaded state variable
  dirty-bitmaps: clean-up bitmaps loading and migration logic
  iotests: improve 169
  iotests: 169: add cases for source vm resuming

 block.c                        |  11 ++--
 block/dirty-bitmap.c           |  79 +++++++++++++---------
 block/qcow2-bitmap.c           |  16 +++++
 block/qcow2.c                  |  86 ++++++++++++++++++------
 block/qcow2.h                  |   1 -
 blockdev.c                     | 144 +++++++++++++++++++++++++----------------
 include/block/block_int.h      |   2 +-
 include/block/dirty-bitmap.h   |   5 +-
 include/qemu/hbitmap.h         |  25 ++++---
 migration/block-dirty-bitmap.c |  12 ++--
 nbd/server.c                   |   4 +-
 qapi/block-core.json           |   7 +-
 qapi/transaction.json          |   2 +
 tests/qemu-iotests/169         |  70 +++++++++++++++++++-
 tests/qemu-iotests/169.out     |   4 +-
 util/hbitmap.c                 |  14 +++-
 16 files changed, 344 insertions(+), 138 deletions(-)

-- 
2.14.5
