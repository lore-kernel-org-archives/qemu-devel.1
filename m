Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FC4C33CB3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:08:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6472082F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uaZvqR+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6472082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isW30-00074n-H4
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 13:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1isW2O-0006Z3-CP
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1isW2M-0007q2-4B
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:08:04 -0500
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:46300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1isW2J-0007nb-KV; Fri, 17 Jan 2020 13:07:59 -0500
Received: by mail-yw1-xc42.google.com with SMTP id u139so14712023ywf.13;
 Fri, 17 Jan 2020 10:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=CfeBZOkNIBLGSMR8OHwXQk7PTiY5DFAYi3DjYR6eC7A=;
 b=uaZvqR+eJM5QowpNg6OarrPr2G/b3xOc62Jo1Ih8h+2GPBEtY0Cf64FdBNMmS3PWro
 lxiNrqCw6AHzteeLoJN8UIDnyBge7IZIBG1t2KGAWsU3EJT3cXL7S9TOdsI/y3oQEwke
 /LACkYBf2S6nAkEoAzrQW23zfEjluyQNNIJYF84HXKk7PH7hQw/+JqkhxbqmUmG6ZQXo
 AJ+38l+yNnaQvIs+IK4xpGZ+c6gksTl363auLh+5N683PuHoHtC82e+DY8FQ1HNUYzl3
 KVeZM+Rj8yrO5dXQF1WhkscE0RwUHzwlsF0adUEOqDVzyMlm9rmyIYSbWdjYTJU9FTOt
 GFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=CfeBZOkNIBLGSMR8OHwXQk7PTiY5DFAYi3DjYR6eC7A=;
 b=PjEurm5BsWRWfGa1eLMGrIYcfopQaQqcIwNsrlk+VAlcZ+l6o+kyqlNWmA3hyKNqrs
 QMAw9+PeuCLIpQHYWvnOnHgBNowrh8wsTwzONQBrDbFiAPj/acet5iW1upVu7NhNL84S
 Curcagf16hKd4j0iXNkkzk9OYPoCgXkgoaPXHoz1tKs3NZdF5aX92m/XqF5PTDp3pLR6
 irtNMA4ROh/GalshUULSKBf/g7Rb4VXSktnsjH9/x5dwSewx3GrPdR4aoqPLN2C93V0o
 n0xVi30bqenXin7AK5ggttbQ2BARKVQaEx2nEwsDaq/0Qwl1ZsFdypByn28xTdHzixWP
 XOig==
X-Gm-Message-State: APjAAAXfPgq54JpN8OJKMSSQ0EWeU5U2RVahv6uB4lRscy+O/YmZLP/m
 NMtGyOI2jUFgjbAELffhSjI=
X-Google-Smtp-Source: APXvYqxcSDRXrH0+/7HtE4vy6Xxg8kTNKa+pgIM+8bcoIdUOJg1N1LyoW+J214kPXjjEa40vjwh5fg==
X-Received: by 2002:a81:a08a:: with SMTP id
 x132mr29444217ywg.430.1579284478881; 
 Fri, 17 Jan 2020 10:07:58 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id y9sm11148113ywc.19.2020.01.17.10.07.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 Jan 2020 10:07:58 -0800 (PST)
Date: Fri, 17 Jan 2020 10:07:56 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/6] hw/arm/exynos4210: Fix DMA initialization
Message-ID: <20200117180756.GA13396@roeck-us.net>
References: <20200110203942.5745-1-linux@roeck-us.net>
 <20200110203942.5745-3-linux@roeck-us.net>
 <CAFEAcA_CeenDy9cNpQi6YpnT5rV+V10+EwYh=-zJEtjaT_gdDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_CeenDy9cNpQi6YpnT5rV+V10+EwYh=-zJEtjaT_gdDA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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

Hi Peter,

On Fri, Jan 17, 2020 at 01:30:19PM +0000, Peter Maydell wrote:
> On Fri, 10 Jan 2020 at 20:39, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > First parameter to exynos4210_get_irq() is not the SPI port number,
> > but the interrupt group number. Interrupt groups are 20 for mdma
> > and 21 for pdma. Interrupts are not inverted. Controllers support 32
> > events (pdma) or 31 events (mdma). Events must all be routed to a single
> > interrupt line. Set other parameters as documented in Exynos4210 datasheet,
> > section 8 (DMA controller).
> >
> > Fixes: 59520dc65e ("hw/arm/exynos4210: Add DMA support for the Exynos4210")
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  hw/arm/exynos4210.c | 24 +++++++++++++++++++-----
> >  1 file changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
> > index 77fbe1baab..c7b5c587b1 100644
> > --- a/hw/arm/exynos4210.c
> > +++ b/hw/arm/exynos4210.c
> > @@ -166,17 +166,31 @@ static uint64_t exynos4210_calc_affinity(int cpu)
> >      return (0x9 << ARM_AFF1_SHIFT) | cpu;
> >  }
> >
> > -static void pl330_create(uint32_t base, qemu_irq irq, int nreq)
> > +static void pl330_create(uint32_t base, qemu_irq irq, int nreq, int nevents,
> > +                         int width)
> >  {
> >      SysBusDevice *busdev;
> >      DeviceState *dev;
> > +    int i;
> >
> >      dev = qdev_create(NULL, "pl330");
> > +    qdev_prop_set_uint8(dev, "num_events", nevents);
> > +    qdev_prop_set_uint8(dev, "num_chnls",  8);
> >      qdev_prop_set_uint8(dev, "num_periph_req",  nreq);
> > +
> > +    qdev_prop_set_uint8(dev, "wr_cap", 4);
> > +    qdev_prop_set_uint8(dev, "wr_q_dep", 8);
> > +    qdev_prop_set_uint8(dev, "rd_cap", 4);
> > +    qdev_prop_set_uint8(dev, "rd_q_dep", 8);
> > +    qdev_prop_set_uint8(dev, "data_width", width);
> > +    qdev_prop_set_uint16(dev, "data_buffer_dep", width);
> >      qdev_init_nofail(dev);
> >      busdev = SYS_BUS_DEVICE(dev);
> >      sysbus_mmio_map(busdev, 0, base);
> > -    sysbus_connect_irq(busdev, 0, irq);
> > +    sysbus_connect_irq(busdev, 0, irq);         /* abort irq line */
> > +    for (i = 0; i < nevents; i++) {
> > +        sysbus_connect_irq(busdev, i + 1, irq); /* event irq lines */
> > +    }
> 
> It isn't valid to connect multiple qemu_irq outputs to a single
> input like this. If the hardware logically ORs the irq lines
> together then you need to instantiate and wire up a TYPE_OR_IRQ
> device (include/hw/or-irq.h) to do that. Unfortunately QEMU
> doesn't catch accidental wiring of a qemu_irq to multiple
> inputs, and it will even sort-of seem to work: the bug is that
> if two inputs go high, and then one goes low, the destination
> will get a "signal went low" call even though the first input
> should still be holding the line high.
> 
Makes sense. Unfortunately, it isn't easy for the non-initiated to
figure out how to wire this up. There are several examples, all
do it differently, and I am having difficulties understanding it.
I'll try to do it, but it may take a while.

Thanks,
Guenter

