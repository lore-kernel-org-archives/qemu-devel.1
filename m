Received: from eggs.gnu.org ([2001:4830:134:3::10]:35848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewTuX-0001wx-9B
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewTuR-0003vp-PK
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:31:17 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Mar 2018 15:30:56 +0100
Message-Id: <20180315143056.14144-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] iscsi: fix iSER compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

This fails in Fedora 28.

Reported-by: Andreas Schwab <schwab@suse.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/iscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index a82170f16e..f5aecfc883 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2244,7 +2244,7 @@ static BlockDriver bdrv_iser = {
     .create_opts            = &iscsi_create_opts,
     .bdrv_reopen_prepare    = iscsi_reopen_prepare,
     .bdrv_reopen_commit     = iscsi_reopen_commit,
-    .bdrv_invalidate_cache  = iscsi_invalidate_cache,
+    .bdrv_co_invalidate_cache  = iscsi_co_invalidate_cache,
 
     .bdrv_getlength  = iscsi_getlength,
     .bdrv_get_info   = iscsi_get_info,
-- 
2.14.3
