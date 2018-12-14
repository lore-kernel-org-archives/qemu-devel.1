Received: from eggs.gnu.org ([2001:4830:134:3::10]:45487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gXnjv-0000uq-Jz
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gXnju-0005jN-Pf
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:42:51 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 14 Dec 2018 16:42:35 +0300
Message-Id: <20181214134240.217870-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 0/5] qcow2 check improvements part I
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all!

These series are derived from "[PATCH v3 0/8] qcow2 check improvements"
(https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02284.html)

Some patches are new, some patches are not included and are postponed to
part II.

So, here:
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

 block/qcow2-refcount.c     | 87 +++++++++++++++++++++++---------------
 tests/qemu-iotests/138     | 12 +++---
 tests/qemu-iotests/138.out |  5 ++-
 3 files changed, 61 insertions(+), 43 deletions(-)

-- 
2.18.0
