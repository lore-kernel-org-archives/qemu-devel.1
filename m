Received: from eggs.gnu.org ([2001:4830:134:3::10]:43101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3Dii-0002EN-7j
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 23:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3Dih-0001Xh-9c
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 23:34:24 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 26 Apr 2017 11:33:53 +0800
Message-Id: <20170426033413.17192-2-famz@redhat.com>
In-Reply-To: <20170426033413.17192-1-famz@redhat.com>
References: <20170426033413.17192-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v15 01/21] block: Make bdrv_perm_names public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

It can be used outside of block.c for making user friendly messages.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c               | 2 +-
 include/block/block.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 1e668fb..fce77bf 100644
--- a/block.c
+++ b/block.c
@@ -1551,7 +1551,7 @@ static char *bdrv_child_user_desc(BdrvChild *c)
     return g_strdup("another user");
 }
 
-static char *bdrv_perm_names(uint64_t perm)
+char *bdrv_perm_names(uint64_t perm)
 {
     struct perm_name {
         uint64_t perm;
diff --git a/include/block/block.h b/include/block/block.h
index 5ddc0cf..eb0565d 100644
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
2.9.3
