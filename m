Received: from eggs.gnu.org ([2001:4830:134:3::10]:34371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cl4ch-0008Bq-Vn
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 21:13:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cl4ch-0002ct-1S
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 21:13:11 -0500
Received: from mail.kernel.org ([198.145.29.136]:59664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cl4cg-0002cf-RL
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 21:13:10 -0500
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Mon,  6 Mar 2017 18:12:48 -0800
Message-Id: <1488852768-8935-8-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1488852768-8935-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1703061807431.17906@sstabellini-ThinkPad-X260>
	<1488852768-8935-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PATCH 8/8] xen/9pfs: build and register Xen 9pfs
 backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, sstabellini@kernel.org, Stefano Stabellini <stefano@aporeto.com>, anthony.perard@citrix.com, jgross@suse.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
CC: anthony.perard@citrix.com
CC: jgross@suse.com
CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
CC: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/Makefile.objs        | 1 +
 hw/xen/xen_backend.c         | 1 +
 include/hw/xen/xen_backend.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
index da0ae0c..76a81c3 100644
--- a/hw/9pfs/Makefile.objs
+++ b/hw/9pfs/Makefile.objs
@@ -7,3 +7,4 @@ common-obj-$(CONFIG_OPEN_BY_HANDLE) +=  9p-handle.o
 common-obj-y += 9p-proxy.o
 
 obj-y += virtio-9p-device.o
+obj-y += xen-9p-backend.o
diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index 6c21c37..7aa347d 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -585,6 +585,7 @@ void xen_be_register_common(void)
     xen_be_register("console", &xen_console_ops);
     xen_be_register("vkbd", &xen_kbdmouse_ops);
     xen_be_register("qdisk", &xen_blkdev_ops);
+    xen_be_register("9pfs", &xen_9pfs_ops);
 #ifdef CONFIG_USB_LIBUSB
     xen_be_register("qusb", &xen_usb_ops);
 #endif
diff --git a/include/hw/xen/xen_backend.h b/include/hw/xen/xen_backend.h
index 4f4799a..84e686c 100644
--- a/include/hw/xen/xen_backend.h
+++ b/include/hw/xen/xen_backend.h
@@ -49,6 +49,7 @@ extern struct XenDevOps xen_console_ops;      /* xen_console.c     */
 extern struct XenDevOps xen_kbdmouse_ops;     /* xen_framebuffer.c */
 extern struct XenDevOps xen_framebuffer_ops;  /* xen_framebuffer.c */
 extern struct XenDevOps xen_blkdev_ops;       /* xen_disk.c        */
+extern struct XenDevOps xen_9pfs_ops;       /* xen-9p-backend.c        */
 extern struct XenDevOps xen_netdev_ops;       /* xen_nic.c         */
 #ifdef CONFIG_USB_LIBUSB
 extern struct XenDevOps xen_usb_ops;          /* xen-usb.c         */
-- 
1.9.1
