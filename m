Received: from eggs.gnu.org ([2001:4830:134:3::10]:52983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e025N-0007KC-IR
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 05:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e025I-00047z-Kt
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 05:04:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e025I-00046t-FK
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 05:04:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFF394E34A
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 09:04:46 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  5 Oct 2017 11:04:43 +0200
Message-Id: <20171005090443.26889-5-kraxel@redhat.com>
In-Reply-To: <20171005090443.26889-1-kraxel@redhat.com>
References: <20171005090443.26889-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] usb: fix host-stub.c build race
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20171004125210.7817-1-kraxel@redhat.com
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
