Received: from eggs.gnu.org ([209.51.188.92]:36149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSHS-0000Zx-7D
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSHQ-0006bp-FB
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:25:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:47041)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkSHQ-0005r5-3x
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:25:44 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 18 Jan 2019 19:23:45 +0800
Message-Id: <20190118112410.3010-19-yang.zhong@intel.com>
In-Reply-To: <20190118112410.3010-1-yang.zhong@intel.com>
References: <20190118112410.3010-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v3 18/43] hw/moxie/Makefile.objs:
 Conditionally build moxie
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

CONFIG_MOXIE added for moxiesim board.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 default-configs/moxie-softmmu.mak | 1 +
 hw/moxie/Makefile.objs            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/moxie-softmmu.mak b/default-configs/moxie-softmmu.mak
index e00d099994..b1765630f2 100644
--- a/default-configs/moxie-softmmu.mak
+++ b/default-configs/moxie-softmmu.mak
@@ -5,3 +5,4 @@ CONFIG_MC146818RTC=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
 CONFIG_VGA=y
+CONFIG_MOXIE=y
diff --git a/hw/moxie/Makefile.objs b/hw/moxie/Makefile.objs
index bfc90012fd..cb575ef0ca 100644
--- a/hw/moxie/Makefile.objs
+++ b/hw/moxie/Makefile.objs
@@ -1,2 +1,2 @@
 # moxie boards
-obj-y += moxiesim.o
+obj-$(CONFIG_MOXIE) += moxiesim.o
-- 
2.17.1
