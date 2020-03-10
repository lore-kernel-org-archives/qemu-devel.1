Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A583AC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 23:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4901E2071B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 23:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4901E2071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBo5b-0005lt-Ez
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 19:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jBo4z-0005CY-70
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 19:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jBo4x-0002eZ-WF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 19:14:29 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:37063)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jBo4s-0002CD-89; Tue, 10 Mar 2020 19:14:24 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 3C7A6747DF7;
 Wed, 11 Mar 2020 00:14:20 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1982A747DCF; Wed, 11 Mar 2020 00:14:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 17F1A747D5D;
 Wed, 11 Mar 2020 00:14:20 +0100 (CET)
Date: Wed, 11 Mar 2020 00:14:20 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH v4 1/4] ide/via: Get rid of via_init_ide()
In-Reply-To: <b261e8ec1325a250ca3c35fbc0a077878e7054df.1583867210.git.balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.22.395.2003110012380.86611@zero.eik.bme.hu>
References: <cover.1583867210.git.balaton@eik.bme.hu>
 <b261e8ec1325a250ca3c35fbc0a077878e7054df.1583867210.git.balaton@eik.bme.hu>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
Cc: philmd@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020, BALATON Zoltan wrote:
> Follow example of CMD646 and remove via_init_ide function and do it
> directly in board code instead.

There's a typo in the title and commit message, it should read 
via_ide_init in both. If a v5 is needed I'll fix that otherwise maybe it 
could be fixed up when committing?

Regards,
BALATON Zoltan

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> hw/ide/via.c            | 8 --------
> hw/mips/mips_fulong2e.c | 5 ++++-
> include/hw/ide.h        | 1 -
> 3 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/hw/ide/via.c b/hw/ide/via.c
> index 096de8dba0..df0b352b58 100644
> --- a/hw/ide/via.c
> +++ b/hw/ide/via.c
> @@ -213,14 +213,6 @@ static void via_ide_exitfn(PCIDevice *dev)
>     }
> }
>
> -void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn)
> -{
> -    PCIDevice *dev;
> -
> -    dev = pci_create_simple(bus, devfn, "via-ide");
> -    pci_ide_create_devs(dev, hd_table);
> -}
> -
> static void via_ide_class_init(ObjectClass *klass, void *data)
> {
>     DeviceClass *dc = DEVICE_CLASS(klass);
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 4727b1d3a4..639ba2a091 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -37,6 +37,7 @@
> #include "qemu/log.h"
> #include "hw/loader.h"
> #include "hw/ide.h"
> +#include "hw/ide/pci.h"
> #include "elf.h"
> #include "hw/isa/vt82c686.h"
> #include "hw/rtc/mc146818rtc.h"
> @@ -239,6 +240,7 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
>     qemu_irq *i8259;
>     ISABus *isa_bus;
>     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
> +    PCIDevice *dev;
>
>     isa_bus = vt82c686b_isa_init(pci_bus, PCI_DEVFN(slot, 0));
>     if (!isa_bus) {
> @@ -256,8 +258,9 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
>     /* Super I/O */
>     isa_create_simple(isa_bus, TYPE_VT82C686B_SUPERIO);
>
> +    dev = pci_create_simple(pci_bus, PCI_DEVFN(slot, 1), "via-ide");
>     ide_drive_get(hd, ARRAY_SIZE(hd));
> -    via_ide_init(pci_bus, hd, PCI_DEVFN(slot, 1));
> +    pci_ide_create_devs(dev, hd);
>
>     pci_create_simple(pci_bus, PCI_DEVFN(slot, 2), "vt82c686b-usb-uhci");
>     pci_create_simple(pci_bus, PCI_DEVFN(slot, 3), "vt82c686b-usb-uhci");
> diff --git a/include/hw/ide.h b/include/hw/ide.h
> index 0c7080ed92..dea0ecf5be 100644
> --- a/include/hw/ide.h
> +++ b/include/hw/ide.h
> @@ -16,7 +16,6 @@ PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
> PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
> PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
> int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
> -void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
>
> /* ide-mmio.c */
> void mmio_ide_init_drives(DeviceState *dev, DriveInfo *hd0, DriveInfo *hd1);
>

