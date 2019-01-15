Received: from eggs.gnu.org ([209.51.188.92]:37462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPYY-0002wr-Mh
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPRV-0001C4-Hx
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:11:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:56304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gjPRV-00013D-AZ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:11:49 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Tue, 15 Jan 2019 22:10:43 +0800
Message-Id: <20190115141108.934-13-yang.zhong@intel.com>
In-Reply-To: <20190115141108.934-1-yang.zhong@intel.com>
References: <20190115141108.934-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v2 12/37] hw/nios2/Makefile.objs:
 Conditionally build nios2
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

CONFIG_NIOS2_10M50_BOARD added for 10m50 dev board.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 default-configs/nios2-softmmu.mak | 1 +
 hw/nios2/Makefile.objs            | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/default-configs/nios2-softmmu.mak b/default-configs/nios2-softmmu.mak
index 74dc70caae..f634c36d36 100644
--- a/default-configs/nios2-softmmu.mak
+++ b/default-configs/nios2-softmmu.mak
@@ -4,3 +4,4 @@ CONFIG_NIOS2=y
 CONFIG_SERIAL=y
 CONFIG_PTIMER=y
 CONFIG_ALTERA_TIMER=y
+CONFIG_NIOS2_10M50_BOARD=y
diff --git a/hw/nios2/Makefile.objs b/hw/nios2/Makefile.objs
index 6b5c421760..12a2891395 100644
--- a/hw/nios2/Makefile.objs
+++ b/hw/nios2/Makefile.objs
@@ -1 +1,2 @@
-obj-y = boot.o cpu_pic.o 10m50_devboard.o
+obj-y = boot.o cpu_pic.o
+obj-$(CONFIG_NIOS2_10M50_BOARD) += 10m50_devboard.o
-- 
2.17.1
