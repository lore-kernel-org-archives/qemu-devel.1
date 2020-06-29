Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3663C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 18:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30C6204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 18:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="hKYnhwgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30C6204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpysw-0006pX-WB
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 14:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@atishpatra.org>)
 id 1jpyrN-0006FK-AX
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 14:50:29 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@atishpatra.org>)
 id 1jpyrK-00052J-3W
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 14:50:29 -0400
Received: by mail-wm1-x344.google.com with SMTP id o2so17125844wmh.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 11:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atishpatra.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+zfmYqYsam5Me3RkDHR2kMw2SoKHgjE2RQQ/z7iQ9kk=;
 b=hKYnhwgWw0E2cvEiw1hLpxx6jsSsjj6+/GhFkomb7qhz+Xl/xeGeDH14ZW5eEfPozy
 TMk7ClmINvQ2AMCJcXuK67NidjqICM05pHIIT4L4zhvGvgtgEqJRk8Cn7Wbwi2QZTQ3e
 i3LNxoHv2+U5rIgoeJKbfZTT0gSfiZ1Ojd+ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+zfmYqYsam5Me3RkDHR2kMw2SoKHgjE2RQQ/z7iQ9kk=;
 b=GuUTNhR5hm5312OeXVUoLZfptpn7i1WOgVh8wAJwzGs3ho/4FWoZw22uD5VLYPExZs
 sUfBFWu2GLqqUYd5zK5SApAAJT3fXhS9peFzdRrphrlMooDHYS8sDs37xheXDLokFsKK
 kQhIkNwr6ixFarRG4Ip/7QrlaCLQV1RJKwc4qAJDKX/C0jY4c/QbL1ByFxe3Jc+VLKlv
 myZKUX3iojTAFeTxkz80TxL/8GufxLwk9xbxGffTfI/r0w/bvgFJWZKCXv616qU0xtOH
 MHSzorErkO62KCEgrGSBOo3129bzkt0V+wSe4SKG9SdnIc3yFflZBPYEbcHDUUFetkQe
 wMKw==
X-Gm-Message-State: AOAM532mZi9sxT8flg5r4leM/OO6VC8YovTKdEtstZPBhmm7+z90N+gj
 nTNcZaUTzd8xLZXysTB/OaWHg9Ybi9mEEqRN6G6a
X-Google-Smtp-Source: ABdhPJw5kscBVoTtad/J5QtoOVHC/M1oCvgIXtdlc+hUYhnn7NMcErCws8zDq8ZDp7nXDqBnKuTXOmrLx/SgNYFLGQU=
X-Received: by 2002:a1c:345:: with SMTP id 66mr2976695wmd.31.1593456623745;
 Mon, 29 Jun 2020 11:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200626003313.715355-1-atish.patra@wdc.com>
 <20200626003313.715355-3-atish.patra@wdc.com>
 <CAEUhbmUCJcosvYd44qPMXdkE+Bj2MUcFBvz1VWSZL2w-6Z3d6g@mail.gmail.com>
 <CAOnJCUKr5XXga5B02WDOeiyvEjgpAfcqp_VN-y2AAD0vXsn2Uw@mail.gmail.com>
 <CAEUhbmVH9RauXydanCv6OpVAMi9cKP4OaJetgNx3vaVSoPSQBw@mail.gmail.com>
 <CAOnJCUJzF0rBEqUFCjgwFQ36m-WO3yuvUY9BD8N6SCTTeLKZ3Q@mail.gmail.com>
 <CAEUhbmXjyBa_Ejn+2joL5w7qOC08eub1zOktDfMTGrFa46PJ6Q@mail.gmail.com>
In-Reply-To: <CAEUhbmXjyBa_Ejn+2joL5w7qOC08eub1zOktDfMTGrFa46PJ6Q@mail.gmail.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Mon, 29 Jun 2020 11:50:12 -0700
Message-ID: <CAOnJCU+VtjnaN=3wVNZMdBMjrj3ag1gnA6okfROA85um8pKqsA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] RISC-V: Copy the fdt in dram instead of ROM
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=atishp@atishpatra.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sat, Jun 27, 2020 at 2:55 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Sat, Jun 27, 2020 at 12:37 PM Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Fri, Jun 26, 2020 at 7:54 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > Hi Atish,
> > >
> > > On Sat, Jun 27, 2020 at 12:58 AM Atish Patra <atishp@atishpatra.org> wrote:
> > > >
> > > > On Fri, Jun 26, 2020 at 4:50 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > >
> > > > > Hi Atish,
> > > > >
> > > > > On Fri, Jun 26, 2020 at 8:33 AM Atish Patra <atish.patra@wdc.com> wrote:
> > > > > >
> > > > > > Currently, the fdt is copied to the ROM after the reset vector. The firmware
> > > > > > has to copy it to DRAM. Instead of this, directly copy the device tree to a
> > > > > > pre-computed dram address. The device tree load address should be as far as
> > > > > > possible from kernel and initrd images. That's why it is kept at the end of
> > > > > > the DRAM or 4GB whichever is lesser.
> > > > > >
> > > > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > > ---
> > > > > >  hw/riscv/boot.c         | 57 +++++++++++++++++++++++++++++------------
> > > > > >  hw/riscv/sifive_u.c     | 32 +++++++++++------------
> > > > > >  hw/riscv/spike.c        |  7 ++++-
> > > > > >  hw/riscv/virt.c         |  7 ++++-
> > > > > >  include/hw/riscv/boot.h |  5 +++-
> > > > > >  5 files changed, 71 insertions(+), 37 deletions(-)
> > > > > >
> > > > > > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > > > > > index 482b78147993..02c4018a8105 100644
> > > > > > --- a/hw/riscv/boot.c
> > > > > > +++ b/hw/riscv/boot.c
> > > > > > @@ -159,44 +159,67 @@ hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
> > > > > >      return *start + size;
> > > > > >  }
> > > > > >
> > > > > > +hwaddr riscv_load_fdt(hwaddr dram_base, uint64_t mem_size, void *fdt)
> > > > >
> > > > > I think we should use uint32_t for the return value type, since it is
> > > > > always below 4GiB
> > > > >
> > > >
> > > > You are correct. I will update it. Thanks.
> > > > > > +{
> > > > > > +    hwaddr temp, fdt_addr;
> > > > > > +    hwaddr dram_end = dram_base + mem_size;
> > > > > > +    int fdtsize = fdt_totalsize(fdt);
> > > > > > +
> > > > > > +    if (fdtsize <= 0) {
> > > > > > +        error_report("invalid device-tree");
> > > > > > +        exit(1);
> > > > > > +    }
> > > > > > +
> > > > > > +    /*
> > > > > > +     * We should put fdt as far as possible to avoid kernel/initrd overwriting
> > > > > > +     * its content. But it should be addressable by 32 bit system as well.
> > > > > > +     * Thus, put it at an aligned address that less than fdt size from end of
> > > > > > +     * dram or 4GB whichever is lesser.
> > > > > > +     */
> > > > > > +    temp = MIN(dram_end, 4096 * MiB);
> > > > > > +    fdt_addr = QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
> > > > > > +
> > > > > > +    fdt_pack(fdt);
> > > > > > +    /* copy in the device tree */
> > > > > > +    qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
> > > > >
> > > > > Use fdtsize
> > > > >
> > > >
> > > > Sure.
> > > > > > +
> > > > > > +    rom_add_blob_fixed_as("fdt", fdt, fdtsize, fdt_addr,
> > > > > > +                          &address_space_memory);
> > > > > > +
> > > > > > +    return fdt_addr;
> > > > > > +}
> > > > > > +
> > > > > >  void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
> > > > > > -                               hwaddr rom_size, void *fdt)
> > > > > > +                               hwaddr rom_size,
> > > > > > +                               hwaddr fdt_load_addr, void *fdt)
> > > > > >  {
> > > > > >      int i;
> > > > > >      /* reset vector */
> > > > > > -    uint32_t reset_vec[8] = {
> > > > > > -        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(dtb) */
> > > > > > -        0x02028593,                  /*     addi   a1, t0, %pcrel_lo(1b) */
> > > > > > +    uint32_t reset_vec[10] = {
> > > > > > +        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
> > > > >
> > > > > fw_dync should be introduced in the next patch, so this line should be
> > > > > kept unchanged in this patch
> > > > >
> > > > As we have fdt_laddr, keeping it unchanged may create confusion with
> > > > another dtb label.
> > > > I will change the label to "end" in the next version.
> > > >
> > > > > >          0xf1402573,                  /*     csrr   a0, mhartid  */
> > > > > >  #if defined(TARGET_RISCV32)
> > > > > > +        0x0202a583,                  /*     lw     a1, 32(t0) */
> > > > > >          0x0182a283,                  /*     lw     t0, 24(t0) */
> > > > > >  #elif defined(TARGET_RISCV64)
> > > > > > +        0x0202b583,                  /*     ld     a1, 32(t0) */
> > > > > >          0x0182b283,                  /*     ld     t0, 24(t0) */
> > > > > >  #endif
> > > > > >          0x00028067,                  /*     jr     t0 */
> > > > > >          0x00000000,
> > > > > >          start_addr,                  /* start: .dword */
> > > > > >          0x00000000,
> > > > > > -                                     /* dtb: */
> > > > > > +        fdt_load_addr,               /* fdt_laddr: .dword */
> > > > > > +        0x00000000,
> > > > > > +                                     /* fw_dyn: */
> > > > > >      };
> > > > > >
> > > > > >      /* copy in the reset vector in little_endian byte order */
> > > > > > -    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> > > > > > +    for (i = 0; i < ARRAY_SIZE(reset_vec); i++) {
> > > > > >          reset_vec[i] = cpu_to_le32(reset_vec[i]);
> > > > > >      }
> > > > > >      rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
> > > > > >                            rom_base, &address_space_memory);
> > > > > >
> > > > > > -    /* copy in the device tree */
> > > > > > -    if (fdt_pack(fdt) || fdt_totalsize(fdt) >
> > > > > > -        rom_size - sizeof(reset_vec)) {
> > > > > > -        error_report("not enough space to store device-tree");
> > > > > > -        exit(1);
> > > > > > -    }
> > > > > > -    qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
> > > > > > -    rom_add_blob_fixed_as("mrom.fdt", fdt, fdt_totalsize(fdt),
> > > > > > -                           rom_base + sizeof(reset_vec),
> > > > > > -                           &address_space_memory);
> > > > > > -
> > > > > >      return;
> > > > > >  }
> > > > > > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > > > > > index 395b21703ab4..7d39a4e4ec6d 100644
> > > > > > --- a/hw/riscv/sifive_u.c
> > > > > > +++ b/hw/riscv/sifive_u.c
> > > > > > @@ -379,6 +379,7 @@ static void sifive_u_machine_init(MachineState *machine)
> > > > > >      MemoryRegion *flash0 = g_new(MemoryRegion, 1);
> > > > > >      target_ulong start_addr = memmap[SIFIVE_U_DRAM].base;
> > > > > >      int i;
> > > > > > +    hwaddr fdt_load_addr;
> > > > > >
> > > > > >      /* Initialize SoC */
> > > > > >      object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_U_SOC);
> > > > > > @@ -450,40 +451,37 @@ static void sifive_u_machine_init(MachineState *machine)
> > > > > >          }
> > > > > >      }
> > > > > >
> > > > > > +    /* Compute the fdt load address in dram */
> > > > > > +    fdt_load_addr = riscv_load_fdt(memmap[SIFIVE_U_DRAM].base,
> > > > > > +                                   machine->ram_size, s->fdt);
> > > > > > +
> > > > > >      /* reset vector */
> > > > > > -    uint32_t reset_vec[8] = {
> > > > > > +    uint32_t reset_vec[11] = {
> > > > > >          s->msel,                       /* MSEL pin state */
> > > > > > -        0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(dtb) */
> > > > > > -        0x01c28593,                    /*     addi   a1, t0, %pcrel_lo(1b) */
> > > > > > +        0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
> > > > > >          0xf1402573,                    /*     csrr   a0, mhartid  */
> > > > > >  #if defined(TARGET_RISCV32)
> > > > > > +        0x0202a583,                    /*     lw     a1, 32(t0) */
> > > > > >          0x0182a283,                    /*     lw     t0, 24(t0) */
> > > > > >  #elif defined(TARGET_RISCV64)
> > > > > > -        0x0182e283,                    /*     lwu    t0, 24(t0) */
> > > > > > +        0x0202b583,                    /*     ld     a1, 32(t0) */
> > > > > > +        0x0182b283,                    /*     ld     t0, 24(t0) */
> > > > >
> > > > > This change (lwu => ld) is unnecessary.
> > > > >
> > > > start_addr is a dword. Currently, the start address is within 32 bits.
> > > > But it can be changed to more than 32 bits. No ?
> > >
> > > For RV32, only 32-bit can be used here. For Rv64, I am not sure
> > > whether it is a big value to support jumping directly to 4GiB address
> > > above in QEMU. For FU540 SoC, all possible boot adddresses are below
> > > 4GiB so I think there is no need to support that in QEMU.
> > >
> >
> > That's true only for hifive unleashed. But that may change for future
> > generations of sifive socs.
> > But I was trying to say that it is confusing to use a lwu for a dword
> > (as per the comment section).
> > If you prefer to use lwu only, we should cast it to a 32 bit value,
> > update the comment and use lwu.
> >
> > I prefer ld because it is not ambiguous and future proof as well.
>
> If we use ld, then please fix the 0x00000000 entry, so that it becomes
> the high 32-bit of start_addr.
>

I am bit confused. It is already happening. Otherwise, it won't boot.

> >
> > > >
> > > > > >  #endif
> > > > > >          0x00028067,                    /*     jr     t0 */
> > > > > >          0x00000000,
> > > > > >          start_addr,                    /* start: .dword */
> > > > > > -                                       /* dtb: */
> > > > > > +        0x00000000,
> > > > >
> > > > > unnecessary change. Above lwu can be kept unchanged
> > > > >
> > > > > > +        fdt_load_addr,                 /* fdt_laddr: .dword */
> > > > > > +        0x00000000,
> > > > > > +                                       /* fw_dyn: */
> > > > >
> > > > > should be in next patch
> > > > >
> > > > Will do.
> > > >
> > > > > >      };
> > > > > >
> > > > > >      /* copy in the reset vector in little_endian byte order */
> > > > > > -    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> > > > > > +    for (i = 0; i < ARRAY_SIZE(reset_vec); i++) {
> > > > > >          reset_vec[i] = cpu_to_le32(reset_vec[i]);
> > > > > >      }
> > > > > >      rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
> > > > > >                            memmap[SIFIVE_U_MROM].base, &address_space_memory);
> > > > > > -
> > > > > > -    /* copy in the device tree */
> > > > > > -    if (fdt_pack(s->fdt) || fdt_totalsize(s->fdt) >
> > > > > > -            memmap[SIFIVE_U_MROM].size - sizeof(reset_vec)) {
> > > > > > -        error_report("not enough space to store device-tree");
> > > > > > -        exit(1);
> > > > > > -    }
> > > > > > -    qemu_fdt_dumpdtb(s->fdt, fdt_totalsize(s->fdt));
> > > > > > -    rom_add_blob_fixed_as("mrom.fdt", s->fdt, fdt_totalsize(s->fdt),
> > > > > > -                          memmap[SIFIVE_U_MROM].base + sizeof(reset_vec),
> > > > > > -                          &address_space_memory);
> > > > > >  }
> > > > > >
> > > > > >  static bool sifive_u_machine_get_start_in_flash(Object *obj, Error **errp)
> > > > > > diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> > > > > > index c696077cbc16..69f050c07e5a 100644
> > > > > > --- a/hw/riscv/spike.c
> > > > > > +++ b/hw/riscv/spike.c
> > > > > > @@ -163,6 +163,7 @@ static void spike_board_init(MachineState *machine)
> > > > > >      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
> > > > > >      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> > > > > >      unsigned int smp_cpus = machine->smp.cpus;
> > > > > > +    hwaddr fdt_load_addr;
> > > > > >
> > > > > >      /* Initialize SOC */
> > > > > >      object_initialize_child(OBJECT(machine), "soc", &s->soc,
> > > > > > @@ -208,9 +209,13 @@ static void spike_board_init(MachineState *machine)
> > > > > >          }
> > > > > >      }
> > > > > >
> > > > > > +    /* Compute the fdt load address in dram */
> > > > > > +    fdt_load_addr = riscv_load_fdt(memmap[SPIKE_DRAM].base,
> > > > > > +                                   machine->ram_size, s->fdt);
> > > > > >      /* load the reset vector */
> > > > > >      riscv_setup_rom_reset_vec(memmap[SPIKE_DRAM].base, memmap[SPIKE_MROM].base,
> > > > > > -                              memmap[SPIKE_MROM].size, s->fdt);
> > > > > > +                              memmap[SPIKE_MROM].size,
> > > > > > +                              fdt_load_addr, s->fdt);
> > > > > >
> > > > > >      /* initialize HTIF using symbols found in load_kernel */
> > > > > >      htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
> > > > > > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > > > > > index 8ec77e43de26..639e284fc2e3 100644
> > > > > > --- a/hw/riscv/virt.c
> > > > > > +++ b/hw/riscv/virt.c
> > > > > > @@ -478,6 +478,7 @@ static void virt_machine_init(MachineState *machine)
> > > > > >      char *plic_hart_config;
> > > > > >      size_t plic_hart_config_len;
> > > > > >      target_ulong start_addr = memmap[VIRT_DRAM].base;
> > > > > > +    hwaddr fdt_load_addr;
> > > > > >      int i;
> > > > > >      unsigned int smp_cpus = machine->smp.cpus;
> > > > > >
> > > > > > @@ -532,9 +533,13 @@ static void virt_machine_init(MachineState *machine)
> > > > > >          start_addr = virt_memmap[VIRT_FLASH].base;
> > > > > >      }
> > > > > >
> > > > > > +    /* Compute the fdt load address in dram */
> > > > > > +    fdt_load_addr = riscv_load_fdt(memmap[VIRT_DRAM].base,
> > > > > > +                                   machine->ram_size, s->fdt);
> > > > > >      /* load the reset vector */
> > > > > >      riscv_setup_rom_reset_vec(start_addr, virt_memmap[VIRT_MROM].base,
> > > > > > -                              virt_memmap[VIRT_MROM].size, s->fdt);
> > > > > > +                              virt_memmap[VIRT_MROM].size,
> > > > > > +                              fdt_load_addr, s->fdt);
> > > > > >
> > > > > >      /* create PLIC hart topology configuration string */
> > > > > >      plic_hart_config_len = (strlen(VIRT_PLIC_HART_CONFIG) + 1) * smp_cpus;
> > > > > > diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> > > > > > index 3e9759c89aa2..f64fcadd2390 100644
> > > > > > --- a/include/hw/riscv/boot.h
> > > > > > +++ b/include/hw/riscv/boot.h
> > > > > > @@ -35,7 +35,10 @@ target_ulong riscv_load_kernel(const char *kernel_filename,
> > > > > >                                 symbol_fn_t sym_cb);
> > > > > >  hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
> > > > > >                           uint64_t kernel_entry, hwaddr *start);
> > > > > > +hwaddr riscv_load_fdt(hwaddr dram_start, uint64_t dram_size,
> > > > > > +                                void *fdt);
> > > > >
> > > > > nits: not indented to (
> > > > >
> > > > > >  void riscv_setup_rom_reset_vec(hwaddr saddr, hwaddr rom_base,
> > > > > > -                               hwaddr rom_size, void *fdt);
> > > > > > +                               hwaddr rom_size,
> > > > > > +                               hwaddr fdt_load_addr, void *fdt);
> > > > > >
> > > > > >  #endif /* RISCV_BOOT_H */
> > > > >
>
> Regards,
> Bin



-- 
Regards,
Atish

