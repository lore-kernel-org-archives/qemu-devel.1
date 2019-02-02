Received: from eggs.gnu.org ([209.51.188.92]:50571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gppgd-0001Iv-QP
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gppgc-0003IQ-PG
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:25:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:56070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gppgc-0002Ky-8r
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:25:58 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Sat,  2 Feb 2019 15:24:46 +0800
Message-Id: <20190202072456.6468-18-yang.zhong@intel.com>
In-Reply-To: <20190202072456.6468-1-yang.zhong@intel.com>
References: <20190202072456.6468-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2 17/27] hw/nios2/Makefile.objs: Conditionally
 build nios2
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

CONFIG_NIOS2_10M50 added for 10m50 dev board.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/nios2-softmmu.mak | 1 +
 hw/nios2/Makefile.objs            | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/default-configs/nios2-softmmu.mak b/default-configs/nios2-softmmu.mak
index 74dc70caae..ab42d0fc28 100644
--- a/default-configs/nios2-softmmu.mak
+++ b/default-configs/nios2-softmmu.mak
@@ -4,3 +4,4 @@ CONFIG_NIOS2=y
 CONFIG_SERIAL=y
 CONFIG_PTIMER=y
 CONFIG_ALTERA_TIMER=y
+CONFIG_NIOS2_10M50=y
diff --git a/hw/nios2/Makefile.objs b/hw/nios2/Makefile.objs
index 6b5c421760..89a419a9f5 100644
--- a/hw/nios2/Makefile.objs
+++ b/hw/nios2/Makefile.objs
@@ -1 +1,2 @@
-obj-y = boot.o cpu_pic.o 10m50_devboard.o
+obj-y = boot.o cpu_pic.o
+obj-$(CONFIG_NIOS2_10M50) += 10m50_devboard.o
-- 
2.17.1
