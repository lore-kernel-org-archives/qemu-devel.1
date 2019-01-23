Received: from eggs.gnu.org ([209.51.188.92]:59761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCVG-00045g-B8
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCVF-0002or-OC
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:59:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:36924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmCVF-0002Nr-GY
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:59:13 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 23 Jan 2019 14:55:51 +0800
Message-Id: <20190123065618.3520-18-yang.zhong@intel.com>
In-Reply-To: <20190123065618.3520-1-yang.zhong@intel.com>
References: <20190123065618.3520-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v4 17/44] hw/cris/Makefile.objs: Create
 CONFIG_* for cris
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

Add the new configs to default-configs/cris-sofmmu.mak.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 default-configs/cris-softmmu.mak | 1 +
 hw/cris/Makefile.objs            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/cris-softmmu.mak b/default-configs/cris-softmmu.mak
index d970d50158..a637c4b4bf 100644
--- a/default-configs/cris-softmmu.mak
+++ b/default-configs/cris-softmmu.mak
@@ -4,3 +4,4 @@ CONFIG_ETRAXFS=y
 CONFIG_NAND=y
 CONFIG_PTIMER=y
 CONFIG_PFLASH_CFI02=y
+CONFIG_AXIS=y
diff --git a/hw/cris/Makefile.objs b/hw/cris/Makefile.objs
index 7624173f77..a4a27b3a13 100644
--- a/hw/cris/Makefile.objs
+++ b/hw/cris/Makefile.objs
@@ -1,2 +1,2 @@
 obj-y += boot.o
-obj-y += axis_dev88.o
+obj-$(CONFIG_AXIS) += axis_dev88.o
-- 
2.17.1
