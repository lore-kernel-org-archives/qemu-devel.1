Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA5DC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 863812074F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863812074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCrq2-0006Aw-Nq
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 17:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jCrly-0007kW-1d
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jCrlw-0000L1-0q
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:23:13 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:57665)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jCrls-00009O-G7; Fri, 13 Mar 2020 17:23:08 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 0592F747E15;
 Fri, 13 Mar 2020 22:23:06 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6A1B5747E12; Fri, 13 Mar 2020 22:23:05 +0100 (CET)
Message-Id: <adddfa21552783020d64e1314318cab6d24362c3.1584134074.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1584134074.git.balaton@eik.bme.hu>
References: <cover.1584134074.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 1/8] hw/ide: Get rid of piix3_init functions
Date: Fri, 13 Mar 2020 22:14:34 +0100
To: qemu-devel@nongnu.org,
    qemu-block@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This removes pci_piix3_ide_init() and pci_piix3_xen_ide_init()
functions similar to clean up done to other ide devices.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/i386/pc_piix.c | 10 +++++-----
 hw/ide/pci.c      |  1 +
 hw/ide/piix.c     | 21 +--------------------
 include/hw/ide.h  |  2 --
 4 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e2d98243bc..c399398739 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -39,6 +39,7 @@
 #include "hw/usb.h"
 #include "net/net.h"
 #include "hw/ide.h"
+#include "hw/ide/pci.h"
 #include "hw/irq.h"
 #include "sysemu/kvm.h"
 #include "hw/kvm/clock.h"
@@ -242,11 +243,10 @@ static void pc_init1(MachineState *machine,
     ide_drive_get(hd, ARRAY_SIZE(hd));
     if (pcmc->pci_enabled) {
         PCIDevice *dev;
-        if (xen_enabled()) {
-            dev = pci_piix3_xen_ide_init(pci_bus, hd, piix3_devfn + 1);
-        } else {
-            dev = pci_piix3_ide_init(pci_bus, hd, piix3_devfn + 1);
-        }
+
+        dev = pci_create_simple(pci_bus, piix3_devfn + 1,
+                                xen_enabled() ? "piix3-ide-xen" : "piix3-ide");
+        pci_ide_create_devs(dev, hd);
         idebus[0] = qdev_get_child_bus(&dev->qdev, "ide.0");
         idebus[1] = qdev_get_child_bus(&dev->qdev, "ide.1");
         pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 1a6a287e76..4fc76c5225 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -476,6 +476,7 @@ const VMStateDescription vmstate_ide_pci = {
     }
 };
 
+/* hd_table must contain 4 block drivers */
 void pci_ide_create_devs(PCIDevice *dev, DriveInfo **hd_table)
 {
     PCIIDEState *d = PCI_IDE(dev);
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index bc575b4d70..8bcd6b72c2 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -197,15 +197,6 @@ int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux)
     return 0;
 }
 
-PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn)
-{
-    PCIDevice *dev;
-
-    dev = pci_create_simple(bus, devfn, "piix3-ide-xen");
-    pci_ide_create_devs(dev, hd_table);
-    return dev;
-}
-
 static void pci_piix_ide_exitfn(PCIDevice *dev)
 {
     PCIIDEState *d = PCI_IDE(dev);
@@ -217,17 +208,6 @@ static void pci_piix_ide_exitfn(PCIDevice *dev)
     }
 }
 
-/* hd_table must contain 4 block drivers */
-/* NOTE: for the PIIX3, the IRQs and IOports are hardcoded */
-PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn)
-{
-    PCIDevice *dev;
-
-    dev = pci_create_simple(bus, devfn, "piix3-ide");
-    pci_ide_create_devs(dev, hd_table);
-    return dev;
-}
-
 /* hd_table must contain 4 block drivers */
 /* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
 PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn)
@@ -239,6 +219,7 @@ PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn)
     return dev;
 }
 
+/* NOTE: for the PIIX3, the IRQs and IOports are hardcoded */
 static void piix3_ide_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/include/hw/ide.h b/include/hw/ide.h
index dea0ecf5be..883bbaeb9b 100644
--- a/include/hw/ide.h
+++ b/include/hw/ide.h
@@ -12,8 +12,6 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int iobase2, int isairq,
                         DriveInfo *hd0, DriveInfo *hd1);
 
 /* ide-pci.c */
-PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
-PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
 PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
 int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
 
-- 
2.21.1


