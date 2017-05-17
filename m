Received: from eggs.gnu.org ([2001:4830:134:3::10]:59236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dAzDb-00063q-JD
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dAzDY-0004KR-Gi
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:42:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dAzDY-0004KA-Ay
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:42:20 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 17 May 2017 10:39:59 -0300
Message-Id: <20170517134003.17110-19-ehabkost@redhat.com>
In-Reply-To: <20170517134003.17110-1-ehabkost@redhat.com>
References: <20170517134003.17110-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 18/22] sysbus-ohci: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

sysbus-ohci needs to be mapped and wired by device or board code,
and won't work with -device. Remove the user_creatable flag from
the device class.

Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170503203604.31462-19-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/usb/hcd-ohci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 18b31022a7..3ada35e954 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -2159,11 +2159,6 @@ static void ohci_sysbus_class_init(ObjectClass *klass, void *data)
     dc->desc = "OHCI USB Controller";
     dc->props = ohci_sysbus_properties;
     dc->reset = usb_ohci_reset_sysbus;
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo ohci_sysbus_info = {
-- 
2.11.0.259.g40922b1
