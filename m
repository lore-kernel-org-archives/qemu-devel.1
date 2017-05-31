Received: from eggs.gnu.org ([2001:4830:134:3::10]:54605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dFx8j-0002tu-JG
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:29:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dFx8i-00037w-UN
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:29:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:28402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dFx8i-00036p-MB
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:29:52 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 31 May 2017 14:29:02 +0800
Message-Id: <1496212144-14947-5-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1496212144-14947-1-git-send-email-yang.zhong@intel.com>
References: <1496212144-14947-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2 4/6] tcg: move translate-common.c to tcg/
 subdirectory
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

tcg: move translate-common.c to tcg/ subdirectory

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 Makefile.target                              | 2 +-
 translate-common.c => tcg/translate-common.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename translate-common.c => tcg/translate-common.c (100%)

diff --git a/Makefile.target b/Makefile.target
index 5d33174..648e61e 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -90,7 +90,7 @@ all: $(PROGS) stap
 # cpu emulator library
 obj-y = exec.o cpu-exec.o
 obj-y += tcg/translate-all.o
-obj-y += translate-common.o
+obj-y += tcg/translate-common.o
 obj-y += cpu-exec-common.o
 obj-y += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
 obj-$(CONFIG_TCG_INTERPRETER) += tci.o
diff --git a/translate-common.c b/tcg/translate-common.c
similarity index 100%
rename from translate-common.c
rename to tcg/translate-common.c
-- 
1.9.1
