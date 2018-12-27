Received: from eggs.gnu.org ([208.118.235.92]:55058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPGz-0003gS-2a
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPGu-0005Fg-Uz
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:36:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:57867)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gcPGu-0004Bd-Kr
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:56 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 27 Dec 2018 14:34:13 +0800
Message-Id: <20181227063419.12981-20-yang.zhong@intel.com>
In-Reply-To: <20181227063419.12981-1-yang.zhong@intel.com>
References: <20181227063419.12981-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH 19/25] edid: express dependencies with
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
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org, thuth@redhat.com, yang.zhong@intel.com

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 hw/display/Kconfig | 2 ++
 hw/i2c/Kconfig     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 8ddce09ead..8b8f1027b1 100644
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
