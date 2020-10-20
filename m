Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258A2C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593512224A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNujiGkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593512224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUudA-0005xK-6U
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kUu1w-0006mM-1E; Tue, 20 Oct 2020 11:58:32 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:41289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kUu1t-00042B-QG; Tue, 20 Oct 2020 11:58:31 -0400
Received: by mail-io1-xd43.google.com with SMTP id u62so2054192iod.8;
 Tue, 20 Oct 2020 08:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1MhmTBr232rGWgtGyv6tzbpRj2ub27EXljLYL09Ar0M=;
 b=fNujiGkQ8RtXK5sjxFVGOQr2pG96z3BXZgwk5uts2EVsWGuFTTUGtEu0DjxYoYBO8J
 AplkVkP8NUstOyomHanVL1/HGxfEUTvNRDh2JPOYBOuaAC6pqWwXZ1JUjcHa4HtStRgo
 fqyOTZuhndYmJaKns//PlBUz/v6DkXTBA07yz/zy/9qd7OlSzYb5JHcdVaTGlXP6rE1T
 duhGel8QConK/q9Bz+t0tAIZUFX3qjT98zmmU1MCjtVxsIHkAl/BirnYvI7ZuqYO1rqA
 NXjwo5NJzIdhwDiO1QBQeEit7u8FWm1i6vnVrdBJPKiJFBO3wtJ6+zeJgIe3eDt7qJuU
 iHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1MhmTBr232rGWgtGyv6tzbpRj2ub27EXljLYL09Ar0M=;
 b=r0X9Bj3o5PoT+CAcpZnrHEx+DJa3O/ePZIOUA/dI92vEIygd9E5djpLoNdHxNMj6S2
 Y383bmCmLpxEeN/u3wFiO3fZg6eTIi153Hv/a4UaeeSFXTzK7/PtKCWf7ViTh5wlCd1I
 m9fTUvNe3x6aKykKTwnHf/2LiT1niorg1ciQMWt0RB7hnwg3u9taSa/1AKR882IumPTD
 ugH3jDwAv9aMyfrjdjX2cZFKsDXM16PqGJ6aekOMjDOe+lIp5UCgnntStlfalYbEk+ek
 MWDK6crnfOeUS8QD2E5NFl4HrsNEicP2d31pvGBUt78VPY+th77O91gt1BUztRzayffo
 Eh6w==
X-Gm-Message-State: AOAM531fEaDJ86YUPxotJO9QmDk66zIekPNUQGpzzJGETHvpcZExrsbb
 znOD+nYeJrCSCrvNApGGQH+Q4l/2ctjLb88AdTg=
X-Google-Smtp-Source: ABdhPJwvrpnrdnJAfTK5B5K4JNZ51my6pAz3vxXMy1m28dm7NKi9diZ428YQodJhmCRKxOVw3KlHYNZCnWFT93qTsrY=
X-Received: by 2002:a05:6638:25cc:: with SMTP id
 u12mr2526754jat.26.1603209508291; 
 Tue, 20 Oct 2020 08:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <46c00c4f15b42feb792090e3d74359e180a6d954.1602634524.git.alistair.francis@wdc.com>
 <mhng-edae75d6-b722-4341-b5dc-85bbaff0bf6d@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-edae75d6-b722-4341-b5dc-85bbaff0bf6d@palmerdabbelt-glaptop1>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 20 Oct 2020 08:46:45 -0700
Message-ID: <CAKmqyKP7KP0RR+mX-+Q9L5uFTELWEikJ+Dw7fOTYRnDr9m3FqQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] hw/riscv: Load the kernel after the firmware
To: Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 19, 2020 at 4:17 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 13 Oct 2020 17:17:33 PDT (-0700), Alistair Francis wrote:
> > Instead of loading the kernel at a hardcoded start address, let's load
> > the kernel at the next alligned address after the end of the firmware.
> >
> > This should have no impact for current users of OpenSBI, but will
> > allow loading a noMMU kernel at the start of memory.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  include/hw/riscv/boot.h |  3 +++
> >  hw/riscv/boot.c         | 19 ++++++++++++++-----
> >  hw/riscv/opentitan.c    |  3 ++-
> >  hw/riscv/sifive_e.c     |  3 ++-
> >  hw/riscv/sifive_u.c     | 10 ++++++++--
> >  hw/riscv/spike.c        | 11 ++++++++---
> >  hw/riscv/virt.c         | 11 ++++++++---
> >  7 files changed, 45 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> > index 2975ed1a31..0b01988727 100644
> > --- a/include/hw/riscv/boot.h
> > +++ b/include/hw/riscv/boot.h
> > @@ -25,6 +25,8 @@
> >
> >  bool riscv_is_32_bit(MachineState *machine);
> >
> > +target_ulong riscv_calc_kernel_start_addr(MachineState *machine,
> > +                                          target_ulong firmware_end_addr);
> >  target_ulong riscv_find_and_load_firmware(MachineState *machine,
> >                                            const char *default_machine_firmware,
> >                                            hwaddr firmware_load_addr,
> > @@ -34,6 +36,7 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
> >                                   hwaddr firmware_load_addr,
> >                                   symbol_fn_t sym_cb);
> >  target_ulong riscv_load_kernel(const char *kernel_filename,
> > +                               target_ulong firmware_end_addr,
> >                                 symbol_fn_t sym_cb);
> >  hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
> >                           uint64_t kernel_entry, hwaddr *start);
> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > index 5dea644f47..9b3fe3fb1e 100644
> > --- a/hw/riscv/boot.c
> > +++ b/hw/riscv/boot.c
> > @@ -33,10 +33,8 @@
> >  #include <libfdt.h>
> >
> >  #if defined(TARGET_RISCV32)
> > -# define KERNEL_BOOT_ADDRESS 0x80400000
> >  #define fw_dynamic_info_data(__val)     cpu_to_le32(__val)
> >  #else
> > -# define KERNEL_BOOT_ADDRESS 0x80200000
> >  #define fw_dynamic_info_data(__val)     cpu_to_le64(__val)
> >  #endif
> >
> > @@ -49,6 +47,15 @@ bool riscv_is_32_bit(MachineState *machine)
> >      }
> >  }
> >
> > +target_ulong riscv_calc_kernel_start_addr(MachineState *machine,
> > +                                          target_ulong firmware_end_addr) {
> > +    if (riscv_is_32_bit(machine)) {
> > +        return QEMU_ALIGN_UP(firmware_end_addr, 4 * MiB);
> > +    } else {
> > +        return QEMU_ALIGN_UP(firmware_end_addr, 2 * MiB);
> > +    }
> > +}
> > +
> >  target_ulong riscv_find_and_load_firmware(MachineState *machine,
> >                                            const char *default_machine_firmware,
> >                                            hwaddr firmware_load_addr,
> > @@ -123,7 +130,9 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
> >      exit(1);
> >  }
> >
> > -target_ulong riscv_load_kernel(const char *kernel_filename, symbol_fn_t sym_cb)
> > +target_ulong riscv_load_kernel(const char *kernel_filename,
> > +                               target_ulong kernel_start_addr,
> > +                               symbol_fn_t sym_cb)
> >  {
> >      uint64_t kernel_entry;
> >
> > @@ -138,9 +147,9 @@ target_ulong riscv_load_kernel(const char *kernel_filename, symbol_fn_t sym_cb)
> >          return kernel_entry;
> >      }
> >
> > -    if (load_image_targphys_as(kernel_filename, KERNEL_BOOT_ADDRESS,
> > +    if (load_image_targphys_as(kernel_filename, kernel_start_addr,
> >                                 ram_size, NULL) > 0) {
> > -        return KERNEL_BOOT_ADDRESS;
> > +        return kernel_start_addr;
> >      }
> >
> >      error_report("could not load kernel '%s'", kernel_filename);
> > diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> > index 0531bd879b..cc758b78b8 100644
> > --- a/hw/riscv/opentitan.c
> > +++ b/hw/riscv/opentitan.c
> > @@ -75,7 +75,8 @@ static void opentitan_board_init(MachineState *machine)
> >      }
> >
> >      if (machine->kernel_filename) {
> > -        riscv_load_kernel(machine->kernel_filename, NULL);
> > +        riscv_load_kernel(machine->kernel_filename,
> > +                          memmap[IBEX_DEV_RAM].base, NULL);
> >      }
> >  }
> >
> > diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> > index fcfac16816..59bac4cc9a 100644
> > --- a/hw/riscv/sifive_e.c
> > +++ b/hw/riscv/sifive_e.c
> > @@ -114,7 +114,8 @@ static void sifive_e_machine_init(MachineState *machine)
> >                            memmap[SIFIVE_E_DEV_MROM].base, &address_space_memory);
> >
> >      if (machine->kernel_filename) {
> > -        riscv_load_kernel(machine->kernel_filename, NULL);
> > +        riscv_load_kernel(machine->kernel_filename,
> > +                          memmap[SIFIVE_E_DEV_DTIM].base, NULL);
> >      }
> >  }
> >
> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > index 5f3ad9bc0f..b2472c6627 100644
> > --- a/hw/riscv/sifive_u.c
> > +++ b/hw/riscv/sifive_u.c
> > @@ -415,6 +415,7 @@ static void sifive_u_machine_init(MachineState *machine)
> >      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
> >      MemoryRegion *flash0 = g_new(MemoryRegion, 1);
> >      target_ulong start_addr = memmap[SIFIVE_U_DEV_DRAM].base;
> > +    target_ulong firmware_end_addr, kernel_start_addr;
> >      uint32_t start_addr_hi32 = 0x00000000;
> >      int i;
> >      uint32_t fdt_load_addr;
> > @@ -474,10 +475,15 @@ static void sifive_u_machine_init(MachineState *machine)
> >          break;
> >      }
> >
> > -    riscv_find_and_load_firmware(machine, BIOS_FILENAME, start_addr, NULL);
> > +    firmware_end_addr = riscv_find_and_load_firmware(machine, BIOS_FILENAME,
> > +                                                     start_addr, NULL);
> >
> >      if (machine->kernel_filename) {
> > -        kernel_entry = riscv_load_kernel(machine->kernel_filename, NULL);
> > +        kernel_start_addr = riscv_calc_kernel_start_addr(machine,
> > +                                                         firmware_end_addr);
> > +
> > +        kernel_entry = riscv_load_kernel(machine->kernel_filename,
> > +                                         kernel_start_addr, NULL);
> >
> >          if (machine->initrd_filename) {
> >              hwaddr start;
> > diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> > index 3fd152a035..facac6e7d2 100644
> > --- a/hw/riscv/spike.c
> > +++ b/hw/riscv/spike.c
> > @@ -195,6 +195,7 @@ static void spike_board_init(MachineState *machine)
> >      MemoryRegion *system_memory = get_system_memory();
> >      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
> >      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> > +    target_ulong firmware_end_addr, kernel_start_addr;
> >      uint32_t fdt_load_addr;
> >      uint64_t kernel_entry;
> >      char *soc_name;
> > @@ -261,12 +262,16 @@ static void spike_board_init(MachineState *machine)
> >      memory_region_add_subregion(system_memory, memmap[SPIKE_MROM].base,
> >                                  mask_rom);
> >
> > -    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
> > -                                 memmap[SPIKE_DRAM].base,
> > -                                 htif_symbol_callback);
> > +    firmware_end_addr = riscv_find_and_load_firmware(machine, BIOS_FILENAME,
> > +                                                     memmap[SPIKE_DRAM].base,
> > +                                                     htif_symbol_callback);
> >
> >      if (machine->kernel_filename) {
> > +        kernel_start_addr = riscv_calc_kernel_start_addr(machine,
> > +                                                         firmware_end_addr);
> > +
> >          kernel_entry = riscv_load_kernel(machine->kernel_filename,
> > +                                         kernel_start_addr,
> >                                           htif_symbol_callback);
> >
> >          if (machine->initrd_filename) {
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index 41bd2f38ba..6bfd10dfc7 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -493,6 +493,7 @@ static void virt_machine_init(MachineState *machine)
> >      char *plic_hart_config, *soc_name;
> >      size_t plic_hart_config_len;
> >      target_ulong start_addr = memmap[VIRT_DRAM].base;
> > +    target_ulong firmware_end_addr, kernel_start_addr;
> >      uint32_t fdt_load_addr;
> >      uint64_t kernel_entry;
> >      DeviceState *mmio_plic, *virtio_plic, *pcie_plic;
> > @@ -602,11 +603,15 @@ static void virt_machine_init(MachineState *machine)
> >      memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
> >                                  mask_rom);
> >
> > -    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
> > -                                 memmap[VIRT_DRAM].base, NULL);
> > +    firmware_end_addr = riscv_find_and_load_firmware(machine, BIOS_FILENAME,
> > +                                                     start_addr, NULL);
> >
> >      if (machine->kernel_filename) {
> > -        kernel_entry = riscv_load_kernel(machine->kernel_filename, NULL);
> > +        kernel_start_addr = riscv_calc_kernel_start_addr(machine,
> > +                                                         firmware_end_addr);
> > +
> > +        kernel_entry = riscv_load_kernel(machine->kernel_filename,
> > +                                         kernel_start_addr, NULL);
> >
> >          if (machine->initrd_filename) {
> >              hwaddr start;
>
> It's probably worth going through and making sure we mark the right regions as
> reserved in the DT, as with these being mobile we might run into latent bugs.

Do you mean mark where the firmware is as reserved?

> I haven't actually looked so maybe we're fine, but IIRC we sort of papered over
> a handful of memory layout agreements that weren't even in specs (or event
> meant to be in specs) that have stuck around for quite a while.

For the virt machine or the sifive_u?

>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks

Alistair

