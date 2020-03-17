Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E890BC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:02:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B8E205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B8E205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE93O-0005u5-T6
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jE8yw-0008Io-QP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jE8yu-0006Tv-Ek
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:57:54 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:31350)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jE8yo-00060Q-Sh; Tue, 17 Mar 2020 05:57:48 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id AE0EF747E18;
 Tue, 17 Mar 2020 10:57:44 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2E4E4747E0B; Tue, 17 Mar 2020 10:57:44 +0100 (CET)
Message-Id: <adddfa21552783020d64e1314318cab6d24362c3.1584437958.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1584437957.git.balaton@eik.bme.hu>
References: <cover.1584437957.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 1/7] hw/ide: Get rid of piix3_init functions
Date: Tue, 17 Mar 2020 10:39:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org,
    qemu-block@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This removes pci_piix3_ide_init() and pci_piix3_xen_ide_init()
functions similar to clean up done to other ide devices.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
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
-            dev =3D pci_piix3_xen_ide_init(pci_bus, hd, piix3_devfn + 1)=
;
-        } else {
-            dev =3D pci_piix3_ide_init(pci_bus, hd, piix3_devfn + 1);
-        }
+
+        dev =3D pci_create_simple(pci_bus, piix3_devfn + 1,
+                                xen_enabled() ? "piix3-ide-xen" : "piix3=
-ide");
+        pci_ide_create_devs(dev, hd);
         idebus[0] =3D qdev_get_child_bus(&dev->qdev, "ide.0");
         idebus[1] =3D qdev_get_child_bus(&dev->qdev, "ide.1");
         pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 1a6a287e76..4fc76c5225 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -476,6 +476,7 @@ const VMStateDescription vmstate_ide_pci =3D {
     }
 };
=20
+/* hd_table must contain 4 block drivers */
 void pci_ide_create_devs(PCIDevice *dev, DriveInfo **hd_table)
 {
     PCIIDEState *d =3D PCI_IDE(dev);
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index bc575b4d70..8bcd6b72c2 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -197,15 +197,6 @@ int pci_piix3_xen_ide_unplug(DeviceState *dev, bool =
aux)
     return 0;
 }
=20
-PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInfo **hd_table, int=
 devfn)
-{
-    PCIDevice *dev;
-
-    dev =3D pci_create_simple(bus, devfn, "piix3-ide-xen");
-    pci_ide_create_devs(dev, hd_table);
-    return dev;
-}
-
 static void pci_piix_ide_exitfn(PCIDevice *dev)
 {
     PCIIDEState *d =3D PCI_IDE(dev);
@@ -217,17 +208,6 @@ static void pci_piix_ide_exitfn(PCIDevice *dev)
     }
 }
=20
-/* hd_table must contain 4 block drivers */
-/* NOTE: for the PIIX3, the IRQs and IOports are hardcoded */
-PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int dev=
fn)
-{
-    PCIDevice *dev;
-
-    dev =3D pci_create_simple(bus, devfn, "piix3-ide");
-    pci_ide_create_devs(dev, hd_table);
-    return dev;
-}
-
 /* hd_table must contain 4 block drivers */
 /* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
 PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int dev=
fn)
@@ -239,6 +219,7 @@ PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo =
**hd_table, int devfn)
     return dev;
 }
=20
+/* NOTE: for the PIIX3, the IRQs and IOports are hardcoded */
 static void piix3_ide_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
diff --git a/include/hw/ide.h b/include/hw/ide.h
index dea0ecf5be..883bbaeb9b 100644
--- a/include/hw/ide.h
+++ b/include/hw/ide.h
@@ -12,8 +12,6 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int io=
base2, int isairq,
                         DriveInfo *hd0, DriveInfo *hd1);
=20
 /* ide-pci.c */
-PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInfo **hd_table, int=
 devfn);
-PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int dev=
fn);
 PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int dev=
fn);
 int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
=20
--=20
2.21.1


