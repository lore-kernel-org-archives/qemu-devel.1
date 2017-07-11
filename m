Received: from eggs.gnu.org ([2001:4830:134:3::10]:40534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxK-0002IF-MF
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxI-0007SF-8k
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:26 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 11 Jul 2017 14:39:03 +1000
Message-Id: <20170711043917.1757-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170711043917.1757-1-david@gibson.dropbear.id.au>
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 03/17] spapr: fix bogus function name in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, groug@kaod.org, bharata@linux.vnet.ibm.com, lvivier@redhat.com, aik@ozlabs.ru, surajjs@au1.ibm.com, sbobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

$ git grep spapr_ppc_reset
hw/ppc/spapr.c: * as part of spapr_ppc_reset().

$ git grep ppc_spapr_reset
hw/ppc/spapr.c:static void ppc_spapr_reset(void)
hw/ppc/spapr.c:    mc->reset = ppc_spapr_reset;
hw/ppc/spapr_hcall.c:        /* If ppc_spapr_reset() did not set up a HPT
 but one is necessary

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 65d8ad2..5acfb47 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1973,7 +1973,7 @@ static void spapr_boot_set(void *opaque, const char *boot_device,
  * Unlike PCI DR devices, LMB DR devices explicitly register this reset
  * routine. Reset for PCI DR devices will be handled by PHB reset routine
  * when it walks all its children devices. LMB devices reset occurs
- * as part of spapr_ppc_reset().
+ * as part of ppc_spapr_reset().
  */
 static void spapr_drc_reset(void *opaque)
 {
-- 
2.9.4
