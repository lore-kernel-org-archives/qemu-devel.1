Received: from eggs.gnu.org ([2001:4830:134:3::10]:54766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d611f-0003GK-Ng
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d611e-0002zH-Pr
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:37:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d611e-0002yj-KN
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:37:30 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  3 May 2017 17:35:59 -0300
Message-Id: <20170503203604.31462-17-ehabkost@redhat.com>
In-Reply-To: <20170503203604.31462-1-ehabkost@redhat.com>
References: <20170503203604.31462-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH RESEND v2 16/21] generic-sdhci: Remove
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
Cc: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, Alistair Francis <alistair.francis@xilinx.com>

generic-sdhci needs to be wired by other devices' code, so it
can't be used with -device. Remove the user_creatable flag from
the device class.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Prasad J Pandit <pjp@fedoraproject.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* (none)
---
 hw/sd/sdhci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index dbf61fccb8..6d6a791ee9 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1360,11 +1360,6 @@ static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
     dc->props = sdhci_sysbus_properties;
     dc->realize = sdhci_sysbus_realize;
     dc->reset = sdhci_poweron_reset;
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo sdhci_sysbus_info = {
-- 
2.11.0.259.g40922b1
