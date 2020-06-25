Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9906AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6071F206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKD8yEsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6071F206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joXtk-0000C3-H6
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 15:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1joXsn-00089y-LW; Thu, 25 Jun 2020 15:50:01 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:33214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1joXsl-0007bc-Oq; Thu, 25 Jun 2020 15:50:01 -0400
Received: by mail-io1-xd41.google.com with SMTP id i25so7452224iog.0;
 Thu, 25 Jun 2020 12:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/RyC1veO3ORa+RKSXar1Qiq6XfsSnjjnZulEjX38NLo=;
 b=nKD8yEsNvpdjsVkfW/RBgwbwSSCSoB6ILzUB0dPDon0cbZw4uMQhgPN0kEsfC2DRex
 dVxvac4r89rOXiegEH0InLt77+iDILNaPipkOgV0rLdMPin1dpUZmNnnePZwaMIySDaM
 PlwkjYDjfa04k/PGyRNTjOyGULZMfv/jVnikHijbsJltmD1QEl5jb1NA9poSKWrANPpt
 oIQ6QtlFRTTJ3DsJJSsv4cw3YWebEr4HNRhT7Phcvkp04jMjoz9JReebFIiE1IL6wck0
 DISAUKO/d82tgImBLT3PyNQOUXnJ8Lf4HDSSjIwz5kCQwu5qPqnnX52IDx6l/vSx35yU
 Sueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/RyC1veO3ORa+RKSXar1Qiq6XfsSnjjnZulEjX38NLo=;
 b=W3uhWDaCJQxJ3qyH5xthJ/5ostUm+/LSWgxRmRibQr3v+S5fekCGOKQW0Jxx3XqMPT
 sHIA09J70DfOSKBohI54IRM2qsuoXJNacyY8fS41gwisnIpEascHMx2BPN++FSviQKIJ
 o2BOe5Lhm8KqBL6fnZHhVkbAaDgGYBP6iWGXIng9PQhzCWka0bbyaZePLfBNCvjI0IUa
 qdKckdGj65olKwttryEETV86flHg90ScmJ3IGmsQBDf6IMbEoPXTaG+FvsdR/M+hQyTF
 0PdStPp5vNq8KKDhf/WB4Udg9GukBKqmluBKutzUbCYEobpYBIK15KIBv1b8Y6qRKjmo
 QgCQ==
X-Gm-Message-State: AOAM531/BxP58Yy8gzMlBNoF2KlLzVU6NTulLQ34QlPADWOHB2Yc2HNG
 JsUI32fgpfoIOPWeS3pbo0HjceuJKzkI3v3tXNE=
X-Google-Smtp-Source: ABdhPJy8PGFVItPsD99FwYYKgoz+TmrIRZWEtJ027lz03odQxAjiqXzkbcu6u4a8YAciY/Km0u0zhlph9A33y+klmHc=
X-Received: by 2002:a05:6638:dd3:: with SMTP id
 m19mr38115118jaj.106.1593114597762; 
 Thu, 25 Jun 2020 12:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200625183741.642407-1-atish.patra@wdc.com>
 <20200625183741.642407-2-atish.patra@wdc.com>
In-Reply-To: <20200625183741.642407-2-atish.patra@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 25 Jun 2020 12:40:21 -0700
Message-ID: <CAKmqyKOVfVBYvRZNht9tCGCFX-USuWo72VR09=6d=h53zavzeA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] riscv: Unify Qemu's reset vector code path
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

On Thu, Jun 25, 2020 at 11:38 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> Currently, all riscv machines except sifive_u have identical reset vector
> code implementations with memory addresses being different for all machines.
> They can be easily combined into a single function in common code.
>
> Move it to common function and let all the machines use the common function.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  hw/riscv/boot.c         | 46 +++++++++++++++++++++++++++++++++++++++++
>  hw/riscv/spike.c        | 38 +++-------------------------------
>  hw/riscv/virt.c         | 37 +++------------------------------
>  include/hw/riscv/boot.h |  2 ++
>  4 files changed, 54 insertions(+), 69 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index adb421b91b68..8ed96da600c9 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -22,12 +22,16 @@
>  #include "qemu/units.h"
>  #include "qemu/error-report.h"
>  #include "exec/cpu-defs.h"
> +#include "exec/address-spaces.h"
>  #include "hw/boards.h"
>  #include "hw/loader.h"
>  #include "hw/riscv/boot.h"
>  #include "elf.h"
> +#include "sysemu/device_tree.h"
>  #include "sysemu/qtest.h"
>
> +#include <libfdt.h>
> +

Do you mind removing these header from the original files, we
shouldn't need them now.

Besides that:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>  #if defined(TARGET_RISCV32)
>  # define KERNEL_BOOT_ADDRESS 0x80400000
>  #else
> @@ -155,3 +159,45 @@ hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
>
>      return *start + size;
>  }
> +
> +void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
> +                               hwaddr rom_size, void *fdt)
> +{
> +    int i;
> +    /* reset vector */
> +    uint32_t reset_vec[8] = {
> +        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(dtb) */
> +        0x02028593,                  /*     addi   a1, t0, %pcrel_lo(1b) */
> +        0xf1402573,                  /*     csrr   a0, mhartid  */
> +#if defined(TARGET_RISCV32)
> +        0x0182a283,                  /*     lw     t0, 24(t0) */
> +#elif defined(TARGET_RISCV64)
> +        0x0182b283,                  /*     ld     t0, 24(t0) */
> +#endif
> +        0x00028067,                  /*     jr     t0 */
> +        0x00000000,
> +        start_addr,                  /* start: .dword */
> +        0x00000000,
> +                                     /* dtb: */
> +    };
> +
> +    /* copy in the reset vector in little_endian byte order */
> +    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> +        reset_vec[i] = cpu_to_le32(reset_vec[i]);
> +    }
> +    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
> +                          rom_base, &address_space_memory);
> +
> +    /* copy in the device tree */
> +    if (fdt_pack(fdt) || fdt_totalsize(fdt) >
> +        rom_size - sizeof(reset_vec)) {
> +        error_report("not enough space to store device-tree");
> +        exit(1);
> +    }
> +    qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
> +    rom_add_blob_fixed_as("mrom.fdt", fdt, fdt_totalsize(fdt),
> +                           rom_base + sizeof(reset_vec),
> +                           &address_space_memory);
> +
> +    return;
> +}
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 3c87e04fdceb..561642c1fb5d 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -165,7 +165,6 @@ static void spike_board_init(MachineState *machine)
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> -    int i;
>      unsigned int smp_cpus = machine->smp.cpus;
>
>      /* Initialize SOC */
> @@ -212,40 +211,9 @@ static void spike_board_init(MachineState *machine)
>          }
>      }
>
> -    /* reset vector */
> -    uint32_t reset_vec[8] = {
> -        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(dtb) */
> -        0x02028593,                  /*     addi   a1, t0, %pcrel_lo(1b) */
> -        0xf1402573,                  /*     csrr   a0, mhartid  */
> -#if defined(TARGET_RISCV32)
> -        0x0182a283,                  /*     lw     t0, 24(t0) */
> -#elif defined(TARGET_RISCV64)
> -        0x0182b283,                  /*     ld     t0, 24(t0) */
> -#endif
> -        0x00028067,                  /*     jr     t0 */
> -        0x00000000,
> -        memmap[SPIKE_DRAM].base,     /* start: .dword DRAM_BASE */
> -        0x00000000,
> -                                     /* dtb: */
> -    };
> -
> -    /* copy in the reset vector in little_endian byte order */
> -    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> -        reset_vec[i] = cpu_to_le32(reset_vec[i]);
> -    }
> -    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
> -                          memmap[SPIKE_MROM].base, &address_space_memory);
> -
> -    /* copy in the device tree */
> -    if (fdt_pack(s->fdt) || fdt_totalsize(s->fdt) >
> -            memmap[SPIKE_MROM].size - sizeof(reset_vec)) {
> -        error_report("not enough space to store device-tree");
> -        exit(1);
> -    }
> -    qemu_fdt_dumpdtb(s->fdt, fdt_totalsize(s->fdt));
> -    rom_add_blob_fixed_as("mrom.fdt", s->fdt, fdt_totalsize(s->fdt),
> -                          memmap[SPIKE_MROM].base + sizeof(reset_vec),
> -                          &address_space_memory);
> +    /* load the reset vector */
> +    riscv_setup_rom_reset_vec(memmap[SPIKE_DRAM].base, memmap[SPIKE_MROM].base,
> +                              memmap[SPIKE_MROM].size, s->fdt);
>
>      /* initialize HTIF using symbols found in load_kernel */
>      htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 616db6f5aced..22a60259daab 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -535,40 +535,9 @@ static void virt_machine_init(MachineState *machine)
>          start_addr = virt_memmap[VIRT_FLASH].base;
>      }
>
> -    /* reset vector */
> -    uint32_t reset_vec[8] = {
> -        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(dtb) */
> -        0x02028593,                  /*     addi   a1, t0, %pcrel_lo(1b) */
> -        0xf1402573,                  /*     csrr   a0, mhartid  */
> -#if defined(TARGET_RISCV32)
> -        0x0182a283,                  /*     lw     t0, 24(t0) */
> -#elif defined(TARGET_RISCV64)
> -        0x0182b283,                  /*     ld     t0, 24(t0) */
> -#endif
> -        0x00028067,                  /*     jr     t0 */
> -        0x00000000,
> -        start_addr,                  /* start: .dword */
> -        0x00000000,
> -                                     /* dtb: */
> -    };
> -
> -    /* copy in the reset vector in little_endian byte order */
> -    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> -        reset_vec[i] = cpu_to_le32(reset_vec[i]);
> -    }
> -    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
> -                          memmap[VIRT_MROM].base, &address_space_memory);
> -
> -    /* copy in the device tree */
> -    if (fdt_pack(s->fdt) || fdt_totalsize(s->fdt) >
> -            memmap[VIRT_MROM].size - sizeof(reset_vec)) {
> -        error_report("not enough space to store device-tree");
> -        exit(1);
> -    }
> -    qemu_fdt_dumpdtb(s->fdt, fdt_totalsize(s->fdt));
> -    rom_add_blob_fixed_as("mrom.fdt", s->fdt, fdt_totalsize(s->fdt),
> -                          memmap[VIRT_MROM].base + sizeof(reset_vec),
> -                          &address_space_memory);
> +    /* load the reset vector */
> +    riscv_setup_rom_reset_vec(start_addr, virt_memmap[VIRT_MROM].base,
> +                              virt_memmap[VIRT_MROM].size, s->fdt);
>
>      /* create PLIC hart topology configuration string */
>      plic_hart_config_len = (strlen(VIRT_PLIC_HART_CONFIG) + 1) * smp_cpus;
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 9daa98da08d7..3e9759c89aa2 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -35,5 +35,7 @@ target_ulong riscv_load_kernel(const char *kernel_filename,
>                                 symbol_fn_t sym_cb);
>  hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
>                           uint64_t kernel_entry, hwaddr *start);
> +void riscv_setup_rom_reset_vec(hwaddr saddr, hwaddr rom_base,
> +                               hwaddr rom_size, void *fdt);
>
>  #endif /* RISCV_BOOT_H */
> --
> 2.26.2
>
>

