Received: from eggs.gnu.org ([209.51.188.92]:50811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gppgo-0001Tn-TX
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:26:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gppgo-0003YX-0c
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:26:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:56076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gppgn-0002hI-Jn
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:26:09 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Sat,  2 Feb 2019 15:24:51 +0800
Message-Id: <20190202072456.6468-23-yang.zhong@intel.com>
In-Reply-To: <20190202072456.6468-1-yang.zhong@intel.com>
References: <20190202072456.6468-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2 22/27] hw/hppa/Makefile.objs: Create
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
