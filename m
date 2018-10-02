Received: from eggs.gnu.org ([2001:4830:134:3::10]:42969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SAx-0003Ya-GQ
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SAv-0007OH-5h
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:25:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SAu-0007O0-E4
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:25:48 -0400
Received: by mail-wm1-x343.google.com with SMTP id z25-v6so6242889wmf.1
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 14:25:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  2 Oct 2018 23:25:19 +0200
Message-Id: <20181002212522.23303-11-f4bug@amsat.org>
In-Reply-To: <20181002212522.23303-1-f4bug@amsat.org>
References: <20181002212522.23303-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 10/12] hw/alpha/typhoon: Remove unuseful code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/alpha/typhoon.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index d74b5b55e1..8004afe45b 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -932,23 +932,10 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
     return b;
 }
 
-static int typhoon_pcihost_init(SysBusDevice *dev)
-{
-    return 0;
-}
-
-static void typhoon_pcihost_class_init(ObjectClass *klass, void *data)
-{
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
-
-    k->init = typhoon_pcihost_init;
-}
-
 static const TypeInfo typhoon_pcihost_info = {
     .name          = TYPE_TYPHOON_PCI_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(TyphoonState),
-    .class_init    = typhoon_pcihost_class_init,
 };
 
 static void typhoon_iommu_memory_region_class_init(ObjectClass *klass,
-- 
2.19.0
