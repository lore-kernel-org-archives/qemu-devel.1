Received: from eggs.gnu.org ([208.118.235.92]:54959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPGn-0003U3-GI
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPGj-0004nq-Fg
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:57867)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gcPGi-0004Bd-ES
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:45 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 27 Dec 2018 14:34:08 +0800
Message-Id: <20181227063419.12981-15-yang.zhong@intel.com>
In-Reply-To: <20181227063419.12981-1-yang.zhong@intel.com>
References: <20181227063419.12981-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH 14/25] bluetooth: express dependencies with
 Kconfig
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

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
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
index 0b8f41040e..7b7ccfc039 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -77,6 +77,7 @@ config USB_BLUETOOTH
     bool
     default y
     depends on USB
+    select BLUETOOTH
 
 config USB_SMARTCARD
     bool
-- 
2.17.1
