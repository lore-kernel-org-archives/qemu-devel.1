Received: from eggs.gnu.org ([2001:4830:134:3::10]:47442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBcNU-0007LK-3A
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBcNT-00039Q-98
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:31:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:61751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dBcNT-00037L-0a
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:31:11 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 19 May 2017 15:30:25 +0800
Message-Id: <1495179026-27872-6-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1495179026-27872-1-git-send-email-yang.zhong@intel.com>
References: <1495179026-27872-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v0 5/6] move tcg relative files into tcg
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

move tci.c to ./tcg

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 Makefile.target    | 2 +-
 tci.c => tcg/tci.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tci.c => tcg/tci.c (100%)

diff --git a/Makefile.target b/Makefile.target
index 7ee6cb3..489a325 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -93,7 +93,7 @@ obj-y += tcg/translate-all.o
 obj-y += tcg/translate-common.o
 obj-y += cpu-exec-common.o
 obj-y += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
-obj-$(CONFIG_TCG_INTERPRETER) += tci.o
+obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
 obj-y += tcg/tcg-common.o
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
 obj-y += fpu/softfloat.o
diff --git a/tci.c b/tcg/tci.c
similarity index 100%
rename from tci.c
rename to tcg/tci.c
-- 
1.9.1
