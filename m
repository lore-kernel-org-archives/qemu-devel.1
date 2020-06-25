Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB618C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 20:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64A420767
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 20:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGtq/qfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64A420767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joY7h-0004lR-VR
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 16:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1joY6z-0004Gw-5K; Thu, 25 Jun 2020 16:04:41 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:36908)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1joY6w-0005a7-Uj; Thu, 25 Jun 2020 16:04:40 -0400
Received: by mail-io1-xd41.google.com with SMTP id c4so7460262iot.4;
 Thu, 25 Jun 2020 13:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R4mjAYpMbW0Nekdj/R3IopbTWy/ml9OLQdvhKFpL0jA=;
 b=WGtq/qfxyi2mQglq52vGVu4lbALir2uPbaubQpxIIJlxhKVk+WaUdW7FfJMiu4+4U9
 w0k6mxk4WDgPVzYzYP1uqRf5ShXfqkgdi9afOShb6Yv6X+wlihMWpz1tLAFdx/QqFMUj
 tsVdl2j9C6YkNqnYlJKAix/Uqxwe1Dmm2aHswUFp+6+6J2taXWtqj9HFSdhgRz/ONn5C
 V8mdGBzFc96OgUVaga2CN0rQQGzZxedhLhpGtSynv2JbibPZK1k187M6Lssg5k+aybda
 qbH1kxP8b1AXCjoUT/88I/zFLD4gDL+cdqyJS10leyHxSYAtYLoSjCP9+s8FsAHBwLH5
 tglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R4mjAYpMbW0Nekdj/R3IopbTWy/ml9OLQdvhKFpL0jA=;
 b=IWmmI+iPWgDv0EyUxotHoBWnhKWbZz1605OxAbbi53mDi8QuwO3S/n2diKfOluWjGm
 rdyTqoJK3i8sAk8z3KswfCj77IQdHxkc4SWMLfsy1WMHfZsYhKoflQpwaXzPFr93P/3Q
 QigT7z0Z6dYu+XHijkVYUimO7ihm77GWTXIGK9DadiE//qXTbqC37qnwU/Cl7yw6ErjX
 PqbXrDlwTkqbV2SNdoQHykxqzevnBwsOSfxCGfhg2aDZ8W/JuktMn+LyuDeODzBZyuTy
 wSRaFb7b4eX5folhFWJRcNhrEhphQK4EwhM4BDsdDmn8l+Bsw6YsM7q9pQtOizEzlx2V
 SRjA==
X-Gm-Message-State: AOAM533LmYXxuRuchP2y8yHXm1E4xF0fXiIRbt7ZUF/lQ4TTzqr1Kynj
 E8oio0GLLqMcfNniQQxhBeaJkiAk/Q94/Af6Pn8=
X-Google-Smtp-Source: ABdhPJyoemgMVJ8O9l0uSen7V/E49xD7YhiIl+rm72w9Sopcf+bA3rd7XyTMATbHwNOb0i4yBZKcDFo1zYA3ozlQJNk=
X-Received: by 2002:a02:5b83:: with SMTP id g125mr29597314jab.91.1593115477405; 
 Thu, 25 Jun 2020 13:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200625183741.642407-1-atish.patra@wdc.com>
 <20200625183741.642407-3-atish.patra@wdc.com>
In-Reply-To: <20200625183741.642407-3-atish.patra@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 25 Jun 2020 12:55:01 -0700
Message-ID: <CAKmqyKOgjjNRZDrO0e8u1G8DPZRQfR4V1R-Ds70E1AQeALA-fQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] RISC-V: Copy the fdt in dram instead of ROM
To: Atish Patra <atish.patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 Alexander Richardson <Alexander.Richardson@cl.cam.ac.uk>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 25, 2020 at 11:41 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> Currently, the fdt is copied to the ROM after the reset vector. The firmware
> has to copy it to DRAM. Instead of this, directly copy the device tree to a
> pre-computed dram address. The device tree load address should be as far as
> possible from kernel and initrd images. That's why it is kept at the end of
> the DRAM or 4GB whichever is lesser.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/boot.c         | 57 +++++++++++++++++++++++++++++------------
>  hw/riscv/sifive_u.c     | 32 +++++++++++------------
>  hw/riscv/spike.c        |  7 ++++-
>  hw/riscv/virt.c         |  7 ++++-
>  include/hw/riscv/boot.h |  5 +++-
>  5 files changed, 71 insertions(+), 37 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 8ed96da600c9..95a6b0b378d5 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -160,44 +160,67 @@ hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
>      return *start + size;
>  }
>
> +hwaddr riscv_load_fdt(hwaddr dram_base, uint64_t mem_size, void *fdt)
> +{
> +    hwaddr temp, fdt_addr;
> +    hwaddr dram_end = dram_base + mem_size;
> +    int fdtsize = fdt_totalsize(fdt);
> +
> +    if (fdtsize <= 0) {
> +        error_report("invalid device-tree");
> +        exit(1);
> +    }
> +
> +    /*
> +     * We should put fdt as far as possible to avoid kernel/initrd overwriting
> +     * its content. But it should be addressable by 32 bit system as well.
> +     * Thus, put it at an aligned address that less than fdt size from end of
> +     * dram or 4GB whichever is lesser.
> +     */
> +    temp = MIN(dram_end, 4096 * MiB);
> +    fdt_addr = QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
> +
> +    fdt_pack(fdt);
> +    /* copy in the device tree */
> +    qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
> +
> +    rom_add_blob_fixed_as("fdt", fdt, fdtsize, fdt_addr,
> +                          &address_space_memory);
> +
> +    return fdt_addr;
> +}
> +
>  void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
> -                               hwaddr rom_size, void *fdt)
> +                               hwaddr rom_size,
> +                               hwaddr fdt_load_addr, void *fdt)
>  {
>      int i;
>      /* reset vector */
> -    uint32_t reset_vec[8] = {
> -        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(dtb) */
> -        0x02028593,                  /*     addi   a1, t0, %pcrel_lo(1b) */
> +    uint32_t reset_vec[10] = {
> +        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
>          0xf1402573,                  /*     csrr   a0, mhartid  */
>  #if defined(TARGET_RISCV32)
> +        0x0202a583,                  /*     lw     a1, 32(t0) */
>          0x0182a283,                  /*     lw     t0, 24(t0) */
>  #elif defined(TARGET_RISCV64)
> +        0x0202b583,                  /*     ld     a1, 32(t0) */
>          0x0182b283,                  /*     ld     t0, 24(t0) */
>  #endif
>          0x00028067,                  /*     jr     t0 */
>          0x00000000,
>          start_addr,                  /* start: .dword */
>          0x00000000,
> -                                     /* dtb: */
> +        fdt_load_addr,               /* fdt_laddr: .dword */
> +        0x00000000,
> +                                     /* fw_dyn: */
>      };
>
>      /* copy in the reset vector in little_endian byte order */
> -    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> +    for (i = 0; i < ARRAY_SIZE(reset_vec); i++) {
>          reset_vec[i] = cpu_to_le32(reset_vec[i]);
>      }
>      rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
>                            rom_base, &address_space_memory);
>
> -    /* copy in the device tree */
> -    if (fdt_pack(fdt) || fdt_totalsize(fdt) >
> -        rom_size - sizeof(reset_vec)) {
> -        error_report("not enough space to store device-tree");
> -        exit(1);
> -    }
> -    qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
> -    rom_add_blob_fixed_as("mrom.fdt", fdt, fdt_totalsize(fdt),
> -                           rom_base + sizeof(reset_vec),
> -                           &address_space_memory);
> -
>      return;
>  }
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 7d051e7c9299..aba247716cee 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -380,6 +380,7 @@ static void sifive_u_machine_init(MachineState *machine)
>      MemoryRegion *flash0 = g_new(MemoryRegion, 1);
>      target_ulong start_addr = memmap[SIFIVE_U_DRAM].base;
>      int i;
> +    hwaddr fdt_load_addr;
>
>      /* Initialize SoC */
>      object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_U_SOC);
> @@ -451,40 +452,37 @@ static void sifive_u_machine_init(MachineState *machine)
>          }
>      }
>
> +    /* Compute the fdt load address in dram */
> +    fdt_load_addr = riscv_load_fdt(memmap[SIFIVE_U_DRAM].base,
> +                                   machine->ram_size, s->fdt);
> +
>      /* reset vector */
> -    uint32_t reset_vec[8] = {
> +    uint32_t reset_vec[11] = {
>          s->msel,                       /* MSEL pin state */
> -        0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(dtb) */
> -        0x01c28593,                    /*     addi   a1, t0, %pcrel_lo(1b) */
> +        0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
>          0xf1402573,                    /*     csrr   a0, mhartid  */
>  #if defined(TARGET_RISCV32)
> +        0x0202a583,                    /*     lw     a1, 32(t0) */
>          0x0182a283,                    /*     lw     t0, 24(t0) */
>  #elif defined(TARGET_RISCV64)
> -        0x0182e283,                    /*     lwu    t0, 24(t0) */
> +        0x0202b583,                    /*     ld     a1, 32(t0) */
> +        0x0182b283,                    /*     ld     t0, 24(t0) */
>  #endif
>          0x00028067,                    /*     jr     t0 */
>          0x00000000,
>          start_addr,                    /* start: .dword */
> -                                       /* dtb: */
> +        0x00000000,
> +        fdt_load_addr,                 /* fdt_laddr: .dword */
> +        0x00000000,
> +                                       /* fw_dyn: */
>      };
>
>      /* copy in the reset vector in little_endian byte order */
> -    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> +    for (i = 0; i < ARRAY_SIZE(reset_vec); i++) {
>          reset_vec[i] = cpu_to_le32(reset_vec[i]);
>      }
>      rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
>                            memmap[SIFIVE_U_MROM].base, &address_space_memory);
> -
> -    /* copy in the device tree */
> -    if (fdt_pack(s->fdt) || fdt_totalsize(s->fdt) >
> -            memmap[SIFIVE_U_MROM].size - sizeof(reset_vec)) {
> -        error_report("not enough space to store device-tree");
> -        exit(1);
> -    }
> -    qemu_fdt_dumpdtb(s->fdt, fdt_totalsize(s->fdt));
> -    rom_add_blob_fixed_as("mrom.fdt", s->fdt, fdt_totalsize(s->fdt),
> -                          memmap[SIFIVE_U_MROM].base + sizeof(reset_vec),
> -                          &address_space_memory);
>  }
>
>  static bool sifive_u_machine_get_start_in_flash(Object *obj, Error **errp)
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 561642c1fb5d..7f58e36b4550 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -166,6 +166,7 @@ static void spike_board_init(MachineState *machine)
>      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>      unsigned int smp_cpus = machine->smp.cpus;
> +    hwaddr fdt_load_addr;
>
>      /* Initialize SOC */
>      object_initialize_child(OBJECT(machine), "soc", &s->soc,
> @@ -211,9 +212,13 @@ static void spike_board_init(MachineState *machine)
>          }
>      }
>
> +    /* Compute the fdt load address in dram */
> +    fdt_load_addr = riscv_load_fdt(memmap[SPIKE_DRAM].base,
> +                                   machine->ram_size, s->fdt);
>      /* load the reset vector */
>      riscv_setup_rom_reset_vec(memmap[SPIKE_DRAM].base, memmap[SPIKE_MROM].base,
> -                              memmap[SPIKE_MROM].size, s->fdt);
> +                              memmap[SPIKE_MROM].size,
> +                              fdt_load_addr, s->fdt);
>
>      /* initialize HTIF using symbols found in load_kernel */
>      htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 22a60259daab..d98d764466bf 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -481,6 +481,7 @@ static void virt_machine_init(MachineState *machine)
>      char *plic_hart_config;
>      size_t plic_hart_config_len;
>      target_ulong start_addr = memmap[VIRT_DRAM].base;
> +    hwaddr fdt_load_addr;
>      int i;
>      unsigned int smp_cpus = machine->smp.cpus;
>
> @@ -535,9 +536,13 @@ static void virt_machine_init(MachineState *machine)
>          start_addr = virt_memmap[VIRT_FLASH].base;
>      }
>
> +    /* Compute the fdt load address in dram */
> +    fdt_load_addr = riscv_load_fdt(memmap[VIRT_DRAM].base,
> +                                   machine->ram_size, s->fdt);
>      /* load the reset vector */
>      riscv_setup_rom_reset_vec(start_addr, virt_memmap[VIRT_MROM].base,
> -                              virt_memmap[VIRT_MROM].size, s->fdt);
> +                              virt_memmap[VIRT_MROM].size,
> +                              fdt_load_addr, s->fdt);
>
>      /* create PLIC hart topology configuration string */
>      plic_hart_config_len = (strlen(VIRT_PLIC_HART_CONFIG) + 1) * smp_cpus;
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 3e9759c89aa2..f64fcadd2390 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -35,7 +35,10 @@ target_ulong riscv_load_kernel(const char *kernel_filename,
>                                 symbol_fn_t sym_cb);
>  hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
>                           uint64_t kernel_entry, hwaddr *start);
> +hwaddr riscv_load_fdt(hwaddr dram_start, uint64_t dram_size,
> +                                void *fdt);
>  void riscv_setup_rom_reset_vec(hwaddr saddr, hwaddr rom_base,
> -                               hwaddr rom_size, void *fdt);
> +                               hwaddr rom_size,
> +                               hwaddr fdt_load_addr, void *fdt);
>
>  #endif /* RISCV_BOOT_H */
> --
> 2.26.2
>
>

