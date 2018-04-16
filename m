Received: from eggs.gnu.org ([2001:4830:134:3::10]:39794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f82Ya-0006AZ-1N
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f82YU-0005lK-Vv
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:44:23 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 16 Apr 2018 14:44:07 +0300
Message-Id: <20180416114414.18406-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 for-2.13 0/7] Dirty bitmaps fixing and
 refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jsnow@redhat.com, famz@redhat.com

v2:
 
05: drop bdrv_undo_clear_dirty_bitmap(), which becomes unused.

Vladimir Sementsov-Ogievskiy (7):
  block/dirty-bitmap: add lock to bdrv_enable/disable_dirty_bitmap
  dirty-bitmaps: fix comment about dirty_bitmap_mutex
  dirty-bitmap: remove missed bdrv_dirty_bitmap_get_autoload header
  dirty-bitmap: separate unused meta-bitmap related functions
  blockdev: refactor block-dirty-bitmap-clear transaction
  block/dirty-bitmap: bdrv_clear_dirty_bitmap: drop unused parameter
  blockdev: unify block-dirty-bitmap-clear command and transaction
    action

 include/block/block_int.h    | 15 ++++++----
 include/block/dirty-bitmap.h | 15 ++++++----
 block/dirty-bitmap.c         | 32 +++++++++-----------
 blockdev.c                   | 69 ++++++++++++++------------------------------
 4 files changed, 54 insertions(+), 77 deletions(-)

-- 
2.11.1
