Received: from eggs.gnu.org ([2001:4830:134:3::10]:56658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70P-0001UO-TC
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70O-00047W-JH
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:41 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:43:08 +1000
Message-Id: <20170927074316.4454-19-david@gibson.dropbear.id.au>
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 18/26] ppc: remove unused CPU definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mark.cave-ayland@ilande.co.uk, balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: John Snow <jsnow@redhat.com>

Following commit aef77960, remove now-unused definitions from
cpu-models.h.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu-models.h | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index ed64005ff8..152365425d 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -292,34 +292,6 @@ enum {
 #endif
     CPU_POWERPC_e200z5             = 0x81000000,
     CPU_POWERPC_e200z6             = 0x81120000,
-    /* MPC55xx microcontrollers */
-#define CPU_POWERPC_MPC55xx          CPU_POWERPC_MPC5567
-#if 0
-#define CPU_POWERPC_MPC5514E         CPU_POWERPC_MPC5514E_v1
-#define CPU_POWERPC_MPC5514E_v0      CPU_POWERPC_e200z0
-#define CPU_POWERPC_MPC5514E_v1      CPU_POWERPC_e200z1
-#define CPU_POWERPC_MPC5514G         CPU_POWERPC_MPC5514G_v1
-#define CPU_POWERPC_MPC5514G_v0      CPU_POWERPC_e200z0
-#define CPU_POWERPC_MPC5514G_v1      CPU_POWERPC_e200z1
-#define CPU_POWERPC_MPC5515S         CPU_POWERPC_e200z1
-#define CPU_POWERPC_MPC5516E         CPU_POWERPC_MPC5516E_v1
-#define CPU_POWERPC_MPC5516E_v0      CPU_POWERPC_e200z0
-#define CPU_POWERPC_MPC5516E_v1      CPU_POWERPC_e200z1
-#define CPU_POWERPC_MPC5516G         CPU_POWERPC_MPC5516G_v1
-#define CPU_POWERPC_MPC5516G_v0      CPU_POWERPC_e200z0
-#define CPU_POWERPC_MPC5516G_v1      CPU_POWERPC_e200z1
-#define CPU_POWERPC_MPC5516S         CPU_POWERPC_e200z1
-#endif
-#if 0
-#define CPU_POWERPC_MPC5533          CPU_POWERPC_e200z3
-#define CPU_POWERPC_MPC5534          CPU_POWERPC_e200z3
-#endif
-#define CPU_POWERPC_MPC5553          CPU_POWERPC_e200z6
-#define CPU_POWERPC_MPC5554          CPU_POWERPC_e200z6
-#define CPU_POWERPC_MPC5561          CPU_POWERPC_e200z6
-#define CPU_POWERPC_MPC5565          CPU_POWERPC_e200z6
-#define CPU_POWERPC_MPC5566          CPU_POWERPC_e200z6
-#define CPU_POWERPC_MPC5567          CPU_POWERPC_e200z6
     /* e300 family */
     /* e300 cores */
     CPU_POWERPC_e300c1             = 0x00830010,
@@ -327,11 +299,7 @@ enum {
     CPU_POWERPC_e300c3             = 0x00850010,
     CPU_POWERPC_e300c4             = 0x00860010,
     /* MPC83xx microcontrollers */
-#define CPU_POWERPC_MPC831x          CPU_POWERPC_e300c3
-#define CPU_POWERPC_MPC832x          CPU_POWERPC_e300c2
 #define CPU_POWERPC_MPC834x          CPU_POWERPC_e300c1
-#define CPU_POWERPC_MPC835x          CPU_POWERPC_e300c1
-#define CPU_POWERPC_MPC836x          CPU_POWERPC_e300c1
 #define CPU_POWERPC_MPC837x          CPU_POWERPC_e300c4
     /* e500 family */
     /* e500 cores  */
-- 
2.13.5
