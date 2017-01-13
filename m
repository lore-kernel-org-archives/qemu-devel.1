Received: from eggs.gnu.org ([2001:4830:134:3::10]:53275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMN-0006Ls-KO
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMM-00022D-Ov
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:11 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 13 Jan 2017 17:28:18 +1100
Message-Id: <1484288903-18807-13-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 12/17] target/ppc/POWER9: Add POWER9
 pa-features definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Add a pa-features definition which includes all of the new fields which
have been added, note we don't claim support for any of these new features
at this stage.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 45bd2de..35799da 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -357,6 +357,20 @@ static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset)
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
 
@@ -371,6 +385,10 @@ static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset)
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
