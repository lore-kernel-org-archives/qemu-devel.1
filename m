Received: from eggs.gnu.org ([2001:4830:134:3::10]:50202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVcVL-0002jq-6S
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVcVH-0002kD-AT
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:41:59 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Jul 2017 13:41:29 +0200
Message-Id: <1499946095-8224-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499946095-8224-1-git-send-email-kwolf@redhat.com>
References: <1499946095-8224-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/9] block: Make blk_all_next() public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/block-backend.c          | 2 +-
 include/sysemu/block-backend.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index d60e53b..15072f8 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -342,7 +342,7 @@ void blk_unref(BlockBackend *blk)
  * Behaves similarly to blk_next() but iterates over all BlockBackends, even the
  * ones which are hidden (i.e. are not referenced by the monitor).
  */
-static BlockBackend *blk_all_next(BlockBackend *blk)
+BlockBackend *blk_all_next(BlockBackend *blk)
 {
     return blk ? QTAILQ_NEXT(blk, link)
                : QTAILQ_FIRST(&block_backends);
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 80096f2..dfdd3b8 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -100,6 +100,7 @@ void blk_remove_all_bs(void);
 const char *blk_name(const BlockBackend *blk);
 BlockBackend *blk_by_name(const char *name);
 BlockBackend *blk_next(BlockBackend *blk);
+BlockBackend *blk_all_next(BlockBackend *blk);
 bool monitor_add_blk(BlockBackend *blk, const char *name, Error **errp);
 void monitor_remove_blk(BlockBackend *blk);
 
-- 
1.8.3.1
