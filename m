Return-Path: <SRS0=JchA=UW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7240DC43613
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 15:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 270142073F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 15:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6re9i1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270142073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45272 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hf4V4-000368-I7
	for qemu-devel@archiver.kernel.org; Sun, 23 Jun 2019 11:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45757)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hf4S0-00027o-1t
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 11:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hf4Ry-0007Vf-C9
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 11:30:40 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43619)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hf4Rw-0007KS-Vi
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 11:30:37 -0400
Received: by mail-lj1-x244.google.com with SMTP id 16so10175745ljv.10
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2019 08:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FuhXew38Y2SrPbiLxQYkL58+IFye4v+y/bn07t28+OY=;
 b=M6re9i1LyUMmkxSL2OAHdfVP1L7d4ZstMpw4HTpGySnMCrcKi5BmPsANw6CVwSSxXV
 pFxCy0CTmJQWT3Zz4/AdnIz/Wx0T+gKUm+oA4zmqBcNNbUCKhEVkg55xpKleb+DNE5eI
 7yaT8dXW5N4uwxMxE6zVGmOuZrwNQMnk62bJSYWuanoUjIz2AMNYn9wriaSiALH57PwB
 SRDK9pvViDZbqwN7x4zvcMLiSaJ3cwV3n+sMANpHQRIM766Iw1vGGhszfzXKXid3N2yg
 EoexNQNkWphT8Ny7l6Jg1dQxu7vjEtGWMmpgbUy/O0NzezU9K7xlQS27gWJf0jfm33A2
 uINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FuhXew38Y2SrPbiLxQYkL58+IFye4v+y/bn07t28+OY=;
 b=JHNl78hLs8B/nbCSrFNh+TZ9mHSIN0ZhpCAErnQD8wKR7RmYcAsQnEGQIRmW5JPkSz
 iYVmnNfrG10wfNxMzwvtOrQvtwlsZSUoKK8LzNKIzWAbg1Fwnmk9xLVhgd//+y2tChea
 zb6T7Wuzo7QHB2do34Fl+uDGZ1r9Zxvxq75ReI0tC5pbmbh0JHKwZxXTXAXkS9vh6oWW
 CrZswaKkSMBIwsFFgLbMyGiF5aP0YSOiG/nRpOo2U6pbQqzLwEhaytwM0cmtuS/NYVYN
 lt0uVJf45rmUq+Y4AgP/NzJEpzQPyVvwFlINq1EvWZzjIrJrYpUr6ly6sxX0lXKqiC1p
 1WOw==
X-Gm-Message-State: APjAAAUMRcjVG+5SM2MSbwN59mP0pWcGMu65j+IKbhffy3vJLrNd3kNc
 olzu0acVxDYA7WhMGLM+JHBzUvufYErVxyr6rumREMGp
X-Google-Smtp-Source: APXvYqxb9bu5eyn/eqhDkqnQ90nHZXwCFlwYfx3llM+x8QnM+UcpB+RzzOWOtsFJmOPqP5sWdvEcZGu7QTKEn/pZg5E=
X-Received: by 2002:a2e:6e0e:: with SMTP id j14mr12333020ljc.85.1561303833816; 
 Sun, 23 Jun 2019 08:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560919807.git.alistair@alistair23.me>
 <PSXP216MB0277171F4F3978296BE895F2DDE50@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
 <4c619c3a-8567-be68-5d4d-eda0ff5b566f@redhat.com>
In-Reply-To: <4c619c3a-8567-be68-5d4d-eda0ff5b566f@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sun, 23 Jun 2019 08:30:05 -0700
Message-ID: <CAKmqyKMQPFHznaWZZFEtazqpA2R30MPUrDp+OSrzDhXzRa5GLg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v3 2/6] target/arm: Allow setting M mode
 entry and sp
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 21, 2019 at 9:38 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Alistair,
>
> On 6/19/19 6:54 AM, Alistair Francis wrote:
> > Add M mode initial entry PC and SP properties.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  target/arm/cpu.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
> >  target/arm/cpu.h |  3 +++
> >  2 files changed, 50 insertions(+)
> >
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 376db154f0..1d83972ab1 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -301,6 +301,9 @@ static void arm_cpu_reset(CPUState *s)
> >               */
> >              initial_msp =3D ldl_p(rom);
> >              initial_pc =3D ldl_p(rom + 4);
> > +        } else if (cpu->init_sp || cpu->init_entry) {
> > +            initial_msp =3D cpu->init_sp;
> > +            initial_pc =3D cpu->init_entry;
> >          } else {
> >              /* Address zero not covered by a ROM blob, or the ROM blob
> >               * is in non-modifiable memory and this is a second reset =
after
> > @@ -801,6 +804,38 @@ static void arm_set_init_svtor(Object *obj, Visito=
r *v, const char *name,
> >      visit_type_uint32(v, name, &cpu->init_svtor, errp);
> >  }
> >
> > +static void arm_get_init_sp(Object *obj, Visitor *v, const char *name,
> > +                            void *opaque, Error **errp)
> > +{
> > +    ARMCPU *cpu =3D ARM_CPU(obj);
> > +
> > +    visit_type_uint32(v, name, &cpu->init_sp, errp);
> > +}
> > +
> > +static void arm_set_init_sp(Object *obj, Visitor *v, const char *name,
> > +                            void *opaque, Error **errp)
> > +{
> > +    ARMCPU *cpu =3D ARM_CPU(obj);
> > +
> > +    visit_type_uint32(v, name, &cpu->init_sp, errp);
> > +}
> > +
> > +static void arm_get_init_entry(Object *obj, Visitor *v, const char *na=
me,
> > +                            void *opaque, Error **errp)
> > +{
> > +    ARMCPU *cpu =3D ARM_CPU(obj);
> > +
> > +    visit_type_uint32(v, name, &cpu->init_entry, errp);
> > +}
> > +
> > +static void arm_set_init_entry(Object *obj, Visitor *v, const char *na=
me,
> > +                            void *opaque, Error **errp)
> > +{
> > +    ARMCPU *cpu =3D ARM_CPU(obj);
> > +
> > +    visit_type_uint32(v, name, &cpu->init_entry, errp);
> > +}
> > +
> >  void arm_cpu_post_init(Object *obj)
> >  {
> >      ARMCPU *cpu =3D ARM_CPU(obj);
> > @@ -913,6 +948,18 @@ void arm_cpu_post_init(Object *obj)
> >          object_property_add(obj, "init-svtor", "uint32",
> >                              arm_get_init_svtor, arm_set_init_svtor,
> >                              NULL, NULL, &error_abort);
> > +    } else {
> > +        /*
> > +         * M profile: initial value of the SP and entry. We can't just=
 use
> > +         * a simple DEFINE_PROP_UINT32 for this because we want to per=
mit
> > +         * the property to be set after realize.
> > +         */
>
> This comment is mostly a copy of the other if() branch, maybe you can
> extract one generic comment for the 2 cases.

Good point, I have updated it.

>
> > +        object_property_add(obj, "init-sp", "uint32",
> > +                            arm_get_init_sp, arm_set_init_sp,
> > +                            NULL, NULL, &error_abort);
> > +        object_property_add(obj, "init-entry", "uint32",
> > +                            arm_get_init_entry, arm_set_init_entry,
> > +                            NULL, NULL, &error_abort);
>
> I'm having difficulties to test your patch :( I tried:
>
> $ arm-softmmu/qemu-system-arm -M emcraft-sf2 \
>   -device loader,file=3D/networking.uImage,cpu-num=3D0 \
>   -d in_asm,int,mmu \
>   -global cpu.init-sp=3D0x2000fff0 \
>   -global cpu.init-entry=3D0xa0008001
> PMSA MPU lookup for execute at 0xa0008000 mmu_idx 65 -> Miss (prot rw-)
> Taking exception 3 [Prefetch Abort]
> ...with CFSR.IACCVIOL
> PMSA MPU lookup for writing at 0x2000ffd0 mmu_idx 65 -> Hit (prot rwx)
> PMSA MPU lookup for writing at 0x2000ffd4 mmu_idx 65 -> Hit (prot rwx)
> PMSA MPU lookup for writing at 0x2000ffd8 mmu_idx 65 -> Hit (prot rwx)
> PMSA MPU lookup for writing at 0x2000ffdc mmu_idx 65 -> Hit (prot rwx)
> PMSA MPU lookup for writing at 0x2000ffe0 mmu_idx 65 -> Hit (prot rwx)
> PMSA MPU lookup for writing at 0x2000ffe4 mmu_idx 65 -> Hit (prot rwx)
> PMSA MPU lookup for writing at 0x2000ffe8 mmu_idx 65 -> Hit (prot rwx)
> PMSA MPU lookup for writing at 0x2000ffec mmu_idx 65 -> Hit (prot rwx)
> ...taking pending nonsecure exception 3
> PMSA MPU lookup for execute at 0x00000000 mmu_idx 67 -> Hit (prot rwx)
> ----------------
> IN:
> PMSA MPU lookup for reading at 0x00000000 mmu_idx 67 -> Hit (prot rwx)
> 0x00000000:  00000000  andeq    r0, r0, r0
>
> Taking exception 18 [v7M INVSTATE UsageFault]
> qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)
>
> R00=3D00000000 R01=3D00000000 R02=3D00000000 R03=3D00000000
> R04=3D00000000 R05=3D00000000 R06=3D00000000 R07=3D00000000
> R08=3D00000000 R09=3D00000000 R10=3D00000000 R11=3D00000000
> R12=3D00000000 R13=3D2000ffd0 R14=3Dfffffff9 R15=3D00000000
> XPSR=3D40000003 -Z-- A handler
> FPSCR: 00000000
> Aborted (core dumped)
>
> (same without setting cpu.init-entry).
>
> Downloaded "Prebuilt Linux image ready to be loaded to the M2S-FG484
> SOM" here: https://emcraft.com/products/255#software
>
> $ file networking.uImage
> networking.uImage: u-boot legacy uImage, Linux-2.6.33-cortexm-1.14.3,
> Linux/ARM, OS Kernel Image (Not compressed), 2299232 bytes, Wed Nov 11
> 14:19:53 2015, Load Address: 0xA0008000, Entry Point: 0xA0008001, Header
> CRC: 0x419AA120, Data CRC: 0x1C34C4BE
>
> This board memory map is:
>
> (qemu) info mtree
> address-space: memory
>   0000000000000000-ffffffffffffffff (prio -1, i/o): system
>     0000000000000000-000000000003ffff (prio 0, i/o): alias MSF2.eNVM
>     0000000020000000-000000002000ffff (prio 0, ram): MSF2.eSRAM
>     0000000040000000-000000004000001f (prio 0, i/o): serial
>     0000000040001000-000000004000103f (prio 0, i/o): mss-spi
>     0000000040002000-0000000040002fff (prio -1000, i/o): i2c_0
>     0000000040003000-0000000040003fff (prio -1000, i/o): dma
>     0000000040004000-000000004000402f (prio 0, i/o): mss-timer
>     0000000040005000-0000000040005fff (prio -1000, i/o): watchdog
>     0000000040011000-000000004001103f (prio 0, i/o): mss-spi
>     0000000040012000-0000000040012fff (prio -1000, i/o): i2c_1
>     0000000040013000-0000000040013fff (prio -1000, i/o): gpio
>     0000000040014000-0000000040014fff (prio -1000, i/o): hs-dma
>     0000000040015000-0000000040015fff (prio -1000, i/o): can
>     0000000040017000-0000000040017fff (prio -1000, i/o): rtc
>     0000000040020000-000000004002ffff (prio -1000, i/o): apb_config
>     0000000040038000-00000000400382ff (prio 0, i/o): msf2-sysreg
>     0000000040041000-0000000040041fff (prio -1000, i/o): emac
>     0000000040043000-0000000040043fff (prio -1000, i/o): usb
>     0000000060000000-000000006003ffff (prio 0, rom): MSF2.eNVM
>     00000000a0000000-00000000a3ffffff (prio 0, ram): ddr-ram
>
> So I set cpu.init-sp close to the end of the SRAM (0x2000fff0).
>
> Without your patch:
>
> PMSA MPU lookup for execute at 0xa0008000 mmu_idx 65 -> Miss (prot rw-)
> Taking exception 3 [Prefetch Abort]
> ...with CFSR.IACCVIOL
> PMSA MPU lookup for writing at 0xffffffe0 mmu_idx 65 -> Hit (prot rw-)
> ...BusFault with BFSR.STKERR
> ...taking pending nonsecure exception 3
> PMSA MPU lookup for execute at 0x00000000 mmu_idx 67 -> Hit (prot rwx)
> ----------------
> IN:
> PMSA MPU lookup for reading at 0x00000000 mmu_idx 67 -> Hit (prot rwx)
> 0x00000000:  00000000  andeq    r0, r0, r0
>
> Taking exception 18 [v7M INVSTATE UsageFault]
> qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)
>
> R00=3D00000000 R01=3D00000000 R02=3D00000000 R03=3D00000000
> R04=3D00000000 R05=3D00000000 R06=3D00000000 R07=3D00000000
> R08=3D00000000 R09=3D00000000 R10=3D00000000 R11=3D00000000
> R12=3D00000000 R13=3Dffffffe0 R14=3Dfffffff9 R15=3D00000000
> XPSR=3D40000003 -Z-- A handler
> FPSCR: 00000000
> Aborted (core dumped)
>
> 304             } else if (cpu->init_sp || cpu->init_entry) {
> (gdb)
> 305                 initial_msp =3D cpu->init_sp;
> (gdb)
> 306                 initial_pc =3D cpu->init_entry;
> (gdb)
> 317             env->regs[13] =3D initial_msp & 0xFFFFFFFC;
> (gdb) p/x initial_msp
> $1 =3D 0x2000fff0
> (gdb) p/x initial_pc
> $2 =3D 0xa0008001
> (gdb) n
> 318             env->regs[15] =3D initial_pc & ~1;
> (gdb)
> 319             env->thumb =3D initial_pc & 1;
>
> I don't understand where I get $pc reset...

Thanks for testing!

I'm a little confused with whats going on here, it doesn't work
without my patch and with my patch it still doesn't work? From the GDB
output it looks like the value setting is working in the reset, are
you sure those are the correct values?

I haven't tested with the emcraft-sf2 machine as I am focused on the
STM. For the STM this is all read when the elf is loaded and I'm not
manually setting anything.

Alistair

>
> >      }
> >
> >      qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index f9da672be5..290fac19d3 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -805,6 +805,9 @@ struct ARMCPU {
> >       */
> >      uint32_t psci_conduit;
> >
> > +    /* For M, initial value of the entry and SP */
> > +    uint32_t init_sp, init_entry;
> > +
> >      /* For v8M, initial value of the Secure VTOR */
> >      uint32_t init_svtor;
> >
> >

