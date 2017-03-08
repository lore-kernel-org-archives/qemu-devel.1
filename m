Received: from eggs.gnu.org ([2001:4830:134:3::10]:59091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1clhjV-0005nt-Nc
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1clhjS-00074z-Iv
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:58:49 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  8 Mar 2017 20:58:43 +0100
Message-Id: <1489003123-3641-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] target/ppc: Fix wrong number of UAMR register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>

The SPR UAMR has the number 13, and not 12. (Fortunately it seems like
Linux is not using this register yet - only the privileged version with
number 29 ... that's why nobody noticed this problem yet)

Signed-off-by: Thomas Huth <thuth@redhat.com>
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
1.8.3.1
