Received: from eggs.gnu.org ([2001:4830:134:3::10]:44809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1coh8D-0008KQ-Uj
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 21:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1coh8D-0004tK-0a
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 21:56:42 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 17 Mar 2017 09:56:30 +0800
Message-Id: <20170317015630.30396-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9] block: Propagate error in
 bdrv_open_backing_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block.c b/block.c
index cb57370..6621167 100644
--- a/block.c
+++ b/block.c
@@ -2025,6 +2025,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     bdrv_set_backing_hd(bs, backing_hd, &local_err);
     bdrv_unref(backing_hd);
     if (local_err) {
+        error_propagate(errp, local_err);
         ret = -EINVAL;
         goto free_exit;
     }
-- 
2.9.3
