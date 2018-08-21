Received: from eggs.gnu.org ([2001:4830:134:3::10]:56803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryN0-0004Jy-OJ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMx-0000VF-5u
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:18 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Aug 2018 14:33:33 +1000
Message-Id: <20180821043343.7514-17-david@gibson.dropbear.id.au>
In-Reply-To: <20180821043343.7514-1-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/26] hw/ppc/prep: Remove ifdeffed-out stub of
 XCSR code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Peter Maydell <peter.maydell@linaro.org>

The prep machine has some code which is stubs of accessors
for XCSR registers. This has been disabled via #if 0
since commit b6b8bd1819ff in 2004, and doesn't have any
actual interesting content. It also uses the deprecated
old_mmio accessor functions. Remove it entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/prep.c | 97 +++------------------------------------------------
 1 file changed, 4 insertions(+), 93 deletions(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 3401570d98..b26138e5c4 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -78,94 +78,6 @@ static int ne2000_irq[NE2000_NB_MAX] =3D { 9, 10, 11, =
3, 4, 5 };
 /* ISA IO ports bridge */
 #define PPC_IO_BASE 0x80000000
=20
-/* PowerPC control and status registers */
-#if 0 // Not used
-static struct {
-    /* IDs */
-    uint32_t veni_devi;
-    uint32_t revi;
-    /* Control and status */
-    uint32_t gcsr;
-    uint32_t xcfr;
-    uint32_t ct32;
-    uint32_t mcsr;
-    /* General purpose registers */
-    uint32_t gprg[6];
-    /* Exceptions */
-    uint32_t feen;
-    uint32_t fest;
-    uint32_t fema;
-    uint32_t fecl;
-    uint32_t eeen;
-    uint32_t eest;
-    uint32_t eecl;
-    uint32_t eeint;
-    uint32_t eemck0;
-    uint32_t eemck1;
-    /* Error diagnostic */
-} XCSR;
-
-static void PPC_XCSR_writeb (void *opaque,
-                             hwaddr addr, uint32_t value)
-{
-    printf("%s: 0x" TARGET_FMT_plx " =3D> 0x%08" PRIx32 "\n", __func__, =
addr,
-           value);
-}
-
-static void PPC_XCSR_writew (void *opaque,
-                             hwaddr addr, uint32_t value)
-{
-    printf("%s: 0x" TARGET_FMT_plx " =3D> 0x%08" PRIx32 "\n", __func__, =
addr,
-           value);
-}
-
-static void PPC_XCSR_writel (void *opaque,
-                             hwaddr addr, uint32_t value)
-{
-    printf("%s: 0x" TARGET_FMT_plx " =3D> 0x%08" PRIx32 "\n", __func__, =
addr,
-           value);
-}
-
-static uint32_t PPC_XCSR_readb (void *opaque, hwaddr addr)
-{
-    uint32_t retval =3D 0;
-
-    printf("%s: 0x" TARGET_FMT_plx " <=3D %08" PRIx32 "\n", __func__, ad=
dr,
-           retval);
-
-    return retval;
-}
-
-static uint32_t PPC_XCSR_readw (void *opaque, hwaddr addr)
-{
-    uint32_t retval =3D 0;
-
-    printf("%s: 0x" TARGET_FMT_plx " <=3D %08" PRIx32 "\n", __func__, ad=
dr,
-           retval);
-
-    return retval;
-}
-
-static uint32_t PPC_XCSR_readl (void *opaque, hwaddr addr)
-{
-    uint32_t retval =3D 0;
-
-    printf("%s: 0x" TARGET_FMT_plx " <=3D %08" PRIx32 "\n", __func__, ad=
dr,
-           retval);
-
-    return retval;
-}
-
-static const MemoryRegionOps PPC_XCSR_ops =3D {
-    .old_mmio =3D {
-        .read =3D { PPC_XCSR_readb, PPC_XCSR_readw, PPC_XCSR_readl, },
-        .write =3D { PPC_XCSR_writeb, PPC_XCSR_writew, PPC_XCSR_writel, =
},
-    },
-    .endianness =3D DEVICE_LITTLE_ENDIAN,
-};
-
-#endif
-
 /* Fake super-io ports for PREP platform (Intel 82378ZB) */
 typedef struct sysctrl_t {
     qemu_irq reset_irq;
@@ -648,11 +560,10 @@ static void ppc_prep_init(MachineState *machine)
     portio_list_init(&prep_port_list, NULL, prep_portio_list, sysctrl, "=
prep");
     portio_list_add(&prep_port_list, isa_address_space_io(isa), 0x0);
=20
-    /* PowerPC control and status register group */
-#if 0
-    memory_region_init_io(xcsr, NULL, &PPC_XCSR_ops, NULL, "ppc-xcsr", 0=
x1000);
-    memory_region_add_subregion(sysmem, 0xFEFF0000, xcsr);
-#endif
+    /*
+     * PowerPC control and status register group: unimplemented,
+     * would be at address 0xFEFF0000.
+     */
=20
     if (machine_usb(machine)) {
         pci_create_simple(pci_bus, -1, "pci-ohci");
--=20
2.17.1
