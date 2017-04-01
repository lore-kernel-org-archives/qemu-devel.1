Received: from eggs.gnu.org ([2001:4830:134:3::10]:52040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7Ct-0005Mc-Gn
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7Cs-0007D8-Ou
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cu7Cs-0007CG-JN
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:54 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 31 Mar 2017 21:46:23 -0300
Message-Id: <20170401004624.30886-19-ehabkost@redhat.com>
In-Reply-To: <20170401004624.30886-1-ehabkost@redhat.com>
References: <20170401004624.30886-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 18/19] sysbus-ohci: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

sysbus-ohci needs to be mappend and wired by device or board
code, and won't work with -device. Remove the user_creatable flag
from the device class.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/usb/hcd-ohci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 0e17fb1e60..3ada35e954 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -2159,11 +2159,6 @@ static void ohci_sysbus_class_init(ObjectClass *klass, void *data)
     dc->desc = "OHCI USB Controller";
     dc->props = ohci_sysbus_properties;
     dc->reset = usb_ohci_reset_sysbus;
-    /*
-     * FIXME: Set only for compatibility on q35 machine-type.
-     * Probably never meant to be user-creatable
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo ohci_sysbus_info = {
-- 
2.11.0.259.g40922b1
