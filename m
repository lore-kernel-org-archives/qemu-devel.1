Received: from eggs.gnu.org ([2001:4830:134:3::10]:54670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d611Q-0002xg-BK
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d611N-0002lN-IK
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:37:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d611N-0002kj-Dr
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:37:13 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  3 May 2017 17:35:55 -0300
Message-Id: <20170503203604.31462-13-ehabkost@redhat.com>
In-Reply-To: <20170503203604.31462-1-ehabkost@redhat.com>
References: <20170503203604.31462-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH RESEND v2 12/21] isabus-bridge: Remove
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
Cc: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>

isabus-bridge needs to be created by isa_bus_new(), and won't
work with -device, as it won't create the TYPE_ISA_BUS bus
itself. Remove the user_creatable flag from the device class.

Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* (none)
---
 hw/isa/isa-bus.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index ad4ac3b4f6..348e0eab9d 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -221,11 +221,6 @@ static void isabus_bridge_class_init(ObjectClass *klass, void *data)
 
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "isa";
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo isabus_bridge_info = {
-- 
2.11.0.259.g40922b1
