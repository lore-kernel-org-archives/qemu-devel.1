Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8051EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 969C425235
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRvyT4gy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969C425235
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSMqn-0003fF-Ge
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 12:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSMpD-0002sG-Pj; Tue, 13 Oct 2020 12:06:55 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:42958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSMpB-00087x-Gf; Tue, 13 Oct 2020 12:06:55 -0400
Received: by mail-il1-x144.google.com with SMTP id l16so393670ilj.9;
 Tue, 13 Oct 2020 09:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R2PJ+/HL1Z97QnBDQt6pZZtEyniLsj9hGI8wGxSZR6M=;
 b=SRvyT4gytrV4HnaizmHCxdZHexdXREdOlUhKGTiqU5ctv9Dbq22WNpN1GVx6anMjnK
 1aunzvPoI1CfFRCiayb3njlw7FrOOfAngKncbRQ01G6NTJETpny3O2oq2Ersq+pHEfQy
 FV2v9rEvCNJICzQGeDu35Q20k7U3Xi5OOFq9XSLHX6fBjiGElJ51tD9KtSgCli40s5Rg
 5rCjd0/TyAEw5LE5Yssw5dgDArXPD4El0xwqPTl9Rsuzh8bo/H+M0XonEW/J+NlKqrpU
 le7i26c8DkS/fM3t9zS3wzEgT453TkPDnXZUw38jvYOaqViwQUtgaYwhbYDrMCasJ29M
 bYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R2PJ+/HL1Z97QnBDQt6pZZtEyniLsj9hGI8wGxSZR6M=;
 b=A9Opt8yCD4wQ75bKnDDFn2aa0sD0A9olVX1h1Cv5ZLdFVCgFVQNXCxq59QoEvL0AjC
 xqJS+luLJUg6fOLYsdPIFmA1F+uVkS9g582ZfBYoOg1OIky7pfUZgUUh8a3QrhD1W676
 6HPAZM3QNBDZgxoHvABrKRQdfV61blDuAvL+LJAdEyYW4UqY3Bk5h/X8Q9o1TAAWkfHK
 vse7P46a6YG23yr0P1A+LLy7Xe/yLn3TVQuLxo68C8DUeJNp9+A/t2wvDhQ3o8FCOV3M
 K7L+JVGEC9GaYqvxc3B6l+MhKGhCDvFx4a1BayTJ9R4R7mqGZwytbNyr5kzw8HARRHjn
 8HcA==
X-Gm-Message-State: AOAM531KvvQUNdKGRLoWv0deZ/17cF5PWgOUWLC7uLha1FDvQU/38Wor
 /++MEn91ZkyK8YS/ZFyxxuIsnx5qmHe/imETw2A=
X-Google-Smtp-Source: ABdhPJyDkQHr7A1/sEd8tXiclcgrlNL2D+BjRYkD/37LJef4kG1DIrtotvU6yfEBs4qGCOurtIWTihSDcZyEW8lfFMo=
X-Received: by 2002:a92:c5c2:: with SMTP id s2mr558453ilt.177.1602605210586;
 Tue, 13 Oct 2020 09:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601652616.git.alistair.francis@wdc.com>
 <4f272c9fab34bedc34b22adb8f9e2fb2dbd338d2.1601652616.git.alistair.francis@wdc.com>
 <CAEUhbmVZt1D=eFzb=cRP51URGyzrRLeRCeUevhHWaua6_aBHZw@mail.gmail.com>
In-Reply-To: <CAEUhbmVZt1D=eFzb=cRP51URGyzrRLeRCeUevhHWaua6_aBHZw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 13 Oct 2020 08:55:13 -0700
Message-ID: <CAKmqyKN16E5it9DkFEdKgug4vPq0cCat8kZrTAOy8c4_3EcsJw@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] hw/riscv: Load the kernel after the firmware
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 9, 2020 at 3:29 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Fri, Oct 2, 2020 at 11:55 PM Alistair Francis
> <alistair.francis@wdc.com> wrote:
>
> Please put some commit message to explain why the changes are necessary.

I have added a commit message.

>
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  include/hw/riscv/boot.h |  1 +
> >  hw/riscv/boot.c         | 10 +++++-----
> >  hw/riscv/opentitan.c    |  3 ++-
> >  hw/riscv/sifive_e.c     |  3 ++-
> >  hw/riscv/sifive_u.c     | 13 +++++++++++--
> >  hw/riscv/spike.c        | 14 +++++++++++---
> >  hw/riscv/virt.c         | 14 +++++++++++---
> >  7 files changed, 43 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> > index 2975ed1a31..85d3227ea6 100644
> > --- a/include/hw/riscv/boot.h
> > +++ b/include/hw/riscv/boot.h
> > @@ -34,6 +34,7 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
> >                                   hwaddr firmware_load_addr,
> >                                   symbol_fn_t sym_cb);
> >  target_ulong riscv_load_kernel(const char *kernel_filename,
> > +                               target_ulong firmware_end_addr,
> >                                 symbol_fn_t sym_cb);
> >  hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
> >                           uint64_t kernel_entry, hwaddr *start);
> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > index 5dea644f47..f8e55ca16a 100644
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
> > @@ -123,7 +121,9 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
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
> > @@ -138,9 +138,9 @@ target_ulong riscv_load_kernel(const char *kernel_filename, symbol_fn_t sym_cb)
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
> > index 5f3ad9bc0f..08b0a3937d 100644
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
> > @@ -474,10 +475,18 @@ static void sifive_u_machine_init(MachineState *machine)
> >          break;
> >      }
> >
> > -    riscv_find_and_load_firmware(machine, BIOS_FILENAME, start_addr, NULL);
> > +    firmware_end_addr = riscv_find_and_load_firmware(machine, BIOS_FILENAME,
> > +                                                     start_addr, NULL);
> >
> >      if (machine->kernel_filename) {
> > -        kernel_entry = riscv_load_kernel(machine->kernel_filename, NULL);
> > +        if (riscv_is_32_bit(machine)) {
> > +            kernel_start_addr = QEMU_ALIGN_UP(firmware_end_addr, 0x400000);
>
> Use 4 * MiB
>
> > +        } else {
> > +            kernel_start_addr = QEMU_ALIGN_UP(firmware_end_addr, 0x200000);
>
> 2 * MiB
>
> > +        }
> > +
> > +        kernel_entry = riscv_load_kernel(machine->kernel_filename,
> > +                                         kernel_start_addr, NULL);
> >
> >          if (machine->initrd_filename) {
> >              hwaddr start;
> > diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> > index 3fd152a035..280fb1f328 100644
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
> > @@ -261,12 +262,19 @@ static void spike_board_init(MachineState *machine)
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
> > +        if (riscv_is_32_bit(machine)) {
> > +            kernel_start_addr = QEMU_ALIGN_UP(firmware_end_addr, 0x400000);
>
> Ditto
>
> It looks like this same code logic is added in several machine codes,
> perhaps a new helper function in riscv/boot.c is needed to determine
> the kernel start address based on the firmware end address.

Done!

Alistair

>
> > +        } else {
> > +            kernel_start_addr = QEMU_ALIGN_UP(firmware_end_addr, 0x200000);
> > +        }
> > +
> >          kernel_entry = riscv_load_kernel(machine->kernel_filename,
> > +                                         kernel_start_addr,
> >                                           htif_symbol_callback);
> >
> >          if (machine->initrd_filename) {
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index 41bd2f38ba..bf22d28eef 100644
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
> > @@ -602,11 +603,18 @@ static void virt_machine_init(MachineState *machine)
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
> > +        if (riscv_is_32_bit(machine)) {
> > +            kernel_start_addr = QEMU_ALIGN_UP(firmware_end_addr, 0x400000);
> > +        } else {
> > +            kernel_start_addr = QEMU_ALIGN_UP(firmware_end_addr, 0x200000);
> > +        }
> > +
> > +        kernel_entry = riscv_load_kernel(machine->kernel_filename,
> > +                                         kernel_start_addr, NULL);
> >
> >          if (machine->initrd_filename) {
> >              hwaddr start;
>
> Regards,
> Bin

