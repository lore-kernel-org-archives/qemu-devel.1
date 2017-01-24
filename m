Received: from eggs.gnu.org ([2001:4830:134:3::10]:42622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cVza8-0002Lg-6e
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cVza4-0000QB-6e
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:48:12 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 24 Jan 2017 12:48:05 +0100
Message-Id: <1485258485-22844-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] target/ppc/cpu-models: Fix/remove bad CPU
 aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org

There is no CPU model called "7447_v1.2" in our list, so the
"7447" alias should point to "7447_v1.1" instead. Let's also
remove the "codename" aliases that point to non-implemented
CPU models - they are really of no use here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/ppc/cpu-models.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 506dee1..4d3e635 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -1375,19 +1375,15 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "7445", "7445_v3.2" },
     { "7455", "7455_v3.2" },
     { "Apollo6", "7455" },
-    { "7447", "7447_v1.2" },
+    { "7447", "7447_v1.1" },
     { "7457", "7457_v1.2" },
     { "Apollo7", "7457" },
     { "7447A", "7447A_v1.2" },
     { "7457A", "7457A_v1.2" },
     { "Apollo7PM", "7457A_v1.0" },
 #if defined(TARGET_PPC64)
-    { "Trident", "620" },
     { "POWER3", "630" },
-    { "Boxer", "POWER3" },
-    { "Dino",  "POWER3" },
     { "POWER3+", "631" },
-    { "POWER5gr", "POWER5" },
     { "POWER5+", "POWER5+_v2.1" },
     { "POWER5gs", "POWER5+_v2.1" },
     { "POWER7", "POWER7_v2.3" },
@@ -1399,21 +1395,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "970", "970_v2.2" },
     { "970fx", "970fx_v3.1" },
     { "970mp", "970mp_v1.1" },
-    { "Apache", "RS64" },
-    { "A35",    "RS64" },
-    { "NorthStar", "RS64-II" },
-    { "A50",       "RS64-II" },
-    { "Pulsar", "RS64-III" },
-    { "IceStar", "RS64-IV" },
-    { "IStar",   "RS64-IV" },
-    { "SStar",   "RS64-IV" },
-#endif
-    { "RIOS",    "POWER" },
-    { "RSC",     "POWER" },
-    { "RSC3308", "POWER" },
-    { "RSC4608", "POWER" },
-    { "RSC2", "POWER2" },
-    { "P2SC", "POWER2" },
+#endif
 
     /* Generic PowerPCs */
 #if defined(TARGET_PPC64)
-- 
1.8.3.1
