Received: from eggs.gnu.org ([2001:4830:134:3::10]:60045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5amh-0003Io-MA
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5amh-0007uS-1w
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:36:19 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  3 May 2017 00:35:36 +0800
Message-Id: <20170502163558.7611-2-famz@redhat.com>
In-Reply-To: <20170502163558.7611-1-famz@redhat.com>
References: <20170502163558.7611-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v17 01/23] block: Make bdrv_perm_names public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, famz@redhat.com, Max Reitz <mreitz@redhat.com>, eblake@redhat.com

It can be used outside of block.c for making user friendly messages.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c               | 2 +-
 include/block/block.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 6c6bb3e..d8fcad9 100644
--- a/block.c
+++ b/block.c
@@ -1588,7 +1588,7 @@ static char *bdrv_child_user_desc(BdrvChild *c)
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
2.9.3
