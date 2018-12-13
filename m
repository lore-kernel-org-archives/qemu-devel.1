Received: from eggs.gnu.org ([2001:4830:134:3::10]:50657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIC5-0003cN-AI
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIC2-00024A-Nd
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:49 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Dec 2018 15:01:07 +1100
Message-Id: <20181213040126.6768-9-david@gibson.dropbear.id.au>
In-Reply-To: <20181213040126.6768-1-david@gibson.dropbear.id.au>
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/27] ppc440_bamboo: use g_new(T,
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc440_bamboo.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index f5720f979e..b8aa55d526 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -169,8 +169,7 @@ static void bamboo_init(MachineState *machine)
     unsigned int pci_irq_nrs[4] =3D { 28, 27, 26, 25 };
     MemoryRegion *address_space_mem =3D get_system_memory();
     MemoryRegion *isa =3D g_new(MemoryRegion, 1);
-    MemoryRegion *ram_memories
-        =3D g_malloc(PPC440EP_SDRAM_NR_BANKS * sizeof(*ram_memories));
+    MemoryRegion *ram_memories =3D g_new(MemoryRegion, PPC440EP_SDRAM_NR=
_BANKS);
     hwaddr ram_bases[PPC440EP_SDRAM_NR_BANKS];
     hwaddr ram_sizes[PPC440EP_SDRAM_NR_BANKS];
     qemu_irq *pic;
@@ -200,7 +199,7 @@ static void bamboo_init(MachineState *machine)
     ppc_dcr_init(env, NULL, NULL);
=20
     /* interrupt controller */
-    irqs =3D g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
+    irqs =3D g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
     irqs[PPCUIC_OUTPUT_INT] =3D ((qemu_irq *)env->irq_inputs)[PPC40x_INP=
UT_INT];
     irqs[PPCUIC_OUTPUT_CINT] =3D ((qemu_irq *)env->irq_inputs)[PPC40x_IN=
PUT_CINT];
     pic =3D ppcuic_init(env, irqs, 0x0C0, 0, 1);
--=20
2.19.2
