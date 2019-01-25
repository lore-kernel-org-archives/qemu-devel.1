Received: from eggs.gnu.org ([209.51.188.92]:58554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyP5-0007z1-Am
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyP3-0002Eq-Vm
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:03 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyP3-0002Dg-No
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:01 -0500
Received: by mail-wm1-x342.google.com with SMTP id p6so6036503wmc.1
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:08:01 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:07:06 +0100
Message-Id: <1548410831-19553-48-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 47/52] vfio: express vfio dependencies with
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
Cc: yang.zhong@intel.com, thuth@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/vfio/Kconfig | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
index f896779..ebda9fd 100644
--- a/hw/vfio/Kconfig
+++ b/hw/vfio/Kconfig
@@ -7,28 +7,30 @@ config VFIO_PCI
     select VFIO
     depends on LINUX
 
-config VFIO_SPAPR
-    bool
-    default y
-    depends on VFIO && LINUX && PSERIES
-
 config VFIO_CCW
     bool
+    default y
     select VFIO
-    depends on LINUX
+    depends on LINUX && S390_CCW_VIRTIO
 
 config VFIO_PLATFORM
     bool
+    default y
     select VFIO
-    depends on LINUX
+    depends on LINUX && PLATFORM_BUS
 
 config VFIO_XGMAC
     bool
+    default y
+    depends on VFIO_PLATFORM
 
 config VFIO_AMD_XGBE
     bool
+    default y
+    depends on VFIO_PLATFORM
 
 config VFIO_AP
     bool
+    default y
     select VFIO
-    depends on LINUX
+    depends on LINUX && S390_CCW_VIRTIO
-- 
1.8.3.1
