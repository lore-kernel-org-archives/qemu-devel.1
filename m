Received: from eggs.gnu.org ([209.51.188.92]:36905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSIt-0001lQ-TY
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSIr-0007ij-L7
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:27:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:47043)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkSIn-0005tr-P7
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:27:11 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 18 Jan 2019 19:24:05 +0800
Message-Id: <20190118112410.3010-39-yang.zhong@intel.com>
In-Reply-To: <20190118112410.3010-1-yang.zhong@intel.com>
References: <20190118112410.3010-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v3 38/43] edid: express dependencies with
 kconfig
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

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/display/Kconfig | 2 ++
 hw/i2c/Kconfig     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 7a9d121772..933793cc13 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -38,6 +38,7 @@ config VGA_PCI
     default y
     depends on PCI
     select VGA
+    select EDID
 
 config VGA_ISA
     bool
@@ -59,6 +60,7 @@ config BOCHS_DISPLAY
     default y
     depends on PCI
     select VGA
+    select EDID
 
 config BLIZZARD
     bool
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 74c9328729..ef1caa6d89 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -8,6 +8,7 @@ config SMBUS_EEPROM
 config DDC
     bool
     depends on I2C
+    select EDID
 
 config VERSATILE_I2C
     bool
-- 
2.17.1
