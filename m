Received: from eggs.gnu.org ([209.51.188.92]:38929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxN-00063J-9b
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxE-0002rZ-Ry
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:36 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:19 +1100
Message-Id: <20190218143049.17142-14-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/43] target/ppc: Disable ISA 2.06 PM
 instructions on POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

The ISA 2.06/2.07 Power Management instructions (doze, nap & rvwinkle)
don't exist on POWER9, don't enable them.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190128094625.4428-13-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 9295f78d5f..c9985c0d22 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8873,7 +8873,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
                         PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
                         PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
                         PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
-                        PPC2_TM | PPC2_PM_ISA206 | PPC2_ISA300 | PPC2_PR=
CNTL;
+                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL;
     pcc->msr_mask =3D (1ull << MSR_SF) |
                     (1ull << MSR_TM) |
                     (1ull << MSR_VR) |
--=20
2.20.1
