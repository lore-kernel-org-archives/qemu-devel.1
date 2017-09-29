Received: from eggs.gnu.org ([2001:4830:134:3::10]:50304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dxt2S-0007GW-9k
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dxt2P-0001QF-8D
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:01:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dxt2P-0001Px-2K
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:00:57 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 29 Sep 2017 13:00:51 +0200
Message-Id: <20170929110052.6111-3-kraxel@redhat.com>
In-Reply-To: <20170929110052.6111-1-kraxel@redhat.com>
References: <20170929110052.6111-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] usb: fix libusb config variable name.
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>
List-ID: <qemu-devel.nongnu.org>

Cc: Jan Kiszka <jan.kiszka@siemens.com>
Fixes: 4e5ee5b21c84fe3023a64b5cc2e12a52ab0597c1
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
Message-id: 20170926063820.30773-1-kraxel@redhat.com
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
