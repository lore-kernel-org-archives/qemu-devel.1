Received: from eggs.gnu.org ([209.51.188.92]:54722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gxcr1-0005rf-Dw
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 14:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gxcqx-000221-On
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 14:20:53 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 23 Feb 2019 22:20:38 +0300
Message-Id: <20190223192041.289782-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/3] block: fix graph modification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com

Hi all.

I've found two problems during my developing of backup-top filter.
The first one was already discussed in context of backup-top series,
so, here is patch 01 taken from it, previously it was
03 of [PATCH v5 00/11] backup-top filter driver for backup
(https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg06218.html)
so, here it is marked v6, and it was changed a lot:
 v6: rewrite using GHashTable and GQueue for efficient BFS.

02 is a new fix of bug I've found today, and 03 is a test for both
fixed bugs.

Vladimir Sementsov-Ogievskiy (3):
  block: improve should_update_child
  block: fix bdrv_check_perm for non-tree subgraph
  tests: add test-bdrv-graph-mod

 include/block/block_int.h   |   5 +
 block.c                     |  70 +++++++++++--
 tests/test-bdrv-graph-mod.c | 198 ++++++++++++++++++++++++++++++++++++
 tests/Makefile.include      |   2 +
 4 files changed, 268 insertions(+), 7 deletions(-)
 create mode 100644 tests/test-bdrv-graph-mod.c

-- 
2.18.0
