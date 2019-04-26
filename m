Received: from eggs.gnu.org ([209.51.188.92]:48397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJqJQ-0006yE-Rz
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 22:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJqJO-0005ou-Qk
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 22:10:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:22753)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJqJN-0005i8-4k
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 22:10:02 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Fri, 26 Apr 2019 10:09:27 +0800
Message-Id: <20190426020927.25470-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] memory: correct the comment to
 DIRTY_MEMORY_MIGRATION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

The dirty bit is DIRTY_MEMORY_MIGRATION. Correct the comment.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/memory.c b/memory.c
index e49369d85d..9d015bfe4c 100644
--- a/memory.c
+++ b/memory.c
@@ -2576,7 +2576,7 @@ void memory_global_dirty_log_start(void)
 
     MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);
 
-    /* Refresh DIRTY_LOG_MIGRATION bit.  */
+    /* Refresh DIRTY_MEMORY_MIGRATION bit.  */
     memory_region_transaction_begin();
     memory_region_update_pending = true;
     memory_region_transaction_commit();
@@ -2586,7 +2586,7 @@ static void memory_global_dirty_log_do_stop(void)
 {
     global_dirty_log = false;
 
-    /* Refresh DIRTY_LOG_MIGRATION bit.  */
+    /* Refresh DIRTY_MEMORY_MIGRATION bit.  */
     memory_region_transaction_begin();
     memory_region_update_pending = true;
     memory_region_transaction_commit();
-- 
2.19.1
