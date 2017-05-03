Received: from eggs.gnu.org ([2001:4830:134:3::10]:54827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d611p-0003Nu-IX
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d611l-00037o-JA
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:37:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d611l-00036m-D8
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:37:37 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  3 May 2017 17:36:01 -0300
Message-Id: <20170503203604.31462-19-ehabkost@redhat.com>
In-Reply-To: <20170503203604.31462-1-ehabkost@redhat.com>
References: <20170503203604.31462-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH RESEND v2 18/21] sysbus-ohci: Remove
 user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

sysbus-ohci needs to be mapped and wired by device or board code,
and won't work with -device. Remove the user_creatable flag from
the device class.

Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Commit message rewrite only
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
