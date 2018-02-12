Received: from eggs.gnu.org ([2001:4830:134:3::10]:44892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zJ-0007gw-C6
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zH-00067Q-UE
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:05 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 12 Feb 2018 14:40:44 +1100
Message-Id: <20180212034054.23441-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180212034054.23441-1-david@gibson.dropbear.id.au>
References: <20180212034054.23441-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/12] hw/ppc: rename functions in comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Commit bcb5ce08cf ("spapr: Rename machine init functions for clarity")
renamed ppc_spapr_reset to spapr_machine_reset and ppc_spapr_init
to spapr_machine_init. Let's also rename the references in
comments.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c       | 3 ++-
 hw/ppc/spapr_hcall.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 659be6b746..96515036e6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -464,7 +464,8 @@ static int spapr_populate_memory(sPAPRMachineState *s=
papr, void *fdt)
             }
         }
         if (!mem_start) {
-            /* ppc_spapr_init() checks for rma_size <=3D node0_size alre=
ady */
+            /* spapr_machine_init() checks for rma_size <=3D node0_size
+             * already */
             spapr_populate_memory_node(fdt, i, 0, spapr->rma_size);
             mem_start +=3D spapr->rma_size;
             node_size -=3D spapr->rma_size;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 596f58378a..76422cfac1 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1635,7 +1635,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
     spapr->cas_legacy_guest_workaround =3D !spapr_ovec_test(ov1_guest,
                                                           OV1_PPC_3_00);
     if (!spapr->cas_reboot) {
-        /* If ppc_spapr_reset() did not set up a HPT but one is necessar=
y
+        /* If spapr_machine_reset() did not set up a HPT but one is nece=
ssary
          * (because the guest isn't going to use radix) then set it up h=
ere. */
         if ((spapr->patb_entry & PATBE1_GR) && !guest_radix) {
             /* legacy hash or new hash: */
--=20
2.14.3
