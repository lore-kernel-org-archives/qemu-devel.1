Received: from eggs.gnu.org ([2001:4830:134:3::10]:35901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8p9e-0001GB-Vd
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8p9e-0006dg-3W
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:04 +0200
Message-Id: <1494513181-7900-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/58] block: Make bdrv_perm_names public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

It can be used outside of block.c for making user friendly messages.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c               | 2 +-
 include/block/block.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index a45b9b5..e3aa7f0 100644
--- a/block.c
+++ b/block.c
@@ -1586,7 +1586,7 @@ static char *bdrv_child_user_desc(BdrvChild *c)
     return g_strdup("another user");
 }
 
-static char *bdrv_perm_names(uint64_t perm)
+char *bdrv_perm_names(uint64_t perm)
 {
     struct perm_name {
         uint64_t perm;
diff --git a/include/block/block.h b/include/block/block.h
index 862eb56..9fa0f23 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -224,6 +224,8 @@ enum {
     BLK_PERM_ALL                = 0x1f,
 };
 
+char *bdrv_perm_names(uint64_t perm);
+
 /* disk I/O throttling */
 void bdrv_init(void);
 void bdrv_init_with_whitelist(void);
-- 
1.8.3.1
