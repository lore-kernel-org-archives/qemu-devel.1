Received: from eggs.gnu.org ([2001:4830:134:3::10]:43794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvV1b-0002hV-3r
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 16:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvV1X-0003NW-VZ
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 16:25:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cvV1X-0003N6-Pl
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 16:25:55 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  4 Apr 2017 17:24:25 -0300
Message-Id: <20170404202429.14643-18-ehabkost@redhat.com>
In-Reply-To: <20170404202429.14643-1-ehabkost@redhat.com>
References: <20170404202429.14643-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 17/21] hpet: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

hpet needs to be mapped and wired by the board code and won't
work with -device. Remove the user_creatable flag from the device
class.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* (none)
---
 hw/timer/hpet.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 4dcbd5bb3d..a2c18b30c3 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -771,11 +771,6 @@ static void hpet_device_class_init(ObjectClass *klass, void *data)
     dc->reset = hpet_reset;
     dc->vmsd = &vmstate_hpet;
     dc->props = hpet_device_properties;
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo hpet_device_info = {
-- 
2.11.0.259.g40922b1
