Received: from eggs.gnu.org ([2001:4830:134:3::10]:54928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cTTxW-000585-Al
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:37:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cTTxT-0004xF-NC
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:37:58 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 17 Jan 2017 14:37:49 +0100
Message-Id: <1484660269-14363-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] ppc: Remove unused function
 cpu_ppc601_rtc_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org

It is completely unused, thus it can be removed without problems.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/ppc.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 8945869..f9a4b51 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -950,13 +950,6 @@ clk_setup_cb cpu_ppc_tb_init (CPUPPCState *env, uint32_t freq)
 }
 
 /* Specific helpers for POWER & PowerPC 601 RTC */
-#if 0
-static clk_setup_cb cpu_ppc601_rtc_init (CPUPPCState *env)
-{
-    return cpu_ppc_tb_init(env, 7812500);
-}
-#endif
-
 void cpu_ppc601_store_rtcu (CPUPPCState *env, uint32_t value)
 {
     _cpu_ppc_store_tbu(env, value);
-- 
1.8.3.1
