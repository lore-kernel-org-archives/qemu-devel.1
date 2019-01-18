Received: from eggs.gnu.org ([209.51.188.92]:35865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSGf-0008Iy-QI
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSGd-0005kY-PE
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:24:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:46972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkSGb-0005bn-Qn
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:24:55 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 18 Jan 2019 19:23:33 +0800
Message-Id: <20190118112410.3010-7-yang.zhong@intel.com>
In-Reply-To: <20190118112410.3010-1-yang.zhong@intel.com>
References: <20190118112410.3010-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v3 06/43] hw/mips/Makefile.objs: Create
 CONFIG_* for r4k, malta, mipssim boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, yang.zhong@intel.com, =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

From: Ákos Kovács <akoskovacs@gmx.com>

Add the new configs to default-configs/mips*-sofmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 default-configs/mips-softmmu-common.mak | 3 +++
 hw/mips/Makefile.objs                   | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index fae2347ee7..479fb4d900 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -36,3 +36,6 @@ CONFIG_EMPTY_SLOT=y
 CONFIG_MIPS_CPS=y
 CONFIG_MIPS_ITU=y
 CONFIG_I2C=y
+CONFIG_R4K=y
+CONFIG_MALTA=y
+CONFIG_MIPSSIM=y
diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
index 17a311aaba..230866ae91 100644
--- a/hw/mips/Makefile.objs
+++ b/hw/mips/Makefile.objs
@@ -1,7 +1,9 @@
-obj-y += mips_r4k.o mips_malta.o mips_mipssim.o
 obj-y += addr.o mips_int.o
+obj-y += gt64xxx_pci.o
+obj-$(CONFIG_R4K) += mips_r4k.o
+obj-$(CONFIG_MALTA) += mips_malta.o
+obj-$(CONFIG_MIPSSIM) += mips_mipssim.o
 obj-$(CONFIG_JAZZ) += mips_jazz.o
 obj-$(CONFIG_FULONG) += mips_fulong2e.o
-obj-y += gt64xxx_pci.o
 obj-$(CONFIG_MIPS_CPS) += cps.o
 obj-$(CONFIG_MIPS_BOSTON) += boston.o
-- 
2.17.1
