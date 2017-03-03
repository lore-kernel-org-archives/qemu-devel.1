Received: from eggs.gnu.org ([2001:4830:134:3::10]:44241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqV-000840-LL
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqU-0001MC-8T
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:31 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  3 Mar 2017 14:24:58 +1100
Message-Id: <20170303032507.16142-9-david@gibson.dropbear.id.au>
In-Reply-To: <20170303032507.16142-1-david@gibson.dropbear.id.au>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/17] target/ppc/POWER9: Add POWER9 pa-features
 definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Add a pa-features definition which includes all of the new fields which
have been added, note we don't claim support for any of these new features
at this stage.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1cc5e00..81e2ada 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -390,6 +390,20 @@ static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset)
         0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
         0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
         0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
+    /* Currently we don't advertise any of the "new" ISAv3.00 functionality */
+    uint8_t pa_features_300[] = { 64, 0,
+        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0, /*  0 -  5 */
+        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /*  6 - 11 */
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 24 - 29 */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 30 - 35 */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 36 - 41 */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 42 - 47 */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 48 - 53 */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 54 - 59 */
+        0x00, 0x00, 0x00, 0x00           }; /* 60 - 63 */
+
     uint8_t *pa_features;
     size_t pa_size;
 
@@ -404,6 +418,10 @@ static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset)
         pa_features = pa_features_207;
         pa_size = sizeof(pa_features_207);
         break;
+    case POWERPC_MMU_3_00:
+        pa_features = pa_features_300;
+        pa_size = sizeof(pa_features_300);
+        break;
     default:
         return;
     }
-- 
2.9.3
