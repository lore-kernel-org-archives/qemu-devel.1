Received: from eggs.gnu.org ([2001:4830:134:3::10]:44142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqS-00083R-1H
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqQ-0001Hr-QH
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:28 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  3 Mar 2017 14:24:54 +1100
Message-Id: <20170303032507.16142-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170303032507.16142-1-david@gibson.dropbear.id.au>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 04/17] target/ppc/POWER9: Add POWERPC_MMU_V3 bit
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

For easier handling of future processors using the POWER9 or something
close to it, add a new bit in the MMU model.  This was originally from a
revised version of 86cf1e9 "target/ppc/POWER9: Add ISAv3.00 MMU definition"
but the older version of the patch was already merged.  This makes the
change on top of the original version.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu-qom.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 4e3132b..da7eb5a 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -71,6 +71,7 @@ enum powerpc_mmu_t {
 #define POWERPC_MMU_1TSEG    0x00020000
 #define POWERPC_MMU_AMR      0x00040000
 #define POWERPC_MMU_64K      0x00080000
+#define POWERPC_MMU_V3       0x00100000 /* ISA V3.00 MMU Support */
     /* 64 bits PowerPC MMU                                     */
     POWERPC_MMU_64B        = POWERPC_MMU_64 | 0x00000001,
     /* Architecture 2.03 and later (has LPCR) */
@@ -92,7 +93,8 @@ enum powerpc_mmu_t {
     /* Architecture 3.00 variant                               */
     POWERPC_MMU_3_00       = POWERPC_MMU_64 | POWERPC_MMU_1TSEG
                              | POWERPC_MMU_64K
-                             | POWERPC_MMU_AMR | 0x00000005,
+                             | POWERPC_MMU_AMR | POWERPC_MMU_V3
+                             | 0x00000005,
 };
 
 /*****************************************************************************/
-- 
2.9.3
