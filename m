Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7860BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 08:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B33207FB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 08:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B33207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc33x-0006uz-Bx
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 04:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1jc33Q-0005az-3A; Fri, 22 May 2020 04:29:20 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1jc33O-0002Ae-Qh; Fri, 22 May 2020 04:29:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id i22so8614135oik.10;
 Fri, 22 May 2020 01:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UiNrG7HGs3W8q6IqBr6PtGoNoWHovdYvwbjl0qlZS1Q=;
 b=C+fB54CZFWMlTdLLGTGlvRVKeSELuLZBIieaLlcnyBsTLvxfkUskrw4MXp1JNGbRsY
 0HvU47fw0Ev/SxNSYcXnC33TSYWnFlCIyCuB1BKTBw8c2DuCrL2/NLS+v7+khncmIIF4
 I4sYHqaLHxQYVeTAuwN8fVYD5KH0OnxN7XLhBdKw+8lTX7y3ocA9GLK/GYZPV23hVF8V
 ruvzaLq0yxz411qau5vYishBn95ntaTzdgkzG2+/BUfjJxcs2lEaAfxH8TuZGBzlbX0k
 SR+WK25c4JWbmFRZarlb8w5MOQ4fiqDnJpE9t7JsnCr3kZR8eVTLd8MTPFf6oC9tohEx
 /n+Q==
X-Gm-Message-State: AOAM530SVZ0MvGTVX3cQG2qlwCz6c897qBAZbTCH4Ggn5R9YKM9mWzDm
 Bgh5RWp7c4uUUILbxGozbVFZLeDE7fEhR2g6C2s=
X-Google-Smtp-Source: ABdhPJzG75so/NQ3+73MyVsVpT1ajB9revzQysbgIDJI98eOYaoNl9+JGYtQ5zUmPUhB1kh6myqOLRvnKw5GNuPt7JU=
X-Received: by 2002:aca:cd93:: with SMTP id d141mr1715139oig.148.1590136156801; 
 Fri, 22 May 2020 01:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200519084904.1069-1-geert+renesas@glider.be>
 <CAFEAcA9-wQ72_M+ZY+EbEgw1L9LVchBgpLivexFXVZ3HuCtcZg@mail.gmail.com>
In-Reply-To: <CAFEAcA9-wQ72_M+ZY+EbEgw1L9LVchBgpLivexFXVZ3HuCtcZg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 May 2020 10:29:05 +0200
Message-ID: <CAMuHMdWrTbWTrLvMnX=60F+UqH6DJ9kDU1FZ5TnT2=mbah1yfg@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: Fix PL061 node name and properties
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.167.194;
 envelope-from=geert.uytterhoeven@gmail.com; helo=mail-oi1-f194.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 04:29:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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

Hi Peter,

On Thu, May 21, 2020 at 6:59 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> On Tue, 19 May 2020 at 09:49, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Make the created node comply with the PL061 Device Tree bindings:
> >   - Use generic node name "gpio" instead of "pl061",
> >   - Add missing "#interrupt-cells" and "interrupt-controller"
> >     properties.
>
> Where have these properties come from? They must be optional,
> because in the version of the binding documentation from Linux
> 5.0 they're not described:
> https://elixir.bootlin.com/linux/v5.0/source/Documentation/devicetree/bindings/gpio/pl061-gpio.txt

Many old DT bindings are incomplete.

> They seem to have magically appeared in kernel commit
> 910f38bed9439e765f7e, which purports to only be a change
> of format from plain text to yaml but has added some
> extra properties and claimed them to be mandatory.

The main motivation behind the conversion from plain text to yaml is to
do automatic validation of DTS files, based on the bindings.  During the
conversion process, many issues are detected, and fixed; not only in the
DTS files, but also in the bindings (e.g. missing properties, like in
this case).

When running the validation on a device tree passed to the guest
(extracted from /sys/firmware/devicetree/base, converted to dts, and
 manually fixed up the phandles), the following is reported about the
pl061 node:

    virt.dt.yaml: pl061@9030000: {'reg': [[0, 151191552, 0, 4096]],
'gpio-controller': True, 'phandle': [[32771]], '#gpio-cells': [[2]],
'clocks': [[32768]], '#interrupt-cells': [[2]], 'compatible':
['arm,pl061', 'arm,primecell'], 'clock-names': ['apb_pclk'],
'$nodename': ['pl061@9030000']} is not valid under any of the given
schemas
    [...]
            virt.dt.yaml: pl061@9030000: 'interrupts' is a required property

    virt.dt.yaml: pl061@9030000: $nodename:0: 'pl061@9030000' does not
match '^gpio@[0-9a-f]+$'
    virt.dt.yaml: pl061@9030000: 'interrupt-controller' is a required property

> Since the devicetree spec says that the interrupt-controller
> property "defines a node as an interrupt controller node"
> and a GPIO chip isn't an interrupt controller, this seems
> like some kind of error in the dtb binding. Maybe I'm
> missing something...

PL061 is an interrupt controller, as it can assert its interrupt output
based on activity on GPIO input lines.

> What actually goes wrong if QEMU doesn't specify these
> properties?

It means that other devices that have their interrupt output connected
to a PL061 GPIO input won't work, as their driver in the guest OS cannot
find the interrupt.  Note that arm/virt.c currently doesn't instantiate
such devices.

> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 7dc96abf72cf2b9a..99593d7bce4d85cb 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -818,13 +818,15 @@ static void create_gpio(const VirtMachineState *vms)
> >                                       qdev_get_gpio_in(vms->gic, irq));
> >
> >      uint32_t phandle = qemu_fdt_alloc_phandle(vms->fdt);
> > -    nodename = g_strdup_printf("/pl061@%" PRIx64, base);
> > +    nodename = g_strdup_printf("/gpio@%" PRIx64, base);
>
> Does the devicetree binding really mandate what the node name is?
> I thought that finding the right device was doe via the
> 'compatible' string and the nodename could be whatever the
> device tree creator wanted.

Matching is indeed done based on compatible value.

For node names, please see
https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3

   "2.2.2 Generic Names Recommendation

    The name of a node should be somewhat generic, reflecting the
    function of the device and not its precise programming model. If
    appropriate, the name should be one of the following choices:

    [...]

    - gpio

    [...]"

While many new generic names have been added recently, "gpio" was
already documented in the Power.orgTM Standard for Embedded Power
ArchitectureTM Platform Requirements (ePAPR).

I hope the above explains the rationale behind these change better.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

