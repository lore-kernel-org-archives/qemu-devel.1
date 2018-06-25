Received: from eggs.gnu.org ([2001:4830:134:3::10]:38656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXUoK-0008M4-Pz
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXUoI-0006rh-8D
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:57:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Jun 2018 19:57:43 +0300
Message-Id: <20180625165745.25259-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/2] dirty bitmap fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Vladimir Sementsov-Ogievskiy (2):
  block/dirty-bitmap: add bdrv_enable_dirty_bitmap_locked
  dirty-bitmap: fix double lock on bitmap enabling

 include/block/dirty-bitmap.h   |  1 +
 block/dirty-bitmap.c           | 12 +++++++++---
 migration/block-dirty-bitmap.c |  4 ++--
 3 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.11.1
