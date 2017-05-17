Received: from eggs.gnu.org ([2001:4830:134:3::10]:58909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dAzCu-00056e-ER
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dAzCq-0003uS-DV
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:41:40 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 17 May 2017 10:39:51 -0300
Message-Id: <20170517134003.17110-11-ehabkost@redhat.com>
In-Reply-To: <20170517134003.17110-1-ehabkost@redhat.com>
References: <20170517134003.17110-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 10/22] sysbus-ahci: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, Rob Herring <robh@kernel.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

The sysbus-ahci devices are supposed to be created and wired by
code from other devices, like calxeda_init() and
xlnx_zynqmp_realize(), and won't work with -device. Remove the
user_creatable flag from the device class.

Cc: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org
Cc: Rob Herring <robh@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Acked-by: John Snow <jsnow@redhat.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170503203604.31462-11-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/ide/ahci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 7f10cda354..2ea1a282ef 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1721,11 +1721,6 @@ static void sysbus_ahci_class_init(ObjectClass *klass, void *data)
     dc->props = sysbus_ahci_properties;
     dc->reset = sysbus_ahci_reset;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo sysbus_ahci_info = {
-- 
2.11.0.259.g40922b1
