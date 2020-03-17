Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1DAC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFEA5205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEA5205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE914-0002uO-0W
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jE8yy-0008Lx-Bc
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jE8yw-0006fz-RP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:57:56 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:31366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jE8ys-00060f-66; Tue, 17 Mar 2020 05:57:50 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id B2E58747E1A;
 Tue, 17 Mar 2020 10:57:44 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 32ECC747E12; Tue, 17 Mar 2020 10:57:44 +0100 (CET)
Message-Id: <3240656814c804513de08bdbbf318f2f590df241.1584437958.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1584437957.git.balaton@eik.bme.hu>
References: <cover.1584437957.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 2/7] hw/ide: Get rid of piix4_init function
Date: Tue, 17 Mar 2020 10:39:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org,
    qemu-block@nongnu.org
Content-Transfer-Encoding: quoted-printable
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This removes pci_piix4_ide_init() function similar to clean up done to
other ide devices.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ide/piix.c    | 12 +-----------
 hw/isa/piix4.c   |  5 ++++-
 include/hw/ide.h |  1 -
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index 8bcd6b72c2..3b2de4c312 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -208,17 +208,6 @@ static void pci_piix_ide_exitfn(PCIDevice *dev)
     }
 }
=20
-/* hd_table must contain 4 block drivers */
-/* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
-PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int dev=
fn)
-{
-    PCIDevice *dev;
-
-    dev =3D pci_create_simple(bus, devfn, "piix4-ide");
-    pci_ide_create_devs(dev, hd_table);
-    return dev;
-}
-
 /* NOTE: for the PIIX3, the IRQs and IOports are hardcoded */
 static void piix3_ide_class_init(ObjectClass *klass, void *data)
 {
@@ -247,6 +236,7 @@ static const TypeInfo piix3_ide_xen_info =3D {
     .class_init    =3D piix3_ide_class_init,
 };
=20
+/* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
 static void piix4_ide_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 7edec5e149..0ab4787658 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -35,6 +35,7 @@
 #include "hw/timer/i8254.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/ide.h"
+#include "hw/ide/pci.h"
 #include "migration/vmstate.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
@@ -255,10 +256,12 @@ DeviceState *piix4_create(PCIBus *pci_bus, ISABus *=
*isa_bus,
         *isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
     }
=20
+    pci =3D pci_create_simple(pci_bus, pci->devfn + 1, "piix4-ide");
     hd =3D g_new(DriveInfo *, ide_drives);
     ide_drive_get(hd, ide_drives);
-    pci_piix4_ide_init(pci_bus, hd, pci->devfn + 1);
+    pci_ide_create_devs(pci, hd);
     g_free(hd);
+
     pci_create_simple(pci_bus, pci->devfn + 2, "piix4-usb-uhci");
     if (smbus) {
         *smbus =3D piix4_pm_init(pci_bus, pci->devfn + 3, 0x1100,
diff --git a/include/hw/ide.h b/include/hw/ide.h
index 883bbaeb9b..21bd8f23f1 100644
--- a/include/hw/ide.h
+++ b/include/hw/ide.h
@@ -12,7 +12,6 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int io=
base2, int isairq,
                         DriveInfo *hd0, DriveInfo *hd1);
=20
 /* ide-pci.c */
-PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int dev=
fn);
 int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
=20
 /* ide-mmio.c */
--=20
2.21.1


