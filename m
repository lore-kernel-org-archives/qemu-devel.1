Received: from eggs.gnu.org ([2001:4830:134:3::10]:35660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1cxovY-00017O-Pf
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 02:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1cxovV-0000u5-Lo
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 02:05:20 -0400
From: Anton Blanchard <anton@ozlabs.org>
Date: Tue, 11 Apr 2017 16:04:56 +1000
Message-Id: <20170411060456.21594-1-anton@ozlabs.org>
Subject: [Qemu-devel] [PATCH] target/ppc: Fix size of struct PPCElfPrstatus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au, agraf@suse.de, aneesh.kumar@linux.vnet.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

From: Anton Blanchard <anton@samba.org>

gdb refuses to parse QEMU memory dumps because struct PPCElfPrstatus
is the wrong size. Fix it.

Signed-off-by: Anton Blanchard <anton@samba.org>
Fixes: e62fbc54d459 ("target-ppc: dump-guest-memory support")
---
 target/ppc/arch_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 28d9cc7d79..8e9397aa58 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -50,7 +50,7 @@ struct PPCUserRegStruct {
 struct PPCElfPrstatus {
     char pad1[112];
     struct PPCUserRegStruct pr_reg;
-    reg_t pad2[4];
+    char pad2[40];
 } QEMU_PACKED;
 
 
-- 
2.11.0
