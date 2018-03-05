Received: from eggs.gnu.org ([2001:4830:134:3::10]:49585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esxWh-0004di-ML
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esxWg-0001lM-Ne
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:20:07 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esxWg-0001kd-Gy
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:20:06 -0500
Received: by mail-wm0-x244.google.com with SMTP id x7so18311140wmc.0
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 13:20:06 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  5 Mar 2018 18:19:23 -0300
Message-Id: <20180305211928.466-18-f4bug@amsat.org>
In-Reply-To: <20180305211928.466-1-f4bug@amsat.org>
References: <20180305211928.466-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 17/22] hw/isa/vt82c686: Rename
 vt82c686b_init() -> vt82c686b_isa_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

This function only initialize the ISA bus.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/isa/vt82c686.h | 2 +-
 hw/isa/vt82c686.c         | 2 +-
 hw/mips/mips_fulong2e.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/isa/vt82c686.h b/include/hw/isa/vt82c686.h
index 471b5e9e53..db97c8ed7a 100644
--- a/include/hw/isa/vt82c686.h
+++ b/include/hw/isa/vt82c686.h
@@ -2,7 +2,7 @@
 #define HW_VT82C686_H
 
 /* vt82c686.c */
-ISABus *vt82c686b_init(PCIBus * bus, int devfn);
+ISABus *vt82c686b_isa_init(PCIBus * bus, int devfn);
 void vt82c686b_ac97_init(PCIBus *bus, int devfn);
 void vt82c686b_mc97_init(PCIBus *bus, int devfn);
 I2CBus *vt82c686b_pm_init(PCIBus *bus, int devfn, uint32_t smb_io_base,
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 070cc1889f..7eaf3c7e8f 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -478,7 +478,7 @@ static void vt82c686b_realize(PCIDevice *d, Error **errp)
     qemu_register_reset(vt82c686b_reset, d);
 }
 
-ISABus *vt82c686b_init(PCIBus *bus, int devfn)
+ISABus *vt82c686b_isa_init(PCIBus *bus, int devfn)
 {
     PCIDevice *d;
 
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index ca1f76a724..9ebc225d3b 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -237,7 +237,7 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
     ISABus *isa_bus;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
 
-    isa_bus = vt82c686b_init(pci_bus, PCI_DEVFN(slot, 0));
+    isa_bus = vt82c686b_isa_init(pci_bus, PCI_DEVFN(slot, 0));
     if (!isa_bus) {
         fprintf(stderr, "vt82c686b_init error\n");
         exit(1);
-- 
2.16.2
