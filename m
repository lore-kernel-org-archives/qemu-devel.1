Received: from eggs.gnu.org ([2001:4830:134:3::10]:38995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fyGg7-0007Dc-EB
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:20:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fyGg4-0008CA-9c
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:20:03 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  7 Sep 2018 15:19:54 +0200
Message-Id: <1536326394-6466-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] target/ppc/cpu-models: Re-group the 970 CPUs
 together again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org

The addition of the POWER9 CPUs divided the entries for the 970 CPUs,
which is a little bit confusing when you look at the code. So let's
re-group the 970 CPUs together again, and since these chips have been
based on the POWER4 processor, move them also in front of the POWER5
chips now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/ppc/cpu-models.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 6c9bfde..7c75963 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -741,26 +741,8 @@
                 "PowerPC 7457A v1.2 (G4)")
     /* 64 bits PowerPC                                                       */
 #if defined (TARGET_PPC64)
-    POWERPC_DEF("power5+_v2.1",  CPU_POWERPC_POWER5P_v21,            POWER5P,
-                "POWER5+ v2.1")
-    POWERPC_DEF("power7_v2.3",   CPU_POWERPC_POWER7_v23,             POWER7,
-                "POWER7 v2.3")
-    POWERPC_DEF("power7+_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
-                "POWER7+ v2.1")
-    POWERPC_DEF("power8e_v2.1",  CPU_POWERPC_POWER8E_v21,            POWER8,
-                "POWER8E v2.1")
-    POWERPC_DEF("power8_v2.0",   CPU_POWERPC_POWER8_v20,             POWER8,
-                "POWER8 v2.0")
-    POWERPC_DEF("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10,         POWER8,
-                "POWER8NVL v1.0")
     POWERPC_DEF("970_v2.2",      CPU_POWERPC_970_v22,                970,
                 "PowerPC 970 v2.2")
-
-    POWERPC_DEF("power9_v1.0",   CPU_POWERPC_POWER9_DD1,             POWER9,
-                "POWER9 v1.0")
-    POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POWER9,
-                "POWER9 v2.0")
-
     POWERPC_DEF("970fx_v1.0",    CPU_POWERPC_970FX_v10,              970,
                 "PowerPC 970FX v1.0 (G5)")
     POWERPC_DEF("970fx_v2.0",    CPU_POWERPC_970FX_v20,              970,
@@ -775,6 +757,22 @@
                 "PowerPC 970MP v1.0")
     POWERPC_DEF("970mp_v1.1",    CPU_POWERPC_970MP_v11,              970,
                 "PowerPC 970MP v1.1")
+    POWERPC_DEF("power5+_v2.1",  CPU_POWERPC_POWER5P_v21,            POWER5P,
+                "POWER5+ v2.1")
+    POWERPC_DEF("power7_v2.3",   CPU_POWERPC_POWER7_v23,             POWER7,
+                "POWER7 v2.3")
+    POWERPC_DEF("power7+_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
+                "POWER7+ v2.1")
+    POWERPC_DEF("power8e_v2.1",  CPU_POWERPC_POWER8E_v21,            POWER8,
+                "POWER8E v2.1")
+    POWERPC_DEF("power8_v2.0",   CPU_POWERPC_POWER8_v20,             POWER8,
+                "POWER8 v2.0")
+    POWERPC_DEF("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10,         POWER8,
+                "POWER8NVL v1.0")
+    POWERPC_DEF("power9_v1.0",   CPU_POWERPC_POWER9_DD1,             POWER9,
+                "POWER9 v1.0")
+    POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POWER9,
+                "POWER9 v2.0")
 #endif /* defined (TARGET_PPC64) */
 
 /***************************************************************************/
@@ -940,6 +938,9 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "7457a", "7457a_v1.2" },
     { "apollo7pm", "7457a_v1.0" },
 #if defined(TARGET_PPC64)
+    { "970", "970_v2.2" },
+    { "970fx", "970fx_v3.1" },
+    { "970mp", "970mp_v1.1" },
     { "power5+", "power5+_v2.1" },
     { "power5gs", "power5+_v2.1" },
     { "power7", "power7_v2.3" },
@@ -948,9 +949,6 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "power8", "power8_v2.0" },
     { "power8nvl", "power8nvl_v1.0" },
     { "power9", "power9_v2.0" },
-    { "970", "970_v2.2" },
-    { "970fx", "970fx_v3.1" },
-    { "970mp", "970mp_v1.1" },
 #endif
 
     /* Generic PowerPCs */
-- 
1.8.3.1
