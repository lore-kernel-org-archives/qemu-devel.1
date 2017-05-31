Received: from eggs.gnu.org ([2001:4830:134:3::10]:54616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dFx8l-0002uU-65
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dFx8k-00038J-Dj
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:29:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:28402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dFx8k-00036p-4d
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:29:54 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 31 May 2017 14:29:03 +0800
Message-Id: <1496212144-14947-6-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1496212144-14947-1-git-send-email-yang.zhong@intel.com>
References: <1496212144-14947-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2 5/6] tcg: move tci.c to tcg/ subdirectory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

tcg: move tci.c to tcg/ subdirectory

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 Makefile.target    | 2 +-
 tci.c => tcg/tci.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tci.c => tcg/tci.c (100%)

diff --git a/Makefile.target b/Makefile.target
index 648e61e..8561132 100644
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
