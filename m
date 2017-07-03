Received: from eggs.gnu.org ([2001:4830:134:3::10]:57978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dRyM8-0000Kq-SP
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dRyM7-0001lY-1s
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:14583)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dRyM6-0001cL-PI
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:22 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Mon,  3 Jul 2017 18:12:20 +0800
Message-Id: <1499076743-15477-13-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
References: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2 12/15] tcg: disable tcg in CPUX86State struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, thuth@redhat.com
Cc: qemu-devel@nongnu.org, anthony.xu@intel.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

Add the CONFIG_TCG for CPU_COMMON_TLB in the CPUX86State struct.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 include/exec/cpu-defs.h | 4 +++-
 target/i386/cpu.h       | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 5f4e303..bc8e7f8 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -25,7 +25,9 @@
 
 #include "qemu/host-utils.h"
 #include "qemu/queue.h"
+#ifdef CONFIG_TCG
 #include "tcg-target.h"
+#endif
 #ifndef CONFIG_USER_ONLY
 #include "exec/hwaddr.h"
 #endif
@@ -54,7 +56,7 @@ typedef uint64_t target_ulong;
 #error TARGET_LONG_SIZE undefined
 #endif
 
-#if !defined(CONFIG_USER_ONLY)
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
 /* use a fully associative victim tlb of 8 entries */
 #define CPU_VTLB_SIZE 8
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 67a6091..d4b10a3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -52,7 +52,9 @@
 
 #include "exec/cpu-defs.h"
 
+#ifdef CONFIG_TCG
 #include "fpu/softfloat.h"
+#endif
 
 #define R_EAX 0
 #define R_ECX 1
-- 
1.9.1
