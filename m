Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEBDC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 21:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CB86214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 21:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqDNi+V2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB86214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0BHH-0002Q4-S2
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 16:35:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j0BGa-0001bN-0H
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 16:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j0BGY-0008Ra-Ow
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 16:34:23 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:50807)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j0BGY-0008Ql-GE; Fri, 07 Feb 2020 16:34:22 -0500
Received: by mail-pj1-x1044.google.com with SMTP id r67so1464384pjb.0;
 Fri, 07 Feb 2020 13:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=cfiWotLrnhcLi8XjkCaC6PtuyFcuR2G9W7x60jGeq2w=;
 b=AqDNi+V2xGR3DqQtPpg63ww+rPTwk8miRJvmJt20+n6glRsYDmHnD9sQrfP0oZ3GMO
 FFfVgy/lMD3QaUokHAqV0w+oXKaToxPKXqSssKObKn730dz2Dap9Nfc73nFO4p5deunO
 sl6oGMnWVSFwAdZrVUeZ9L5ylcLobiN/+Xu2ewc/hxEhaCdbeR8PIGjsrwZ61lXSnlpQ
 uHQNRSF5uZsG9Qp+sOIuQ3OJjMNhWX+sJqEutUk04OOVo+QA9lx6UPSfjer+LimmYKI6
 3YDHETAgIoa8z9omtkd6oZmCuZkpZwdVG1fDujfr2QWY+A511uUIWnZHhXiV15pBafqM
 iKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=cfiWotLrnhcLi8XjkCaC6PtuyFcuR2G9W7x60jGeq2w=;
 b=FQP/LBgs8lHaAeM88AeMCnh9jNBXWoVAFv4oSoClUB1YKprzU3VRCmqaooTZsZJZpo
 FGfDuDuudMa2NfHU1O3JuAGvbAddvH/B1xn7JHdQq9JcUBZav4aOms8yl4z9AUC5QrKL
 eKfXuR6WM7EmuO4pYprBivb0XIL+Q3POXbNZoWog2wEKf+JKLEuUsHf6EAu8JSsubi53
 p5/E1/Geop0/t0b0cdrDGXAmL4S3R2vAgoAex/AHak9oI5BGqsSjP/7hP0dxr2Knsgg5
 m4p5xPF3IHaw/h+3Wa0c9fUBWLxUb0R+VpGkYNA/q3+z9Tk+F1SCIM/urNj/eQJzH3R0
 sSxA==
X-Gm-Message-State: APjAAAVegnAm2iGNNuWhWgSkFKDR03wNNzkbL+5t8XiyTIC3jz8fAscl
 vu8GaeAy+ZWO8pVpMigB8Tg=
X-Google-Smtp-Source: APXvYqwlWkqw0ss0QkpSCK3mpKeyk8+sCi+zWFTI2UG+S00juhvMpQC3LgfrGmIfxFXY+Rdea/yzEw==
X-Received: by 2002:a17:90a:5d85:: with SMTP id
 t5mr6153257pji.126.1581111261091; 
 Fri, 07 Feb 2020 13:34:21 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id t15sm4016891pgr.60.2020.02.07.13.34.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Feb 2020 13:34:20 -0800 (PST)
Date: Fri, 7 Feb 2020 13:34:19 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v2] hw/arm: ast2600: Wire up EHCI controllers
Message-ID: <20200207213419.GA7154@roeck-us.net>
References: <20200207174548.9087-1-linux@roeck-us.net>
 <CAPan3WqT8gUmpjboD460CVP2imYftMHtRQ+rcmvEiDXnLN+3=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPan3WqT8gUmpjboD460CVP2imYftMHtRQ+rcmvEiDXnLN+3=A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 07, 2020 at 10:25:01PM +0100, Niek Linnenbank wrote:
> Hi Guenter,
> 
> On Fri, Feb 7, 2020 at 6:46 PM Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > Initialize EHCI controllers on AST2600 using the existing
> > TYPE_PLATFORM_EHCI. After this change, booting ast2600-evb
> > into Linux successfully instantiates a USB interface after
> > the necessary changes are made to its devicetree files.
> >
> > ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> > ehci-platform: EHCI generic platform driver
> > ehci-platform 1e6a3000.usb: EHCI Host Controller
> > ehci-platform 1e6a3000.usb: new USB bus registered, assigned bus number 1
> > ehci-platform 1e6a3000.usb: irq 25, io mem 0x1e6a3000
> > ehci-platform 1e6a3000.usb: USB 2.0 started, EHCI 1.00
> > usb usb1: Manufacturer: Linux 5.5.0-09825-ga0802f2d0ef5-dirty ehci_hcd
> > usb 1-1: new high-speed USB device number 2 using ehci-platform
> >
> > Reviewed-by: Cédric Le Goater <clg@kaod.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v2: Rebased to master (to fix context conflict)
> >     Added Reviewed-by: tag
> >
> >  hw/arm/aspeed_ast2600.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> > index 90cf1c755d..446b44d31c 100644
> > --- a/hw/arm/aspeed_ast2600.c
> > +++ b/hw/arm/aspeed_ast2600.c
> > @@ -31,6 +31,8 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
> >      [ASPEED_FMC]       = 0x1E620000,
> >      [ASPEED_SPI1]      = 0x1E630000,
> >      [ASPEED_SPI2]      = 0x1E641000,
> > +    [ASPEED_EHCI1]     = 0x1E6A1000,
> > +    [ASPEED_EHCI2]     = 0x1E6A3000,
> >      [ASPEED_MII1]      = 0x1E650000,
> >      [ASPEED_MII2]      = 0x1E650008,
> >      [ASPEED_MII3]      = 0x1E650010,
> > @@ -79,6 +81,8 @@ static const int aspeed_soc_ast2600_irqmap[] = {
> >      [ASPEED_ADC]       = 78,
> >      [ASPEED_XDMA]      = 6,
> >      [ASPEED_SDHCI]     = 43,
> > +    [ASPEED_EHCI1]     = 5,
> > +    [ASPEED_EHCI2]     = 9,
> >      [ASPEED_EMMC]      = 15,
> >      [ASPEED_GPIO]      = 40,
> >      [ASPEED_GPIO_1_8V] = 11,
> > @@ -166,6 +170,11 @@ static void aspeed_soc_ast2600_init(Object *obj)
> >                                sizeof(s->spi[i]), typename);
> >      }
> >
> > +    for (i = 0; i < sc->ehcis_num; i++) {
> > +        sysbus_init_child_obj(obj, "ehci[*]", OBJECT(&s->ehci[i]),
> > +                              sizeof(s->ehci[i]), TYPE_PLATFORM_EHCI);
> > +    }
> > +
> >      snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
> >      sysbus_init_child_obj(obj, "sdmc", OBJECT(&s->sdmc), sizeof(s->sdmc),
> >                            typename);
> > @@ -416,6 +425,19 @@ static void aspeed_soc_ast2600_realize(DeviceState
> > *dev, Error **errp)
> >                          s->spi[i].ctrl->flash_window_base);
> >      }
> >
> > +    /* EHCI */
> > +    for (i = 0; i < sc->ehcis_num; i++) {
> > +        object_property_set_bool(OBJECT(&s->ehci[i]), true, "realized",
> > &err);
> > +        if (err) {
> > +            error_propagate(errp, err);
> > +            return;
> > +        }
> >
> 
> Would it make sense to directly use error_fatal in the call to
> object_property_set_bool?
> That way you can avoid the additional code for propagating the error.
> 

The code matches the pattern used in the rest of the function.
Given that, I would be hesitant to change it for this one case.

> 
> > +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
> > +                        sc->memmap[ASPEED_EHCI1 + i]);
> > +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
> > +                           aspeed_soc_get_irq(s, ASPEED_EHCI1 + i));
> > +    }
> > +
> >      /* SDMC - SDRAM Memory Controller */
> >      object_property_set_bool(OBJECT(&s->sdmc), true, "realized", &err);
> >      if (err) {
> > @@ -534,6 +556,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass
> > *oc, void *data)
> >      sc->silicon_rev  = AST2600_A0_SILICON_REV;
> >      sc->sram_size    = 0x10000;
> >      sc->spis_num     = 2;
> > +    sc->ehcis_num    = 2;
> >
> 
> Since this field is only set once here, does it need to be part of the
> class state?
> 

The same applies to spis_num, wdts_num, and macs_num.
AspeedSoCClass is defined for all ast2X00 SoCs, and
the same mechanism is used for all of them. I don't see
the benefit of deviating from a common mechanism.

Guenter

