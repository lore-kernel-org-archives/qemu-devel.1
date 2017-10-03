Received: from eggs.gnu.org ([2001:4830:134:3::10]:54135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thomas@crissyfield.de>) id 1dzS4e-0003F0-8H
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 14:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thomas@crissyfield.de>) id 1dzS4d-00027R-7u
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 14:37:44 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:47069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <thomas@crissyfield.de>)
	id 1dzS4c-00021x-Td
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 14:37:43 -0400
Received: by mail-wm0-x236.google.com with SMTP id m72so18557753wmc.1
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 11:37:42 -0700 (PDT)
From: "Dr. Thomas Jansen" <thomas@crissyfield.de>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.6\))
Message-Id: <BDAEBE2E-BBD3-4795-9692-F7531691A283@crissyfield.de>
Date: Tue, 3 Oct 2017 20:37:40 +0200
Subject: [Qemu-devel] [PATCH] usb: fix typo CONFIG_LIBUSB ->
 CONFIG_USB_LIBUSB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

A previous commit (4e5ee5b21c) broke USB pass-through by introducing
a typo in a configuration variable.

Signed-off-by: Thomas Jansen <thomas@crissyfield.de)
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
2.11.0
