Received: from eggs.gnu.org ([2001:4830:134:3::10]:45675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQM-0007ri-9A
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:25:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQL-0001MU-7M
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:25:58 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 17 Jan 2018 13:25:24 +1100
Message-Id: <20180117022525.31767-22-david@gibson.dropbear.id.au>
In-Reply-To: <20180117022525.31767-1-david@gibson.dropbear.id.au>
References: <20180117022525.31767-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/22] target/ppc: add support for POWER9 HILE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h         | 1 +
 target/ppc/excp_helper.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index dc6820c5eb..14aaa87fe8 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2012,6 +2012,7 @@ void ppc_compat_add_property(Object *obj, const cha=
r *name,
 #define HID0_DOZE           (1 << 23)           /* pre-2.06 */
 #define HID0_NAP            (1 << 22)           /* pre-2.06 */
 #define HID0_HILE           PPC_BIT(19) /* POWER8 */
+#define HID0_POWER9_HILE    PPC_BIT(4)
=20
 /***********************************************************************=
******/
 /* PowerPC Instructions types definitions                               =
     */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 37d2410726..4e548a4487 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -654,7 +654,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
         }
     } else if (excp_model =3D=3D POWERPC_EXCP_POWER8) {
         if (new_msr & MSR_HVB) {
-            if (env->spr[SPR_HID0] & HID0_HILE) {
+            if (env->spr[SPR_HID0] & (HID0_HILE | HID0_POWER9_HILE)) {
                 new_msr |=3D (target_ulong)1 << MSR_LE;
             }
         } else if (env->spr[SPR_LPCR] & LPCR_ILE) {
--=20
2.14.3
