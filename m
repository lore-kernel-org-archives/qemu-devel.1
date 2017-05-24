Received: from eggs.gnu.org ([2001:4830:134:3::10]:34176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDMQQ-0000hw-Sl
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDMQN-00073n-SE
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:53:26 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 24 May 2017 10:52:28 +0800
Message-Id: <20170524025235.32190-10-famz@redhat.com>
In-Reply-To: <20170524025235.32190-1-famz@redhat.com>
References: <20170524025235.32190-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 09/16] commit: Allow aio context change on
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

The block job has the aio context change notifier, we should allow it
here as well.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/commit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/commit.c b/block/commit.c
index e2ee0ff..bbf7768 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -391,7 +391,8 @@ void commit_start(const char *job_id, BlockDriverState *bs,
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
2.9.4
