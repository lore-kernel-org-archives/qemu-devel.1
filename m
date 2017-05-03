Received: from eggs.gnu.org ([2001:4830:134:3::10]:54736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d611c-0003DG-DY
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d611a-0002vY-Dv
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:37:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d611a-0002tO-78
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:37:26 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  3 May 2017 17:35:58 -0300
Message-Id: <20170503203604.31462-16-ehabkost@redhat.com>
In-Reply-To: <20170503203604.31462-1-ehabkost@redhat.com>
References: <20170503203604.31462-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH RESEND v2 15/21] esp: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

esp devices aren't going to work with -device, as they need IRQs
to be connected and mmio to be mapped (this is done by
esp_init()). Remove the user_creatable flag from the device
class.

Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Commit message rewrite only
---
 hw/scsi/esp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 7bdc1e1b99..eee831efeb 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -728,11 +728,6 @@ static void sysbus_esp_class_init(ObjectClass *klass, void *data)
     dc->reset = sysbus_esp_hard_reset;
     dc->vmsd = &vmstate_sysbus_esp_scsi;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo sysbus_esp_info = {
-- 
2.11.0.259.g40922b1
