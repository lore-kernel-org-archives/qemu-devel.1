Received: from eggs.gnu.org ([2001:4830:134:3::10]:53326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eb97s-0002UR-CO
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:04:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eb97o-0007Sv-GK
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:04:51 -0500
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:33183)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eb97o-0007SQ-AF
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:04:48 -0500
Received: from player687.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id D5B35A29D2
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 19:04:38 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 15 Jan 2018 19:04:06 +0100
Message-Id: <20180115180406.28489-7-clg@kaod.org>
In-Reply-To: <20180115180406.28489-1-clg@kaod.org>
References: <20180115180406.28489-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/6] target/ppc: add support for POWER9 HILE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h         | 1 +
 target/ppc/excp_helper.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index dc6820c5eb99..14aaa87fe825 100644
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
index 37d241072685..4e548a448747 100644
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
2.13.6
