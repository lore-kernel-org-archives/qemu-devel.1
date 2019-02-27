Received: from eggs.gnu.org ([209.51.188.92]:51079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyzUt-00053r-Bm
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyzIt-0003vN-In
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:31:21 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 27 Feb 2019 16:14:28 +0300
Message-Id: <20190227131433.197063-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 0/5] qcow2 check improvements part I
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@virtuozzo.com, vsementsov@virtuozzo.com

Hi all!

v5:
01: - add Max's r-b
02: - s/it's/it/ in comment in block/qcow2-refcount.c [Max]
    - fix comment style accordingly to updated checkpatch
      ('/*' on separate line)
    - add Max's r-b
04: - add Max's r-b
05: - refactor change in check_oflag_copied, to increase
      res->corruptions separately from l2_dirty variable [Max]

v4 was derived from "[PATCH v3 0/8] qcow2 check improvements"
(https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02284.html)

v4:
Some patches are new, some patches are not included and are postponed to
part II.

01,03 - unchanged
02: handle broken iotest
04-05: new

Vladimir Sementsov-Ogievskiy (5):
  qcow2-refcount: fix check_oflag_copied
  qcow2-refcount: avoid eating RAM
  qcow2-refcount: check_refcounts_l2: reduce ignored overlaps
  qcow2-refcount: check_refcounts_l2: don't count fixed cluster as
    allocated
  qcow2-refcount: don't mask corruptions under internal errors

 block/qcow2-refcount.c     | 80 ++++++++++++++++++++++++--------------
 tests/qemu-iotests/138     | 12 +++---
 tests/qemu-iotests/138.out |  5 ++-
 3 files changed, 59 insertions(+), 38 deletions(-)

-- 
2.18.0
