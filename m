Received: from eggs.gnu.org ([209.51.188.92]:36068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6rU-0007CV-6l
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6rT-0003Km-EJ
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:34:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:60109)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gp6rT-0002ib-6f
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:34:11 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 31 Jan 2019 15:32:32 +0800
Message-Id: <20190131073234.18037-26-yang.zhong@intel.com>
In-Reply-To: <20190131073234.18037-1-yang.zhong@intel.com>
References: <20190131073234.18037-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v1 25/27] hw/tricore/Makefile.objs: Create
 CONFIG_* for tricore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, yang.zhong@intel.com

Add the new configs to default-configs/tricore-sofmmu.mak.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/tricore-softmmu.mak | 1 +
 hw/tricore/Makefile.objs            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/tricore-softmmu.mak b/default-configs/tricore-softmmu.mak
index e69de29bb2..c397cff38a 100644
--- a/default-configs/tricore-softmmu.mak
+++ b/default-configs/tricore-softmmu.mak
@@ -0,0 +1 @@
+CONFIG_TRICORE=y
diff --git a/hw/tricore/Makefile.objs b/hw/tricore/Makefile.objs
index 435e095cff..5501f6c1a8 100644
--- a/hw/tricore/Makefile.objs
+++ b/hw/tricore/Makefile.objs
@@ -1 +1 @@
-obj-y += tricore_testboard.o
+obj-$(CONFIG_TRICORE) += tricore_testboard.o
-- 
2.17.1
