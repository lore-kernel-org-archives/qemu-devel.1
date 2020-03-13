Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E774CC4CECE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CFD20749
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CFD20749
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCffz-00048L-0K
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 04:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jCfcy-0008Pt-EJ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jCfcx-0004wJ-8V
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:25:08 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:51510
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jCfcu-0004qL-Ji; Fri, 13 Mar 2020 04:25:04 -0400
Received: from host86-185-91-43.range86-185.btcentralplus.com ([86.185.91.43]
 helo=kentang.home) by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jCfdC-0007Mr-Qw; Fri, 13 Mar 2020 08:25:27 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: jsnow@redhat.com, philmd@redhat.com, amarkovic@wavecomp.com,
 mst@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 balaton@eik.bme.hu
Date: Fri, 13 Mar 2020 08:24:39 +0000
Message-Id: <20200313082444.2439-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200313082444.2439-1-mark.cave-ayland@ilande.co.uk>
References: <20200313082444.2439-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.185.91.43
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 2/7] ide/via: Get rid of via_ide_init()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:41c9:1:41f::167
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

Follow example of CMD646 and remove via_ide_init function and do it
directly in board code instead.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/via.c            | 8 --------
 hw/mips/mips_fulong2e.c | 5 ++++-
 include/hw/ide.h        | 1 -
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/hw/ide/via.c b/hw/ide/via.c
index 84f0efff94..3153be8862 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -211,14 +211,6 @@ static void via_ide_exitfn(PCIDevice *dev)
     }
 }
 
-void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn)
-{
-    PCIDevice *dev;
-
-    dev = pci_create_simple(bus, devfn, "via-ide");
-    pci_ide_create_devs(dev, hd_table);
-}
-
 static void via_ide_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 4727b1d3a4..639ba2a091 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -37,6 +37,7 @@
 #include "qemu/log.h"
 #include "hw/loader.h"
 #include "hw/ide.h"
+#include "hw/ide/pci.h"
 #include "elf.h"
 #include "hw/isa/vt82c686.h"
 #include "hw/rtc/mc146818rtc.h"
@@ -239,6 +240,7 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
     qemu_irq *i8259;
     ISABus *isa_bus;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    PCIDevice *dev;
 
     isa_bus = vt82c686b_isa_init(pci_bus, PCI_DEVFN(slot, 0));
     if (!isa_bus) {
@@ -256,8 +258,9 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
     /* Super I/O */
     isa_create_simple(isa_bus, TYPE_VT82C686B_SUPERIO);
 
+    dev = pci_create_simple(pci_bus, PCI_DEVFN(slot, 1), "via-ide");
     ide_drive_get(hd, ARRAY_SIZE(hd));
-    via_ide_init(pci_bus, hd, PCI_DEVFN(slot, 1));
+    pci_ide_create_devs(dev, hd);
 
     pci_create_simple(pci_bus, PCI_DEVFN(slot, 2), "vt82c686b-usb-uhci");
     pci_create_simple(pci_bus, PCI_DEVFN(slot, 3), "vt82c686b-usb-uhci");
diff --git a/include/hw/ide.h b/include/hw/ide.h
index 28d8a06439..575c099b5b 100644
--- a/include/hw/ide.h
+++ b/include/hw/ide.h
@@ -18,7 +18,6 @@ PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
 PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
 PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
 int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
-void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
 
 /* ide-mmio.c */
 void mmio_ide_init_drives(DeviceState *dev, DriveInfo *hd0, DriveInfo *hd1);
-- 
2.20.1


