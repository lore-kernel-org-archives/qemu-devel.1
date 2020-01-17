Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB9BC33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC0520728
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KG65b7+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC0520728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isWSz-0000nA-A4
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 13:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isWS9-0008MJ-IP
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isWS7-00053U-R1
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:34:41 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isWS7-00052c-Ky
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:34:39 -0500
Received: by mail-ot1-x342.google.com with SMTP id z9so21243822oth.5
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 10:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cu8LmZtO09JhDsRRE9XVFe5anQPJkJMUXiHosXnVzec=;
 b=KG65b7+A8E7vck5ST8q0ovt/AFR9y4uye172HzRrhYK/WrO+LDuWkcFZ6fTi6q/G6T
 KScQwX1LF86P4z6MqWThcOUBj8L8NDOx6VtVUbw9TtP992ZIsWkLPDzbKKn7W7A9qV5o
 DCOdXrX+pmpU767DSpl5lpO8RWqeI059ymEPg0oG5HOsoruTpWr8TesUk7t4gmkU6WS0
 kg3j0MBGjJ36HOrYwnOwfaXODyOKUn9Uv1cTh0VYxenzsmjzMv3Pg4ku0AROSLEKNjXx
 UX4N92aPKi8Ic9qR8GIZkTGeapu9/D5cxs8AnvxWll+0UY23BkuprzaO9bzTko8py9YZ
 btSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cu8LmZtO09JhDsRRE9XVFe5anQPJkJMUXiHosXnVzec=;
 b=iFLd6WNM8oKOoOIU69j3fQleU1868HN7hE5d9eUzjA0BKEWHo2HTcU7I2R50tbttd0
 A0xX0suikXMBfx0jODxJKRcRxCZ4qIkmd76pQvIw6yFcwVhZjDcmBNlaPDAmBijoMBEk
 D1BexUCHuQqu/XmBAs96RP3I/A4lKHc+lIbDk+oyCDy/6nsFrzOmU2AfAi4KGYHOoWQb
 WWuQbynM9JV6c80BBYXKJJ5ELLOZOgipzpuc3qXz9CYLY6lsKywh81PrrQnj6LWpuvZi
 Ve8NNHRTAiJpReGqchHGn3la7oMrG2AtZrzz92j6SpKbWKJTHIjXLgBtFdZucPEmNHBx
 yGXA==
X-Gm-Message-State: APjAAAU/W0ea4ZYn8o/aHBdy6jTVkwpVG0B3rk4/Q7zYMViYreOEy/Fc
 jA8g+6IRMLdwDFVXiUio0QgCIU7BqL9CjaFlDK8s0g==
X-Google-Smtp-Source: APXvYqwerbvjZm0eCLFBA8j0X1YGEvPR1YU4hu55WLYUpybGjFlXNCFxlMrD5/kMp1KYj6Uulq1mJhDeu6/42Q4iHUk=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr7193676ota.232.1579286078589; 
 Fri, 17 Jan 2020 10:34:38 -0800 (PST)
MIME-Version: 1.0
References: <20200110203942.5745-1-linux@roeck-us.net>
 <20200110203942.5745-3-linux@roeck-us.net>
 <CAFEAcA_CeenDy9cNpQi6YpnT5rV+V10+EwYh=-zJEtjaT_gdDA@mail.gmail.com>
 <20200117180756.GA13396@roeck-us.net>
In-Reply-To: <20200117180756.GA13396@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 18:34:27 +0000
Message-ID: <CAFEAcA_27U7pOtTdmcWiT6wmWj2dNm2TZKKP2xV1nTp4j=bTDA@mail.gmail.com>
Subject: Re: [PATCH 2/6] hw/arm/exynos4210: Fix DMA initialization
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jan 2020 at 18:07, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi Peter,
>
> On Fri, Jan 17, 2020 at 01:30:19PM +0000, Peter Maydell wrote:
> > On Fri, 10 Jan 2020 at 20:39, Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > First parameter to exynos4210_get_irq() is not the SPI port number,
> > > but the interrupt group number. Interrupt groups are 20 for mdma
> > > and 21 for pdma. Interrupts are not inverted. Controllers support 32
> > > events (pdma) or 31 events (mdma). Events must all be routed to a single
> > > interrupt line. Set other parameters as documented in Exynos4210 datasheet,
> > > section 8 (DMA controller).
> > >
> > > Fixes: 59520dc65e ("hw/arm/exynos4210: Add DMA support for the Exynos4210")
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >  hw/arm/exynos4210.c | 24 +++++++++++++++++++-----
> > >  1 file changed, 19 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
> > > index 77fbe1baab..c7b5c587b1 100644
> > > --- a/hw/arm/exynos4210.c
> > > +++ b/hw/arm/exynos4210.c
> > > @@ -166,17 +166,31 @@ static uint64_t exynos4210_calc_affinity(int cpu)
> > >      return (0x9 << ARM_AFF1_SHIFT) | cpu;
> > >  }
> > >
> > > -static void pl330_create(uint32_t base, qemu_irq irq, int nreq)
> > > +static void pl330_create(uint32_t base, qemu_irq irq, int nreq, int nevents,
> > > +                         int width)
> > >  {
> > >      SysBusDevice *busdev;
> > >      DeviceState *dev;
> > > +    int i;
> > >
> > >      dev = qdev_create(NULL, "pl330");
> > > +    qdev_prop_set_uint8(dev, "num_events", nevents);
> > > +    qdev_prop_set_uint8(dev, "num_chnls",  8);
> > >      qdev_prop_set_uint8(dev, "num_periph_req",  nreq);
> > > +
> > > +    qdev_prop_set_uint8(dev, "wr_cap", 4);
> > > +    qdev_prop_set_uint8(dev, "wr_q_dep", 8);
> > > +    qdev_prop_set_uint8(dev, "rd_cap", 4);
> > > +    qdev_prop_set_uint8(dev, "rd_q_dep", 8);
> > > +    qdev_prop_set_uint8(dev, "data_width", width);
> > > +    qdev_prop_set_uint16(dev, "data_buffer_dep", width);
> > >      qdev_init_nofail(dev);
> > >      busdev = SYS_BUS_DEVICE(dev);
> > >      sysbus_mmio_map(busdev, 0, base);
> > > -    sysbus_connect_irq(busdev, 0, irq);
> > > +    sysbus_connect_irq(busdev, 0, irq);         /* abort irq line */
> > > +    for (i = 0; i < nevents; i++) {
> > > +        sysbus_connect_irq(busdev, i + 1, irq); /* event irq lines */
> > > +    }
> >
> > It isn't valid to connect multiple qemu_irq outputs to a single
> > input like this. If the hardware logically ORs the irq lines
> > together then you need to instantiate and wire up a TYPE_OR_IRQ
> > device (include/hw/or-irq.h) to do that. Unfortunately QEMU
> > doesn't catch accidental wiring of a qemu_irq to multiple
> > inputs, and it will even sort-of seem to work: the bug is that
> > if two inputs go high, and then one goes low, the destination
> > will get a "signal went low" call even though the first input
> > should still be holding the line high.
> >
> Makes sense. Unfortunately, it isn't easy for the non-initiated to
> figure out how to wire this up. There are several examples, all
> do it differently, and I am having difficulties understanding it.
> I'll try to do it, but it may take a while.

I'd suggest following how hw/arm/armsse.c does it. This is
assuming we need one OR gate for each PL330. Roughly:

 * #include "hw/or-irq.h" in include/hw/arm/exynos4210.h
 * new field in the Exynos4210State struct "qemu_or_irq
pl330_irq_orgate[NUM_PL330S];"
 * TYPE_EXYNOS4210_SOC will need an instance_init, so add
   ".instance_init = exynos4210_init," to the exynos4210_info definition
 * all the instance_init needs to do is call object_initialize_child()
   for each OR gate, something like:
      static void exynos4210_init(Object *obj)
      {
          Exynos4210State *s = EXYNOS4210_SOC(obj);
          int i;

          for (i = 0; i < ARRAY_SIZE(s->pl330_irq_orgate); i++) {
              char *name = g_strdup_printf("pl330-irq-orgate%d", i);
              qemu_or_irq *orgate = &s->pl330_irq_orgate[i];

              object_initialize_child(obj, name, orgate, sizeof(*orgate),
                                      TYPE_OR_IRQ, &error_abort, NULL);
              g_free(name);
          }
      }
  * in exynos4210_realize() you need another loop; the loop body
    should set the number of input lines and realize the object:
    object_property_set_int(OBJECT(&s->pl330_irq_orgate[i]),
                            num_lines,
                            "num-lines", &err);
    if (err) {
        error_propagate(errp, err);
        return;
    }
    object_property_set_bool(OBJECT(&s->pl330_irq_orgate[i]), true,
                             "realized", &err);
    if (err) {
        error_propagate(errp, err);
        return;
    }

    where num_lines is I think going to be 33, 33, and 2 (1 + the
    value of nevents for that pl330).
    It doesn't really matter exactly where in the realize function
    we do this as long as the realize of the or-gate happens
    before we wire it up. So you might want to have a single
    loop whose body does "set or-gate num_lines; realize or-gate;
    create pl330; wire up pl330".

  * finally, the "wiring up" part. a qemu_irq_orgate is just a
    qdev device with N inputs and one output. So in pl330_create()
    (assuming 'this_orgate' is a pointer to the right pl330_irq_orgate[n])
    you wire up each input with
       for (i = 0; i < nevents + 1; i++) {
             sysbus_connect_irq(busdev, i,
                 qdev_get_gpio_in(DEVICE(this_orgate), i));
       }
     (nb: unlike your patch here I've rolled the abort irq line into
     the loop with the event irqs because it's all the same code)
   And you wire up the output with
      qdev_connect_gpio_out(DEVICE(this_orgate), 0,
                            irq_the_output_goes_to);

PS: this is using what I think of as "modern style", where the
sub-objects of a device object are inline in the device struct,
and the container device's initialize initializes them and the
container device's realize realizes them. It is also possible to
use the TYPE_OR_IRQ in the more old-style way where you call
the qdev_create() function which allocates memory for the object
(as the Exynos code is currently doing for the PL330 objects,
for instance) and then qdev_init_nofail() to initialize/realize
it, but I think 'modern style' is where we should be going as we
write new code.

thanks
-- PMM

