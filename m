Received: from eggs.gnu.org ([2001:4830:134:3::10]:40376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAJk-0002c0-PO
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAJj-00013J-VP
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:18:40 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 21 Mar 2017 11:16:27 +0800
Message-Id: <20170321031635.22123-9-famz@redhat.com>
In-Reply-To: <20170321031635.22123-1-famz@redhat.com>
References: <20170321031635.22123-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 08/16] commit: Allow aio context change on
 s->base
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

The block job has the aio context change notifier, we should allow it
here as well.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/commit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/commit.c b/block/commit.c
index 2832482..a1805c2 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -388,7 +388,8 @@ void commit_start(const char *job_id, BlockDriverState *bs,
                       | BLK_PERM_RESIZE,
                       BLK_PERM_CONSISTENT_READ
                       | BLK_PERM_GRAPH_MOD
-                      | BLK_PERM_WRITE_UNCHANGED);
+                      | BLK_PERM_WRITE_UNCHANGED
+                      | BLK_PERM_AIO_CONTEXT_CHANGE);
     ret = blk_insert_bs(s->base, base, errp);
     if (ret < 0) {
         goto fail;
-- 
2.9.3
