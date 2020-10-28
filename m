Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B616C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 02:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8CEF20709
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 02:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3Ftg153"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8CEF20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXasE-0001rq-PY
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 22:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXare-0001S7-Vr; Tue, 27 Oct 2020 22:07:03 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:42638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXard-0000i3-1G; Tue, 27 Oct 2020 22:07:02 -0400
Received: by mail-yb1-xb44.google.com with SMTP id a12so2956370ybg.9;
 Tue, 27 Oct 2020 19:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GCTuKbs0MTqN0jlRoij574zIRN4+H2PXsJGuJwuOpfA=;
 b=O3Ftg153nJbDmshzEMf16K2DLuzfFS9P4+vrXvV6YpqcSlHlz3UJXryS137vcfHwPs
 0trI+andkraIFP/+88CaN01k62WXRY1Q7kpY3X3wcuDXAloUk1xUxSbEepxtdkbbhHrq
 APXgTlSH/iaLy1t9ka4MWKgQz+Ignj7ikb5vAQQ/w25+r4SC3/st/5KxFRpjK1PA/sBM
 X+xBaQXPxFpTJkt+jJc5wr302dmkbvwx+odMxFx2maS2WtLItIi0EfOvL0GSSzIhPism
 8wfGQkA6E+C1zJ3Rm/nXsQGYmGduTHyR3JuKb3Klr1hlHQ1xt286RNgeN2XEme4uKSkL
 9dUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GCTuKbs0MTqN0jlRoij574zIRN4+H2PXsJGuJwuOpfA=;
 b=C7l5iJibFwBH+1st4Lo3ghl0er1HoQ3XOF5wtoJ5ntBjoqWcWuzy7Gat8um3sBvVE6
 nKukh3uLHVZng40sHD9hDRqmqgFiHRwJ1uVX6982AImQf1q1aeO62nq+xTRXDqEJMwH0
 xeIoynOWmXwafyeisnzYHtgnafoRYW1PXvKwFQXVu/VNRnhnkY+lpMjr198ZdOKX1dL5
 UF08eZcntQkYOPF9ax1rcFAw75uLTTyw8DxdrfwE/bQMmaJjkiJ+h/YLbFlBToDRLggk
 mI1ciEj6SiL/KzCKd9aqMeYDITAWjZS2LKds+iJSO2JD2G7164o6ecIkuONrEKqjCpr/
 vkPQ==
X-Gm-Message-State: AOAM530d8bkTvXsrOSCtyvsmd7KS81EhXXegwhFjEXYqyYPYhhPxddLe
 m7MI2CxqB0vegtySO9t7pT/tcTPnq5PD2YJEjNc=
X-Google-Smtp-Source: ABdhPJwQzvnrUuUewcRxjYuKrPiWX/ULjZSyf90K8scw4Nq8Dd1kS17Xoue2V5ZWIrRaqmYgbvNuwUKbebO+4Z+7uE4=
X-Received: by 2002:a25:386:: with SMTP id 128mr7213003ybd.122.1603850819320; 
 Tue, 27 Oct 2020 19:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201027141740.18336-1-bmeng.cn@gmail.com>
 <20201027141740.18336-9-bmeng.cn@gmail.com>
 <CAKmqyKPx0GeMCtBsPJ_VXf7ukMKemXMebEMaXSCABg+qN7va9Q@mail.gmail.com>
In-Reply-To: <CAKmqyKPx0GeMCtBsPJ_VXf7ukMKemXMebEMaXSCABg+qN7va9Q@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 28 Oct 2020 10:06:48 +0800
Message-ID: <CAEUhbmUj8ETrtvLnxPeqLrrs8igFm=qbrJpE+_z=u8yt5VYbMQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 8/9] hw/riscv: microchip_pfsoc: Correct DDR memory
 map
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Anup Patel <anup.patel@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Ivan Griffin <ivan.griffin@emdalo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On Wed, Oct 28, 2020 at 5:07 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Tue, Oct 27, 2020 at 7:48 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > When system memory is larger than 1 GiB (high memory), PolarFire SoC
> > maps it at address 0x10_0000_0000. Address 0xC000_0000 and above is
> > aliased to the same 1 GiB low memory with different cache attributes.
> >
> > At present QEMU maps the system memory contiguously from 0x8000_0000.
> > This corrects the wrong QEMU logic. Note address 0x14_0000_0000 is
> > the alias to the high memory, and even physical memory is only 1 GiB,
> > the HSS codes still tries to probe the high memory alias address.
> > It seems there is no issue on the real hardware, so we will have to
> > take that into the consideration in our emulation.
> >
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > ---
> >
> >  hw/riscv/microchip_pfsoc.c         | 49 +++++++++++++++++++++++++++---
> >  include/hw/riscv/microchip_pfsoc.h |  5 ++-
> >  2 files changed, 48 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> > index b9c2f73e7c..c595c9c967 100644
> > --- a/hw/riscv/microchip_pfsoc.c
> > +++ b/hw/riscv/microchip_pfsoc.c
> > @@ -102,7 +102,10 @@ static const struct MemmapEntry {
> >      [MICROCHIP_PFSOC_ENVM_CFG] =        { 0x20200000,     0x1000 },
> >      [MICROCHIP_PFSOC_ENVM_DATA] =       { 0x20220000,    0x20000 },
> >      [MICROCHIP_PFSOC_IOSCB] =           { 0x30000000, 0x10000000 },
> > -    [MICROCHIP_PFSOC_DRAM] =            { 0x80000000,        0x0 },
> > +    [MICROCHIP_PFSOC_DRAM_LO] =         { 0x80000000, 0x40000000 },
> > +    [MICROCHIP_PFSOC_DRAM_LO_ALIAS] =   { 0xc0000000, 0x40000000 },
> > +    [MICROCHIP_PFSOC_DRAM_HI] =       { 0x1000000000,        0x0 },
> > +    [MICROCHIP_PFSOC_DRAM_HI_ALIAS] = { 0x1400000000,        0x0 },
> >  };
> >
> >  static void microchip_pfsoc_soc_instance_init(Object *obj)
> > @@ -405,7 +408,11 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
> >      const struct MemmapEntry *memmap = microchip_pfsoc_memmap;
> >      MicrochipIcicleKitState *s = MICROCHIP_ICICLE_KIT_MACHINE(machine);
> >      MemoryRegion *system_memory = get_system_memory();
> > -    MemoryRegion *main_mem = g_new(MemoryRegion, 1);
> > +    MemoryRegion *mem_low = g_new(MemoryRegion, 1);
> > +    MemoryRegion *mem_low_alias = g_new(MemoryRegion, 1);
> > +    MemoryRegion *mem_high = g_new(MemoryRegion, 1);
> > +    MemoryRegion *mem_high_alias = g_new(MemoryRegion, 1);
> > +    uint64_t mem_high_size;
> >      DriveInfo *dinfo = drive_get_next(IF_SD);
> >
> >      /* Sanity check on RAM size */
> > @@ -422,10 +429,42 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
> >      qdev_realize(DEVICE(&s->soc), NULL, &error_abort);
> >
> >      /* Register RAM */
> > -    memory_region_init_ram(main_mem, NULL, "microchip.icicle.kit.ram",
> > -                           machine->ram_size, &error_fatal);
> > +    memory_region_init_ram(mem_low, NULL, "microchip.icicle.kit.ram_low",
> > +                           memmap[MICROCHIP_PFSOC_DRAM_LO].size,
> > +                           &error_fatal);
> > +    memory_region_init_alias(mem_low_alias, NULL,
> > +                             "microchip.icicle.kit.ram_low.alias",
> > +                             mem_low, 0,
> > +                             memmap[MICROCHIP_PFSOC_DRAM_LO_ALIAS].size);
> > +    memory_region_add_subregion(system_memory,
> > +                                memmap[MICROCHIP_PFSOC_DRAM_LO].base,
> > +                                mem_low);
> > +    memory_region_add_subregion(system_memory,
> > +                                memmap[MICROCHIP_PFSOC_DRAM_LO_ALIAS].base,
> > +                                mem_low_alias);
> > +
> > +    /*
> > +     * Map 1 GiB high memory because HSS will do memory test against the high
> > +     * memory address range regardless of physical memory installed.
> > +     *
> > +     * See memory_tests() in mss_ddr.c in the HSS source code.
> > +     */
> > +    mem_high_size = machine->ram_size - 1 * GiB;
> > +    if (mem_high_size < 1 * GiB) {
> > +        mem_high_size = 1 * GiB;
>
> This now means that the machine requires at least 2GB of memory!

Yes, unfortunately :(

>
> Can you increase the default_ram_size so we will return an error if
> the user specified less than 2GB instead of just increasing it without
> their knowledge?
>

Sure.

Regards,
Bin

