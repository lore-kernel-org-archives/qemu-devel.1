Received: from eggs.gnu.org ([209.51.188.92]:40681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHXcs-00067n-5C
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 13:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHXcq-0003y3-KU
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 13:48:38 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 19 Apr 2019 20:48:30 +0300
Message-Id: <20190419174832.146377-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/2] introduce pinned blk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com

Hi all.

Here is a proposal of replacing workaround in mirror, when
we have to move filter node back to block-job blk after
bdrv_replace_node.

Vladimir Sementsov-Ogievskiy (2):
  block: introduce pinned blk
  blockjob: use blk_new_pinned in block_job_create

 include/block/block_int.h      |  6 ++++++
 include/sysemu/block-backend.h |  1 +
 block.c                        |  2 +-
 block/block-backend.c          | 23 ++++++++++++++++++++++-
 block/mirror.c                 |  6 +-----
 blockjob.c                     |  2 +-
 6 files changed, 32 insertions(+), 8 deletions(-)

-- 
2.18.0
