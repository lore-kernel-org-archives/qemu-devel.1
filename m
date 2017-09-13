Received: from eggs.gnu.org ([2001:4830:134:3::10]:49261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds41v-00068I-7v
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds41s-0004KP-0x
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:32:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ds41r-0004Js-Ra
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:32:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E76814E4F3
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:32:18 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Sep 2017 11:32:15 +0200
Message-Id: <20170913093215.10043-5-kraxel@redhat.com>
In-Reply-To: <20170913093215.10043-1-kraxel@redhat.com>
References: <20170913093215.10043-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] usb: only build usb-host with CONFIG_USB=y
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-id: 20170908111217.21985-3-kraxel@redhat.com
---
 hw/usb/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index a43ebbc17f..757e365562 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -38,7 +38,7 @@ endif
 common-obj-$(CONFIG_USB_REDIR) += redirect.o quirks.o
 
 # usb pass-through
-ifeq ($(CONFIG_LIBUSB),y)
+ifeq ($(CONFIG_LIBUSB)$(CONFIG_USB),yy)
 common-obj-y += host-libusb.o host-legacy.o
 else
 common-obj-y += host-stub.o
-- 
2.9.3
