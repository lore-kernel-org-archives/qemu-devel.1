Received: from eggs.gnu.org ([2001:4830:134:3::10]:59954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRd4M-0003Ug-Ee
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRd4I-00077n-NY
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:06:26 -0500
Received: from 6.mo5.mail-out.ovh.net ([178.32.119.138]:38911)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gRd4G-00075u-Rg
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:06:21 -0500
Received: from player793.ha.ovh.net (unknown [10.109.146.82])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id ADB13207676
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 14:06:17 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 27 Nov 2018 14:06:12 +0100
Message-ID: <154332397198.541746.6299446399761681597.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH for-4.0 7/9] virtex_ml507: use g_new(T,
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
 hw/ppc/virtex_ml507.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index ee9b4b449086..517712057434 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -105,7 +105,7 @@ static PowerPCCPU *ppc440_init_xilinx(ram_addr_t *ram_size,
     ppc_dcr_init(env, NULL, NULL);
 
     /* interrupt controller */
-    irqs = g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
+    irqs = g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
     irqs[PPCUIC_OUTPUT_INT] = ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_INT];
     irqs[PPCUIC_OUTPUT_CINT] = ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_CINT];
     ppcuic_init(env, irqs, 0x0C0, 0, 1);
