Received: from eggs.gnu.org ([2001:4830:134:3::10]:47855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fbQ7C-0006V1-Qt
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fbQ7A-0000FJ-Ta
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:45:34 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  6 Jul 2018 14:36:26 +0300
Message-Id: <20180706113630.25222-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/4] transaction support for bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is a last brick, necessary to play with nbd bitmap export in
conjunction with image fleecing.

v2: don't compare with v1, it is changed a lot, to do the whole thing
    in .prepare instead of .commit. It is needed to be compatible with
    backup block job transaction actions [John]

Vladimir Sementsov-Ogievskiy (4):
  drity-bitmap: switch assert-fails to errors in bdrv_merge_dirty_bitmap
  dirty-bitmap: restore bitmap after merge
  blockdev: rename block-dirty-bitmap-clear transaction handlers
  qapi: add transaction support for x-block-dirty-bitmap-merge

 qapi/transaction.json        |  2 ++
 include/block/block_int.h    |  2 +-
 include/block/dirty-bitmap.h |  2 +-
 include/qemu/hbitmap.h       | 25 +++++++++++-------
 block/dirty-bitmap.c         | 36 ++++++++++++++++++++------
 blockdev.c                   | 60 +++++++++++++++++++++++++++++++-------------
 util/hbitmap.c               | 11 +++++---
 7 files changed, 100 insertions(+), 38 deletions(-)

-- 
2.11.1
