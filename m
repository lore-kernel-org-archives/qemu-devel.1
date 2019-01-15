Received: from eggs.gnu.org ([209.51.188.92]:37462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPYM-0002wr-MN
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPSn-0001eo-JG
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:13:10 -0500
Received: from mga05.intel.com ([192.55.52.43]:56327)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gjPSn-0001AS-BV
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:13:09 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Tue, 15 Jan 2019 22:11:03 +0800
Message-Id: <20190115141108.934-33-yang.zhong@intel.com>
In-Reply-To: <20190115141108.934-1-yang.zhong@intel.com>
References: <20190115141108.934-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v2 32/37] edid: express dependencies with
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
