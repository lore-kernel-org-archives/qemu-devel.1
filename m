Received: from eggs.gnu.org ([2001:4830:134:3::10]:44716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqLx1-0007IY-Cr
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqLww-0001Zk-DL
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:20:47 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 16 Aug 2018 20:20:23 +0300
Message-Id: <1534440027-10528-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/4] block nodes graph visualization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, stefanha@redhat.com, pbonzini@redhat.com

Hi all!

On the way of backup schemes development (and in general any complicated
developments in Qemu block layer) it would be good to have a way to print
out graph of block nodes with their permissions. Here is this way.

Instead of a lot of words I'll reply to this cover letter with example
graph, generated in patch 04.

Vladimir Sementsov-Ogievskiy (4):
  block: improve blk_root_get_parent_desc
  qapi: add x-query-block-nodes-relations
  scripts/qemu: add render_block_graph method for QEMUMachine
  not-for-commit: example of new command usage for debugging

 qapi/block-core.json   | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/block/block.h  |  1 +
 block.c                | 57 ++++++++++++++++++++++++++++++++++++++++
 block/block-backend.c  |  2 +-
 blockdev.c             |  5 ++++
 scripts/qemu.py        | 53 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/222 |  1 +
 7 files changed, 189 insertions(+), 1 deletion(-)

-- 
2.11.1
