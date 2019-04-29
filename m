Received: from eggs.gnu.org ([209.51.188.92]:34071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hL2HL-0002RK-Hq
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hL2HJ-0003vt-NQ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:08:51 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 29 Apr 2019 12:08:37 +0300
Message-Id: <20190429090842.57910-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v7 0/5] backup-top: preparing refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all!

Here some refactoring patches, as a first step for backup-top filter
introduction.

v7:
01,03,04: add Max's r-b
05: fix s/return NULL/goto error/ [Max]

v6:
01: - use end_cluster instead of last_cluster and fix bug in
      calculation [Max]
02: only rebased on 01, keep r-b
03, 04: new
05: it's rewritten
    "[PATCH v5 10/11] block/backup: tiny refactor backup_job_create",
    to make it more useful in general than just code movement inside
    one function

Vladimir Sementsov-Ogievskiy (5):
  block/backup: simplify backup_incremental_init_copy_bitmap
  block/backup: move to copy_bitmap with granularity
  block/backup: refactor and tolerate unallocated cluster skipping
  block/backup: unify different modes code path
  block/backup: refactor: split out backup_calculate_cluster_size

 block/backup.c | 243 +++++++++++++++++++++----------------------------
 1 file changed, 105 insertions(+), 138 deletions(-)

-- 
2.18.0
