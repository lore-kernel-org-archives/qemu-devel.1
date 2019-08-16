Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900A0C3A589
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 01:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520AF2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 01:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6f9DP0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520AF2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyQro-0001Kq-B0
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 21:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rashmica.g@gmail.com>) id 1hyQql-0000jl-FB
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 21:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rashmica.g@gmail.com>) id 1hyQqk-0006QE-BX
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 21:16:15 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40008)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rashmica.g@gmail.com>)
 id 1hyQqh-0006N5-De; Thu, 15 Aug 2019 21:16:11 -0400
Received: by mail-pg1-x544.google.com with SMTP id w10so2090282pgj.7;
 Thu, 15 Aug 2019 18:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=G44lGmpWIhp5NRRDjzvhTsMhKROnWAORyvlVRk65qKk=;
 b=P6f9DP0kjYufEVkdxgzWUZpsJK9rHhmLenjEG9ha/uc0eXbz23SPd1VeGHKLwd5mRM
 Fw6oJY9zPZl6dOX3SKvBLglTL55doQkGTEWMYTd5W9kP9SMCwCryIa5IgaiX4m6uxRuy
 PdY1+KCmM88W4IfwmF8Evr9qcSwUlFOGEWtDc2Q6lG+fC+zMaJYpAVuU7+7CUQKtoj39
 Zfv0Juxx/+hWvdFt0dTLOtcdxLCDV5wAQzOYzZl/fcwJz33+tyn9NKSLKk0rYyX7MZnc
 QPufYlN2cwVbostDE3XiocOJmkN4NGwX0rPnhN+qJuXFYSvtrMfz16mc53ni7NsIh1sy
 B1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=G44lGmpWIhp5NRRDjzvhTsMhKROnWAORyvlVRk65qKk=;
 b=eNCQ95yUvHFXPpV6VYxLFNcM5066ge5A9ZcJ9iNh6X1I7C/zdKJQS5YW8b96RU+l2g
 xWL5ngyKABr8B041fcqEXcm3CGdDz6H6WthB0M/aeQGWWZQ9jJwoduqjviv/GK4A6f6L
 gb9Me7CUdlc7M2iB1+aL3kaey23ga5cAZWVIRL2FpM+jnGFrg683+StOj9uZ2ZImWA01
 /XSuqo9bT8MAI1VtNX9oAGxLpvZMW24nYhTmoODGyImk77XpVuYBTsdZkYg7hzhD+YWp
 3mDdezBUEsXvLMQ8J8h6XhJro+2LpdaEsi1w8IBaVcU2Qhqec/iqWJTcOoucYgZ7Gts8
 V+zQ==
X-Gm-Message-State: APjAAAWk74LT4e6LoGNrvSPx2M+iRFvap0/IqPid/LVQBauZWR3L8xoZ
 vXMwmJ5C5G81o7k7IoAfOns=
X-Google-Smtp-Source: APXvYqzOwAsK0tOM8Rg2mz4bHgXqxaBWJA+p6IGioSXtAeTidns4CLlob51A1USSZxdW6zIQGArs4Q==
X-Received: by 2002:a17:90a:b104:: with SMTP id
 z4mr4791446pjq.120.1565918169739; 
 Thu, 15 Aug 2019 18:16:09 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id z24sm4929435pfr.51.2019.08.15.18.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2019 18:16:09 -0700 (PDT)
Message-ID: <186994ccaaaa1c07015426ef2cc84bcefb411b09.camel@gmail.com>
From: Rashmica Gupta <rashmica.g@gmail.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, 
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Date: Fri, 16 Aug 2019 11:16:04 +1000
In-Reply-To: <88221198-9699-6ec4-14f7-ee3c375a57e4@kaod.org>
References: <20190814071433.22243-1-rashmica.g@gmail.com>
 <20190814071433.22243-4-rashmica.g@gmail.com>
 <88221198-9699-6ec4-14f7-ee3c375a57e4@kaod.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v4 3/3] hw/gpio: Add in AST2600 specific
 implementation
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
Cc: andrew@aj.id.au, aik@ozlabs.ru, qemu-devel@nongnu.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-08-14 at 14:37 +0200, Cédric Le Goater wrote:
> On 14/08/2019 09:14, Rashmica Gupta wrote:

...

> > +static void aspeed_2600_gpio_realize(DeviceState *dev, Error
> > **errp)
> > +{
> > +    AspeedGPIOState *s = ASPEED_GPIO(dev);
> > +    AspeedGPIOState *s_1_8, *s_3_6;
> > +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> > +    AspeedGPIOClass *agc, *agc2;
> > +    int pin;
> > +    void *obj;
> > +
> > +    /* Create and setup the 1.8V gpio state/class */
> > +    obj = object_new(TYPE_ASPEED_GPIO "-ast2600");
> > +    s_1_8 = ASPEED_GPIO(obj);
> > +    object_property_add_child(OBJECT(dev), TYPE_ASPEED_GPIO "-
> > ast2600-1.8v",
> > +                              obj, errp);
> > +    if (error_abort) {
> > +        error_propagate(errp, error_abort);
> > +    }
> 
> This looks wrong. 
> 
> Shouldn't we instantiate 2 GPIOs devices under the AST2600 SoC with
> different
> types ? 
> 

We were trying to keep one GPIO device with two states, one state for
3.6V gpios and one for the 1.8V gpios. As you can see I couldn't find
a nice way to do that. I'll have a go at just making two seperate
devices.


> C.
> 
> 
> > +    agc = ASPEED_GPIO_GET_CLASS(s_1_8);
> > +    agc->ctrl = (void *)&aspeed_gpio_ast2600_1_8v_controller;
> > +    aspeed_gpio_init(obj);
> > +
> > +    /* Create and setup the 3.6V gpio state/class */
> > +    obj = object_new(TYPE_ASPEED_GPIO "-ast2600");
> > +    s_3_6 = ASPEED_GPIO(obj);
> > +    object_property_add_child(OBJECT(dev), TYPE_ASPEED_GPIO "-
> > ast2600-3.6v",
> > +                              obj, errp);
> > +    if (error_abort) {
> > +        error_propagate(errp, error_abort);
> > +    }
> > +    agc2 = ASPEED_GPIO_GET_CLASS(s_3_6);
> > +    agc2->ctrl = (void *)&aspeed_gpio_ast2600_3_6v_controller;
> > +    aspeed_gpio_init(obj);
> > +
> > +    for (pin = 0; pin < agc->ctrl->nr_gpio_pins; pin++) {
> > +        sysbus_init_irq(sbd, &s->gpios[pin]);
> > +    }
> > +
> > +    memory_region_init_io(&s_3_6->iomem, OBJECT(s_3_6),
> > &aspeed_gpio_ops, s_3_6,
> > +            TYPE_ASPEED_GPIO, GPIO_3_6V_MEM_SIZE +
> > GPIO_1_8V_MEM_SIZE);
> > +    s_3_6->lookup = aspeed_3_6v_gpios;
> > +
> > +    memory_region_init_io(&s_1_8->iomem, OBJECT(s_1_8),
> > &aspeed_gpio_ops, s_1_8,
> > +            TYPE_ASPEED_GPIO, GPIO_1_8V_MEM_SIZE);
> > +    memory_region_add_subregion(&s_3_6->iomem,
> > GPIO_1_8V_REG_OFFSET,
> > +                                &s_1_8->iomem);
> > +    s_1_8->lookup = aspeed_1_8v_gpios;
> > +
> > +    sysbus_init_mmio(sbd, &s_3_6->iomem);
> > +    sysbus_init_mmio(sbd, &s_1_8->iomem);
> > +}
> > +
> >  static const VMStateDescription vmstate_gpio_regs = {
> >      .name = TYPE_ASPEED_GPIO"/regs",
> >      .version_id = 1,
> > @@ -830,6 +991,16 @@ static const VMStateDescription
> > vmstate_aspeed_gpio = {
> >     }
> >  };
> >  
> > +static void aspeed_gpio_ast2600_class_init(ObjectClass *klass,
> > void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +
> > +    dc->realize = aspeed_2600_gpio_realize;
> > +    dc->reset = aspeed_gpio_reset;
> > +    dc->desc = "Aspeed GPIO Controller";
> > +    dc->vmsd = &vmstate_aspeed_gpio;
> > +}
> > +
> >  static void aspeed_gpio_class_init(ObjectClass *klass, void *data)
> >  {
> >      DeviceClass *dc = DEVICE_CLASS(klass);
> > @@ -866,11 +1037,18 @@ static const TypeInfo
> > aspeed_gpio_ast2500_info = {
> >      .class_data     = (void *)&aspeed_gpio_ast2500_controller,
> >  };
> >  
> > +static const TypeInfo aspeed_gpio_ast2600_info = {
> > +    .name           = TYPE_ASPEED_GPIO "-ast2600",
> > +    .parent         = TYPE_ASPEED_GPIO,
> > +    .class_init     = aspeed_gpio_ast2600_class_init,
> > +};
> > +
> >  static void aspeed_gpio_register_types(void)
> >  {
> >      type_register_static(&aspeed_gpio_info);
> >      type_register_static(&aspeed_gpio_ast2400_info);
> >      type_register_static(&aspeed_gpio_ast2500_info);
> > +    type_register_static(&aspeed_gpio_ast2600_info);
> >  }
> >  
> >  type_init(aspeed_gpio_register_types);
> > diff --git a/slirp b/slirp
> > index f0da672620..126c04acba 160000
> > --- a/slirp
> > +++ b/slirp
> > @@ -1 +1 @@
> > -Subproject commit f0da6726207b740f6101028b2992f918477a4b08
> > +Subproject commit 126c04acbabd7ad32c2b018fe10dfac2a3bc1210
> > 


