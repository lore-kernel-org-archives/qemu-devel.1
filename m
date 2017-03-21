Received: from eggs.gnu.org ([2001:4830:134:3::10]:42038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqANC-0005bD-EE
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAN9-0002k3-BC
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:22:14 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 21 Mar 2017 11:16:35 +0800
Message-Id: <20170321031635.22123-17-famz@redhat.com>
In-Reply-To: <20170321031635.22123-1-famz@redhat.com>
References: <20170321031635.22123-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 16/16] Revert "mirror: Request aio context
 change permission on target"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

This reverts commit bee8490438adfb30785cd5256019e8cba9fb3a07.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/mirror.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index 168cf60..240da19 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1187,7 +1187,6 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     target_is_backing = bdrv_chain_contains(bs, target);
     target_graph_mod = (backing_mode != MIRROR_LEAVE_BACKING_CHAIN);
     s->target = blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE |
-                        BLK_PERM_AIO_CONTEXT_CHANGE |
                         (target_graph_mod ? BLK_PERM_GRAPH_MOD : 0),
                         BLK_PERM_WRITE_UNCHANGED |
                         (target_is_backing ? BLK_PERM_CONSISTENT_READ |
-- 
2.9.3
