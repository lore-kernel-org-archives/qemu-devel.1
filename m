Received: from eggs.gnu.org ([209.51.188.92]:38637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8y-0000rn-T6
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8k-0007s5-VA
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:14 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:01:10 +1100
Message-Id: <20190204090124.26191-24-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/37] spapr: Drop unused parameters from fdt
 building helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

spapr_load_rtas() handles now RTAS address and size information in the FD=
T
so drop them from spapr_build_fdt().

While we are here, fix a small typo.

Fixes: 3f5dabceba24 "pseries: Consolidate construction of /rtas device tr=
ee node"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 487cdf2f3a..c66e7d8e0a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1225,9 +1225,7 @@ static void spapr_dt_hypervisor(sPAPRMachineState *=
spapr, void *fdt)
     }
 }
=20
-static void *spapr_build_fdt(sPAPRMachineState *spapr,
-                             hwaddr rtas_addr,
-                             hwaddr rtas_size)
+static void *spapr_build_fdt(sPAPRMachineState *spapr)
 {
     MachineState *machine =3D MACHINE(spapr);
     MachineClass *mc =3D MACHINE_GET_CLASS(machine);
@@ -1644,14 +1642,14 @@ static void spapr_machine_reset(void)
=20
     /*
      * We place the device tree and RTAS just below either the top of th=
e RMA,
-     * or just below 2GB, whichever is lowere, so that it can be
+     * or just below 2GB, whichever is lower, so that it can be
      * processed with 32-bit real mode code if necessary
      */
     rtas_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR);
     rtas_addr =3D rtas_limit - RTAS_MAX_SIZE;
     fdt_addr =3D rtas_addr - FDT_MAX_SIZE;
=20
-    fdt =3D spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
+    fdt =3D spapr_build_fdt(spapr);
=20
     spapr_load_rtas(spapr, fdt, rtas_addr);
=20
--=20
2.20.1
