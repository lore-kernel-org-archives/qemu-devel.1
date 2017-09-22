Received: from eggs.gnu.org ([2001:4830:134:3::10]:36404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1dvIbW-0006LE-Sb
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1dvIbT-0007hx-QO
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:42:30 -0400
Received: from goliath.siemens.de ([192.35.17.28]:42469)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1dvIbT-0007hf-H0
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:42:27 -0400
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <af89f372-3fa7-a727-b49c-6418c3fab985@siemens.com>
Date: Fri, 22 Sep 2017 09:42:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] usb: Fix usb-host build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

This reverts the incorrect commit 2041649f0b04 (these are
machine-independent objects) and fixes the name of the config var.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 hw/usb/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 757e365562..c7f0a52f44 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -38,7 +38,7 @@ endif
 common-obj-$(CONFIG_USB_REDIR) += redirect.o quirks.o
 
 # usb pass-through
-ifeq ($(CONFIG_LIBUSB)$(CONFIG_USB),yy)
+ifeq ($(CONFIG_USB_LIBUSB),y)
 common-obj-y += host-libusb.o host-legacy.o
 else
 common-obj-y += host-stub.o
-- 
2.12.3
