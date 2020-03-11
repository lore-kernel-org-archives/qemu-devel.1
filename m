Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04CDC0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 21:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBA720739
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 21:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBA720739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC8dh-0005Us-RO
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 17:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jC8ci-0004Br-5n
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 17:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jC8cg-000187-S3
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 17:10:40 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:47832
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jC8ce-0000yD-1N; Wed, 11 Mar 2020 17:10:36 -0400
Received: from host86-177-178-88.range86-177.btcentralplus.com
 ([86.177.178.88] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jC8cq-0004x8-Rb; Wed, 11 Mar 2020 21:10:54 +0000
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <cover.1583867210.git.balaton@eik.bme.hu>
 <6b7af110e1576d6873777673b3e3fa01f4c9839e.1583867210.git.balaton@eik.bme.hu>
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
Message-ID: <b24001fe-0e20-cf05-6695-518e9972ac2d@ilande.co.uk>
Date: Wed, 11 Mar 2020 21:10:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6b7af110e1576d6873777673b3e3fa01f4c9839e.1583867210.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.177.178.88
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v4 4/4] via-ide: Also emulate non 100% native mode
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

On 10/03/2020 19:06, BALATON Zoltan wrote:

> Some machines operate in "non 100% native mode" where interrupts are
> fixed at legacy IDE interrupts and some guests expect this behaviour
> without checking based on knowledge about hardware. Even Linux has
> arch specific workarounds for this that are activated on such boards
> so this needs to be emulated as well.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> 
> Notes:
>     v2: Don't use PCI_INTERRUPT_LINE in via_ide_set_irq()
>     v3: Patch pci.c instead of local workaround for PCI reset clearing
>         PCI_INTERRUPT_PIN config reg
> 
>  hw/ide/via.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ide/via.c b/hw/ide/via.c
> index df0b352b58..1eada23097 100644
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
> @@ -25,6 +26,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "hw/qdev-properties.h"
>  #include "hw/pci/pci.h"
>  #include "migration/vmstate.h"
>  #include "qemu/module.h"
> @@ -111,11 +113,18 @@ static void via_ide_set_irq(void *opaque, int n, int level)
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
> +        PCI_IDE(d)->flags & BIT(PCI_IDE_LEGACY_IRQ)) {
> +        qemu_set_irq(isa_get_irq(NULL, (n ? 15 : 14)), level);
> +    } else {
> +        qemu_set_irq(isa_get_irq(NULL, 14), level);
>      }
>  }
>  
> @@ -169,7 +178,9 @@ static void via_ide_realize(PCIDevice *dev, Error **errp)
>  
>      pci_config_set_prog_interface(pci_conf, 0x8f); /* native PCI ATA mode */
>      pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
> -    dev->wmask[PCI_INTERRUPT_LINE] = 0xf;
> +    /* Bits 0 and 4 of CLASS_PROG select native mode and are writable */
> +    dev->wmask[PCI_CLASS_PROG] = 5;
> +    dev->wmask[PCI_INTERRUPT_LINE] = 0;
>  
>      memory_region_init_io(&d->data_bar[0], OBJECT(d), &pci_ide_data_le_ops,
>                            &d->bus[0], "via-ide0-data", 8);
> @@ -213,6 +224,12 @@ static void via_ide_exitfn(PCIDevice *dev)
>      }
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
> @@ -225,6 +242,7 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
>      k->device_id = PCI_DEVICE_ID_VIA_IDE;
>      k->revision = 0x06;
>      k->class_id = PCI_CLASS_STORAGE_IDE;
> +    device_class_set_props(dc, via_ide_properties);
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>  }

I don't think this (and adding the feature bit) are the right solution here. I'll do
my best to look at the test cases you've sent off-list over the next couple of days
and report back.


ATB,

Mark.

