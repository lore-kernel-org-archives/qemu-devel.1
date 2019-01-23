Received: from eggs.gnu.org ([209.51.188.92]:59743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCVD-0003yO-1r
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:59:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCVC-0002hZ-CH
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:59:11 -0500
Received: from mga18.intel.com ([134.134.136.126]:36921)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmCVC-0002NF-35
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:59:10 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 23 Jan 2019 14:55:49 +0800
Message-Id: <20190123065618.3520-16-yang.zhong@intel.com>
In-Reply-To: <20190123065618.3520-1-yang.zhong@intel.com>
References: <20190123065618.3520-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v4 15/44] hw/sparc64/Makefile.objs: Create
 CONFIG_* for sparc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com, yang.zhong@intel.com

Add the new configs to default-configs/sparc64-sofmmu.mak.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/sparc64-softmmu.mak | 2 ++
 hw/sparc64/Makefile.objs            | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
index ce63d47046..1fae4888db 100644
--- a/default-configs/sparc64-softmmu.mak
+++ b/default-configs/sparc64-softmmu.mak
@@ -17,3 +17,5 @@ CONFIG_SUNHME=y
 CONFIG_MC146818RTC=y
 CONFIG_ISA_TESTDEV=y
 CONFIG_SUN4V_RTC=y
+CONFIG_SUN4U=y
+CONFIG_NIAGARA=y
diff --git a/hw/sparc64/Makefile.objs b/hw/sparc64/Makefile.objs
index 117e0ff27d..af0525c1a2 100644
--- a/hw/sparc64/Makefile.objs
+++ b/hw/sparc64/Makefile.objs
@@ -1,4 +1,4 @@
 obj-y += sparc64.o
-obj-y += sun4u_iommu.o
-obj-y += sun4u.o
-obj-y += niagara.o
\ No newline at end of file
+obj-$(CONFIG_SUN4U) += sun4u_iommu.o
+obj-$(CONFIG_SUN4U) += sun4u.o
+obj-$(CONFIG_NIAGARA) += niagara.o
-- 
2.17.1
