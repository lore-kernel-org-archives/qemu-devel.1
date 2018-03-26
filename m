Received: from eggs.gnu.org ([2001:4830:134:3::10]:48114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0QBT-00045T-Mq
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 07:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0QBQ-0007N2-GM
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 07:21:03 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 26 Mar 2018 14:20:49 +0300
Message-Id: <20180326112056.8420-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/7] Dirty bitmaps fixing and refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Nothing critical here.

01 - these functions are unused for now, but the will be used in
     the qmp bitmaps api.

Vladimir Sementsov-Ogievskiy (7):
  block/dirty-bitmap: add lock to bdrv_enable/disable_dirty_bitmap
  dirty-bitmaps: fix comment about dirty_bitmap_mutex
  dirty-bitmap: remove missed bdrv_dirty_bitmap_get_autoload header
  dirty-bitmap: separate unused meta-bitmap related functions
  blockdev: refactor block-dirty-bitmap-clear transaction
  block/dirty-bitmap: bdrv_clear_dirty_bitmap: drop unused parameter
  blockdev: unify block-dirty-bitmap-clear command and transaction
    action

 include/block/block_int.h    | 14 +++++----
 include/block/dirty-bitmap.h | 15 ++++++----
 block/dirty-bitmap.c         | 23 +++++++++------
 blockdev.c                   | 69 ++++++++++++++------------------------------
 4 files changed, 54 insertions(+), 67 deletions(-)

-- 
2.11.1
