Received: from eggs.gnu.org ([2001:4830:134:3::10]:39942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cffDv-0000RG-LF
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 23:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cffDu-0002nj-PM
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 23:05:15 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Mon, 20 Feb 2017 15:04:36 +1100
Message-Id: <1487563478-22265-9-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
References: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V3 08/10] target/ppc/POWER9: Add
 POWER9 pa-features definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com, sjitindarsingh@gmail.com

Add a pa-features definition which includes all of the new fields which
have been added, note we don't claim support for any of these new features
at this stage.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2fbf193..cef950d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -356,6 +356,20 @@ static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset)
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
 
@@ -370,6 +384,10 @@ static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset)
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
2.5.5
