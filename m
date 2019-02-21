Received: from eggs.gnu.org ([209.51.188.92]:33477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gwqFN-0004dO-AT
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:26:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gwqFJ-0000dn-52
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:26:46 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Thu, 21 Feb 2019 18:26:37 +0300
Message-Id: <1550762799-830661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/2] block-stream: include base into job node
 list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berto@igalia.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

The block-stream job needs to own the base node as the limiter for
the copy-on-read operation. So, the base node is included in the
job node list by calling to the function block_job_add_bdrv().
Also, the block-stream job would not allow the base node to go
away due to the graph modification, e.g. when a filter node is
inserted between the bottom node and the base node.
For that reason, the flag BLK_PERM_GRAPH_MOD is unset in the
shared permission bit mask of the base node.

Andrey Shinkevich (2):
  iotests: 030 TestParallelOps non-shared base node
  block-stream: include base node into the job protected list

 block/stream.c         |  9 +++++++++
 tests/qemu-iotests/030 | 34 ++++++++++++++++++----------------
 2 files changed, 27 insertions(+), 16 deletions(-)

-- 
1.8.3.1
