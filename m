Received: from eggs.gnu.org ([209.51.188.92]:42496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gsMJt-0004XZ-8a
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 01:40:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gsMJs-0004YP-0m
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 01:40:57 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Sat,  9 Feb 2019 07:39:26 +0100
Message-Id: <1549694366-1284-26-git-send-email-thuth@redhat.com>
In-Reply-To: <1549694366-1284-1-git-send-email-thuth@redhat.com>
References: <1549694366-1284-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 25/25] hw/arm: Remove hard-enablement of the
 remaining PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, yang.zhong@intel.com, pbonzini@redhat.com
Cc: qemu-arm@nongnu.org, philmd@redhat.com

The PCI devices should be pulled in by default if PCI_DEVICES
is set, so there is no need anymore to enforce them in the configs
file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index e0d1a00..47f721e 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -31,16 +31,7 @@ CONFIG_RASPI=y
 CONFIG_DIGIC=y
 CONFIG_SABRELITE=y
 CONFIG_MSF2=y
-
-CONFIG_VGA=y
-
 CONFIG_NRF51_SOC=y
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
