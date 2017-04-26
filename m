Received: from eggs.gnu.org ([2001:4830:134:3::10]:56832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwt-0005Nf-3W
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwj-00084S-Pw
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:15 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 26 Apr 2017 17:00:20 +1000
Message-Id: <20170426070034.10727-35-david@gibson.dropbear.id.au>
In-Reply-To: <20170426070034.10727-1-david@gibson.dropbear.id.au>
References: <20170426070034.10727-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 34/48] target/ppc: Fix size of struct
 PPCElfPrstatus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Anton Blanchard <anton@samba.org>, David Gibson <david@gibson.dropbear.id.au>

From: Anton Blanchard <anton@samba.org>

gdb refuses to parse QEMU memory dumps because struct PPCElfPrstatus
is the wrong size. Fix it.

Signed-off-by: Anton Blanchard <anton@samba.org>
Fixes: e62fbc54d459 ("target-ppc: dump-guest-memory support")
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/arch_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 28d9cc7..8e9397a 100644
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
2.9.3
