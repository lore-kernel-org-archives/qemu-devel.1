Received: from eggs.gnu.org ([2001:4830:134:3::10]:53029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fvF47-0008Ds-Dc
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 01:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fvExU-0000AA-86
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 00:53:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51210 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fvExU-00008x-3F
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 00:53:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80DFA804B9F4
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 04:53:27 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 30 Aug 2018 06:53:24 +0200
Message-Id: <20180830045324.21584-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] usb: add config options for hub and hid
 devices (kbd, mouse, tablet).
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
---
 default-configs/usb.mak | 2 ++
 hw/usb/Makefile.objs    | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/default-configs/usb.mak b/default-configs/usb.mak
index e42cfeabbe..3ee117dbf6 100644
--- a/default-configs/usb.mak
+++ b/default-configs/usb.mak
@@ -1,4 +1,6 @@
 CONFIG_USB=y
+CONFIG_USB_HUB=y
+CONFIG_USB_HID=y
 CONFIG_USB_TABLET_WACOM=y
 CONFIG_USB_STORAGE_BOT=y
 CONFIG_USB_STORAGE_UAS=y
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 41be700812..c8802aaefd 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -15,8 +15,8 @@ obj-$(CONFIG_TUSB6010) += tusb6010.o
 obj-$(CONFIG_IMX)      += chipidea.o
 
 # emulated usb devices
-common-obj-$(CONFIG_USB) += dev-hub.o
-common-obj-$(CONFIG_USB) += dev-hid.o
+common-obj-$(CONFIG_USB_HUB) += dev-hub.o
+common-obj-$(CONFIG_USB_HID) += dev-hid.o
 common-obj-$(CONFIG_USB_TABLET_WACOM) += dev-wacom.o
 common-obj-$(CONFIG_USB_STORAGE_BOT)  += dev-storage.o
 common-obj-$(CONFIG_USB_STORAGE_UAS)  += dev-uas.o
-- 
2.9.3
