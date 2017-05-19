Received: from eggs.gnu.org ([2001:4830:134:3::10]:47402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBcNQ-0007JS-Mr
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBcNM-00037i-Mn
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:31:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:61751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dBcNM-00037L-FW
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:31:04 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 19 May 2017 15:30:21 +0800
Message-Id: <1495179026-27872-2-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1495179026-27872-1-git-send-email-yang.zhong@intel.com>
References: <1495179026-27872-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v0 1/6] move tcg relative files into tcg
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

move tcg-runtime.c to ./tcg directory

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 Makefile.target                    | 2 +-
 tcg-runtime.c => tcg/tcg-runtime.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tcg-runtime.c => tcg/tcg-runtime.c (100%)

diff --git a/Makefile.target b/Makefile.target
index 465a633..c388fd6 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -98,7 +98,7 @@ obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
 obj-y += fpu/softfloat.o
 obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
-obj-y += tcg-runtime.o
+obj-y += tcg/tcg-runtime.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 obj-$(call lnot,$(CONFIG_HAX)) += hax-stub.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
diff --git a/tcg-runtime.c b/tcg/tcg-runtime.c
similarity index 100%
rename from tcg-runtime.c
rename to tcg/tcg-runtime.c
-- 
1.9.1
