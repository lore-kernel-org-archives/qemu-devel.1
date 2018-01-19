Received: from eggs.gnu.org ([2001:4830:134:3::10]:40978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecTAd-0002Aj-Fy
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecTAc-0000vs-Oc
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:41:11 -0500
Received: from ozlabs.org ([103.22.144.67]:40875)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ecTAc-0000tH-Dg
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:41:10 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 19 Jan 2018 20:40:07 +1100
Message-Id: <20180119094015.28266-6-david@gibson.dropbear.id.au>
In-Reply-To: <20180119094015.28266-1-david@gibson.dropbear.id.au>
References: <20180119094015.28266-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/13] target/ppc: fix doorbell and hypervisor
 doorbell definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, surajjs@au1.ibm.com, lvivier@redhat.com, agraf@suse.de, qemu-ppc@nognu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

commit f03a1af581b9 ("ppc: Fix POWER7 and POWER8 exception definitions")
introduced definitions for the server doorbell exceptions by reusing
the embedded definitions but this adds complexity in the powerpc_excp()
routine. Let's introduce specific definitions for the Server doorbells
exception.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 14aaa87fe8..b8f4dfc108 100644
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
2.14.3
