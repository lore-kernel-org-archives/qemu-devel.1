Received: from eggs.gnu.org ([2001:4830:134:3::10]:52494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kC-0007s4-MA
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9k6-0004Cb-1c
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:40 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:32 +1100
Message-Id: <20170202051445.5735-95-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 094/107] ppc: Remove unused function
 cpu_ppc601_rtc_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

It is completely unused, thus it can be removed without problems.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
2.9.3
