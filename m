Received: from eggs.gnu.org ([209.51.188.92]:36063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSHP-0000Xo-RI
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSHN-0006YN-Sj
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:25:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:47045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkSHJ-0005vM-OS
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:25:41 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 18 Jan 2019 19:23:42 +0800
Message-Id: <20190118112410.3010-16-yang.zhong@intel.com>
In-Reply-To: <20190118112410.3010-1-yang.zhong@intel.com>
References: <20190118112410.3010-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v3 15/43] hw/alpha/Makefile.objs: Create
 CONFIG_* for alpha
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

Add the new configs to default-configs/alpha-sofmmu.mak.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 default-configs/alpha-softmmu.mak | 2 ++
 hw/alpha/Makefile.objs            | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index 4d654eaa0b..c570caccd1 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -19,3 +19,5 @@ CONFIG_I8259=y
 CONFIG_MC146818RTC=y
 CONFIG_ISA_TESTDEV=y
 CONFIG_SMC37C669=y
+CONFIG_DP264=y
+CONFIG_TYPHOON=y
diff --git a/hw/alpha/Makefile.objs b/hw/alpha/Makefile.objs
index 5c742756f0..61579207ee 100644
--- a/hw/alpha/Makefile.objs
+++ b/hw/alpha/Makefile.objs
@@ -1 +1,3 @@
-obj-y += dp264.o pci.o typhoon.o
+obj-y += pci.o
+obj-$(CONFIG_DP264) += dp264.o
+obj-$(CONFIG_TYPHOON) += typhoon.o
-- 
2.17.1
