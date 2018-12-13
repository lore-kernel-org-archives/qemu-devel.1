Received: from eggs.gnu.org ([2001:4830:134:3::10]:50640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIC4-0003bk-T5
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIC2-00024O-NU
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:48 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Dec 2018 15:01:06 +1100
Message-Id: <20181213040126.6768-8-david@gibson.dropbear.id.au>
In-Reply-To: <20181213040126.6768-1-david@gibson.dropbear.id.au>
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/27] ppc405_uc: use g_new(T,
 n) instead of g_malloc(sizeof(T) * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Because it is a recommended coding practice (see HACKING).

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc405_uc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 5c58415cf1..e1aadf126d 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -1519,7 +1519,7 @@ CPUPPCState *ppc405cr_init(MemoryRegion *address_sp=
ace_mem,
     /* OBP arbitrer */
     ppc4xx_opba_init(0xef600600);
     /* Universal interrupt controller */
-    irqs =3D g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
+    irqs =3D g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
     irqs[PPCUIC_OUTPUT_INT] =3D
         ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_INT];
     irqs[PPCUIC_OUTPUT_CINT] =3D
@@ -1877,7 +1877,7 @@ CPUPPCState *ppc405ep_init(MemoryRegion *address_sp=
ace_mem,
     /* Initialize timers */
     ppc_booke_timers_init(cpu, sysclk, 0);
     /* Universal interrupt controller */
-    irqs =3D g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
+    irqs =3D g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
     irqs[PPCUIC_OUTPUT_INT] =3D
         ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_INT];
     irqs[PPCUIC_OUTPUT_CINT] =3D
--=20
2.19.2
