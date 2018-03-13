Received: from eggs.gnu.org ([2001:4830:134:3::10]:58425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiU-00068z-2s
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiP-0003tT-Uw
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:22 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:38378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsiP-0003sO-OK
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:17 -0400
Received: by mail-wr0-x241.google.com with SMTP id l8so2547239wrg.5
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:17 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:54 +0100
Message-Id: <20180313224719.4954-45-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 44/69] hw/isa/vt82c686: Rename vt82c686b_init()
 -> vt82c686b_isa_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

This function only initialize the ISA bus.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180308223946.26784-19-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/vt82c686.c         | 2 +-
 hw/mips/mips_fulong2e.c   | 2 +-
 include/hw/isa/vt82c686.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

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
index 2697d772eb..b14dab8781 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -236,7 +236,7 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
     ISABus *isa_bus;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
 
-    isa_bus = vt82c686b_init(pci_bus, PCI_DEVFN(slot, 0));
+    isa_bus = vt82c686b_isa_init(pci_bus, PCI_DEVFN(slot, 0));
     if (!isa_bus) {
         fprintf(stderr, "vt82c686b_init error\n");
         exit(1);
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
-- 
2.14.3
