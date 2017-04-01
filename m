Received: from eggs.gnu.org ([2001:4830:134:3::10]:51971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7Ck-0005I5-DH
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7Cj-00075Q-FW
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cu7Cj-00074Z-9c
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:45 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 31 Mar 2017 21:46:20 -0300
Message-Id: <20170401004624.30886-16-ehabkost@redhat.com>
In-Reply-To: <20170401004624.30886-1-ehabkost@redhat.com>
References: <20170401004624.30886-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 15/19] esp: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

esp devices aren't going to work with -device, as they need to be
wired by esp_init(). Remove the user_creatable flag from the
device class.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/scsi/esp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 1087b8f14f..eee831efeb 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -728,11 +728,6 @@ static void sysbus_esp_class_init(ObjectClass *klass, void *data)
     dc->reset = sysbus_esp_hard_reset;
     dc->vmsd = &vmstate_sysbus_esp_scsi;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    /*
-     * FIXME: Set only for compatibility on q35 machine-type.
-     * Probably never meant to be user-creatable
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo sysbus_esp_info = {
-- 
2.11.0.259.g40922b1
