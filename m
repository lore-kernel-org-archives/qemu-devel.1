Received: from eggs.gnu.org ([2001:4830:134:3::10]:56463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPz-0005GR-8Y
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPw-0007V9-L0
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjPw-0007Uq-BB
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:48 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:30 +0300
Message-Id: <1533815202-11967-18-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 17/29] vmsvga: Define interrupt source flags
 for interrupt status and mask registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, habkost@redhat.com, kraxel@redhat.com, Leonid Shatz <leonid.shatz@oracle.com>, Liran Alon <liran.alon@oracle.com>

From: Leonid Shatz <leonid.shatz@oracle.com>

Based on Linux kernel
drivers/gpu/drm/vmwgfx/device_include/svga_reg.h.

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index ce5b8814ac91..597051ec5c92 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -334,6 +334,18 @@ enum {
 #define SVGA_MAX_WIDTH                  ROUND_UP(2360, VNC_DIRTY_PIXELS_PER_BIT)
 #define SVGA_MAX_HEIGHT                 1770
 
+/*
+ * Interrupt source flags for IRQSTATUS_PORT and IRQMASK.
+ *
+ * Interrupts are only supported when the
+ * SVGA_CAP_IRQMASK capability is present.
+ */
+#define SVGA_IRQFLAG_ANY_FENCE            0x1    /* Any fence was passed */
+#define SVGA_IRQFLAG_FIFO_PROGRESS        0x2    /* Made forward progress in the FIFO */
+#define SVGA_IRQFLAG_FENCE_GOAL           0x4    /* SVGA_FIFO_FENCE_GOAL reached */
+#define SVGA_IRQFLAG_COMMAND_BUFFER       0x8    /* Command buffer completed */
+#define SVGA_IRQFLAG_ERROR                0x10   /* Error while processing commands */
+
 #ifdef VERBOSE
 # define GUEST_OS_BASE          0x5001
 static const char *vmsvga_guest_id[] = {
-- 
1.9.1
