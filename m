Received: from eggs.gnu.org ([2001:4830:134:3::10]:54055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dAwGj-0002Jv-67
	for qemu-devel@nongnu.org; Wed, 17 May 2017 06:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dAwGg-00044N-3j
	for qemu-devel@nongnu.org; Wed, 17 May 2017 06:33:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34321)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dAwGf-000443-UM
	for qemu-devel@nongnu.org; Wed, 17 May 2017 06:33:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E47A81222
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 10:33:20 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 17 May 2017 12:33:13 +0200
Message-Id: <20170517103313.8459-2-kraxel@redhat.com>
In-Reply-To: <20170517103313.8459-1-kraxel@redhat.com>
References: <20170517103313.8459-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] xhci: add CONFIG_USB_XHCI_NEC option
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

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1451189
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 default-configs/pci.mak | 1 +
 hw/usb/Makefile.objs    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index 60dc6510ec..3bbeb62d9a 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -7,6 +7,7 @@ CONFIG_USB_UHCI=y
 CONFIG_USB_OHCI=y
 CONFIG_USB_EHCI=y
 CONFIG_USB_XHCI=y
+CONFIG_USB_XHCI_NEC=y
 CONFIG_NE2000_PCI=y
 CONFIG_EEPRO100_PCI=y
 CONFIG_PCNET_PCI=y
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 249106f32d..97f1c4561a 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -8,7 +8,7 @@ common-obj-$(CONFIG_USB_OHCI) += hcd-ohci.o
 common-obj-$(CONFIG_USB_EHCI) += hcd-ehci.o hcd-ehci-pci.o
 common-obj-$(CONFIG_USB_EHCI_SYSBUS) += hcd-ehci-sysbus.o
 common-obj-$(CONFIG_USB_XHCI) += hcd-xhci.o
-common-obj-$(CONFIG_USB_XHCI) += hcd-xhci-nec.o
+common-obj-$(CONFIG_USB_XHCI_NEC) += hcd-xhci-nec.o
 common-obj-$(CONFIG_USB_MUSB) += hcd-musb.o
 
 obj-$(CONFIG_TUSB6010) += tusb6010.o
-- 
2.9.3
