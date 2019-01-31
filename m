Received: from eggs.gnu.org ([209.51.188.92]:36033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6rK-00073R-Sm
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:34:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6rI-0003Eb-Vf
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:34:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:60109)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gp6rH-0002ib-1R
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:34:00 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 31 Jan 2019 15:32:29 +0800
Message-Id: <20190131073234.18037-23-yang.zhong@intel.com>
In-Reply-To: <20190131073234.18037-1-yang.zhong@intel.com>
References: <20190131073234.18037-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v1 22/27] hw/hppa/Makefile.objs: Create
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
Cc: pbonzini@redhat.com, thuth@redhat.com, yang.zhong@intel.com

Add the new configs to default-configs/hppa-sofmmu.mak.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 default-configs/hppa-softmmu.mak | 1 +
 hw/hppa/Makefile.objs            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-softmmu.mak
index 4badc0521e..b594a6ddd9 100644
--- a/default-configs/hppa-softmmu.mak
+++ b/default-configs/hppa-softmmu.mak
@@ -10,3 +10,4 @@ CONFIG_IDE_CMD646=y
 # CONFIG_IDE_MMIO=y
 CONFIG_VIRTIO_VGA=y
 CONFIG_MC146818RTC=y
+CONFIG_DINO=y
diff --git a/hw/hppa/Makefile.objs b/hw/hppa/Makefile.objs
index bef241ed25..67838f50a3 100644
--- a/hw/hppa/Makefile.objs
+++ b/hw/hppa/Makefile.objs
@@ -1 +1 @@
-obj-y += machine.o pci.o dino.o
+obj-$(CONFIG_DINO) += pci.o machine.o dino.o
-- 
2.17.1
