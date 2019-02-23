Received: from eggs.gnu.org ([209.51.188.92]:57850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gxS5F-0005PK-6y
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 02:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gxS5E-0002zS-Dw
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 02:50:53 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Sat, 23 Feb 2019 08:49:22 +0100
Message-Id: <1550908162-22644-31-git-send-email-thuth@redhat.com>
In-Reply-To: <1550908162-22644-1-git-send-email-thuth@redhat.com>
References: <1550908162-22644-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 30/30] hw/arm: Remove hard-enablement of the
 remaining PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yang.zhong@intel.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

The PCI devices should be pulled in by default if PCI_DEVICES
is set, so there is no need anymore to enforce them in the configs
file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index ee95cc0..6b1f6a8 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -33,14 +33,6 @@ CONFIG_DIGIC=y
 CONFIG_SABRELITE=y
 CONFIG_EMCRAFT_SF2=y
 CONFIG_MICROBIT=y
-
-CONFIG_VGA=y
-
 CONFIG_FSL_IMX25=y
 CONFIG_FSL_IMX7=y
 CONFIG_FSL_IMX6UL=y
-
-CONFIG_PCIE_PORT=y
-CONFIG_XIO3130=y
-CONFIG_IOH3420=y
-CONFIG_I82801B11=y
-- 
1.8.3.1
