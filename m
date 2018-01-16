Received: from eggs.gnu.org ([2001:4830:134:3::10]:56701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ebLt1-00028q-Lk
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 02:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ebLsw-0007jN-LF
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 02:42:23 -0500
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:59855)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ebLsw-0007iC-En
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 02:42:18 -0500
Received: from player168.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id D5553916DD
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 08:42:16 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 16 Jan 2018 08:41:55 +0100
Message-Id: <20180116074157.16886-2-clg@kaod.org>
In-Reply-To: <20180116074157.16886-1-clg@kaod.org>
References: <20180116074157.16886-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] target/ppc: fix doorbell and hypervisor
 doorbell definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

commit f03a1af581b9 ("ppc: Fix POWER7 and POWER8 exception definitions")
introduced definitions for the server doorbell exceptions by reusing
the embedded definitions but this adds complexity in the powerpc_excp()
routine. Let's introduce specific definitions for the Server doorbells
exception.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 14aaa87fe825..b8f4dfc1084a 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -140,9 +140,6 @@ enum {
     POWERPC_EXCP_HYPPRIV  =3D 41, /* Embedded hypervisor priv instructio=
n      */
     /* Vectors 42 to 63 are reserved                                    =
     */
     /* Exceptions defined in the PowerPC server specification           =
     */
-    /* Server doorbell variants */
-#define POWERPC_EXCP_SDOOR      POWERPC_EXCP_GDOORI
-#define POWERPC_EXCP_SDOOR_HV   POWERPC_EXCP_DOORI
     POWERPC_EXCP_RESET    =3D 64, /* System reset exception             =
       */
     POWERPC_EXCP_DSEG     =3D 65, /* Data segment exception             =
       */
     POWERPC_EXCP_ISEG     =3D 66, /* Instruction segment exception      =
       */
@@ -189,8 +186,11 @@ enum {
     POWERPC_EXCP_HV_EMU   =3D 96, /* HV emulation assistance            =
       */
     POWERPC_EXCP_HV_MAINT =3D 97, /* HMI                                =
       */
     POWERPC_EXCP_HV_FU    =3D 98, /* Hypervisor Facility unavailable    =
       */
+    /* Server doorbell variants */
+    POWERPC_EXCP_SDOOR    =3D 99,
+    POWERPC_EXCP_SDOOR_HV =3D 100,
     /* EOL                                                              =
     */
-    POWERPC_EXCP_NB       =3D 99,
+    POWERPC_EXCP_NB       =3D 101,
     /* QEMU exceptions: used internally during code translation         =
     */
     POWERPC_EXCP_STOP         =3D 0x200, /* stop translation            =
       */
     POWERPC_EXCP_BRANCH       =3D 0x201, /* branch instruction          =
       */
--=20
2.13.6
