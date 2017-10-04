Received: from eggs.gnu.org ([2001:4830:134:3::10]:37761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dzj9x-00037w-IQ
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dzj9t-0007Y0-MA
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:52:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dzj9t-0007XA-GY
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:52:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D7AE4ACBB
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 12:52:16 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed,  4 Oct 2017 14:52:10 +0200
Message-Id: <20171004125210.7817-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] usb: fix host-stub.c build race
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

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/Makefile.objs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 0e6d54b21f..bdfead6701 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -47,6 +47,7 @@ common-obj-y += host-libusb.o host-legacy.o
 else
 common-obj-y += host-stub.o
 endif
+common-obj-$(CONFIG_ALL) += host-stub.o
 
 host-libusb.o-cflags := $(LIBUSB_CFLAGS)
 host-libusb.o-libs := $(LIBUSB_LIBS)
-- 
2.9.3
