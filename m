Received: from eggs.gnu.org ([2001:4830:134:3::10]:48904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cne2d-0007Rm-09
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 00:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cne2c-0007AF-7X
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 00:26:35 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 14 Mar 2017 15:26:23 +1100
Message-Id: <20170314042626.20020-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170314042626.20020-1-david@gibson.dropbear.id.au>
References: <20170314042626.20020-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 1/4] target/ppc: Fix wrong number of UAMR
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, pbonzini@redhat.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

The SPR UAMR has the number 13, and not 12. (Fortunately it seems like
Linux is not using this register yet - only the privileged version with
number 29 ... that's why nobody noticed this problem yet)

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 7c4a1f5..5ee33b3 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1408,7 +1408,7 @@ int ppc_compat_max_threads(PowerPCCPU *cpu);
 #define SPR_601_UDECR         (0x006)
 #define SPR_LR                (0x008)
 #define SPR_CTR               (0x009)
-#define SPR_UAMR              (0x00C)
+#define SPR_UAMR              (0x00D)
 #define SPR_DSCR              (0x011)
 #define SPR_DSISR             (0x012)
 #define SPR_DAR               (0x013) /* DAE for PowerPC 601 */
-- 
2.9.3
