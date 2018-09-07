Received: from eggs.gnu.org ([2001:4830:134:3::10]:45573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fyBFT-0007UG-Qb
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 03:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fyBFQ-00053N-Jg
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 03:32:11 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  7 Sep 2018 17:31:43 +1000
Message-Id: <20180907073155.26200-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180907073155.26200-1-david@gibson.dropbear.id.au>
References: <20180907073155.26200-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 02/14] spapr: fix leak of rev array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, mark.cave-ayland@ilande.co.uk, "Emilio G. Cota" <cota@braap.org>, David Gibson <david@gibson.dropbear.id.au>

From: "Emilio G. Cota" <cota@braap.org>

Introduced in 04d595b300 ("spapr: do not use CPU_FOREACH_REVERSE",
2018-08-23)

Fixes: CID1395181
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
