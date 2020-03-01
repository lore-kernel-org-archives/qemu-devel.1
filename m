Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9055C3F2D1
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 11:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D878214DB
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 11:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D878214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8Mqg-0006kg-Pj
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 06:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1j8Mq1-0006EF-FQ
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 06:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1j8Mq0-00014Z-6U
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 06:32:49 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:52514
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1j8Mpw-00011T-L0; Sun, 01 Mar 2020 06:32:44 -0500
Received: from host86-135-55-139.range86-135.btcentralplus.com
 ([86.135.55.139] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1j8Mq1-0007Dw-FI; Sun, 01 Mar 2020 11:32:54 +0000
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <cover.1583017348.git.balaton@eik.bme.hu>
 <775825dba26f6b36ab067f253e4ab5dc3a3d15dc.1583017348.git.balaton@eik.bme.hu>
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
Message-ID: <d85cd8c6-99a3-8430-41cc-486aad1ad8de@ilande.co.uk>
Date: Sun, 1 Mar 2020 11:32:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <775825dba26f6b36ab067f253e4ab5dc3a3d15dc.1583017348.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.135.55.139
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 1/2] ide: Make room for flags in PCIIDEState and add one
 for legacy IRQ routing
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

On 29/02/2020 23:02, BALATON Zoltan wrote:

> We'll need a flag for implementing some device specific behaviour in
> via-ide but we already have a currently CMD646 specific field that can
> be repurposed for this and leave room for furhter flags if needed in
> the future. This patch changes the "secondary" field to "flags" and
> define the flags for CMD646 and via-ide and change CMD646 and its
> users accordingly.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/alpha/dp264.c     |  2 +-
>  hw/ide/cmd646.c      | 12 ++++++------
>  hw/sparc64/sun4u.c   |  9 ++-------
>  include/hw/ide.h     |  4 ++--
>  include/hw/ide/pci.h |  7 ++++++-
>  5 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index 8d71a30617..e4075feaaf 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -102,7 +102,7 @@ static void clipper_init(MachineState *machine)
>          DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>          ide_drive_get(hd, ARRAY_SIZE(hd));
>  
> -        pci_cmd646_ide_init(pci_bus, hd, 0);
> +        pci_cmd646_ide_init(pci_bus, hd, -1, false);
>      }
>  
>      /* Load PALcode.  Given that this is not "real" cpu palcode,
> diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
> index 335c060673..0be650791f 100644
> --- a/hw/ide/cmd646.c
> +++ b/hw/ide/cmd646.c
> @@ -256,7 +256,7 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Error **errp)
>      pci_conf[PCI_CLASS_PROG] = 0x8f;
>  
>      pci_conf[CNTRL] = CNTRL_EN_CH0; // enable IDE0
> -    if (d->secondary) {
> +    if (d->flags & BIT(PCI_IDE_SECONDARY)) {
>          /* XXX: if not enabled, really disable the seconday IDE controller */
>          pci_conf[CNTRL] |= CNTRL_EN_CH1; /* enable IDE1 */
>      }
> @@ -317,20 +317,20 @@ static void pci_cmd646_ide_exitfn(PCIDevice *dev)
>      }
>  }
>  
> -void pci_cmd646_ide_init(PCIBus *bus, DriveInfo **hd_table,
> -                         int secondary_ide_enabled)
> +void pci_cmd646_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn,
> +                         bool secondary_ide_enabled)
>  {
>      PCIDevice *dev;
>  
> -    dev = pci_create(bus, -1, "cmd646-ide");
> -    qdev_prop_set_uint32(&dev->qdev, "secondary", secondary_ide_enabled);
> +    dev = pci_create(bus, devfn, "cmd646-ide");
> +    qdev_prop_set_bit(&dev->qdev, "secondary", secondary_ide_enabled);
>      qdev_init_nofail(&dev->qdev);
>  
>      pci_ide_create_devs(dev, hd_table);
>  }

Note that legacy init functions such as pci_cmd646_ide_init() should be removed where
possible, and in fact I posted a patch last week to completely remove it. This is
because using qdev directly allows each board to wire up the device as required,
rather than pushing it down into a set of init functions with different defaults.

Given that you're working in this area, I'd highly recommend doing the same for
via_ide_init() too.

>  static Property cmd646_ide_properties[] = {
> -    DEFINE_PROP_UINT32("secondary", PCIIDEState, secondary, 0),
> +    DEFINE_PROP_BIT("secondary", PCIIDEState, flags, PCI_IDE_SECONDARY, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index b7ac42f7a5..b64899300c 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -50,8 +50,7 @@
>  #include "hw/sparc/sparc64.h"
>  #include "hw/nvram/fw_cfg.h"
>  #include "hw/sysbus.h"
> -#include "hw/ide.h"
> -#include "hw/ide/pci.h"
> +#include "hw/ide/internal.h"
>  #include "hw/loader.h"
>  #include "hw/fw-path-provider.h"
>  #include "elf.h"
> @@ -664,11 +663,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      }
>  
>      ide_drive_get(hd, ARRAY_SIZE(hd));
> -
> -    pci_dev = pci_create(pci_busA, PCI_DEVFN(3, 0), "cmd646-ide");
> -    qdev_prop_set_uint32(&pci_dev->qdev, "secondary", 1);
> -    qdev_init_nofail(&pci_dev->qdev);
> -    pci_ide_create_devs(pci_dev, hd);
> +    pci_cmd646_ide_init(pci_busA, hd, PCI_DEVFN(3, 0), true);
>  
>      /* Map NVRAM into I/O (ebus) space */
>      nvram = m48t59_init(NULL, 0, 0, NVRAM_SIZE, 1968, 59);
> diff --git a/include/hw/ide.h b/include/hw/ide.h
> index 28d8a06439..d88c5ee695 100644
> --- a/include/hw/ide.h
> +++ b/include/hw/ide.h
> @@ -12,8 +12,8 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int iobase2, int isairq,
>                          DriveInfo *hd0, DriveInfo *hd1);
>  
>  /* ide-pci.c */
> -void pci_cmd646_ide_init(PCIBus *bus, DriveInfo **hd_table,
> -                         int secondary_ide_enabled);
> +void pci_cmd646_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn,
> +                         bool secondary_ide_enabled);
>  PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
>  PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
>  PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
> diff --git a/include/hw/ide/pci.h b/include/hw/ide/pci.h
> index a9f2c33e68..21075edf16 100644
> --- a/include/hw/ide/pci.h
> +++ b/include/hw/ide/pci.h
> @@ -40,6 +40,11 @@ typedef struct BMDMAState {
>  #define TYPE_PCI_IDE "pci-ide"
>  #define PCI_IDE(obj) OBJECT_CHECK(PCIIDEState, (obj), TYPE_PCI_IDE)
>  
> +enum {
> +    PCI_IDE_SECONDARY, /* used only for cmd646 */
> +    PCI_IDE_LEGACY_IRQ
> +};
> +
>  typedef struct PCIIDEState {
>      /*< private >*/
>      PCIDevice parent_obj;
> @@ -47,7 +52,7 @@ typedef struct PCIIDEState {
>  
>      IDEBus bus[2];
>      BMDMAState bmdma[2];
> -    uint32_t secondary; /* used only for cmd646 */
> +    uint32_t flags;
>      MemoryRegion bmdma_bar;
>      MemoryRegion cmd_bar[2];
>      MemoryRegion data_bar[2];

ATB,

Mark.

