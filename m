Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1566C18E5A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2DB2465A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2DB2465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOWO-0006Wf-2a
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jBOQY-0004XZ-DC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jBOQW-0002ck-Os
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:51:02 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:42600
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jBOQS-0002ZA-AR; Mon, 09 Mar 2020 15:50:56 -0400
Received: from host86-177-178-88.range86-177.btcentralplus.com
 ([86.177.178.88] helo=[192.168.1.110])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jBOQe-0007XN-SP; Mon, 09 Mar 2020 19:51:14 +0000
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <cover.1583714522.git.balaton@eik.bme.hu>
 <2acb7e522055bb9ac45586c1792edc7615ef3ae6.1583714522.git.balaton@eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <e6a293bb-5019-9d2e-c694-2c0917bb0a35@ilande.co.uk>
Date: Mon, 9 Mar 2020 19:50:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2acb7e522055bb9ac45586c1792edc7615ef3ae6.1583714522.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.177.178.88
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 2/2] via-ide: Also emulate non 100% native mode
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
Cc: philmd@redhat.com, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/03/2020 00:42, BALATON Zoltan wrote:

> Some machines operate in "non 100% native mode" where interrupts are
> fixed at legacy IDE interrupts and some guests expect this behaviour
> without checking based on knowledge about hardware. Even Linux has
> arch specific workarounds for this that are activated on such boards
> so this needs to be emulated as well.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> v2: Don't use PCI_INTERRUPT_LINE in via_ide_set_irq()
> 
>  hw/ide/via.c            | 57 +++++++++++++++++++++++++++++++++++------
>  hw/mips/mips_fulong2e.c |  2 +-
>  include/hw/ide.h        |  3 ++-
>  3 files changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/ide/via.c b/hw/ide/via.c
> index 096de8dba0..44ecc2af29 100644
> --- a/hw/ide/via.c
> +++ b/hw/ide/via.c
> @@ -1,9 +1,10 @@
>  /*
> - * QEMU IDE Emulation: PCI VIA82C686B support.
> + * QEMU VIA southbridge IDE emulation (VT82C686B, VT8231)
>   *
>   * Copyright (c) 2003 Fabrice Bellard
>   * Copyright (c) 2006 Openedhand Ltd.
>   * Copyright (c) 2010 Huacai Chen <zltjiangshi@gmail.com>
> + * Copyright (c) 2019-2020 BALATON Zoltan
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining a copy
>   * of this software and associated documentation files (the "Software"), to deal
> @@ -25,6 +26,8 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/range.h"
> +#include "hw/qdev-properties.h"
>  #include "hw/pci/pci.h"
>  #include "migration/vmstate.h"
>  #include "qemu/module.h"
> @@ -111,14 +114,40 @@ static void via_ide_set_irq(void *opaque, int n, int level)
>      } else {
>          d->config[0x70 + n * 8] &= ~0x80;
>      }
> -
>      level = (d->config[0x70] & 0x80) || (d->config[0x78] & 0x80);
> -    n = pci_get_byte(d->config + PCI_INTERRUPT_LINE);
> -    if (n) {
> -        qemu_set_irq(isa_get_irq(NULL, n), level);
> +
> +    /*
> +     * Some machines operate in "non 100% native mode" where PCI_INTERRUPT_LINE
> +     * is not used but IDE always uses ISA IRQ 14 and 15 even in native mode.
> +     * Some guest drivers expect this, often without checking.
> +     */
> +    if (!(pci_get_byte(d->config + PCI_CLASS_PROG) & (n ? 4 : 1)) ||

One other thing whilst I'm here: the above line is quite cryptic to read unless
you're very familiar with the PCI IDE specifications. How about something like this
towards the top of the function:

int native = n ? pci_get_byte(d->config + PCI_CLASS_PROG) & 4 :
                 pci_get_byte(d->config + PCI_CLASS_PROG) & 1;

and change the if() accordingly:

if (native) {
   ...
} else {
   ...
}

With that you can could probably drop the comment since it's really obvious what the
code is doing when reading it against the datasheet.

> +        PCI_IDE(d)->flags & BIT(PCI_IDE_LEGACY_IRQ)) {
> +        qemu_set_irq(isa_get_irq(NULL, (n ? 15 : 14)), level);
> +    } else {
> +        qemu_set_irq(isa_get_irq(NULL, 14), level);
>      }
>  }
>  
> +static uint32_t via_ide_config_read(PCIDevice *d, uint32_t address, int len)
> +{
> +    /*
> +     * The pegasos2 firmware writes to PCI_INTERRUPT_LINE but on real
> +     * hardware it's fixed at 14 and won't change. Some guests also expect
> +     * legacy interrupts, without reading PCI_INTERRUPT_LINE but Linux
> +     * depends on this to read 14. We set it to 14 in the reset method and
> +     * also set the wmask to 0 to emulate this but that turns out to be not
> +     * enough. QEMU resets the PCI bus after this device and
> +     * pci_do_device_reset() called from pci_device_reset() will zero
> +     * PCI_INTERRUPT_LINE so this config_read function is to counter that and
> +     * restore the correct value, otherwise this should not be needed.
> +     */
> +    if (range_covers_byte(address, len, PCI_INTERRUPT_LINE)) {
> +        pci_set_byte(d->config + PCI_INTERRUPT_LINE, 14);
> +    }
> +    return pci_default_read_config(d, address, len);
> +}
> +
>  static void via_ide_reset(DeviceState *dev)
>  {
>      PCIIDEState *d = PCI_IDE(dev);
> @@ -169,7 +198,8 @@ static void via_ide_realize(PCIDevice *dev, Error **errp)
>  
>      pci_config_set_prog_interface(pci_conf, 0x8f); /* native PCI ATA mode */
>      pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
> -    dev->wmask[PCI_INTERRUPT_LINE] = 0xf;
> +    dev->wmask[PCI_CLASS_PROG] = 5;
> +    dev->wmask[PCI_INTERRUPT_LINE] = 0;
>  
>      memory_region_init_io(&d->data_bar[0], OBJECT(d), &pci_ide_data_le_ops,
>                            &d->bus[0], "via-ide0-data", 8);
> @@ -213,14 +243,23 @@ static void via_ide_exitfn(PCIDevice *dev)
>      }
>  }
>  
> -void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn)
> +void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn,
> +                  bool legacy_irq)
>  {
>      PCIDevice *dev;
>  
> -    dev = pci_create_simple(bus, devfn, "via-ide");
> +    dev = pci_create(bus, devfn, "via-ide");
> +    qdev_prop_set_bit(&dev->qdev, "legacy-irq", legacy_irq);
> +    qdev_init_nofail(&dev->qdev);
>      pci_ide_create_devs(dev, hd_table);
>  }
>  
> +static Property via_ide_properties[] = {
> +    DEFINE_PROP_BIT("legacy-irq", PCIIDEState, flags, PCI_IDE_LEGACY_IRQ,
> +                    false),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void via_ide_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -229,10 +268,12 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
>      dc->reset = via_ide_reset;
>      k->realize = via_ide_realize;
>      k->exit = via_ide_exitfn;
> +    k->config_read = via_ide_config_read;
>      k->vendor_id = PCI_VENDOR_ID_VIA;
>      k->device_id = PCI_DEVICE_ID_VIA_IDE;
>      k->revision = 0x06;
>      k->class_id = PCI_CLASS_STORAGE_IDE;
> +    device_class_set_props(dc, via_ide_properties);
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>  }
>  
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 4727b1d3a4..150182c62a 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -257,7 +257,7 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
>      isa_create_simple(isa_bus, TYPE_VT82C686B_SUPERIO);
>  
>      ide_drive_get(hd, ARRAY_SIZE(hd));
> -    via_ide_init(pci_bus, hd, PCI_DEVFN(slot, 1));
> +    via_ide_init(pci_bus, hd, PCI_DEVFN(slot, 1), false);
>  
>      pci_create_simple(pci_bus, PCI_DEVFN(slot, 2), "vt82c686b-usb-uhci");
>      pci_create_simple(pci_bus, PCI_DEVFN(slot, 3), "vt82c686b-usb-uhci");
> diff --git a/include/hw/ide.h b/include/hw/ide.h
> index d88c5ee695..2a7001ccba 100644
> --- a/include/hw/ide.h
> +++ b/include/hw/ide.h
> @@ -18,7 +18,8 @@ PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
>  PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
>  PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
>  int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
> -void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
> +void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn,
> +                  bool legacy_irq);
>  
>  /* ide-mmio.c */
>  void mmio_ide_init_drives(DeviceState *dev, DriveInfo *hd0, DriveInfo *hd1);


ATB,

Mark.

