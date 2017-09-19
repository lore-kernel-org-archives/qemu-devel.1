Received: from eggs.gnu.org ([2001:4830:134:3::10]:34794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1duQBn-000533-Lj
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 17:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1duQBk-0003kb-8F
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 17:36:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1duQBk-0003k5-3Z
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 17:36:16 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 19 Sep 2017 17:36:10 -0400
Message-Id: <20170919213611.8988-2-jsnow@redhat.com>
In-Reply-To: <20170919213611.8988-1-jsnow@redhat.com>
References: <20170919213611.8988-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] ppc: remove unused CPU definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, thuth@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, John Snow <jsnow@redhat.com>

Following commit aef77960, remove now-unused definitions from
cpu-models.h.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 target/ppc/cpu-models.h | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index df31d7f..b34b512 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -291,34 +291,6 @@ enum {
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
@@ -326,11 +298,7 @@ enum {
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
2.9.5
