Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229F4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10B820DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cam.ac.uk header.i=@cam.ac.uk header.b="W7VQi2qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10B820DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cl.cam.ac.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKZ2-000358-04
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alr48@hermes.cam.ac.uk>)
 id 1jmK1U-0004t2-Cy; Fri, 19 Jun 2020 12:37:48 -0400
Received: from ppsw-42.csi.cam.ac.uk ([131.111.8.142]:59144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alr48@hermes.cam.ac.uk>)
 id 1jmK1R-0007JD-Ga; Fri, 19 Jun 2020 12:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cam.ac.uk; 
 s=20180806.ppsw;
 h=Sender:Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b9XpFmq302HcE5kKEQ1PU2CezAxkYWjLmwokgZ4919A=; b=W7VQi2qzVp9q1d7nX8OeXgJagJ
 0YzBHfzvpnuNQE92RGwBYZCnqXGM8meYIs2bpIr/ABiyYtI5Ka2PCgCQU1ZmIz6uE4pHrSmofL4ZA
 RE5M7npwDFFNZFwlte8AQstQMpHlbHdIhGoZ4LxxVETsjLyRFuk6llOawgVeYsiGbYl4=;
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from mail-io1-f54.google.com ([209.85.166.54]:34919)
 by ppsw-42.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:587)
 with esmtpsa (PLAIN:alr48) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 id 1jmK1O-000SgX-7d (Exim 4.92.3)
 (return-path <alr48@hermes.cam.ac.uk>); Fri, 19 Jun 2020 17:37:42 +0100
Received: by mail-io1-f54.google.com with SMTP id s18so11960060ioe.2;
 Fri, 19 Jun 2020 09:37:42 -0700 (PDT)
X-Gm-Message-State: AOAM531MWVcTNI4SZDoYzpfniI0a98tLi9Bsh9zcHaOlGaRSB5BmBgqp
 vFEQfCDYxcHTxGUiHjDEUbzhS7k2dJl4Zsh49Ic=
X-Google-Smtp-Source: ABdhPJyV7jVZO7bwKk87VOfU9zwXKxYv8YFKvxotEJo65VtNRtqvyGvMqZhLKB+2lzJ4neyTtMu+qhWZf3GupEsFP8U=
X-Received: by 2002:a5e:dd07:: with SMTP id t7mr5255119iop.21.1592584661175;
 Fri, 19 Jun 2020 09:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200616192700.1900260-1-atish.patra@wdc.com>
 <20200616192700.1900260-2-atish.patra@wdc.com>
In-Reply-To: <20200616192700.1900260-2-atish.patra@wdc.com>
From: Alexander Richardson <Alexander.Richardson@cl.cam.ac.uk>
Date: Fri, 19 Jun 2020 17:37:25 +0100
X-Gmail-Original-Message-ID: <CAEeofcjkjBHwQx_pRPG1GSfkg5KHc6UqfEEmu_14sJmgVfqG7w@mail.gmail.com>
Message-ID: <CAEeofcjkjBHwQx_pRPG1GSfkg5KHc6UqfEEmu_14sJmgVfqG7w@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: Unify Qemu's reset vector code path
To: Atish Patra <atish.patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=131.111.8.142;
 envelope-from=alr48@hermes.cam.ac.uk; helo=ppsw-42.csi.cam.ac.uk
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 12:37:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Jun 2020 13:07:04 -0400
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
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 at 20:30, Atish Patra <atish.patra@wdc.com> wrote:
>
> Currently, all riscv machines have identical reset vector code
> implementations with memory addresses being different for all machines.
> They can be easily combined into a single function in common code.
>
> Move it to common function and let all the machines use the common function.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  hw/riscv/boot.c         | 46 +++++++++++++++++++++++++++++++++++++++++
>  hw/riscv/sifive_u.c     | 38 +++-------------------------------
>  hw/riscv/spike.c        | 38 +++-------------------------------
>  hw/riscv/virt.c         | 37 +++------------------------------
>  include/hw/riscv/boot.h |  2 ++
>  5 files changed, 57 insertions(+), 104 deletions(-)
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
Maybe use ARRAY_SIZE(reset_vec) instead of sizeof(reset_vec) >> 2 ?

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
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index f9fef2be9170..c2712570e0d9 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -325,7 +325,6 @@ static void sifive_u_machine_init(MachineState *machine)
>      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>      MemoryRegion *flash0 = g_new(MemoryRegion, 1);
>      target_ulong start_addr = memmap[SIFIVE_U_DRAM].base;
> -    int i;
>
>      /* Initialize SoC */
>      object_initialize_child(OBJECT(machine), "soc", &s->soc,
> @@ -374,40 +373,9 @@ static void sifive_u_machine_init(MachineState *machine)
>          start_addr = memmap[SIFIVE_U_FLASH0].base;
>      }
>
> -    /* reset vector */
> -    uint32_t reset_vec[8] = {
> -        0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(dtb) */
> -        0x02028593,                    /*     addi   a1, t0, %pcrel_lo(1b) */
> -        0xf1402573,                    /*     csrr   a0, mhartid  */
> -#if defined(TARGET_RISCV32)
> -        0x0182a283,                    /*     lw     t0, 24(t0) */
> -#elif defined(TARGET_RISCV64)
> -        0x0182b283,                    /*     ld     t0, 24(t0) */
> -#endif
> -        0x00028067,                    /*     jr     t0 */
> -        0x00000000,
> -        start_addr,                    /* start: .dword */
> -        0x00000000,
> -                                       /* dtb: */
> -    };
> -
> -    /* copy in the reset vector in little_endian byte order */
> -    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> -        reset_vec[i] = cpu_to_le32(reset_vec[i]);
> -    }
> -    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
> -                          memmap[SIFIVE_U_MROM].base, &address_space_memory);
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
> +    /* load the reset vector */
> +    riscv_setup_rom_reset_vec(start_addr, memmap[SIFIVE_U_MROM].base,
> +                              memmap[SIFIVE_U_MROM].size, s->fdt);
>  }
>
>  static bool sifive_u_machine_get_start_in_flash(Object *obj, Error **errp)
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 7bbbdb50363d..238eae48716a 100644
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
> @@ -213,40 +212,9 @@ static void spike_board_init(MachineState *machine)
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
> index 4e4c494a7050..a8e2d58cc067 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -536,40 +536,9 @@ static void virt_machine_init(MachineState *machine)
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

