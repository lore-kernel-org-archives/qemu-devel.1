Received: from eggs.gnu.org ([2001:4830:134:3::10]:35142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76XS-00041R-3J
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76Oc-0007RO-EN
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:10:31 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:38816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76Ob-0007Og-3o
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:10:30 -0400
Received: by mail-wr1-x42f.google.com with SMTP id a13-v6so4946448wrt.5
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 15:10:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  2 Oct 2018 00:09:42 +0200
Message-Id: <20181001220942.2382-16-f4bug@amsat.org>
In-Reply-To: <20181001220942.2382-1-f4bug@amsat.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 15/15] hw/mips/malta: Remove unuseful code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mips_malta.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 4ccfa87c35..b6633fa141 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1422,23 +1422,10 @@ void mips_malta_init(MachineState *machine)
     pci_vga_init(pci_bus);
 }
 
-static int mips_malta_sysbus_device_init(SysBusDevice *sysbusdev)
-{
-    return 0;
-}
-
-static void mips_malta_class_init(ObjectClass *klass, void *data)
-{
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
-
-    k->init = mips_malta_sysbus_device_init;
-}
-
 static const TypeInfo mips_malta_device = {
     .name          = TYPE_MIPS_MALTA,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(MaltaState),
-    .class_init    = mips_malta_class_init,
 };
 
 static void mips_malta_machine_init(MachineClass *mc)
-- 
2.19.0
