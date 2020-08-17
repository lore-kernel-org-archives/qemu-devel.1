Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6989CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 19:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16CB120738
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 19:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSS4ZDvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CB120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7kVN-0002f5-BO
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 15:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1k7kUR-0001lQ-7x; Mon, 17 Aug 2020 15:08:15 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:36423)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1k7kUN-0000GO-OE; Mon, 17 Aug 2020 15:08:14 -0400
Received: by mail-il1-x144.google.com with SMTP id z3so15505838ilh.3;
 Mon, 17 Aug 2020 12:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UoQMYDjpm71W1CwHVO8b5sdhifFoNHHgZwlikhmlKgo=;
 b=CSS4ZDvgNcR+8sylxQiuCOLc5tpcgX6flNV32xeZ2jTDcdMZJqngLRH+bjv0YozXk7
 Qo1vSgUUQRxJkLj4Lzpx33Pg0PFJM7DMCQvVUDPYxAvHp4SjYKYI8MJOQPK6JzIC06+H
 CeQNgSqmqh/MapRA6WfnDtVNkQRLCDhOVXUBZQgRZOyuMjWrB+cJeDcpwnTe3YKst99a
 2bkgzuUIONL/eOizoyyOwWBBwr/euAiy99fwm7Uv+IsMPrzD7gkcp+DK/7VSgEr3aYMF
 oJnV7X0qy6NDAoGQczo6QBe0GTD+A3NJLKLmyZuwwli/PbkkaGTr+MJ2jfexQTzyZQrR
 n4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UoQMYDjpm71W1CwHVO8b5sdhifFoNHHgZwlikhmlKgo=;
 b=jkPT0hjNyZfpHmhomMSrs83LqROkSPIJo9ABzIvqbMyQ2Dm66o16TmsN3c2xIEJvL0
 VFOPLW8cmEOveSBVPHHawHXt2jsPZU7gUkqlKH7feHQBiA1xjiLUXoE7E2vE9UHKcVm8
 9fuo1Ra/++fWkPYG7LzcKzwpUkGe+zkBiKCxvvrFZUNLSFZvV6MtB6PmJXpkXzYUMnB9
 2bTgfK1S2hfEBZ6kL/mivO1fvsFECJO93FKuZr2wSxUF7qSW6ksEtMKKDqxD9wxQVM9o
 1s60HJrlLZE5+qE1CJSaUiBAM38MH9MVlWyE7BdFtJZKWPyKDfrCONYCDGpdFTzCNL3e
 2C3A==
X-Gm-Message-State: AOAM5303UF5ZZuZON7W2O5XjtruAiu5lO9oxrvbsjU5d501GnMKLLovK
 Cd02JHNvvTuTE9QBt7ATi9SDpKqQwW1DT3y6C/0=
X-Google-Smtp-Source: ABdhPJyc2ekhcXK/QqHxOGVqR3PTVslKztGgFv6lGgf41/PCy+jp0xJMSurA+99V1RWdqzYtPnnDskAXBJ+uuNZIe+E=
X-Received: by 2002:a92:8708:: with SMTP id m8mr15431969ild.19.1597691290079; 
 Mon, 17 Aug 2020 12:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-7-ehabkost@redhat.com>
 <6ff80e86-2499-f1af-787b-e22043756d7e@amsat.org>
In-Reply-To: <6ff80e86-2499-f1af-787b-e22043756d7e@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 17 Aug 2020 21:07:58 +0200
Message-ID: <CAPan3Wq94G7Nd6segi-JnrL6Zbkb-ygeykkL4zbvRv7rCQ8a2g@mail.gmail.com>
Subject: Re: [PATCH 06/41] allwinner-h3: Rename memmap enum constants
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000ce580e05ad177df0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ce580e05ad177df0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Interesting suggestion Philippe. I modelled the initial code of the H3 SoC
mostly in-line with the aspeed SoC,
to let it use commonly applied code structures where possible. And it looks
like in this series, aspeed_soc.h is also
getting the same change. I'll see if I can find some time to make a small
patch to move the enum to the local allwinner-h3.c file like you
suggested.

For Eduardo's work, I'm OK with a rename for now to AW_H3_DEV_*. I see it
is also done like that in aspeed_soc.h and similar files.
I do have one follow-up question: which value(s) from the enum are actually
in conflict? Could you add that in the commit message perhaps, for clarity?

With that answered:
  Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Regards,
Niek

On Fri, Aug 14, 2020 at 7:54 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> +Niek as maintainer.
>
> On 8/14/20 12:25 AM, Eduardo Habkost wrote:
> > Some of the enum constant names conflict with the QOM type check
> > macros.  This needs to be addressed to allow us to transform the
> > QOM type check macros into functions generated by
> > OBJECT_DECLARE_TYPE().
> >
> > Rename all the constants to AW_H3_DEV_*, to avoid conflicts.
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  include/hw/arm/allwinner-h3.h |  62 ++++++++---------
> >  hw/arm/allwinner-h3.c         | 124 +++++++++++++++++-----------------
> >  hw/arm/orangepi.c             |   6 +-
> >  3 files changed, 96 insertions(+), 96 deletions(-)
> >
> > diff --git a/include/hw/arm/allwinner-h3.h
> b/include/hw/arm/allwinner-h3.h
> > index 82e4e59216..626139dcb3 100644
> > --- a/include/hw/arm/allwinner-h3.h
> > +++ b/include/hw/arm/allwinner-h3.h
> > @@ -61,37 +61,37 @@
> >   * @see AwH3State
> >   */
> >  enum {
> > -    AW_H3_SRAM_A1,
> > -    AW_H3_SRAM_A2,
> > -    AW_H3_SRAM_C,
> > -    AW_H3_SYSCTRL,
> > -    AW_H3_MMC0,
> > -    AW_H3_SID,
> > -    AW_H3_EHCI0,
> > -    AW_H3_OHCI0,
> > -    AW_H3_EHCI1,
> > -    AW_H3_OHCI1,
> > -    AW_H3_EHCI2,
> > -    AW_H3_OHCI2,
> > -    AW_H3_EHCI3,
> > -    AW_H3_OHCI3,
> > -    AW_H3_CCU,
> > -    AW_H3_PIT,
> > -    AW_H3_UART0,
> > -    AW_H3_UART1,
> > -    AW_H3_UART2,
> > -    AW_H3_UART3,
> > -    AW_H3_EMAC,
> > -    AW_H3_DRAMCOM,
> > -    AW_H3_DRAMCTL,
> > -    AW_H3_DRAMPHY,
> > -    AW_H3_GIC_DIST,
> > -    AW_H3_GIC_CPU,
> > -    AW_H3_GIC_HYP,
> > -    AW_H3_GIC_VCPU,
> > -    AW_H3_RTC,
> > -    AW_H3_CPUCFG,
> > -    AW_H3_SDRAM
> > +    AW_H3_DEV_SRAM_A1,
> > +    AW_H3_DEV_SRAM_A2,
> > +    AW_H3_DEV_SRAM_C,
> > +    AW_H3_DEV_SYSCTRL,
>
> My 2 cents:
> These are not devices, but peripheral blocks or IP cores.
> Anyway, short change could be to name them E_AW_H3_xxx,
> but I don't understand why these are exposed. This enum
> should be locally declared in hw/arm/allwinner-h3.c,
> and the SoC might provide a get_sdram_base_address()
> method so the machine can access it.
>
> > +    AW_H3_DEV_MMC0,
> > +    AW_H3_DEV_SID,
> > +    AW_H3_DEV_EHCI0,
> > +    AW_H3_DEV_OHCI0,
> > +    AW_H3_DEV_EHCI1,
> > +    AW_H3_DEV_OHCI1,
> > +    AW_H3_DEV_EHCI2,
> > +    AW_H3_DEV_OHCI2,
> > +    AW_H3_DEV_EHCI3,
> > +    AW_H3_DEV_OHCI3,
> > +    AW_H3_DEV_CCU,
> > +    AW_H3_DEV_PIT,
> > +    AW_H3_DEV_UART0,
> > +    AW_H3_DEV_UART1,
> > +    AW_H3_DEV_UART2,
> > +    AW_H3_DEV_UART3,
> > +    AW_H3_DEV_EMAC,
> > +    AW_H3_DEV_DRAMCOM,
> > +    AW_H3_DEV_DRAMCTL,
> > +    AW_H3_DEV_DRAMPHY,
> > +    AW_H3_DEV_GIC_DIST,
> > +    AW_H3_DEV_GIC_CPU,
> > +    AW_H3_DEV_GIC_HYP,
> > +    AW_H3_DEV_GIC_VCPU,
> > +    AW_H3_DEV_RTC,
> > +    AW_H3_DEV_CPUCFG,
> > +    AW_H3_DEV_SDRAM
> >  };
> >
> >  /** Total number of CPU cores in the H3 SoC */
> > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> > index ff92ded82c..341abe6718 100644
> > --- a/hw/arm/allwinner-h3.c
> > +++ b/hw/arm/allwinner-h3.c
> > @@ -35,37 +35,37 @@
> >
> >  /* Memory map */
> >  const hwaddr allwinner_h3_memmap[] =3D {
> > -    [AW_H3_SRAM_A1]    =3D 0x00000000,
> > -    [AW_H3_SRAM_A2]    =3D 0x00044000,
> > -    [AW_H3_SRAM_C]     =3D 0x00010000,
> > -    [AW_H3_SYSCTRL]    =3D 0x01c00000,
> > -    [AW_H3_MMC0]       =3D 0x01c0f000,
> > -    [AW_H3_SID]        =3D 0x01c14000,
> > -    [AW_H3_EHCI0]      =3D 0x01c1a000,
> > -    [AW_H3_OHCI0]      =3D 0x01c1a400,
> > -    [AW_H3_EHCI1]      =3D 0x01c1b000,
> > -    [AW_H3_OHCI1]      =3D 0x01c1b400,
> > -    [AW_H3_EHCI2]      =3D 0x01c1c000,
> > -    [AW_H3_OHCI2]      =3D 0x01c1c400,
> > -    [AW_H3_EHCI3]      =3D 0x01c1d000,
> > -    [AW_H3_OHCI3]      =3D 0x01c1d400,
> > -    [AW_H3_CCU]        =3D 0x01c20000,
> > -    [AW_H3_PIT]        =3D 0x01c20c00,
> > -    [AW_H3_UART0]      =3D 0x01c28000,
> > -    [AW_H3_UART1]      =3D 0x01c28400,
> > -    [AW_H3_UART2]      =3D 0x01c28800,
> > -    [AW_H3_UART3]      =3D 0x01c28c00,
> > -    [AW_H3_EMAC]       =3D 0x01c30000,
> > -    [AW_H3_DRAMCOM]    =3D 0x01c62000,
> > -    [AW_H3_DRAMCTL]    =3D 0x01c63000,
> > -    [AW_H3_DRAMPHY]    =3D 0x01c65000,
> > -    [AW_H3_GIC_DIST]   =3D 0x01c81000,
> > -    [AW_H3_GIC_CPU]    =3D 0x01c82000,
> > -    [AW_H3_GIC_HYP]    =3D 0x01c84000,
> > -    [AW_H3_GIC_VCPU]   =3D 0x01c86000,
> > -    [AW_H3_RTC]        =3D 0x01f00000,
> > -    [AW_H3_CPUCFG]     =3D 0x01f01c00,
> > -    [AW_H3_SDRAM]      =3D 0x40000000
> > +    [AW_H3_DEV_SRAM_A1]    =3D 0x00000000,
> > +    [AW_H3_DEV_SRAM_A2]    =3D 0x00044000,
> > +    [AW_H3_DEV_SRAM_C]     =3D 0x00010000,
> > +    [AW_H3_DEV_SYSCTRL]    =3D 0x01c00000,
> > +    [AW_H3_DEV_MMC0]       =3D 0x01c0f000,
> > +    [AW_H3_DEV_SID]        =3D 0x01c14000,
> > +    [AW_H3_DEV_EHCI0]      =3D 0x01c1a000,
> > +    [AW_H3_DEV_OHCI0]      =3D 0x01c1a400,
> > +    [AW_H3_DEV_EHCI1]      =3D 0x01c1b000,
> > +    [AW_H3_DEV_OHCI1]      =3D 0x01c1b400,
> > +    [AW_H3_DEV_EHCI2]      =3D 0x01c1c000,
> > +    [AW_H3_DEV_OHCI2]      =3D 0x01c1c400,
> > +    [AW_H3_DEV_EHCI3]      =3D 0x01c1d000,
> > +    [AW_H3_DEV_OHCI3]      =3D 0x01c1d400,
> > +    [AW_H3_DEV_CCU]        =3D 0x01c20000,
> > +    [AW_H3_DEV_PIT]        =3D 0x01c20c00,
> > +    [AW_H3_DEV_UART0]      =3D 0x01c28000,
> > +    [AW_H3_DEV_UART1]      =3D 0x01c28400,
> > +    [AW_H3_DEV_UART2]      =3D 0x01c28800,
> > +    [AW_H3_DEV_UART3]      =3D 0x01c28c00,
> > +    [AW_H3_DEV_EMAC]       =3D 0x01c30000,
> > +    [AW_H3_DEV_DRAMCOM]    =3D 0x01c62000,
> > +    [AW_H3_DEV_DRAMCTL]    =3D 0x01c63000,
> > +    [AW_H3_DEV_DRAMPHY]    =3D 0x01c65000,
> > +    [AW_H3_DEV_GIC_DIST]   =3D 0x01c81000,
> > +    [AW_H3_DEV_GIC_CPU]    =3D 0x01c82000,
> > +    [AW_H3_DEV_GIC_HYP]    =3D 0x01c84000,
> > +    [AW_H3_DEV_GIC_VCPU]   =3D 0x01c86000,
> > +    [AW_H3_DEV_RTC]        =3D 0x01f00000,
> > +    [AW_H3_DEV_CPUCFG]     =3D 0x01f01c00,
> > +    [AW_H3_DEV_SDRAM]      =3D 0x40000000
> >  };
> >
> >  /* List of unimplemented devices */
> > @@ -183,7 +183,7 @@ void allwinner_h3_bootrom_setup(AwH3State *s,
> BlockBackend *blk)
> >      }
> >
> >      rom_add_blob("allwinner-h3.bootrom", buffer, rom_size,
> > -                  rom_size, s->memmap[AW_H3_SRAM_A1],
> > +                  rom_size, s->memmap[AW_H3_DEV_SRAM_A1],
> >                    NULL, NULL, NULL, NULL, false);
> >  }
> >
> > @@ -262,10 +262,10 @@ static void allwinner_h3_realize(DeviceState *dev=
,
> Error **errp)
> >      qdev_prop_set_bit(DEVICE(&s->gic), "has-virtualization-extensions"=
,
> true);
> >      sysbus_realize(SYS_BUS_DEVICE(&s->gic), &error_fatal);
> >
> > -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 0,
> s->memmap[AW_H3_GIC_DIST]);
> > -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1,
> s->memmap[AW_H3_GIC_CPU]);
> > -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 2,
> s->memmap[AW_H3_GIC_HYP]);
> > -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 3,
> s->memmap[AW_H3_GIC_VCPU]);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 0,
> s->memmap[AW_H3_DEV_GIC_DIST]);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1,
> s->memmap[AW_H3_DEV_GIC_CPU]);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 2,
> s->memmap[AW_H3_DEV_GIC_HYP]);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 3,
> s->memmap[AW_H3_DEV_GIC_VCPU]);
> >
> >      /*
> >       * Wire the outputs from each CPU's generic timer and the GICv3
> > @@ -312,7 +312,7 @@ static void allwinner_h3_realize(DeviceState *dev,
> Error **errp)
> >
> >      /* Timer */
> >      sysbus_realize(SYS_BUS_DEVICE(&s->timer), &error_fatal);
> > -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer), 0, s->memmap[AW_H3_PIT]=
);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer), 0,
> s->memmap[AW_H3_DEV_PIT]);
> >      sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer), 0,
> >                         qdev_get_gpio_in(DEVICE(&s->gic),
> AW_H3_GIC_SPI_TIMER0));
> >      sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer), 1,
> > @@ -325,32 +325,32 @@ static void allwinner_h3_realize(DeviceState *dev=
,
> Error **errp)
> >                              32 * KiB, &error_abort);
> >      memory_region_init_ram(&s->sram_c, OBJECT(dev), "sram C",
> >                              44 * KiB, &error_abort);
> > -    memory_region_add_subregion(get_system_memory(),
> s->memmap[AW_H3_SRAM_A1],
> > +    memory_region_add_subregion(get_system_memory(),
> s->memmap[AW_H3_DEV_SRAM_A1],
> >                                  &s->sram_a1);
> > -    memory_region_add_subregion(get_system_memory(),
> s->memmap[AW_H3_SRAM_A2],
> > +    memory_region_add_subregion(get_system_memory(),
> s->memmap[AW_H3_DEV_SRAM_A2],
> >                                  &s->sram_a2);
> > -    memory_region_add_subregion(get_system_memory(),
> s->memmap[AW_H3_SRAM_C],
> > +    memory_region_add_subregion(get_system_memory(),
> s->memmap[AW_H3_DEV_SRAM_C],
> >                                  &s->sram_c);
> >
> >      /* Clock Control Unit */
> >      sysbus_realize(SYS_BUS_DEVICE(&s->ccu), &error_fatal);
> > -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_H3_CCU]);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0,
> s->memmap[AW_H3_DEV_CCU]);
> >
> >      /* System Control */
> >      sysbus_realize(SYS_BUS_DEVICE(&s->sysctrl), &error_fatal);
> > -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysctrl), 0,
> s->memmap[AW_H3_SYSCTRL]);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysctrl), 0,
> s->memmap[AW_H3_DEV_SYSCTRL]);
> >
> >      /* CPU Configuration */
> >      sysbus_realize(SYS_BUS_DEVICE(&s->cpucfg), &error_fatal);
> > -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucfg), 0,
> s->memmap[AW_H3_CPUCFG]);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucfg), 0,
> s->memmap[AW_H3_DEV_CPUCFG]);
> >
> >      /* Security Identifier */
> >      sysbus_realize(SYS_BUS_DEVICE(&s->sid), &error_fatal);
> > -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, s->memmap[AW_H3_SID]);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0,
> s->memmap[AW_H3_DEV_SID]);
> >
> >      /* SD/MMC */
> >      sysbus_realize(SYS_BUS_DEVICE(&s->mmc0), &error_fatal);
> > -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc0), 0, s->memmap[AW_H3_MMC0]=
);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc0), 0,
> s->memmap[AW_H3_DEV_MMC0]);
> >      sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc0), 0,
> >                         qdev_get_gpio_in(DEVICE(&s->gic),
> AW_H3_GIC_SPI_MMC0));
> >
> > @@ -364,63 +364,63 @@ static void allwinner_h3_realize(DeviceState *dev=
,
> Error **errp)
> >          qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
> >      }
> >      sysbus_realize(SYS_BUS_DEVICE(&s->emac), &error_fatal);
> > -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->emac), 0, s->memmap[AW_H3_EMAC]=
);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->emac), 0,
> s->memmap[AW_H3_DEV_EMAC]);
> >      sysbus_connect_irq(SYS_BUS_DEVICE(&s->emac), 0,
> >                         qdev_get_gpio_in(DEVICE(&s->gic),
> AW_H3_GIC_SPI_EMAC));
> >
> >      /* Universal Serial Bus */
> > -    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
> > +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI0],
> >                           qdev_get_gpio_in(DEVICE(&s->gic),
> >                                            AW_H3_GIC_SPI_EHCI0));
> > -    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI1],
> > +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI1],
> >                           qdev_get_gpio_in(DEVICE(&s->gic),
> >                                            AW_H3_GIC_SPI_EHCI1));
> > -    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI2],
> > +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI2],
> >                           qdev_get_gpio_in(DEVICE(&s->gic),
> >                                            AW_H3_GIC_SPI_EHCI2));
> > -    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI3],
> > +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI3],
> >                           qdev_get_gpio_in(DEVICE(&s->gic),
> >                                            AW_H3_GIC_SPI_EHCI3));
> >
> > -    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI0],
> > +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI0],
> >                           qdev_get_gpio_in(DEVICE(&s->gic),
> >                                            AW_H3_GIC_SPI_OHCI0));
> > -    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI1],
> > +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI1],
> >                           qdev_get_gpio_in(DEVICE(&s->gic),
> >                                            AW_H3_GIC_SPI_OHCI1));
> > -    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI2],
> > +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI2],
> >                           qdev_get_gpio_in(DEVICE(&s->gic),
> >                                            AW_H3_GIC_SPI_OHCI2));
> > -    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI3],
> > +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI3],
> >                           qdev_get_gpio_in(DEVICE(&s->gic),
> >                                            AW_H3_GIC_SPI_OHCI3));
> >
> >      /* UART0. For future clocktree API: All UARTS are connected to
> APB2_CLK. */
> > -    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART0], 2,
> > +    serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART0], 2,
> >                     qdev_get_gpio_in(DEVICE(&s->gic),
> AW_H3_GIC_SPI_UART0),
> >                     115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
> >      /* UART1 */
> > -    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART1], 2,
> > +    serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART1], 2,
> >                     qdev_get_gpio_in(DEVICE(&s->gic),
> AW_H3_GIC_SPI_UART1),
> >                     115200, serial_hd(1), DEVICE_NATIVE_ENDIAN);
> >      /* UART2 */
> > -    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART2], 2,
> > +    serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART2], 2,
> >                     qdev_get_gpio_in(DEVICE(&s->gic),
> AW_H3_GIC_SPI_UART2),
> >                     115200, serial_hd(2), DEVICE_NATIVE_ENDIAN);
> >      /* UART3 */
> > -    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART3], 2,
> > +    serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART3], 2,
> >                     qdev_get_gpio_in(DEVICE(&s->gic),
> AW_H3_GIC_SPI_UART3),
> >                     115200, serial_hd(3), DEVICE_NATIVE_ENDIAN);
> >
> >      /* DRAMC */
> >      sysbus_realize(SYS_BUS_DEVICE(&s->dramc), &error_fatal);
> > -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 0,
> s->memmap[AW_H3_DRAMCOM]);
> > -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 1,
> s->memmap[AW_H3_DRAMCTL]);
> > -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 2,
> s->memmap[AW_H3_DRAMPHY]);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 0,
> s->memmap[AW_H3_DEV_DRAMCOM]);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 1,
> s->memmap[AW_H3_DEV_DRAMCTL]);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 2,
> s->memmap[AW_H3_DEV_DRAMPHY]);
> >
> >      /* RTC */
> >      sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &error_fatal);
> > -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, s->memmap[AW_H3_RTC]);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0,
> s->memmap[AW_H3_DEV_RTC]);
> >
> >      /* Unimplemented devices */
> >      for (i =3D 0; i < ARRAY_SIZE(unimplemented); i++) {
> > diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> > index 1679468232..17a568a2b4 100644
> > --- a/hw/arm/orangepi.c
> > +++ b/hw/arm/orangepi.c
> > @@ -79,7 +79,7 @@ static void orangepi_init(MachineState *machine)
> >      object_property_set_int(OBJECT(&h3->emac), "phy-addr", 1,
> &error_abort);
> >
> >      /* DRAMC */
> > -    object_property_set_uint(OBJECT(h3), "ram-addr",
> h3->memmap[AW_H3_SDRAM],
> > +    object_property_set_uint(OBJECT(h3), "ram-addr",
> h3->memmap[AW_H3_DEV_SDRAM],
> >                               &error_abort);
> >      object_property_set_int(OBJECT(h3), "ram-size", machine->ram_size =
/
> MiB,
> >                              &error_abort);
> > @@ -98,7 +98,7 @@ static void orangepi_init(MachineState *machine)
> >      qdev_realize_and_unref(carddev, bus, &error_fatal);
> >
> >      /* SDRAM */
> > -    memory_region_add_subregion(get_system_memory(),
> h3->memmap[AW_H3_SDRAM],
> > +    memory_region_add_subregion(get_system_memory(),
> h3->memmap[AW_H3_DEV_SDRAM],
> >                                  machine->ram);
> >
> >      /* Load target kernel or start using BootROM */
> > @@ -106,7 +106,7 @@ static void orangepi_init(MachineState *machine)
> >          /* Use Boot ROM to copy data from SD card to SRAM */
> >          allwinner_h3_bootrom_setup(h3, blk);
> >      }
> > -    orangepi_binfo.loader_start =3D h3->memmap[AW_H3_SDRAM];
> > +    orangepi_binfo.loader_start =3D h3->memmap[AW_H3_DEV_SDRAM];
> >      orangepi_binfo.ram_size =3D machine->ram_size;
> >      arm_load_kernel(ARM_CPU(first_cpu), machine, &orangepi_binfo);
> >  }
> >
>
>

--=20
Niek Linnenbank

--000000000000ce580e05ad177df0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Interesting suggestion P=
hilippe. I modelled the initial code of the H3 SoC mostly in-line with the =
aspeed SoC,</div><div>to let it use commonly applied code structures where =
possible. And it looks like in this series, aspeed_soc.h is also</div><div>=
getting the same change. I&#39;ll see if I can find some time to make a sma=
ll patch to move the enum to the local allwinner-h3.c file like you</div><d=
iv>suggested.</div><div><br></div><div>For Eduardo&#39;s work, I&#39;m OK w=
ith a rename for now to AW_H3_DEV_*. I see it is also done like that in asp=
eed_soc.h and similar files.</div><div><div>I do have one follow-up questio=
n: which value(s) from the enum are actually in conflict? Could you add tha=
t in the commit message perhaps, for clarity?<br></div><div><br></div></div=
>With that answered:<br><div><div><div>=C2=A0 Reviewed-by: Niek Linnenbank =
&lt;<a href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a=
>&gt;</div><div><br></div><div>Regards,</div><div>Niek<br></div></div></div=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>On Fri, Aug 14, 2020 at 7:54 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D=
"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">+Niek as maintainer.<br>
<br>
On 8/14/20 12:25 AM, Eduardo Habkost wrote:<br>
&gt; Some of the enum constant names conflict with the QOM type check<br>
&gt; macros.=C2=A0 This needs to be addressed to allow us to transform the<=
br>
&gt; QOM type check macros into functions generated by<br>
&gt; OBJECT_DECLARE_TYPE().<br>
&gt; <br>
&gt; Rename all the constants to AW_H3_DEV_*, to avoid conflicts.<br>
&gt; <br>
&gt; Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.c=
om" target=3D"_blank">ehabkost@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/hw/arm/allwinner-h3.h |=C2=A0 62 ++++++++---------<br>
&gt;=C2=A0 hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 124 +++=
++++++++++++++-----------------<br>
&gt;=C2=A0 hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 3 files changed, 96 insertions(+), 96 deletions(-)<br>
&gt; <br>
&gt; diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-=
h3.h<br>
&gt; index 82e4e59216..626139dcb3 100644<br>
&gt; --- a/include/hw/arm/allwinner-h3.h<br>
&gt; +++ b/include/hw/arm/allwinner-h3.h<br>
&gt; @@ -61,37 +61,37 @@<br>
&gt;=C2=A0 =C2=A0* @see AwH3State<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 enum {<br>
&gt; -=C2=A0 =C2=A0 AW_H3_SRAM_A1,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_SRAM_A2,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_SRAM_C,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_SYSCTRL,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_MMC0,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_SID,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_EHCI0,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_OHCI0,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_EHCI1,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_OHCI1,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_EHCI2,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_OHCI2,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_EHCI3,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_OHCI3,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_CCU,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_PIT,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_UART0,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_UART1,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_UART2,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_UART3,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_EMAC,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_DRAMCOM,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_DRAMCTL,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_DRAMPHY,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_GIC_DIST,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_GIC_CPU,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_GIC_HYP,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_GIC_VCPU,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_RTC,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_CPUCFG,<br>
&gt; -=C2=A0 =C2=A0 AW_H3_SDRAM<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_SRAM_A1,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_SRAM_A2,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_SRAM_C,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_SYSCTRL,<br>
<br>
My 2 cents:<br>
These are not devices, but peripheral blocks or IP cores.<br>
Anyway, short change could be to name them E_AW_H3_xxx,<br>
but I don&#39;t understand why these are exposed. This enum<br>
should be locally declared in hw/arm/allwinner-h3.c,<br>
and the SoC might provide a get_sdram_base_address()<br>
method so the machine can access it.<br>
<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_MMC0,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_SID,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_EHCI0,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_OHCI0,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_EHCI1,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_OHCI1,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_EHCI2,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_OHCI2,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_EHCI3,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_OHCI3,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_CCU,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_PIT,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_UART0,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_UART1,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_UART2,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_UART3,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_EMAC,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_DRAMCOM,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_DRAMCTL,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_DRAMPHY,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_GIC_DIST,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_GIC_CPU,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_GIC_HYP,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_GIC_VCPU,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_RTC,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_CPUCFG,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_DEV_SDRAM<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /** Total number of CPU cores in the H3 SoC */<br>
&gt; diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
&gt; index ff92ded82c..341abe6718 100644<br>
&gt; --- a/hw/arm/allwinner-h3.c<br>
&gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt; @@ -35,37 +35,37 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* Memory map */<br>
&gt;=C2=A0 const hwaddr allwinner_h3_memmap[] =3D {<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_SRAM_A1]=C2=A0 =C2=A0 =3D 0x00000000,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_SRAM_A2]=C2=A0 =C2=A0 =3D 0x00044000,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_SRAM_C]=C2=A0 =C2=A0 =C2=A0=3D 0x00010000,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_SYSCTRL]=C2=A0 =C2=A0 =3D 0x01c00000,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_MMC0]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x01c0f000,<=
br>
&gt; -=C2=A0 =C2=A0 [AW_H3_SID]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c14000,<=
br>
&gt; -=C2=A0 =C2=A0 [AW_H3_EHCI0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1a000,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_OHCI0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1a400,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_EHCI1]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1b000,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_OHCI1]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1b400,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_EHCI2]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1c000,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_OHCI2]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1c400,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_EHCI3]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1d000,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_OHCI3]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1d400,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_CCU]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c20000,<=
br>
&gt; -=C2=A0 =C2=A0 [AW_H3_PIT]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c20c00,<=
br>
&gt; -=C2=A0 =C2=A0 [AW_H3_UART0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28000,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_UART1]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28400,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_UART2]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28800,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_UART3]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28c00,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_EMAC]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x01c30000,<=
br>
&gt; -=C2=A0 =C2=A0 [AW_H3_DRAMCOM]=C2=A0 =C2=A0 =3D 0x01c62000,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_DRAMCTL]=C2=A0 =C2=A0 =3D 0x01c63000,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_DRAMPHY]=C2=A0 =C2=A0 =3D 0x01c65000,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_GIC_DIST]=C2=A0 =C2=A0=3D 0x01c81000,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_GIC_CPU]=C2=A0 =C2=A0 =3D 0x01c82000,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_GIC_HYP]=C2=A0 =C2=A0 =3D 0x01c84000,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_GIC_VCPU]=C2=A0 =C2=A0=3D 0x01c86000,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_RTC]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01f00000,<=
br>
&gt; -=C2=A0 =C2=A0 [AW_H3_CPUCFG]=C2=A0 =C2=A0 =C2=A0=3D 0x01f01c00,<br>
&gt; -=C2=A0 =C2=A0 [AW_H3_SDRAM]=C2=A0 =C2=A0 =C2=A0 =3D 0x40000000<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_SRAM_A1]=C2=A0 =C2=A0 =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_SRAM_A2]=C2=A0 =C2=A0 =3D 0x00044000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_SRAM_C]=C2=A0 =C2=A0 =C2=A0=3D 0x00010000,<b=
r>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_SYSCTRL]=C2=A0 =C2=A0 =3D 0x01c00000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_MMC0]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x01c0f0=
00,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_SID]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c140=
00,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_EHCI0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1a000,<b=
r>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_OHCI0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1a400,<b=
r>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_EHCI1]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1b000,<b=
r>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_OHCI1]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1b400,<b=
r>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_EHCI2]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1c000,<b=
r>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_OHCI2]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1c400,<b=
r>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_EHCI3]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1d000,<b=
r>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_OHCI3]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1d400,<b=
r>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_CCU]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c200=
00,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_PIT]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c20c=
00,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_UART0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28000,<b=
r>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_UART1]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28400,<b=
r>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_UART2]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28800,<b=
r>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_UART3]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28c00,<b=
r>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_EMAC]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x01c300=
00,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_DRAMCOM]=C2=A0 =C2=A0 =3D 0x01c62000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_DRAMCTL]=C2=A0 =C2=A0 =3D 0x01c63000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_DRAMPHY]=C2=A0 =C2=A0 =3D 0x01c65000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_GIC_DIST]=C2=A0 =C2=A0=3D 0x01c81000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_GIC_CPU]=C2=A0 =C2=A0 =3D 0x01c82000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_GIC_HYP]=C2=A0 =C2=A0 =3D 0x01c84000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_GIC_VCPU]=C2=A0 =C2=A0=3D 0x01c86000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_RTC]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01f000=
00,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_CPUCFG]=C2=A0 =C2=A0 =C2=A0=3D 0x01f01c00,<b=
r>
&gt; +=C2=A0 =C2=A0 [AW_H3_DEV_SDRAM]=C2=A0 =C2=A0 =C2=A0 =3D 0x40000000<br=
>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* List of unimplemented devices */<br>
&gt; @@ -183,7 +183,7 @@ void allwinner_h3_bootrom_setup(AwH3State *s, Bloc=
kBackend *blk)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 rom_add_blob(&quot;allwinner-h3.bootrom&quot;, buf=
fer, rom_size,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_si=
ze, s-&gt;memmap[AW_H3_SRAM_A1],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_si=
ze, s-&gt;memmap[AW_H3_DEV_SRAM_A1],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 N=
ULL, NULL, NULL, NULL, false);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; @@ -262,10 +262,10 @@ static void allwinner_h3_realize(DeviceState *de=
v, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qdev_prop_set_bit(DEVICE(&amp;s-&gt;gic), &quot;ha=
s-virtualization-extensions&quot;, true);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;gic), &am=
p;error_fatal);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 0, s-&g=
t;memmap[AW_H3_GIC_DIST]);<br>
&gt; -=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 1, s-&g=
t;memmap[AW_H3_GIC_CPU]);<br>
&gt; -=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 2, s-&g=
t;memmap[AW_H3_GIC_HYP]);<br>
&gt; -=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 3, s-&g=
t;memmap[AW_H3_GIC_VCPU]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 0, s-&g=
t;memmap[AW_H3_DEV_GIC_DIST]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 1, s-&g=
t;memmap[AW_H3_DEV_GIC_CPU]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 2, s-&g=
t;memmap[AW_H3_DEV_GIC_HYP]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 3, s-&g=
t;memmap[AW_H3_DEV_GIC_VCPU]);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* Wire the outputs from each CPU&#39;s gener=
ic timer and the GICv3<br>
&gt; @@ -312,7 +312,7 @@ static void allwinner_h3_realize(DeviceState *dev,=
 Error **errp)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Timer */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;timer), &=
amp;error_fatal);<br>
&gt; -=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;timer), 0, s-=
&gt;memmap[AW_H3_PIT]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;timer), 0, s-=
&gt;memmap[AW_H3_DEV_PIT]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;timer=
), 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_=
TIMER0));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;timer=
), 1,<br>
&gt; @@ -325,32 +325,32 @@ static void allwinner_h3_realize(DeviceState *de=
v, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 32 * KiB, &amp;error_abort);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 memory_region_init_ram(&amp;s-&gt;sram_c, OBJECT(d=
ev), &quot;sram C&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 44 * KiB, &amp;error_abort);<br>
&gt; -=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), s-&gt;=
memmap[AW_H3_SRAM_A1],<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), s-&gt;=
memmap[AW_H3_DEV_SRAM_A1],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;sram_a1);<br>
&gt; -=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), s-&gt;=
memmap[AW_H3_SRAM_A2],<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), s-&gt;=
memmap[AW_H3_DEV_SRAM_A2],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;sram_a2);<br>
&gt; -=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), s-&gt;=
memmap[AW_H3_SRAM_C],<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), s-&gt;=
memmap[AW_H3_DEV_SRAM_C],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;sram_c);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Clock Control Unit */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;ccu), &am=
p;error_fatal);<br>
&gt; -=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;ccu), 0, s-&g=
t;memmap[AW_H3_CCU]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;ccu), 0, s-&g=
t;memmap[AW_H3_DEV_CCU]);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* System Control */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;sysctrl),=
 &amp;error_fatal);<br>
&gt; -=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;sysctrl), 0, =
s-&gt;memmap[AW_H3_SYSCTRL]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;sysctrl), 0, =
s-&gt;memmap[AW_H3_DEV_SYSCTRL]);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* CPU Configuration */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;cpucfg), =
&amp;error_fatal);<br>
&gt; -=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;cpucfg), 0, s=
-&gt;memmap[AW_H3_CPUCFG]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;cpucfg), 0, s=
-&gt;memmap[AW_H3_DEV_CPUCFG]);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Security Identifier */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;sid), &am=
p;error_fatal);<br>
&gt; -=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;sid), 0, s-&g=
t;memmap[AW_H3_SID]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;sid), 0, s-&g=
t;memmap[AW_H3_DEV_SID]);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* SD/MMC */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;mmc0), &a=
mp;error_fatal);<br>
&gt; -=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;mmc0), 0, s-&=
gt;memmap[AW_H3_MMC0]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;mmc0), 0, s-&=
gt;memmap[AW_H3_DEV_MMC0]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;mmc0)=
, 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_=
MMC0));<br>
&gt;=C2=A0 <br>
&gt; @@ -364,63 +364,63 @@ static void allwinner_h3_realize(DeviceState *de=
v, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_set_nic_properties(DEVICE(&amp;=
s-&gt;emac), &amp;nd_table[0]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;emac), &a=
mp;error_fatal);<br>
&gt; -=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;emac), 0, s-&=
gt;memmap[AW_H3_EMAC]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;emac), 0, s-&=
gt;memmap[AW_H3_DEV_EMAC]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;emac)=
, 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_=
EMAC));<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Universal Serial Bus */<br>
&gt; -=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H=
3_EHCI0],<br>
&gt; +=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H=
3_DEV_EHCI0],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 AW_H3_GIC_SPI_EHCI0));<br>
&gt; -=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H=
3_EHCI1],<br>
&gt; +=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H=
3_DEV_EHCI1],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 AW_H3_GIC_SPI_EHCI1));<br>
&gt; -=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H=
3_EHCI2],<br>
&gt; +=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H=
3_DEV_EHCI2],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 AW_H3_GIC_SPI_EHCI2));<br>
&gt; -=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H=
3_EHCI3],<br>
&gt; +=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H=
3_DEV_EHCI3],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 AW_H3_GIC_SPI_EHCI3));<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;mem=
map[AW_H3_OHCI0],<br>
&gt; +=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;mem=
map[AW_H3_DEV_OHCI0],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 AW_H3_GIC_SPI_OHCI0));<br>
&gt; -=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;mem=
map[AW_H3_OHCI1],<br>
&gt; +=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;mem=
map[AW_H3_DEV_OHCI1],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 AW_H3_GIC_SPI_OHCI1));<br>
&gt; -=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;mem=
map[AW_H3_OHCI2],<br>
&gt; +=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;mem=
map[AW_H3_DEV_OHCI2],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 AW_H3_GIC_SPI_OHCI2));<br>
&gt; -=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;mem=
map[AW_H3_OHCI3],<br>
&gt; +=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;mem=
map[AW_H3_DEV_OHCI3],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 AW_H3_GIC_SPI_OHCI3));<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* UART0. For future clocktree API: All UARTS are =
connected to APB2_CLK. */<br>
&gt; -=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_=
UART0], 2,<br>
&gt; +=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_=
DEV_UART0], 2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_UART0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* UART1 */<br>
&gt; -=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_=
UART1], 2,<br>
&gt; +=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_=
DEV_UART1], 2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_UART1),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0115200, serial_hd(1), DEVICE_NATIVE_ENDIAN);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* UART2 */<br>
&gt; -=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_=
UART2], 2,<br>
&gt; +=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_=
DEV_UART2], 2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_UART2),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0115200, serial_hd(2), DEVICE_NATIVE_ENDIAN);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* UART3 */<br>
&gt; -=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_=
UART3], 2,<br>
&gt; +=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_=
DEV_UART3], 2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_UART3),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0115200, serial_hd(3), DEVICE_NATIVE_ENDIAN);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* DRAMC */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;dramc), &=
amp;error_fatal);<br>
&gt; -=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;dramc), 0, s-=
&gt;memmap[AW_H3_DRAMCOM]);<br>
&gt; -=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;dramc), 1, s-=
&gt;memmap[AW_H3_DRAMCTL]);<br>
&gt; -=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;dramc), 2, s-=
&gt;memmap[AW_H3_DRAMPHY]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;dramc), 0, s-=
&gt;memmap[AW_H3_DEV_DRAMCOM]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;dramc), 1, s-=
&gt;memmap[AW_H3_DEV_DRAMCTL]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;dramc), 2, s-=
&gt;memmap[AW_H3_DEV_DRAMPHY]);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* RTC */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;rtc), &am=
p;error_fatal);<br>
&gt; -=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;rtc), 0, s-&g=
t;memmap[AW_H3_RTC]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;rtc), 0, s-&g=
t;memmap[AW_H3_DEV_RTC]);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Unimplemented devices */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(unimplemented); i+=
+) {<br>
&gt; diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c<br>
&gt; index 1679468232..17a568a2b4 100644<br>
&gt; --- a/hw/arm/orangepi.c<br>
&gt; +++ b/hw/arm/orangepi.c<br>
&gt; @@ -79,7 +79,7 @@ static void orangepi_init(MachineState *machine)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 object_property_set_int(OBJECT(&amp;h3-&gt;emac), =
&quot;phy-addr&quot;, 1, &amp;error_abort);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* DRAMC */<br>
&gt; -=C2=A0 =C2=A0 object_property_set_uint(OBJECT(h3), &quot;ram-addr&quo=
t;, h3-&gt;memmap[AW_H3_SDRAM],<br>
&gt; +=C2=A0 =C2=A0 object_property_set_uint(OBJECT(h3), &quot;ram-addr&quo=
t;, h3-&gt;memmap[AW_H3_DEV_SDRAM],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 object_property_set_int(OBJECT(h3), &quot;ram-size=
&quot;, machine-&gt;ram_size / MiB,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_abort);<br>
&gt; @@ -98,7 +98,7 @@ static void orangepi_init(MachineState *machine)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qdev_realize_and_unref(carddev, bus, &amp;error_fa=
tal);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* SDRAM */<br>
&gt; -=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), h3-&gt=
;memmap[AW_H3_SDRAM],<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), h3-&gt=
;memmap[AW_H3_DEV_SDRAM],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 machine-&gt;ram);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Load target kernel or start using BootROM */<br=
>
&gt; @@ -106,7 +106,7 @@ static void orangepi_init(MachineState *machine)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Use Boot ROM to copy data from SD=
 card to SRAM */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 allwinner_h3_bootrom_setup(h3, blk);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 orangepi_binfo.loader_start =3D h3-&gt;memmap[AW_H3_SDR=
AM];<br>
&gt; +=C2=A0 =C2=A0 orangepi_binfo.loader_start =3D h3-&gt;memmap[AW_H3_DEV=
_SDRAM];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 orangepi_binfo.ram_size =3D machine-&gt;ram_size;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 arm_load_kernel(ARM_CPU(first_cpu), machine, &amp;=
orangepi_binfo);<br>
&gt;=C2=A0 }<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div>

--000000000000ce580e05ad177df0--

