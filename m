Received: from eggs.gnu.org ([209.51.188.92]:45862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJisj-0003Lm-KQ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJish-0002Md-Ny
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:14:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJisf-0002Fn-OI
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:13:59 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Apr 2019 15:13:40 -0300
Message-Id: <20190425181342.15360-3-ehabkost@redhat.com>
In-Reply-To: <20190425181342.15360-1-ehabkost@redhat.com>
References: <20190425181342.15360-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] Categorize devices: IGD passthrough ISA
 bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Ernest Esene <eroken1@gmail.com>

From: Ernest Esene <eroken1@gmail.com>

Set category for the device.

Signed-off-by: Ernest Esene <eroken1@gmail.com>
Message-Id: <20190327133714.GA9329@erokenlabserver>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
[ehabkost: edited commit message]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc_piix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8ad8e885c6..03a9cb8af3 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -911,6 +911,7 @@ static void isa_bridge_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     dc->desc        = "ISA bridge faked to support IGD PT";
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     k->vendor_id    = PCI_VENDOR_ID_INTEL;
     k->class_id     = PCI_CLASS_BRIDGE_ISA;
 };
-- 
2.18.0.rc1.1.g3f1ff2140
