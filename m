Received: from eggs.gnu.org ([209.51.188.92]:36145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSHS-0000Zp-2w
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSHQ-0006bE-8U
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:25:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:47045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkSHP-0005vM-Vn
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:25:44 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 18 Jan 2019 19:23:44 +0800
Message-Id: <20190118112410.3010-18-yang.zhong@intel.com>
In-Reply-To: <20190118112410.3010-1-yang.zhong@intel.com>
References: <20190118112410.3010-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v3 17/43] hw/hppa/Makefile.objs: Create
 CONFIG_* for hppa
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

Add the new configs to default-configs/hppa-sofmmu.mak.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 default-configs/hppa-softmmu.mak | 2 ++
 hw/hppa/Makefile.objs            | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-softmmu.mak
index 4badc0521e..846e9f0ba6 100644
--- a/default-configs/hppa-softmmu.mak
+++ b/default-configs/hppa-softmmu.mak
@@ -10,3 +10,5 @@ CONFIG_IDE_CMD646=y
 # CONFIG_IDE_MMIO=y
 CONFIG_VIRTIO_VGA=y
 CONFIG_MC146818RTC=y
+CONFIG_HPPA=y
+CONFIG_DINO=y
diff --git a/hw/hppa/Makefile.objs b/hw/hppa/Makefile.objs
index bef241ed25..6204b74e5e 100644
--- a/hw/hppa/Makefile.objs
+++ b/hw/hppa/Makefile.objs
@@ -1 +1,3 @@
-obj-y += machine.o pci.o dino.o
+obj-y += pci.o
+obj-$(CONFIG_HPPA) += machine.o
+obj-$(CONFIG_DINO) += dino.o
-- 
2.17.1
