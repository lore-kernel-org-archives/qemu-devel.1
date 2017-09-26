Received: from eggs.gnu.org ([2001:4830:134:3::10]:41020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dwjVk-0002h3-B3
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 02:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dwjVh-00064x-7o
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 02:38:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dwjVh-00064e-2N
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 02:38:25 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 26 Sep 2017 08:38:20 +0200
Message-Id: <20170926063820.30773-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] usb: fix libusb config variable name.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

Cc: Jan Kiszka <jan.kiszka@siemens.com>
Fixes: 4e5ee5b21c84fe3023a64b5cc2e12a52ab0597c1
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 9255234c63..0e6d54b21f 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -42,7 +42,7 @@ redirect.o-cflags = $(USB_REDIR_CFLAGS)
 redirect.o-libs = $(USB_REDIR_LIBS)
 
 # usb pass-through
-ifeq ($(CONFIG_LIBUSB)$(CONFIG_USB),yy)
+ifeq ($(CONFIG_USB_LIBUSB)$(CONFIG_USB),yy)
 common-obj-y += host-libusb.o host-legacy.o
 else
 common-obj-y += host-stub.o
-- 
2.9.3
