Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82C4C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:54:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266A3206F9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkBFSeg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266A3206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZd63-0005jx-4u
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 11:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kZd54-0004Fv-1d; Mon, 02 Nov 2020 11:53:18 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:33149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kZd51-0003jM-OS; Mon, 02 Nov 2020 11:53:17 -0500
Received: by mail-io1-xd42.google.com with SMTP id j12so961660iow.0;
 Mon, 02 Nov 2020 08:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tS8v4nzlJZu7d6GXguhBK1/ScAKpUC99fTeoGWL9UbI=;
 b=fkBFSeg8j4fZ3mhXBRHEKwFpBjg+nMEvixDEGXD/AL8bIirPoHlf26P3JgEMf+Bt67
 Ap6urpBfwtt6yVBj0tslWrAycu/0y6jNOh6+ZHCGRKzyIv2/WMe90Oh8yhWFNo/qWkB0
 L75Aly5NhANd5xyRJ/2fjcZYkeXC5qdd+UYBFaB31JSJlxTobuMgL/ATJDig7IFsEtAt
 OJha2LNO/JsG/GPIwhKBMgGWC3fS47Tg3njXCF4yyWY1EJRlYoOpCzAXX3eV8nZADnUF
 dR1l6aaQVsewEPhjkyZoiidWg/V8kVLmDrMORmUtLnuB4gJUzKdLqs7f2CdKPqnkD/pB
 1T/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tS8v4nzlJZu7d6GXguhBK1/ScAKpUC99fTeoGWL9UbI=;
 b=CvqT7m5/BWdWEaHGYLO5i+jtASD+TfmKYJFF0h1rjk0eok+yQtwj2n4z8vHF9+EdUe
 4gFilABYAcXa0fB9B7h5GWsYpkpnVhLhwdFbTaPoX06aOPtq4X0NiKep/LhNn0MpIBwk
 efWxG79Nxt+F8n0danrDgNy3pv5nxNwQaTddRHRQckvelU+FUqGGJLkSKjCpCVgft/bO
 /F/nCMxC6QST16ik0FKomWZsedUl+o1zL1/8kWCQ8FyWNEM0OH25bFxTKeJrwBUHKrlR
 GE+JjuIayj+7DkfPGP9BY+xwMC5N0TaM40bPKfN+1E3me1h01snc5cAztxeWWUkVSD6h
 TAIw==
X-Gm-Message-State: AOAM532+icj15y4RlwVqubFpXx5/1KxHYddo8hGKbTugspAFgVB92TbE
 0GLMgyv0V3rrZZo4MhmM8NqzsDrsfHewPMy7VyI=
X-Google-Smtp-Source: ABdhPJxz0bjwomIQGa6s98p8OZH+Cw8svwcc0245tLDKUCauRYfEZXP+irYeiib1RRXIQcdUxX/ec4/TCbCDtWTiAL4=
X-Received: by 2002:a05:6638:451:: with SMTP id
 r17mr12741147jap.8.1604335993824; 
 Mon, 02 Nov 2020 08:53:13 -0800 (PST)
MIME-Version: 1.0
References: <20201101170538.3732-1-bmeng.cn@gmail.com>
In-Reply-To: <20201101170538.3732-1-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 2 Nov 2020 08:41:17 -0800
Message-ID: <CAKmqyKMsFZEBvNs9M3tBZi25eFVPKj9VDu60neZcf-W3bFUgEg@mail.gmail.com>
Subject: Re: [PATCH v4] hw/riscv: microchip_pfsoc: Correct DDR memory map
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
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
 Bin Meng <bin.meng@windriver.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Nov 1, 2020 at 9:06 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> When system memory is larger than 1 GiB (high memory), PolarFire SoC
> maps it at address 0x10_0000_0000. Address 0xC000_0000 and above is
> aliased to the same 1 GiB low memory with different cache attributes.
>
> At present QEMU maps the system memory contiguously from 0x8000_0000.
> This corrects the wrong QEMU logic. Note address 0x14_0000_0000 is
> the alias to the high memory, and even physical memory is only 1 GiB,
> the HSS codes still tries to probe the high memory alias address.
> It seems there is no issue on the real hardware, so we will have to
> take that into the consideration in our emulation. Due to this, we
> we increase the default system memory size to 1537 MiB (the minimum
> required high memory size by HSS) so that user gets notified an error
> when less than 1537 MiB is specified.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
> This patch should replace the following commit in Alistair's
> riscv-to-apply.next tree:
> https://github.com/alistair23/qemu/commit/8c47c1e9df850a928b4b230240a950feabe6152f
>
> Changes in v4:
> - Change default ram size to 1537 MiB which is the minimum required
>   high memory size to satisfy HSS
>
> Changes in v3:
> - Change default ram size to 2047 MiB for 32-bit host
>
>  hw/riscv/microchip_pfsoc.c         | 50 ++++++++++++++++++++++++++----
>  include/hw/riscv/microchip_pfsoc.h |  5 ++-
>  2 files changed, 48 insertions(+), 7 deletions(-)
>
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 44a84732ac..96cb8b983a 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -121,7 +121,10 @@ static const struct MemmapEntry {
>      [MICROCHIP_PFSOC_ENVM_CFG] =        { 0x20200000,     0x1000 },
>      [MICROCHIP_PFSOC_ENVM_DATA] =       { 0x20220000,    0x20000 },
>      [MICROCHIP_PFSOC_IOSCB] =           { 0x30000000, 0x10000000 },
> -    [MICROCHIP_PFSOC_DRAM] =            { 0x80000000,        0x0 },
> +    [MICROCHIP_PFSOC_DRAM_LO] =         { 0x80000000, 0x40000000 },
> +    [MICROCHIP_PFSOC_DRAM_LO_ALIAS] =   { 0xc0000000, 0x40000000 },
> +    [MICROCHIP_PFSOC_DRAM_HI] =       { 0x1000000000,        0x0 },
> +    [MICROCHIP_PFSOC_DRAM_HI_ALIAS] = { 0x1400000000,        0x0 },
>  };
>
>  static void microchip_pfsoc_soc_instance_init(Object *obj)
> @@ -424,7 +427,11 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
>      const struct MemmapEntry *memmap = microchip_pfsoc_memmap;
>      MicrochipIcicleKitState *s = MICROCHIP_ICICLE_KIT_MACHINE(machine);
>      MemoryRegion *system_memory = get_system_memory();
> -    MemoryRegion *main_mem = g_new(MemoryRegion, 1);
> +    MemoryRegion *mem_low = g_new(MemoryRegion, 1);
> +    MemoryRegion *mem_low_alias = g_new(MemoryRegion, 1);
> +    MemoryRegion *mem_high = g_new(MemoryRegion, 1);
> +    MemoryRegion *mem_high_alias = g_new(MemoryRegion, 1);
> +    uint64_t mem_high_size;
>      DriveInfo *dinfo = drive_get_next(IF_SD);
>
>      /* Sanity check on RAM size */
> @@ -441,10 +448,33 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
>      qdev_realize(DEVICE(&s->soc), NULL, &error_abort);
>
>      /* Register RAM */
> -    memory_region_init_ram(main_mem, NULL, "microchip.icicle.kit.ram",
> -                           machine->ram_size, &error_fatal);
> +    memory_region_init_ram(mem_low, NULL, "microchip.icicle.kit.ram_low",
> +                           memmap[MICROCHIP_PFSOC_DRAM_LO].size,
> +                           &error_fatal);
> +    memory_region_init_alias(mem_low_alias, NULL,
> +                             "microchip.icicle.kit.ram_low.alias",
> +                             mem_low, 0,
> +                             memmap[MICROCHIP_PFSOC_DRAM_LO_ALIAS].size);
> +    memory_region_add_subregion(system_memory,
> +                                memmap[MICROCHIP_PFSOC_DRAM_LO].base,
> +                                mem_low);
>      memory_region_add_subregion(system_memory,
> -                                memmap[MICROCHIP_PFSOC_DRAM].base, main_mem);
> +                                memmap[MICROCHIP_PFSOC_DRAM_LO_ALIAS].base,
> +                                mem_low_alias);
> +
> +    mem_high_size = machine->ram_size - 1 * GiB;
> +
> +    memory_region_init_ram(mem_high, NULL, "microchip.icicle.kit.ram_high",
> +                           mem_high_size, &error_fatal);
> +    memory_region_init_alias(mem_high_alias, NULL,
> +                             "microchip.icicle.kit.ram_high.alias",
> +                             mem_high, 0, mem_high_size);
> +    memory_region_add_subregion(system_memory,
> +                                memmap[MICROCHIP_PFSOC_DRAM_HI].base,
> +                                mem_high);
> +    memory_region_add_subregion(system_memory,
> +                                memmap[MICROCHIP_PFSOC_DRAM_HI_ALIAS].base,
> +                                mem_high_alias);
>
>      /* Load the firmware */
>      riscv_find_and_load_firmware(machine, BIOS_FILENAME, RESET_VECTOR, NULL);
> @@ -470,7 +500,15 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, void *data)
>                     MICROCHIP_PFSOC_COMPUTE_CPU_COUNT;
>      mc->min_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT + 1;
>      mc->default_cpus = mc->min_cpus;
> -    mc->default_ram_size = 1 * GiB;
> +
> +    /*
> +     * Map 513 MiB high memory, the mimimum required high memory size, because
> +     * HSS will do memory test against the high memory address range regardless
> +     * of physical memory installed.
> +     *
> +     * See memory_tests() in mss_ddr.c in the HSS source code.
> +     */
> +    mc->default_ram_size = 1537 * MiB;
>  }
>
>  static const TypeInfo microchip_icicle_kit_machine_typeinfo = {
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> index f34a6b3fd7..db77e9c84a 100644
> --- a/include/hw/riscv/microchip_pfsoc.h
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -105,7 +105,10 @@ enum {
>      MICROCHIP_PFSOC_ENVM_CFG,
>      MICROCHIP_PFSOC_ENVM_DATA,
>      MICROCHIP_PFSOC_IOSCB,
> -    MICROCHIP_PFSOC_DRAM,
> +    MICROCHIP_PFSOC_DRAM_LO,
> +    MICROCHIP_PFSOC_DRAM_LO_ALIAS,
> +    MICROCHIP_PFSOC_DRAM_HI,
> +    MICROCHIP_PFSOC_DRAM_HI_ALIAS
>  };
>
>  enum {
> --
> 2.25.1
>
>

