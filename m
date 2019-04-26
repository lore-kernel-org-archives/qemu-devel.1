Received: from eggs.gnu.org ([209.51.188.92]:59954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0W-0005RR-U6
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0V-0004Nh-Ic
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:48 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:05:56 +1000
Message-Id: <20190426060627.18153-6-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/36] target/ppc: Style fixes for
 ppc-models.[ch]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/cpu-models.c | 2 +-
 target/ppc/cpu-models.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 7c75963e3c..9d7050b5fa 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -740,7 +740,7 @@
     POWERPC_DEF("7457a_v1.2",    CPU_POWERPC_74x7A_v12,              745=
5,
                 "PowerPC 7457A v1.2 (G4)")
     /* 64 bits PowerPC                                                  =
     */
-#if defined (TARGET_PPC64)
+#if defined(TARGET_PPC64)
     POWERPC_DEF("970_v2.2",      CPU_POWERPC_970_v22,                970=
,
                 "PowerPC 970 v2.2")
     POWERPC_DEF("970fx_v1.0",    CPU_POWERPC_970FX_v10,              970=
,
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index efdb2fa53c..4fdb73034d 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -393,7 +393,8 @@ enum {
     CPU_POWERPC_RS64IV             =3D 0x00370000,
 #endif /* defined(TARGET_PPC64) */
     /* Original POWER */
-    /* XXX: should be POWER (RIOS), RSC3308, RSC4608,
+    /*
+     * XXX: should be POWER (RIOS), RSC3308, RSC4608,
      * POWER2 (RIOS2) & RSC2 (P2SC) here
      */
     /* PA Semi core */
--=20
2.20.1
