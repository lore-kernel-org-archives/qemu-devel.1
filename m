Received: from eggs.gnu.org ([209.51.188.92]:56994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gxS42-0004QR-1i
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 02:49:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gxS40-0001n1-2x
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 02:49:37 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Sat, 23 Feb 2019 08:48:53 +0100
Message-Id: <1550908162-22644-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1550908162-22644-1-git-send-email-thuth@redhat.com>
References: <1550908162-22644-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 01/30] hw/arm/Kconfig: Add a config switch
 for MUSCA
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

The musca machine has been added recently, so we need now a Kconfig
switch for this, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 I assume Paolo will add this config switch to his next iteration
 of the Kconfig patches already, so in that case this patch can be
 dropped / ignored.

 hw/arm/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3176680..ac5faca 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -18,6 +18,9 @@ config INTEGRATOR
 config MAINSTONE
     bool
 
+config MUSCA
+    bool
+
 config MUSICPAL
     bool
     select PTIMER
-- 
1.8.3.1
