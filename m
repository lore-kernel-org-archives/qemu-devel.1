Received: from eggs.gnu.org ([2001:4830:134:3::10]:44409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1ftIjd-0001sN-Ju
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 16:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1ftIja-0004Wd-9L
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 16:31:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 24 Aug 2018 16:31:01 -0400
Message-Id: <20180824203101.30125-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH] spapr: fix leak of rev array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org

Introduced in 04d595b300 ("spapr: do not use CPU_FOREACH_REVERSE",
2018-08-23)

Fixes: CID1395181
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 hw/ppc/spapr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4edb6c7d16..505d4c84e5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -607,6 +607,7 @@ static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *spapr)
         spapr_populate_cpu_dt(cs, fdt, offset, spapr);
     }
 
+    g_free(rev);
 }
 
 static uint32_t spapr_pc_dimm_node(MemoryDeviceInfoList *list, ram_addr_t addr)
-- 
2.17.1
