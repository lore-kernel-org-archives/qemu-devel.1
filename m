Received: from eggs.gnu.org ([209.51.188.92]:36425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSIG-0001DU-Od
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSIF-0007Fq-Ud
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:26:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:47043)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkSIF-0005tr-Mb
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:26:35 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 18 Jan 2019 19:23:47 +0800
Message-Id: <20190118112410.3010-21-yang.zhong@intel.com>
In-Reply-To: <20190118112410.3010-1-yang.zhong@intel.com>
References: <20190118112410.3010-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v3 20/43] hw/tricore/Makefile.objs: Create
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
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, yang.zhong@intel.com

Add the new configs to default-configs/tricore-sofmmu.mak.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
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
