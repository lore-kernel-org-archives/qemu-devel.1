Received: from eggs.gnu.org ([209.51.188.92]:60205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCWO-000561-Gw
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCWM-0003sH-BD
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:36919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmCWM-0002Mh-0Z
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:22 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 23 Jan 2019 14:56:08 +0800
Message-Id: <20190123065618.3520-35-yang.zhong@intel.com>
In-Reply-To: <20190123065618.3520-1-yang.zhong@intel.com>
References: <20190123065618.3520-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v4 34/44] bluetooth: express dependencies
 with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com, yang.zhong@intel.com

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/Makefile.objs | 2 +-
 hw/usb/Kconfig   | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 39d882af6f..b95b0c74a1 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -3,7 +3,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += acpi/
 devices-dirs-$(CONFIG_SOFTMMU) += adc/
 devices-dirs-$(CONFIG_SOFTMMU) += audio/
 devices-dirs-$(CONFIG_SOFTMMU) += block/
-devices-dirs-$(CONFIG_SOFTMMU) += bt/
+devices-dirs-$(CONFIG_BLUETOOTH) += bt/
 devices-dirs-$(CONFIG_SOFTMMU) += char/
 devices-dirs-$(CONFIG_SOFTMMU) += cpu/
 devices-dirs-$(CONFIG_SOFTMMU) += display/
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index db46c56cc8..8feab2ac0c 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -79,6 +79,7 @@ config USB_BLUETOOTH
     bool
     default y
     depends on USB
+    select BLUETOOTH
 
 config USB_SMARTCARD
     bool
-- 
2.17.1
