Received: from eggs.gnu.org ([2001:4830:134:3::10]:50666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIC5-0003cf-KY
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIC3-00026U-Iv
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:49 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Dec 2018 15:01:08 +1100
Message-Id: <20181213040126.6768-10-david@gibson.dropbear.id.au>
In-Reply-To: <20181213040126.6768-1-david@gibson.dropbear.id.au>
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/27] sam460ex: use g_new(T,
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
 hw/ppc/sam460ex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 5aac58f36e..4b051c0950 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -430,7 +430,7 @@ static void sam460ex_init(MachineState *machine)
     ppc4xx_plb_init(env);
=20
     /* interrupt controllers */
-    irqs =3D g_malloc0(sizeof(*irqs) * PPCUIC_OUTPUT_NB);
+    irqs =3D g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
     irqs[PPCUIC_OUTPUT_INT] =3D ((qemu_irq *)env->irq_inputs)[PPC40x_INP=
UT_INT];
     irqs[PPCUIC_OUTPUT_CINT] =3D ((qemu_irq *)env->irq_inputs)[PPC40x_IN=
PUT_CINT];
     uic[0] =3D ppcuic_init(env, irqs, 0xc0, 0, 1);
--=20
2.19.2
