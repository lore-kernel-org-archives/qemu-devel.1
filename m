Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0628C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 01:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49DD120722
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 01:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StA1JdZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DD120722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq4is-0002NP-Fo
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 21:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jq4hg-0001Xn-FK; Mon, 29 Jun 2020 21:04:53 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:34169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jq4hc-000449-TP; Mon, 29 Jun 2020 21:04:50 -0400
Received: by mail-yb1-xb42.google.com with SMTP id j19so6254564ybj.1;
 Mon, 29 Jun 2020 18:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2gloZ1BcqS3npr+OTl9aFg3Kcknp3tiU9+fhtRKt120=;
 b=StA1JdZUwDrAX5ViC6Os7mgpcPj7P2Dur+H8V7BNkMbatclxVq4lDig6Re/5Pb7BfI
 cOFWFSQN4cVHWhF8cKInLgxRpdQUfe89V5JNNcCJWlHWuDoK3JBq8n7yINARxSzmId88
 sryDAl3QbzcgSCng1rtMvwrtNtRi0wEUjlACXhO50Ehf0nD5ncm+Od2yfhYBCYpY3DgZ
 3Z69cShB3Ve2frUAt45o1X+LzyPN2pXHzWeIHfowow8nwL/nFpA8ZVLxxrKs1vZc0WXb
 hPQw3Btv9LVEfrT3csg2lI1aA7HyJK2ENBZfXqhGa+hSjbhWuZmdgypJzBGDj27FLEcC
 7t+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2gloZ1BcqS3npr+OTl9aFg3Kcknp3tiU9+fhtRKt120=;
 b=Idia7WeNaKH0cuURdU6UhFHgUYOlc0swL/ChQOrR9GRqmt9z1AX25koCOriBJ1A/mP
 NRkbFdG3pfSr1AXt1ZS6K7DinrrAXNtQVsnF3lVTfF5sOcp9BmFahLjFHechloDqU93J
 HXknZQXw1MquK0D0wcHclYPA54DFa+cSSrlr+0A0yMciIjxQCZwRxcpNQ8UK8bTeQf7R
 FbsmiXGvSTKqiFohO+YnjBIuHnUxggj1U2hD7rNAFHkWz34VWICiBx3cNmmcYjP4hOAg
 PTvoj933vJqXr0zVxpMtJ7UFubdXN0hHSyDY7yhnBqIqXSFhCSdRD1gV6Zz7oRasuwfQ
 C/Qw==
X-Gm-Message-State: AOAM531UBIRJm6VDvaTKRl+8nMt8aRIq6VxqyG2X1Lkd7w54WJJTWwAy
 j/mr81L+sg5BzgfDJZVWpcPmppYEDy3KrHEirMM=
X-Google-Smtp-Source: ABdhPJwr+X+uQIJQAF6r1S4JLSeua7S122A5p8sKCnq0xVvwll5x9YFD9rUND2DTpBmAs1Wive/nLegaItBTv2Htb0g=
X-Received: by 2002:a25:5806:: with SMTP id m6mr999839ybb.152.1593479087085;
 Mon, 29 Jun 2020 18:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200626003313.715355-1-atish.patra@wdc.com>
 <20200626003313.715355-3-atish.patra@wdc.com>
 <CAEUhbmUCJcosvYd44qPMXdkE+Bj2MUcFBvz1VWSZL2w-6Z3d6g@mail.gmail.com>
 <CAOnJCUKr5XXga5B02WDOeiyvEjgpAfcqp_VN-y2AAD0vXsn2Uw@mail.gmail.com>
 <CAEUhbmVH9RauXydanCv6OpVAMi9cKP4OaJetgNx3vaVSoPSQBw@mail.gmail.com>
 <CAOnJCUJzF0rBEqUFCjgwFQ36m-WO3yuvUY9BD8N6SCTTeLKZ3Q@mail.gmail.com>
 <CAEUhbmXjyBa_Ejn+2joL5w7qOC08eub1zOktDfMTGrFa46PJ6Q@mail.gmail.com>
 <CAOnJCU+VtjnaN=3wVNZMdBMjrj3ag1gnA6okfROA85um8pKqsA@mail.gmail.com>
In-Reply-To: <CAOnJCU+VtjnaN=3wVNZMdBMjrj3ag1gnA6okfROA85um8pKqsA@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 30 Jun 2020 09:04:35 +0800
Message-ID: <CAEUhbmVG=rT2qZ8x=cpBQOg8my3n4cuG98xGPjVqyLgpx-aT+A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] RISC-V: Copy the fdt in dram instead of ROM
To: Atish Patra <atishp@atishpatra.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alexander Richardson <Alexander.Richardson@cl.cam.ac.uk>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 2:50 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Sat, Jun 27, 2020 at 2:55 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > On Sat, Jun 27, 2020 at 12:37 PM Atish Patra <atishp@atishpatra.org> wrote:
> > >
> > > On Fri, Jun 26, 2020 at 7:54 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > >
> > > > Hi Atish,
> > > >
> > > > On Sat, Jun 27, 2020 at 12:58 AM Atish Patra <atishp@atishpatra.org> wrote:
> > > > >
> > > > > On Fri, Jun 26, 2020 at 4:50 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > > >
> > > > > > Hi Atish,
> > > > > >
> > > > > > On Fri, Jun 26, 2020 at 8:33 AM Atish Patra <atish.patra@wdc.com> wrote:
> > > > > > >
> > > > > > > Currently, the fdt is copied to the ROM after the reset vector. The firmware
> > > > > > > has to copy it to DRAM. Instead of this, directly copy the device tree to a
> > > > > > > pre-computed dram address. The device tree load address should be as far as
> > > > > > > possible from kernel and initrd images. That's why it is kept at the end of
> > > > > > > the DRAM or 4GB whichever is lesser.
> > > > > > >
> > > > > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > > > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > > > ---
> > > > > > >  hw/riscv/boot.c         | 57 +++++++++++++++++++++++++++++------------
> > > > > > >  hw/riscv/sifive_u.c     | 32 +++++++++++------------
> > > > > > >  hw/riscv/spike.c        |  7 ++++-
> > > > > > >  hw/riscv/virt.c         |  7 ++++-
> > > > > > >  include/hw/riscv/boot.h |  5 +++-
> > > > > > >  5 files changed, 71 insertions(+), 37 deletions(-)
> > > > > > >
> > > > > > > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > > > > > > index 482b78147993..02c4018a8105 100644
> > > > > > > --- a/hw/riscv/boot.c
> > > > > > > +++ b/hw/riscv/boot.c
> > > > > > > @@ -159,44 +159,67 @@ hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
> > > > > > >      return *start + size;
> > > > > > >  }
> > > > > > >
> > > > > > > +hwaddr riscv_load_fdt(hwaddr dram_base, uint64_t mem_size, void *fdt)
> > > > > >
> > > > > > I think we should use uint32_t for the return value type, since it is
> > > > > > always below 4GiB
> > > > > >
> > > > >
> > > > > You are correct. I will update it. Thanks.
> > > > > > > +{
> > > > > > > +    hwaddr temp, fdt_addr;
> > > > > > > +    hwaddr dram_end = dram_base + mem_size;
> > > > > > > +    int fdtsize = fdt_totalsize(fdt);
> > > > > > > +
> > > > > > > +    if (fdtsize <= 0) {
> > > > > > > +        error_report("invalid device-tree");
> > > > > > > +        exit(1);
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    /*
> > > > > > > +     * We should put fdt as far as possible to avoid kernel/initrd overwriting
> > > > > > > +     * its content. But it should be addressable by 32 bit system as well.
> > > > > > > +     * Thus, put it at an aligned address that less than fdt size from end of
> > > > > > > +     * dram or 4GB whichever is lesser.
> > > > > > > +     */
> > > > > > > +    temp = MIN(dram_end, 4096 * MiB);
> > > > > > > +    fdt_addr = QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
> > > > > > > +
> > > > > > > +    fdt_pack(fdt);
> > > > > > > +    /* copy in the device tree */
> > > > > > > +    qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
> > > > > >
> > > > > > Use fdtsize
> > > > > >
> > > > >
> > > > > Sure.
> > > > > > > +
> > > > > > > +    rom_add_blob_fixed_as("fdt", fdt, fdtsize, fdt_addr,
> > > > > > > +                          &address_space_memory);
> > > > > > > +
> > > > > > > +    return fdt_addr;
> > > > > > > +}
> > > > > > > +
> > > > > > >  void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
> > > > > > > -                               hwaddr rom_size, void *fdt)
> > > > > > > +                               hwaddr rom_size,
> > > > > > > +                               hwaddr fdt_load_addr, void *fdt)
> > > > > > >  {
> > > > > > >      int i;
> > > > > > >      /* reset vector */
> > > > > > > -    uint32_t reset_vec[8] = {
> > > > > > > -        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(dtb) */
> > > > > > > -        0x02028593,                  /*     addi   a1, t0, %pcrel_lo(1b) */
> > > > > > > +    uint32_t reset_vec[10] = {
> > > > > > > +        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
> > > > > >
> > > > > > fw_dync should be introduced in the next patch, so this line should be
> > > > > > kept unchanged in this patch
> > > > > >
> > > > > As we have fdt_laddr, keeping it unchanged may create confusion with
> > > > > another dtb label.
> > > > > I will change the label to "end" in the next version.
> > > > >
> > > > > > >          0xf1402573,                  /*     csrr   a0, mhartid  */
> > > > > > >  #if defined(TARGET_RISCV32)
> > > > > > > +        0x0202a583,                  /*     lw     a1, 32(t0) */
> > > > > > >          0x0182a283,                  /*     lw     t0, 24(t0) */
> > > > > > >  #elif defined(TARGET_RISCV64)
> > > > > > > +        0x0202b583,                  /*     ld     a1, 32(t0) */
> > > > > > >          0x0182b283,                  /*     ld     t0, 24(t0) */
> > > > > > >  #endif
> > > > > > >          0x00028067,                  /*     jr     t0 */
> > > > > > >          0x00000000,
> > > > > > >          start_addr,                  /* start: .dword */
> > > > > > >          0x00000000,
> > > > > > > -                                     /* dtb: */
> > > > > > > +        fdt_load_addr,               /* fdt_laddr: .dword */
> > > > > > > +        0x00000000,
> > > > > > > +                                     /* fw_dyn: */
> > > > > > >      };
> > > > > > >
> > > > > > >      /* copy in the reset vector in little_endian byte order */
> > > > > > > -    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> > > > > > > +    for (i = 0; i < ARRAY_SIZE(reset_vec); i++) {
> > > > > > >          reset_vec[i] = cpu_to_le32(reset_vec[i]);
> > > > > > >      }
> > > > > > >      rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
> > > > > > >                            rom_base, &address_space_memory);
> > > > > > >
> > > > > > > -    /* copy in the device tree */
> > > > > > > -    if (fdt_pack(fdt) || fdt_totalsize(fdt) >
> > > > > > > -        rom_size - sizeof(reset_vec)) {
> > > > > > > -        error_report("not enough space to store device-tree");
> > > > > > > -        exit(1);
> > > > > > > -    }
> > > > > > > -    qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
> > > > > > > -    rom_add_blob_fixed_as("mrom.fdt", fdt, fdt_totalsize(fdt),
> > > > > > > -                           rom_base + sizeof(reset_vec),
> > > > > > > -                           &address_space_memory);
> > > > > > > -
> > > > > > >      return;
> > > > > > >  }
> > > > > > > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > > > > > > index 395b21703ab4..7d39a4e4ec6d 100644
> > > > > > > --- a/hw/riscv/sifive_u.c
> > > > > > > +++ b/hw/riscv/sifive_u.c
> > > > > > > @@ -379,6 +379,7 @@ static void sifive_u_machine_init(MachineState *machine)
> > > > > > >      MemoryRegion *flash0 = g_new(MemoryRegion, 1);
> > > > > > >      target_ulong start_addr = memmap[SIFIVE_U_DRAM].base;
> > > > > > >      int i;
> > > > > > > +    hwaddr fdt_load_addr;
> > > > > > >
> > > > > > >      /* Initialize SoC */
> > > > > > >      object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_U_SOC);
> > > > > > > @@ -450,40 +451,37 @@ static void sifive_u_machine_init(MachineState *machine)
> > > > > > >          }
> > > > > > >      }
> > > > > > >
> > > > > > > +    /* Compute the fdt load address in dram */
> > > > > > > +    fdt_load_addr = riscv_load_fdt(memmap[SIFIVE_U_DRAM].base,
> > > > > > > +                                   machine->ram_size, s->fdt);
> > > > > > > +
> > > > > > >      /* reset vector */
> > > > > > > -    uint32_t reset_vec[8] = {
> > > > > > > +    uint32_t reset_vec[11] = {
> > > > > > >          s->msel,                       /* MSEL pin state */
> > > > > > > -        0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(dtb) */
> > > > > > > -        0x01c28593,                    /*     addi   a1, t0, %pcrel_lo(1b) */
> > > > > > > +        0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
> > > > > > >          0xf1402573,                    /*     csrr   a0, mhartid  */
> > > > > > >  #if defined(TARGET_RISCV32)
> > > > > > > +        0x0202a583,                    /*     lw     a1, 32(t0) */
> > > > > > >          0x0182a283,                    /*     lw     t0, 24(t0) */
> > > > > > >  #elif defined(TARGET_RISCV64)
> > > > > > > -        0x0182e283,                    /*     lwu    t0, 24(t0) */
> > > > > > > +        0x0202b583,                    /*     ld     a1, 32(t0) */
> > > > > > > +        0x0182b283,                    /*     ld     t0, 24(t0) */
> > > > > >
> > > > > > This change (lwu => ld) is unnecessary.
> > > > > >
> > > > > start_addr is a dword. Currently, the start address is within 32 bits.
> > > > > But it can be changed to more than 32 bits. No ?
> > > >
> > > > For RV32, only 32-bit can be used here. For Rv64, I am not sure
> > > > whether it is a big value to support jumping directly to 4GiB address
> > > > above in QEMU. For FU540 SoC, all possible boot adddresses are below
> > > > 4GiB so I think there is no need to support that in QEMU.
> > > >
> > >
> > > That's true only for hifive unleashed. But that may change for future
> > > generations of sifive socs.
> > > But I was trying to say that it is confusing to use a lwu for a dword
> > > (as per the comment section).
> > > If you prefer to use lwu only, we should cast it to a 32 bit value,
> > > update the comment and use lwu.
> > >
> > > I prefer ld because it is not ambiguous and future proof as well.
> >
> > If we use ld, then please fix the 0x00000000 entry, so that it becomes
> > the high 32-bit of start_addr.
> >
>
> I am bit confused. It is already happening. Otherwise, it won't boot.

Currently all machines are using 32-bit start_addr. Because the high
32-bit of the start_addr is hardcoded to zero, as I mentioned.

Regards,
Bin

