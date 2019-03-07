Received: from eggs.gnu.org ([209.51.188.92]:44856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1tv3-0007Pm-0Z
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1tv2-0002ih-B6
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:22:44 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  7 Mar 2019 15:18:53 +0100
Message-Id: <1551968334-18982-29-git-send-email-thuth@redhat.com>
In-Reply-To: <1551968334-18982-1-git-send-email-thuth@redhat.com>
References: <1551968334-18982-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v4 28/29] hw/arm: Express dependencies of the
 musca machines with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yang.zhong@intel.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-arm@nongnu.org, John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Dependencies have been determined with trial-and-error and by
looking at the musca.c source file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3a04def..7a0e0ba 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -77,6 +77,12 @@ config MAINSTONE
     select PFLASH_CFI01
     select SMC91C111
 
+config MUSCA
+    bool
+    select ARMSSE
+    select PL011
+    select PL031
+
 config MUSICPAL
     bool
     select BITBANG_I2C
@@ -429,6 +435,3 @@ config ARMSSE_CPUID
 
 config ARMSSE_MHU
     bool
-
-config MUSCA
-    bool
-- 
1.8.3.1
