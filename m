Received: from eggs.gnu.org ([2001:4830:134:3::10]:59377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRd3L-0002bh-5h
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRd3H-0005TS-5c
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:05:23 -0500
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:50283)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gRd3F-0005Pb-2K
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:05:19 -0500
Received: from player760.ha.ovh.net (unknown [10.109.146.82])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 2903BE46CA
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 14:05:12 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 27 Nov 2018 14:05:06 +0100
Message-ID: <154332390658.541746.14345430389973192696.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH for-4.0 1/9] target/ppc: use g_new(T,
 n) instead of g_malloc(sizeof(T) * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Because it is a recommended coding practice (see HACKING).

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/translate_init.inc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 168d0cec28b7..03f1d34a9769 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9081,13 +9081,13 @@ static void init_ppc_proc(PowerPCCPU *cpu)
             nb_tlb *= 2;
         switch (env->tlb_type) {
         case TLB_6XX:
-            env->tlb.tlb6 = g_malloc0(nb_tlb * sizeof(ppc6xx_tlb_t));
+            env->tlb.tlb6 = g_new0(ppc6xx_tlb_t, nb_tlb);
             break;
         case TLB_EMB:
-            env->tlb.tlbe = g_malloc0(nb_tlb * sizeof(ppcemb_tlb_t));
+            env->tlb.tlbe = g_new0(ppcemb_tlb_t, nb_tlb);
             break;
         case TLB_MAS:
-            env->tlb.tlbm = g_malloc0(nb_tlb * sizeof(ppcmas_tlb_t));
+            env->tlb.tlbm = g_new0(ppcmas_tlb_t, nb_tlb);
             break;
         }
         /* Pre-compute some useful values */
