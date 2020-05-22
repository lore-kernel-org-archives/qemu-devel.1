Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA5AC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 09:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BACB206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 09:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dbxEoQ1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BACB206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc41e-0006Iy-UJ
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 05:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc40p-0005RH-Nn
 for qemu-devel@nongnu.org; Fri, 22 May 2020 05:30:43 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc40n-0004f9-Dc
 for qemu-devel@nongnu.org; Fri, 22 May 2020 05:30:43 -0400
Received: by mail-ot1-x342.google.com with SMTP id d7so7751556ote.6
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 02:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nF0Zz2tYNcVFNJ5PUvWvL3lB/NQEzfmuqjlJ2RrZJTk=;
 b=dbxEoQ1MOgfk7i7ZyFjY/8t5tRCEHqnQcoCHd+aUie+5NIUA3x2osIfPWeg0/ybS9j
 BR32ym2906FD9OLdjCTDeucsprFeedFkJjZmeWqLAJ7umNYB1c/nOS2wDOrF0WbMjtRN
 LUUccD6Z8zLCNUvIaDSSX1jb7bbdzbRKYOLICJn0W3ieK6wYvfE8+h0wIu4EtufJudqG
 n+FvG1dXrd3K+9rS28/I+66hZgkpVul98WeXy1iGaECaZHzRBN8nXwR6H8YS9+0mD8a9
 IJ/o1ecRnSC3nwVGa0Ph+t1dq33keluxCxmRpfq7eiReSwXluN12ApIKXNqr1MSR1vDa
 VzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nF0Zz2tYNcVFNJ5PUvWvL3lB/NQEzfmuqjlJ2RrZJTk=;
 b=cuNNBpCzPnBdENg1/5N+86jVE45xDNY0U8nnffQkuff2bwBAIP0g60qwZmohaNlRjX
 Ve7C68kPhZ5L6pcdth3rJwvMsyAzMHhtE9rEisJ0pk2qeElXxTKvMycxTWGg6nRnWCnl
 6FsB4s4/FcfwmQFLXrnu3pCV5iTYe5KxJU9w4cTMlnuR9rWCpGxBoubQQgOl/zOmBbmT
 R+AyWG7ePKkStfCBqgfKCY8vrKvR+XZ6AtYZ8Kgu+In4dXe7YjuOnqo+cC9NdToUxKY+
 6IMcpF9/7aDfnKor1w6skWhNZskQEkaiMB4P2GObr8FKQh7siTJCTEFK5l8XhFywtMjk
 nqMg==
X-Gm-Message-State: AOAM531ZHnlRUBHkJ2bGW7+U8Cc4ZrfqoNJdZISVF8YL2CovnmRfSPZV
 pK/JJXjGwRVyYr6tVlcnvbZw7RFbuGu76LvSt2iwaw==
X-Google-Smtp-Source: ABdhPJwxxN6kKQFZyaYu8ps7BrOEnJrssdH3r8tcrPGeNQ0V9H5Qjk72tc7d64DEb3ecZ2H/hmbAH8eTz/P6SiJBBgQ=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr9746842oth.221.1590139839986;
 Fri, 22 May 2020 02:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200519084904.1069-1-geert+renesas@glider.be>
 <CAFEAcA9-wQ72_M+ZY+EbEgw1L9LVchBgpLivexFXVZ3HuCtcZg@mail.gmail.com>
 <CAMuHMdWrTbWTrLvMnX=60F+UqH6DJ9kDU1FZ5TnT2=mbah1yfg@mail.gmail.com>
In-Reply-To: <CAMuHMdWrTbWTrLvMnX=60F+UqH6DJ9kDU1FZ5TnT2=mbah1yfg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 May 2020 10:30:28 +0100
Message-ID: <CAFEAcA9TzPcWWiJNTQ=EZzsSVy5qTPz5DXTePGmXWBTxZg7i7w@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: Fix PL061 node name and properties
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 22 May 2020 at 09:29, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Peter,
>
> On Thu, May 21, 2020 at 6:59 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> > On Tue, 19 May 2020 at 09:49, Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > Make the created node comply with the PL061 Device Tree bindings:
> > >   - Use generic node name "gpio" instead of "pl061",
> > >   - Add missing "#interrupt-cells" and "interrupt-controller"
> > >     properties.
> >
> > Where have these properties come from? They must be optional,
> > because in the version of the binding documentation from Linux
> > 5.0 they're not described:
> > https://elixir.bootlin.com/linux/v5.0/source/Documentation/devicetree/bindings/gpio/pl061-gpio.txt
>
> Many old DT bindings are incomplete.

Yeah, but production QEMU is out there in the world based on
the old DT binding documentation. So you can't unilaterally
make a part of the binding that wasn't documented and that QEMU
didn't emit mandatory. It might be preferable for new QEMU to
emit it, of course.

> When running the validation on a device tree passed to the guest
> (extracted from /sys/firmware/devicetree/base, converted to dts, and
>  manually fixed up the phandles), the following is reported about the
> pl061 node:
>
>     virt.dt.yaml: pl061@9030000: {'reg': [[0, 151191552, 0, 4096]],
> 'gpio-controller': True, 'phandle': [[32771]], '#gpio-cells': [[2]],
> 'clocks': [[32768]], '#interrupt-cells': [[2]], 'compatible':
> ['arm,pl061', 'arm,primecell'], 'clock-names': ['apb_pclk'],
> '$nodename': ['pl061@9030000']} is not valid under any of the given
> schemas
>     [...]
>             virt.dt.yaml: pl061@9030000: 'interrupts' is a required property
>
>     virt.dt.yaml: pl061@9030000: $nodename:0: 'pl061@9030000' does not
> match '^gpio@[0-9a-f]+$'
>     virt.dt.yaml: pl061@9030000: 'interrupt-controller' is a required property

This is just saying "the yaml says these things are mandatory".
You could equally get rid of them by marking them optional in
the yaml, right?

Also, complaining about the nodename seems like a bug in the
validation: it is not a mandatory part of the spec, just a
recommendation.

> > Since the devicetree spec says that the interrupt-controller
> > property "defines a node as an interrupt controller node"
> > and a GPIO chip isn't an interrupt controller, this seems
> > like some kind of error in the dtb binding. Maybe I'm
> > missing something...
>
> PL061 is an interrupt controller, as it can assert its interrupt output
> based on activity on GPIO input lines.

By that logic the PL011 UART is an interrupt controller, because
it can assert its interrupt output based on activity on the serial
port input lines.

A GPIO controller is not an interrupt controller inherently.
Maybe you can use it in a system design as an interrupt
controller if you want to, and in that system's dtb perhaps
it would make sense to label it as one, but the virt board's
PL061 is in no way an interrupt controller -- it's just a GPIO
controller.

> > What actually goes wrong if QEMU doesn't specify these
> > properties?
>
> It means that other devices that have their interrupt output connected
> to a PL061 GPIO input won't work, as their driver in the guest OS cannot
> find the interrupt.  Note that arm/virt.c currently doesn't instantiate
> such devices.

OK. But why would we want to run an interrupt line through the GPIO
controller when we have a perfectly good interrupt controller in
the system already?

It might be reasonable to add the properties now to avoid setting
a bear trap for ourselves in future; on the other hand if running
interrupt lines through the GPIO controller doesn't work then it
acts as a nudge to stop people adding devices that are wired
up in a weird way.

> > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > index 7dc96abf72cf2b9a..99593d7bce4d85cb 100644
> > > --- a/hw/arm/virt.c
> > > +++ b/hw/arm/virt.c
> > > @@ -818,13 +818,15 @@ static void create_gpio(const VirtMachineState *vms)
> > >                                       qdev_get_gpio_in(vms->gic, irq));
> > >
> > >      uint32_t phandle = qemu_fdt_alloc_phandle(vms->fdt);
> > > -    nodename = g_strdup_printf("/pl061@%" PRIx64, base);
> > > +    nodename = g_strdup_printf("/gpio@%" PRIx64, base);
> >
> > Does the devicetree binding really mandate what the node name is?
> > I thought that finding the right device was doe via the
> > 'compatible' string and the nodename could be whatever the
> > device tree creator wanted.
>
> Matching is indeed done based on compatible value.

OK, then we don't need to change the node name here. Lots
of the other devices on the virt board have node names that
happen to use the device name rather than being more generic.

thanks
-- PMM

