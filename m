Received: from eggs.gnu.org ([2001:4830:134:3::10]:53440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMa-0006Zv-Af
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMZ-00027a-Eo
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:24 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 13 Jan 2017 17:28:22 +1100
Message-Id: <1484288903-18807-17-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 16/17] target/ppc/mmu_hash64: Fix printing
 unsigned as signed int
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

We were printing an unsigned value as a signed value, fix this.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/mmu-hash64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 03607d5..08d2393 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -189,8 +189,8 @@ int ppc_store_slb(PowerPCCPU *cpu, target_ulong slot,
     slb->vsid = vsid;
     slb->sps = sps;
 
-    LOG_SLB("%s: %d " TARGET_FMT_lx " - " TARGET_FMT_lx " => %016" PRIx64
-            " %016" PRIx64 "\n", __func__, slot, esid, vsid,
+    LOG_SLB("%s: " TARGET_FMT_lu " " TARGET_FMT_lx " - " TARGET_FMT_lx
+            " => %016" PRIx64 " %016" PRIx64 "\n", __func__, slot, esid, vsid,
             slb->esid, slb->vsid);
 
     return 0;
-- 
2.5.5
