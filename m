Received: from eggs.gnu.org ([2001:4830:134:3::10]:59785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRd3r-00034d-Ej
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRd3n-0006OA-2B
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:05:55 -0500
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:57391)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gRd3m-0006H2-Dq
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:05:50 -0500
Received: from player695.ha.ovh.net (unknown [10.109.160.153])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 25E68174EFD
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 14:05:46 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 27 Nov 2018 14:05:38 +0100
Message-ID: <154332393835.541746.592813777514601908.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH for-4.0 4/9] ppc405_uc: use g_new(T,
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
 hw/ppc/ppc405_uc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 5c58415cf1fd..e1aadf126d59 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -1519,7 +1519,7 @@ CPUPPCState *ppc405cr_init(MemoryRegion *address_space_mem,
     /* OBP arbitrer */
     ppc4xx_opba_init(0xef600600);
     /* Universal interrupt controller */
-    irqs = g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
+    irqs = g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
     irqs[PPCUIC_OUTPUT_INT] =
         ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_INT];
     irqs[PPCUIC_OUTPUT_CINT] =
@@ -1877,7 +1877,7 @@ CPUPPCState *ppc405ep_init(MemoryRegion *address_space_mem,
     /* Initialize timers */
     ppc_booke_timers_init(cpu, sysclk, 0);
     /* Universal interrupt controller */
-    irqs = g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
+    irqs = g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
     irqs[PPCUIC_OUTPUT_INT] =
         ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_INT];
     irqs[PPCUIC_OUTPUT_CINT] =
