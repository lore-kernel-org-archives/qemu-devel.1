Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68001C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 00:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B6E20863
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 00:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT2ORDH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B6E20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34264 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdOLg-0001KL-1q
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 20:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43343)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rashmica.g@gmail.com>) id 1hdOK8-0000R9-A6
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rashmica.g@gmail.com>) id 1hdOK4-0007LO-CQ
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:19:34 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rashmica.g@gmail.com>)
 id 1hdOJx-00077x-Ha; Tue, 18 Jun 2019 20:19:25 -0400
Received: by mail-pl1-x644.google.com with SMTP id k8so5417957plt.3;
 Tue, 18 Jun 2019 17:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K/1c8f1wGw2bxDm6YYyD89wi2cuLiWFSdw6J7k5V91c=;
 b=lT2ORDH+bDOfU+U+3GZWNmJV7HZWIhmacVtSn6q/3SX2TsBzjz+FgBFnnE2DLWSVxl
 ZWWdqxqVRomFQln7bzHeWGAe0ncVEUJ4nkqx9qhNJuorR5/ISmRDNcZvImKeDG4EiKVO
 fn3GAUudVpYuPkzUMejZtSq/dJqlNX/lIDOTm0S38uXvEm1hI2CWDjlECJ4IqhJQU0Lj
 eehnEC/2kBcNESjB9ilvOJyEOBRtLTil5As2y57EiKkQ4gNZiMlwX7Fg2MKrSi6Xl/r/
 8YESVdAkFgqO1qrhOQQv7ibxOjOO/mgWeRb/nD6xRRfSwxn1G9sAcKDulk7hB1stA6wR
 i1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K/1c8f1wGw2bxDm6YYyD89wi2cuLiWFSdw6J7k5V91c=;
 b=WMD7vDsap97zp/0YLcW9EP7ZOt92Y8Xoo8bx4BjRmYihU+xH2NXmr8kzGr3OEbp9zE
 q00Gv8GCCXoVh3TJ3HpjAsNdjBrX9QquEoaIxARSP0mQw+ARQ1SYN1jZ5aA6BVQwqBcL
 Osbwl00l8epwXplOLky4mryl0roK8UJZP46ynBWnf4G8QX1ZFRktIEmiz+9RIdOCn2pn
 kCNfzNIHhyl+gcfQU3UfxMpFy2cOXZbRKJ4SkQs+0AERqpsEqtgTVsbnkLSyKP3ygQAp
 Z1dH05uBpSOQi8ogCkGmzOPhUAdh8aUICOBusb2nMtDm/sBEkoamdUSWsDLSgNbvClc/
 C3rQ==
X-Gm-Message-State: APjAAAXKFJVLBdFalUvB61Dtw4Xoqe2T0HzrCeu1jSounrTFcgRGhiBf
 PvCH06gsxjjbkOJc0dd+eyc=
X-Google-Smtp-Source: APXvYqx/DVj11nW9LFMxQOq3T4o6F9bcosumgsEAHqNoeAT2RqBjeXB/Ph2w3agngbfU3pqxbZ+/Og==
X-Received: by 2002:a17:902:2a26:: with SMTP id
 i35mr77084394plb.315.1560903561862; 
 Tue, 18 Jun 2019 17:19:21 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id a18sm3705853pjq.0.2019.06.18.17.19.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Jun 2019 17:19:21 -0700 (PDT)
Message-ID: <c4f4eb5f0a347fed2325ffc6e97be54a36860b46.camel@gmail.com>
From: Rashmica Gupta <rashmica.g@gmail.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-arm@nongnu.org
Date: Wed, 19 Jun 2019 10:19:17 +1000
In-Reply-To: <07308eea-1249-98d2-6e3a-d701c97410ee@kaod.org>
References: <20190618085154.21498-1-rashmica.g@gmail.com>
 <20190618085154.21498-3-rashmica.g@gmail.com>
 <07308eea-1249-98d2-6e3a-d701c97410ee@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH 2/2] aspeed: add a GPIO controller to the
 SoC
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
Cc: andrew@aj.id.au, qemu-devel@nongnu.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-06-18 at 11:21 +0200, Cédric Le Goater wrote:
> On 18/06/2019 10:51, Rashmica Gupta wrote:
> > Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
> > ---
> >  hw/arm/aspeed_soc.c         | 17 +++++++++++++++++
> >  include/hw/arm/aspeed_soc.h |  3 +++
> >  2 files changed, 20 insertions(+)
> > 
> > diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> > index 1cc98b9f40..8583869acf 100644
> > --- a/hw/arm/aspeed_soc.c
> > +++ b/hw/arm/aspeed_soc.c
> > @@ -23,6 +23,7 @@
> >  #include "net/net.h"
> >  
> >  #define ASPEED_SOC_IOMEM_SIZE       0x00200000
> > +#define ASPEED_SOC_GPIO_BASE        0x1E780000
> > 
> 
> You should put this value in the memmap array.
>

Oops, good spot!

> C. 
> 
> 
> >  static const hwaddr aspeed_soc_ast2400_memmap[] = {
> >      [ASPEED_IOMEM]  = 0x1E600000,
> > @@ -120,6 +121,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
> >          .spis_num     = 1,
> >          .fmc_typename = "aspeed.smc.fmc",
> >          .spi_typename = aspeed_soc_ast2400_typenames,
> > +        .gpio_typename = "aspeed.gpio-ast2400",
> >          .wdts_num     = 2,
> >          .irqmap       = aspeed_soc_ast2400_irqmap,
> >          .memmap       = aspeed_soc_ast2400_memmap,
> > @@ -131,6 +133,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
> >          .spis_num     = 1,
> >          .fmc_typename = "aspeed.smc.fmc",
> >          .spi_typename = aspeed_soc_ast2400_typenames,
> > +        .gpio_typename = "aspeed.gpio-ast2400",
> >          .wdts_num     = 2,
> >          .irqmap       = aspeed_soc_ast2400_irqmap,
> >          .memmap       = aspeed_soc_ast2400_memmap,
> > @@ -142,6 +145,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
> >          .spis_num     = 1,
> >          .fmc_typename = "aspeed.smc.fmc",
> >          .spi_typename = aspeed_soc_ast2400_typenames,
> > +        .gpio_typename = "aspeed.gpio-ast2400",
> >          .wdts_num     = 2,
> >          .irqmap       = aspeed_soc_ast2400_irqmap,
> >          .memmap       = aspeed_soc_ast2400_memmap,
> > @@ -153,6 +157,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
> >          .spis_num     = 2,
> >          .fmc_typename = "aspeed.smc.ast2500-fmc",
> >          .spi_typename = aspeed_soc_ast2500_typenames,
> > +        .gpio_typename = "aspeed.gpio-ast2500",
> >          .wdts_num     = 3,
> >          .irqmap       = aspeed_soc_ast2500_irqmap,
> >          .memmap       = aspeed_soc_ast2500_memmap,
> > @@ -225,6 +230,8 @@ static void aspeed_soc_init(Object *obj)
> >  
> >      sysbus_init_child_obj(obj, "ftgmac100", OBJECT(&s->ftgmac100),
> >                            sizeof(s->ftgmac100), TYPE_FTGMAC100);
> > +    sysbus_init_child_obj(obj, "gpio", OBJECT(&s->gpio), sizeof(s-
> > >gpio),
> > +                          sc->info->gpio_typename);
> >  }
> >  
> >  static void aspeed_soc_realize(DeviceState *dev, Error **errp)
> > @@ -366,6 +373,16 @@ static void aspeed_soc_realize(DeviceState
> > *dev, Error **errp)
> >                      sc->info->memmap[ASPEED_ETH1]);
> >      sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
> >                         aspeed_soc_get_irq(s, ASPEED_ETH1));
> > +
> > +    /* GPIO */
> > +    object_property_set_bool(OBJECT(&s->gpio), true, "realized",
> > &err);
> > +    if (err) {
> > +        error_propagate(errp, err);
> > +        return;
> > +    }
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0,
> > ASPEED_SOC_GPIO_BASE);
> > +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
> > +            qdev_get_gpio_in(DEVICE(&s->vic), 20));
> >  }
> >  
> >  static void aspeed_soc_class_init(ObjectClass *oc, void *data)
> > diff --git a/include/hw/arm/aspeed_soc.h
> > b/include/hw/arm/aspeed_soc.h
> > index 88b901d5df..28ff2bedb4 100644
> > --- a/include/hw/arm/aspeed_soc.h
> > +++ b/include/hw/arm/aspeed_soc.h
> > @@ -20,6 +20,7 @@
> >  #include "hw/ssi/aspeed_smc.h"
> >  #include "hw/watchdog/wdt_aspeed.h"
> >  #include "hw/net/ftgmac100.h"
> > +#include "hw/gpio/aspeed_gpio.h"
> >  
> >  #define ASPEED_SPIS_NUM  2
> >  #define ASPEED_WDTS_NUM  3
> > @@ -40,6 +41,7 @@ typedef struct AspeedSoCState {
> >      AspeedSDMCState sdmc;
> >      AspeedWDTState wdt[ASPEED_WDTS_NUM];
> >      FTGMAC100State ftgmac100;
> > +    AspeedGPIOState gpio;
> >  } AspeedSoCState;
> >  
> >  #define TYPE_ASPEED_SOC "aspeed-soc"
> > @@ -53,6 +55,7 @@ typedef struct AspeedSoCInfo {
> >      int spis_num;
> >      const char *fmc_typename;
> >      const char **spi_typename;
> > +    const char *gpio_typename;
> >      int wdts_num;
> >      const int *irqmap;
> >      const hwaddr *memmap;
> > 
> 
> 


