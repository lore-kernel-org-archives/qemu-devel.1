Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D66DC56201
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0BA2223FD
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBq5ASy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BA2223FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWyRl-0003ox-Mw
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 05:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWyId-0002AN-Nr; Mon, 26 Oct 2020 04:56:19 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:36672)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWyIb-0005kM-RR; Mon, 26 Oct 2020 04:56:19 -0400
Received: by mail-yb1-xb42.google.com with SMTP id f140so7015721ybg.3;
 Mon, 26 Oct 2020 01:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s536AZZpRLlIXesgwxri1axUHJ6DRlZIVLg8B0woC+c=;
 b=JBq5ASy/JZzDDNzgVxtjlvOdhFM1DodP3xFze2S7dJPcr3KVNZh83120YZdwhY4PzO
 C4tDxkZeXbwPJQFv85vzR2SZKf8g97NEbV2jeP43Yf7C4TP1/JDnt0/eh4XtybPts58C
 ivxQTh9WUcF4bt5LBB0NXhKlAFPSG944OgjeJaxtaR7zXEtbN9quIFUhk054LYe23ITg
 Y369vJ/y3ehMAYfOx0jyup0GiYPJR038/SM+2EdLlh0uz1WZpSI46qGkInrUh9VpE4YX
 XAxkSpcWDuHeLw7btu+I0RQ+psxLBckz//t/aPUQbwa45CFg7IrZRfzkxPnZYePHHVwV
 Bclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s536AZZpRLlIXesgwxri1axUHJ6DRlZIVLg8B0woC+c=;
 b=BeIE3wxHFhcyK4BFuezRudRkAEzaQNWMrPW3fzLdj5cZBqFk6J4yvDAhNu2BUmmxGr
 LlywZgbjcJaGmI2rNBfVu+zy87rbD/RS8mXxLyvQr8L9RSyvxDR6oh74OOArhYm4+yJQ
 BIYIhOENc7FiF5fXWrUVYvPy+OXwuBBDt1Gsyb5AXswMMPVpTdmJk+kERK21lS+vmkVU
 5HI80+wNEWfX7C5gys2IAwMquTR6lk2ZMpZ9r44hS41aBpBLMK+/GdaNg0rnVDNiOEC8
 DzTK4WsaGQugZRr2VjWGq62Djg7XKYGqY/8czRMYeagOoGtGNWkO921Bj8CeCQOpCCKm
 WzlA==
X-Gm-Message-State: AOAM530/XuQ9n/Mev4VdRLk/9IJJWvUFgy5ooJYpH1KR9yu+RzaTLJ9q
 SW7kZOXLNgIfoT2OO0RBXu4oPTuf2vbPhyjvMlA=
X-Google-Smtp-Source: ABdhPJz9oUQsjCn/iWcp+HUHOlhuqi1pcOk8jgSgIMl9w3tsO5yiacfnIpovAwA0k+uOLiGkb5D4wsR4G29pAXpUFaQ=
X-Received: by 2002:a25:328a:: with SMTP id
 y132mr18122426yby.306.1603702576560; 
 Mon, 26 Oct 2020 01:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603467169.git.alistair.francis@wdc.com>
 <7ce5ff70057b2fad2d455887d048c419a7e42746.1603467169.git.alistair.francis@wdc.com>
In-Reply-To: <7ce5ff70057b2fad2d455887d048c419a7e42746.1603467169.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 26 Oct 2020 16:56:04 +0800
Message-ID: <CAEUhbmXVDj0AJ9-0WC3G_Gk4jA6B78hQoFz6KX0SGdCPPCsVTQ@mail.gmail.com>
Subject: Re: [PATCH v1 07/16] hw/riscv: sifive_u: Remove compile time XLEN
 checks
To: Alistair Francis <alistair.francis@wdc.com>
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 11:44 PM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/sifive_u.c | 57 ++++++++++++++++++++++++---------------------
>  1 file changed, 31 insertions(+), 26 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 978cfedd24..3bc32c9225 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -60,12 +60,6 @@
>
>  #include <libfdt.h>
>
> -#if defined(TARGET_RISCV32)
> -# define BIOS_FILENAME "opensbi-riscv32-generic-fw_dynamic.bin"
> -#else
> -# define BIOS_FILENAME "opensbi-riscv64-generic-fw_dynamic.bin"
> -#endif
> -
>  static const struct MemmapEntry {
>      hwaddr base;
>      hwaddr size;
> @@ -93,7 +87,7 @@ static const struct MemmapEntry {
>  #define GEM_REVISION        0x10070109
>
>  static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
> -    uint64_t mem_size, const char *cmdline)
> +                       uint64_t mem_size, const char *cmdline, bool is_32_bit)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
>      void *fdt;
> @@ -167,11 +161,11 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>          qemu_fdt_add_subnode(fdt, nodename);
>          /* cpu 0 is the management hart that does not have mmu */
>          if (cpu != 0) {
> -#if defined(TARGET_RISCV32)
> -            qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
> -#else
> -            qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
> -#endif
> +            if (is_32_bit) {
> +                qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
> +            } else {
> +                qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
> +            }
>              isa = riscv_isa_string(&s->soc.u_cpus.harts[cpu - 1]);
>          } else {
>              isa = riscv_isa_string(&s->soc.e_cpus.harts[0]);
> @@ -414,7 +408,7 @@ static void sifive_u_machine_init(MachineState *machine)
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>      MemoryRegion *flash0 = g_new(MemoryRegion, 1);
> -    target_ulong start_addr = memmap[SIFIVE_U_DEV_DRAM].base;
> +    uint64_t start_addr = memmap[SIFIVE_U_DEV_DRAM].base;

Why is this change necessary? If yes, should we do the same change to virt.c?

>      target_ulong firmware_end_addr, kernel_start_addr;
>      uint32_t start_addr_hi32 = 0x00000000;
>      int i;
> @@ -446,7 +440,8 @@ static void sifive_u_machine_init(MachineState *machine)
>                            qemu_allocate_irq(sifive_u_machine_reset, NULL, 0));
>
>      /* create device tree */
> -    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
> +    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline,
> +               riscv_is_32_bit(machine));
>
>      if (s->start_in_flash) {
>          /*
> @@ -475,8 +470,15 @@ static void sifive_u_machine_init(MachineState *machine)
>          break;
>      }
>
> -    firmware_end_addr = riscv_find_and_load_firmware(machine, BIOS_FILENAME,
> -                                                     start_addr, NULL);
> +    if (riscv_is_32_bit(machine)) {
> +        firmware_end_addr = riscv_find_and_load_firmware(machine,
> +                                    "opensbi-riscv32-generic-fw_dynamic.bin",
> +                                    start_addr, NULL);
> +    } else {
> +        firmware_end_addr = riscv_find_and_load_firmware(machine,
> +                                    "opensbi-riscv64-generic-fw_dynamic.bin",
> +                                    start_addr, NULL);
> +    }
>
>      if (machine->kernel_filename) {
>          kernel_start_addr = riscv_calc_kernel_start_addr(machine,
> @@ -506,9 +508,9 @@ static void sifive_u_machine_init(MachineState *machine)
>      /* Compute the fdt load address in dram */
>      fdt_load_addr = riscv_load_fdt(memmap[SIFIVE_U_DEV_DRAM].base,
>                                     machine->ram_size, s->fdt);
> -    #if defined(TARGET_RISCV64)
> -    start_addr_hi32 = start_addr >> 32;
> -    #endif
> +    if (!riscv_is_32_bit(machine)) {
> +        start_addr_hi32 = start_addr >> 32;
> +    }
>
>      /* reset vector */
>      uint32_t reset_vec[11] = {
> @@ -516,13 +518,8 @@ static void sifive_u_machine_init(MachineState *machine)
>          0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
>          0x02828613,                    /*     addi   a2, t0, %pcrel_lo(1b) */
>          0xf1402573,                    /*     csrr   a0, mhartid  */
> -#if defined(TARGET_RISCV32)
> -        0x0202a583,                    /*     lw     a1, 32(t0) */
> -        0x0182a283,                    /*     lw     t0, 24(t0) */
> -#elif defined(TARGET_RISCV64)
> -        0x0202b583,                    /*     ld     a1, 32(t0) */
> -        0x0182b283,                    /*     ld     t0, 24(t0) */
> -#endif
> +        0,
> +        0,
>          0x00028067,                    /*     jr     t0 */
>          start_addr,                    /* start: .dword */
>          start_addr_hi32,
> @@ -530,6 +527,14 @@ static void sifive_u_machine_init(MachineState *machine)
>          0x00000000,
>                                         /* fw_dyn: */
>      };
> +    if (riscv_is_32_bit(machine)) {
> +        reset_vec[4] = 0x0202a583;     /*     lw     a1, 32(t0) */
> +        reset_vec[5] = 0x0182a283;     /*     lw     t0, 24(t0) */
> +    } else {
> +        reset_vec[4] = 0x0202b583;     /*     ld     a1, 32(t0) */
> +        reset_vec[5] = 0x0182b283;     /*     ld     t0, 24(t0) */
> +    }
> +
>
>      /* copy in the reset vector in little_endian byte order */
>      for (i = 0; i < ARRAY_SIZE(reset_vec); i++) {

Regards,
Bin

