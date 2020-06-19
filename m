Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90505C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 01:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D8F20776
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 01:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="uW6V2FvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D8F20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm6FV-0005lh-EH
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 21:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@atishpatra.org>)
 id 1jm6Db-0004tf-BO
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 21:53:23 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@atishpatra.org>)
 id 1jm6DY-00076w-6y
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 21:53:23 -0400
Received: by mail-wr1-x441.google.com with SMTP id l10so8071674wrr.10
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 18:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atishpatra.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5UNRIxxaCwPB6Qj9Awjd7+NylhIl3+bxNdId/TR+si4=;
 b=uW6V2FvH5vuVA1n6xMu06PLEy/x+U02Jb/E7NOpxK4U1OzxEmNDHpSlA4Mri+In2At
 P7rRj9j1T8uHeHaTAAMOiLM23MyDxQH3R4oAbjXqDA43OQ/fi8FBglYDOmG8ASz8VBqn
 z8jiSIHN/IY5Rnux5YSk95Q0YzpVm389mmmV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5UNRIxxaCwPB6Qj9Awjd7+NylhIl3+bxNdId/TR+si4=;
 b=CAyqyWBDKTJ28QItmXV3NYuJidM1KCHeJVMTNEbBMe3Yc8bPb13UB8Y+U4rtbiYE4c
 fC2MVF/cG7xPAc4cntzveLSjANYV7OSDssqanb4Nz/ZbsINGNtmrMcUTmi3HNyNbi6pt
 qJx2fYOsGJHfftAekuPEdA6uMhjGDc6ta+u+N0LpEvLRfFeEYDMcZZr462hVeUV+PYTZ
 B93Vdjzk7TW7TJNkppDybcYYlsHd9+mMpq3EqzrMA7eiyKToJbSYgLPgOlm7BYlJ28GC
 prwlw1+AieCa+71gH6t/27nIBSzdX9NPlrax75KN50/KwtGj0Cqv72Ja6lqn1scXLDmf
 bVSA==
X-Gm-Message-State: AOAM532xiSZkIrW2oxOSJwXH16IM546f8FXj+JGxkEplH5rjtoTujzZe
 InX3INxQn6t8B5g0R1ZQ038ze3gkOz8aAzahzabQ
X-Google-Smtp-Source: ABdhPJyayRCeCDizVnfpEfmMb8doJ8vLJmy2BajVY6P9DlAAnsXiJy/qw/Jf129Nmajzp7VZBOpUdgph6lP850kJf1c=
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr1327762wrv.162.1592531598358; 
 Thu, 18 Jun 2020 18:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200616192700.1900260-1-atish.patra@wdc.com>
 <20200616192700.1900260-3-atish.patra@wdc.com>
 <CAEUhbmXfo6PusamsDkhqAWX=dta3t3qCiS0SUpEz7DKheosPAg@mail.gmail.com>
In-Reply-To: <CAEUhbmXfo6PusamsDkhqAWX=dta3t3qCiS0SUpEz7DKheosPAg@mail.gmail.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Thu, 18 Jun 2020 18:53:07 -0700
Message-ID: <CAOnJCUJxNzes=6xHHhAafV=RZX4Zi1COcNwFpG1=bbFLLsUMSg@mail.gmail.com>
Subject: Re: [PATCH 2/3] RISC-V: Copy the fdt in dram instead of ROM
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=atishp@atishpatra.org; helo=mail-wr1-x441.google.com
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
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 18, 2020 at 1:26 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Wed, Jun 17, 2020 at 3:29 AM Atish Patra <atish.patra@wdc.com> wrote:
> >
> > Currently, the fdt is copied to the ROM after the reset vector. The firmware
> > has to copy it to DRAM. Instead of this, directly copy the device tree to a
> > pre-computed dram address. The device tree load address should be as far as
> > possible from kernel and initrd images. That's why it is kept at the end of
> > the DRAM or 4GB whichever is lesser.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  hw/riscv/boot.c         | 45 ++++++++++++++++++++++++++++++-----------
> >  hw/riscv/sifive_u.c     | 14 ++++++++++++-
> >  hw/riscv/spike.c        | 14 ++++++++++++-
> >  hw/riscv/virt.c         | 13 +++++++++++-
> >  include/hw/riscv/boot.h |  5 ++++-
> >  5 files changed, 75 insertions(+), 16 deletions(-)
> >
> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > index 8ed96da600c9..0378b7f1bd58 100644
> > --- a/hw/riscv/boot.c
> > +++ b/hw/riscv/boot.c
> > @@ -160,25 +160,51 @@ hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
> >      return *start + size;
> >  }
> >
> > +hwaddr riscv_calc_fdt_load_addr(hwaddr dram_base, uint64_t mem_size, void *fdt)
> > +{
> > +    hwaddr temp, fdt_addr;
> > +    hwaddr dram_end = dram_base + mem_size;
> > +    int fdtsize = fdt_totalsize(fdt);
> > +
> > +    if (fdtsize <= 0) {
> > +        error_report("invalid device-tree");
> > +        exit(1);
> > +    }
> > +    /*
> > +     * We should put fdt as far as possible to avoid kernel/initrd overwriting
> > +     * its content. But it should be addressable by 32 bit system as well.
> > +     * Thus, put it at an aligned address that less than fdt size from end of
> > +     * dram or 4GB whichever is lesser.
> > +     */
> > +    temp = MIN(dram_end, 4096 * MiB);
> > +    fdt_addr = QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
> > +
> > +    return fdt_addr;
> > +}
> > +
> >  void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
> > -                               hwaddr rom_size, void *fdt)
> > +                               hwaddr rom_size,
> > +                               hwaddr fdt_load_addr, void *fdt)
> >  {
> >      int i;
> >      /* reset vector */
> > -    uint32_t reset_vec[8] = {
> > -        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(dtb) */
> > -        0x02028593,                  /*     addi   a1, t0, %pcrel_lo(1b) */
> > +    uint32_t reset_vec[10] = {
> > +        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
> >          0xf1402573,                  /*     csrr   a0, mhartid  */
> >  #if defined(TARGET_RISCV32)
> > +        0x0202a583,                  /*     lw     a1, 32(t0) */
> >          0x0182a283,                  /*     lw     t0, 24(t0) */
> >  #elif defined(TARGET_RISCV64)
> > +        0x0202b583,                  /*     ld     a1, 32(t0) */
> >          0x0182b283,                  /*     ld     t0, 24(t0) */
> >  #endif
> >          0x00028067,                  /*     jr     t0 */
> >          0x00000000,
> >          start_addr,                  /* start: .dword */
> >          0x00000000,
> > -                                     /* dtb: */
> > +        fdt_load_addr,               /* fdt_laddr: .dword */
> > +        0x00000000,
> > +                                     /* fw_dyn: */
> >      };
> >
> >      /* copy in the reset vector in little_endian byte order */
> > @@ -189,14 +215,9 @@ void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
> >                            rom_base, &address_space_memory);
> >
> >      /* copy in the device tree */
> > -    if (fdt_pack(fdt) || fdt_totalsize(fdt) >
> > -        rom_size - sizeof(reset_vec)) {
> > -        error_report("not enough space to store device-tree");
> > -        exit(1);
> > -    }
> >      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
> > -    rom_add_blob_fixed_as("mrom.fdt", fdt, fdt_totalsize(fdt),
> > -                           rom_base + sizeof(reset_vec),
> > +
> > +    rom_add_blob_fixed_as("fdt", fdt, fdt_totalsize(fdt), fdt_load_addr,
> >                             &address_space_memory);
> >
> >      return;
> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > index c2712570e0d9..1a1540c7f98d 100644
> > --- a/hw/riscv/sifive_u.c
> > +++ b/hw/riscv/sifive_u.c
> > @@ -31,6 +31,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > +#include "qemu/units.h"
> >  #include "qemu/log.h"
> >  #include "qemu/error-report.h"
> >  #include "qapi/error.h"
> > @@ -325,6 +326,7 @@ static void sifive_u_machine_init(MachineState *machine)
> >      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
> >      MemoryRegion *flash0 = g_new(MemoryRegion, 1);
> >      target_ulong start_addr = memmap[SIFIVE_U_DRAM].base;
> > +    hwaddr fdt_load_addr;
> >
> >      /* Initialize SoC */
> >      object_initialize_child(OBJECT(machine), "soc", &s->soc,
> > @@ -369,13 +371,23 @@ static void sifive_u_machine_init(MachineState *machine)
> >          }
> >      }
> >
> > +    /* Compute the fdt load address in dram */
> > +    fdt_load_addr = riscv_calc_fdt_load_addr(memmap[SIFIVE_U_DRAM].base,
> > +                                             machine->ram_size, s->fdt);
> > +
> > +    if (fdt_load_addr >= (memmap[SIFIVE_U_DRAM].base + machine->ram_size)) {
>
> This check is unnecessary as the parameter passed to
> riscv_calc_fdt_load_addr() guarantees that this won't happen.
>

Sure. I will remove that.

> > +        error_report("Not enough space for FDT after kernel + initrd");
> > +        exit(1);
> > +     }
> > +
> >      if (s->start_in_flash) {
> >          start_addr = memmap[SIFIVE_U_FLASH0].base;
> >      }
> >
> >      /* load the reset vector */
> >      riscv_setup_rom_reset_vec(start_addr, memmap[SIFIVE_U_MROM].base,
> > -                              memmap[SIFIVE_U_MROM].size, s->fdt);
> > +                              memmap[SIFIVE_U_MROM].size,
> > +                              fdt_load_addr, s->fdt);
> >  }
> >
> >  static bool sifive_u_machine_get_start_in_flash(Object *obj, Error **errp)
> > diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> > index 238eae48716a..2a34a1382487 100644
> > --- a/hw/riscv/spike.c
> > +++ b/hw/riscv/spike.c
> > @@ -24,6 +24,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > +#include "qemu/units.h"
> >  #include "qemu/log.h"
> >  #include "qemu/error-report.h"
> >  #include "qapi/error.h"
> > @@ -166,6 +167,7 @@ static void spike_board_init(MachineState *machine)
> >      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
> >      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> >      unsigned int smp_cpus = machine->smp.cpus;
> > +    hwaddr fdt_load_addr;
> >
> >      /* Initialize SOC */
> >      object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> > @@ -212,9 +214,19 @@ static void spike_board_init(MachineState *machine)
> >          }
> >      }
> >
> > +    /* Compute the fdt load address in dram */
> > +    fdt_load_addr = riscv_calc_fdt_load_addr(memmap[SPIKE_DRAM].base,
> > +                                             machine->ram_size, s->fdt);
> > +
> > +    if (fdt_load_addr >= (memmap[SPIKE_DRAM].base + machine->ram_size)) {
> > +        error_report("Not enough space for FDT after kernel + initrd");
> > +        exit(1);
> > +     }
> > +
> >      /* load the reset vector */
> >      riscv_setup_rom_reset_vec(memmap[SPIKE_DRAM].base, memmap[SPIKE_MROM].base,
> > -                              memmap[SPIKE_MROM].size, s->fdt);
> > +                              memmap[SPIKE_MROM].size,
> > +                              fdt_load_addr, s->fdt);
> >
> >      /* initialize HTIF using symbols found in load_kernel */
> >      htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index a8e2d58cc067..ebb5dd5c8c1c 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -481,6 +481,7 @@ static void virt_machine_init(MachineState *machine)
> >      char *plic_hart_config;
> >      size_t plic_hart_config_len;
> >      target_ulong start_addr = memmap[VIRT_DRAM].base;
> > +    hwaddr fdt_load_addr;
> >      int i;
> >      unsigned int smp_cpus = machine->smp.cpus;
> >
> > @@ -536,9 +537,19 @@ static void virt_machine_init(MachineState *machine)
> >          start_addr = virt_memmap[VIRT_FLASH].base;
> >      }
> >
> > +    /* Compute the fdt load address in dram */
> > +    fdt_load_addr = riscv_calc_fdt_load_addr(memmap[VIRT_DRAM].base,
> > +                                             machine->ram_size, s->fdt);
> > +    if (fdt_load_addr >= (memmap[VIRT_DRAM].base + machine->ram_size)) {
> > +        error_report("Not enough space for FDT after kernel + initrd");
> > +        exit(1);
> > +     }
> > +
> > +
> >      /* load the reset vector */
> >      riscv_setup_rom_reset_vec(start_addr, virt_memmap[VIRT_MROM].base,
> > -                              virt_memmap[VIRT_MROM].size, s->fdt);
> > +                              virt_memmap[VIRT_MROM].size,
> > +                              fdt_load_addr, s->fdt);
> >
> >      /* create PLIC hart topology configuration string */
> >      plic_hart_config_len = (strlen(VIRT_PLIC_HART_CONFIG) + 1) * smp_cpus;
> > diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> > index 3e9759c89aa2..b6289a05d952 100644
> > --- a/include/hw/riscv/boot.h
> > +++ b/include/hw/riscv/boot.h
> > @@ -35,7 +35,10 @@ target_ulong riscv_load_kernel(const char *kernel_filename,
> >                                 symbol_fn_t sym_cb);
> >  hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
> >                           uint64_t kernel_entry, hwaddr *start);
> > +hwaddr riscv_calc_fdt_load_addr(hwaddr dram_start, uint64_t dram_size,
> > +                                void *fdt);
> >  void riscv_setup_rom_reset_vec(hwaddr saddr, hwaddr rom_base,
> > -                               hwaddr rom_size, void *fdt);
> > +                               hwaddr rom_size,
> > +                               hwaddr fdt_load_addr, void *fdt);
> >
> >  #endif /* RISCV_BOOT_H */
>
> Regards,
> Bin
>


-- 
Regards,
Atish

