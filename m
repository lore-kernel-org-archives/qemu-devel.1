Received: from eggs.gnu.org ([209.51.188.92]:58471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyP2-0007wF-Qx
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyP1-0002CH-Ms
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:00 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyP1-0002BJ-Db
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:59 -0500
Received: by mail-wr1-x442.google.com with SMTP id z5so9599232wrt.11
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:59 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:07:04 +0100
Message-Id: <1548410831-19553-46-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 45/52] display: express dependencies with
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
Cc: yang.zhong@intel.com, thuth@redhat.com

From: Yang Zhong <yang.zhong@intel.com>

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-40-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/Kconfig | 4 +++-
 hw/i2c/Kconfig     | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 66044ca..bbd772b 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -38,6 +38,7 @@ config VGA_PCI
     default y if PCI_DEVICES
     depends on PCI
     select VGA
+    select EDID
 
 config VGA_ISA
     bool
@@ -59,6 +60,7 @@ config BOCHS_DISPLAY
     default y if PCI_DEVICES
     depends on PCI
     select VGA
+    select EDID
 
 config BLIZZARD
     bool
@@ -69,7 +71,7 @@ config FRAMEBUFFER
 config MILKYMIST_TMU2
     bool
     default y
-    depends on OPENGL
+    depends on OPENGL && MILKYMIST
 
 config SM501
     bool
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 74c9328..ef1caa6 100644
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
1.8.3.1
