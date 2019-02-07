Received: from eggs.gnu.org ([209.51.188.92]:57563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnw2-00024L-Fu
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnw1-0002ME-Q5
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:02 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnw1-0002Lm-Iw
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:01 -0500
Received: by mail-wr1-x441.google.com with SMTP id q1so810740wrp.7
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:01 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:05 +0100
Message-Id: <1549562254-41157-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 22/51] vfio: express vfio dependencies with
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
Cc: thuth@redhat.com, philmd@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/vfio/Kconfig | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
index 0fdff10..ebda9fd 100644
--- a/hw/vfio/Kconfig
+++ b/hw/vfio/Kconfig
@@ -9,21 +9,28 @@ config VFIO_PCI
 
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
