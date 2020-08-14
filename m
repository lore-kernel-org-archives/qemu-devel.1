Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99E2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:31:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9304D20716
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sxg1eE/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9304D20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6bgL-0005gY-Qf
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 11:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k6bUU-00033a-79
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:19:34 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:32996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k6bUR-0000tB-Qc
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:19:33 -0400
Received: by mail-il1-x142.google.com with SMTP id r13so4310428iln.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jyGDsrHCao/o7GHhYThw3p4q7QMEbY/qIu7PwbA24N8=;
 b=Sxg1eE/x+BIve2TDvhyrVJc4JgWmiVRpqPOMD7Ei3pw6tBEH8rJy8ZhBkED4Er7lGO
 juSR2FMT6GRzXh9uLCr2oNWEsLIbqDxrAQGW6omcXmpLKqMPzu7kZmfGRjSnzvXagf4Q
 fHXVsbrwtQadAcUo7OtKNUZI6zGwWYMcm/VGYvPVubMXMeypAcfeXh7qRVXLDR8ZdD0S
 jNdHX41KhqCA3N0G1fFKHYtlD3rHZmVa09NkJg/7IjHeaxEH0YgF9+ank9qlZUox7yMT
 zZuLDDXVHJLqozRcKA0kgaq264e/yg9pif6SyL0/rQl8bqxB8hnhMYgG0BlwNBnDjRTA
 yUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jyGDsrHCao/o7GHhYThw3p4q7QMEbY/qIu7PwbA24N8=;
 b=QSQ2FkADUY+MIaq+KJdYvCfWpO6GFsu8kWsjhcGcXqEgeoH27AEnme3y8aJzTCdeHr
 7KS1Pob2DcOZaQR0mPQd9yf74+yEsuy97CU1dWGzqBrYwXEtVMdx6Y4Exs6zL7AFeEr3
 9xmWnLyMCwuhwuR27/0TY+Ov7e3FwbXIto1IOegvDztAt9soiQOlNJ6lE3TNWUeyvjqG
 5VLiHpb670EyAn0hzB+l6z57wvYs3932Yn864OIZW/bRf5u0oJBHtv3AnH3JRuaMzBkk
 fGHuXGTRc59FmgeDclNkbKhYMY32tfkis9T+gH2rTg+2zXUK1+ReBdwDK0OO48OPeNOE
 jd0Q==
X-Gm-Message-State: AOAM531QQNhM1TR1IYvQx5txstp4TPTreFiQDeqacaVcDDPi6pj1kVG4
 T7SgeQmaR8c+EXczHo+Wk6At4WHPVi4HGuOy5MRjoYLj+mk=
X-Google-Smtp-Source: ABdhPJx4s70n8nytgNCyhLZ7Y2aUoed8fi45TvI4VNkVvRMMLsBTug+1PRYPePUuf1Gh6B6TZWj4HeTs+WpvQeqWx24=
X-Received: by 2002:a05:6e02:ed4:: with SMTP id
 i20mr2943256ilk.267.1597418370395; 
 Fri, 14 Aug 2020 08:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-11-ehabkost@redhat.com>
In-Reply-To: <20200813222625.243136-11-ehabkost@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 14 Aug 2020 08:09:01 -0700
Message-ID: <CAKmqyKNe+f04rXuBcf7z6ms0GGUSL0cn6twiBhNUUkt-obD2pQ@mail.gmail.com>
Subject: Re: [PATCH 10/41] sifive_u: Rename memmap enum constants
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 13, 2020 at 3:37 PM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Some of the enum constant names conflict with the QOM type check
> macros.  This needs to be addressed to allow us to transform the
> QOM type check macros into functions generated by
> OBJECT_DECLARE_TYPE().
>
> Rename all the constants to SIFIVE_U_DEV_*, to avoid conflicts.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/riscv/sifive_u.h |  30 ++++----
>  hw/riscv/sifive_u.c         | 136 ++++++++++++++++++------------------
>  2 files changed, 83 insertions(+), 83 deletions(-)
>
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index aba4d0181f..0dab922f3a 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -68,21 +68,21 @@ typedef struct SiFiveUState {
>  } SiFiveUState;
>
>  enum {
> -    SIFIVE_U_DEBUG,
> -    SIFIVE_U_MROM,
> -    SIFIVE_U_CLINT,
> -    SIFIVE_U_L2LIM,
> -    SIFIVE_U_PLIC,
> -    SIFIVE_U_PRCI,
> -    SIFIVE_U_UART0,
> -    SIFIVE_U_UART1,
> -    SIFIVE_U_GPIO,
> -    SIFIVE_U_OTP,
> -    SIFIVE_U_DMC,
> -    SIFIVE_U_FLASH0,
> -    SIFIVE_U_DRAM,
> -    SIFIVE_U_GEM,
> -    SIFIVE_U_GEM_MGMT
> +    SIFIVE_U_DEV_DEBUG,
> +    SIFIVE_U_DEV_MROM,
> +    SIFIVE_U_DEV_CLINT,
> +    SIFIVE_U_DEV_L2LIM,
> +    SIFIVE_U_DEV_PLIC,
> +    SIFIVE_U_DEV_PRCI,
> +    SIFIVE_U_DEV_UART0,
> +    SIFIVE_U_DEV_UART1,
> +    SIFIVE_U_DEV_GPIO,
> +    SIFIVE_U_DEV_OTP,
> +    SIFIVE_U_DEV_DMC,
> +    SIFIVE_U_DEV_FLASH0,
> +    SIFIVE_U_DEV_DRAM,
> +    SIFIVE_U_DEV_GEM,
> +    SIFIVE_U_DEV_GEM_MGMT
>  };
>
>  enum {
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index e5682c38a9..0dfbcb5160 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -69,21 +69,21 @@ static const struct MemmapEntry {
>      hwaddr base;
>      hwaddr size;
>  } sifive_u_memmap[] = {
> -    [SIFIVE_U_DEBUG] =    {        0x0,      0x100 },
> -    [SIFIVE_U_MROM] =     {     0x1000,     0xf000 },
> -    [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
> -    [SIFIVE_U_L2LIM] =    {  0x8000000,  0x2000000 },
> -    [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
> -    [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
> -    [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
> -    [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
> -    [SIFIVE_U_GPIO] =     { 0x10060000,     0x1000 },
> -    [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
> -    [SIFIVE_U_GEM] =      { 0x10090000,     0x2000 },
> -    [SIFIVE_U_GEM_MGMT] = { 0x100a0000,     0x1000 },
> -    [SIFIVE_U_DMC] =      { 0x100b0000,    0x10000 },
> -    [SIFIVE_U_FLASH0] =   { 0x20000000, 0x10000000 },
> -    [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
> +    [SIFIVE_U_DEV_DEBUG] =    {        0x0,      0x100 },
> +    [SIFIVE_U_DEV_MROM] =     {     0x1000,     0xf000 },
> +    [SIFIVE_U_DEV_CLINT] =    {  0x2000000,    0x10000 },
> +    [SIFIVE_U_DEV_L2LIM] =    {  0x8000000,  0x2000000 },
> +    [SIFIVE_U_DEV_PLIC] =     {  0xc000000,  0x4000000 },
> +    [SIFIVE_U_DEV_PRCI] =     { 0x10000000,     0x1000 },
> +    [SIFIVE_U_DEV_UART0] =    { 0x10010000,     0x1000 },
> +    [SIFIVE_U_DEV_UART1] =    { 0x10011000,     0x1000 },
> +    [SIFIVE_U_DEV_GPIO] =     { 0x10060000,     0x1000 },
> +    [SIFIVE_U_DEV_OTP] =      { 0x10070000,     0x1000 },
> +    [SIFIVE_U_DEV_GEM] =      { 0x10090000,     0x2000 },
> +    [SIFIVE_U_DEV_GEM_MGMT] = { 0x100a0000,     0x1000 },
> +    [SIFIVE_U_DEV_DMC] =      { 0x100b0000,    0x10000 },
> +    [SIFIVE_U_DEV_FLASH0] =   { 0x20000000, 0x10000000 },
> +    [SIFIVE_U_DEV_DRAM] =     { 0x80000000,        0x0 },
>  };
>
>  #define OTP_SERIAL          1
> @@ -142,10 +142,10 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      g_free(nodename);
>
>      nodename = g_strdup_printf("/memory@%lx",
> -        (long)memmap[SIFIVE_U_DRAM].base);
> +        (long)memmap[SIFIVE_U_DEV_DRAM].base);
>      qemu_fdt_add_subnode(fdt, nodename);
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
> -        memmap[SIFIVE_U_DRAM].base >> 32, memmap[SIFIVE_U_DRAM].base,
> +        memmap[SIFIVE_U_DEV_DRAM].base >> 32, memmap[SIFIVE_U_DEV_DRAM].base,
>          mem_size >> 32, mem_size);
>      qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
>      g_free(nodename);
> @@ -200,39 +200,39 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>          g_free(nodename);
>      }
>      nodename = g_strdup_printf("/soc/clint@%lx",
> -        (long)memmap[SIFIVE_U_CLINT].base);
> +        (long)memmap[SIFIVE_U_DEV_CLINT].base);
>      qemu_fdt_add_subnode(fdt, nodename);
>      qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,clint0");
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
> -        0x0, memmap[SIFIVE_U_CLINT].base,
> -        0x0, memmap[SIFIVE_U_CLINT].size);
> +        0x0, memmap[SIFIVE_U_DEV_CLINT].base,
> +        0x0, memmap[SIFIVE_U_DEV_CLINT].size);
>      qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
>          cells, ms->smp.cpus * sizeof(uint32_t) * 4);
>      g_free(cells);
>      g_free(nodename);
>
>      nodename = g_strdup_printf("/soc/otp@%lx",
> -        (long)memmap[SIFIVE_U_OTP].base);
> +        (long)memmap[SIFIVE_U_DEV_OTP].base);
>      qemu_fdt_add_subnode(fdt, nodename);
>      qemu_fdt_setprop_cell(fdt, nodename, "fuse-count", SIFIVE_U_OTP_REG_SIZE);
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
> -        0x0, memmap[SIFIVE_U_OTP].base,
> -        0x0, memmap[SIFIVE_U_OTP].size);
> +        0x0, memmap[SIFIVE_U_DEV_OTP].base,
> +        0x0, memmap[SIFIVE_U_DEV_OTP].size);
>      qemu_fdt_setprop_string(fdt, nodename, "compatible",
>          "sifive,fu540-c000-otp");
>      g_free(nodename);
>
>      prci_phandle = phandle++;
>      nodename = g_strdup_printf("/soc/clock-controller@%lx",
> -        (long)memmap[SIFIVE_U_PRCI].base);
> +        (long)memmap[SIFIVE_U_DEV_PRCI].base);
>      qemu_fdt_add_subnode(fdt, nodename);
>      qemu_fdt_setprop_cell(fdt, nodename, "phandle", prci_phandle);
>      qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x1);
>      qemu_fdt_setprop_cells(fdt, nodename, "clocks",
>          hfclk_phandle, rtcclk_phandle);
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
> -        0x0, memmap[SIFIVE_U_PRCI].base,
> -        0x0, memmap[SIFIVE_U_PRCI].size);
> +        0x0, memmap[SIFIVE_U_DEV_PRCI].base,
> +        0x0, memmap[SIFIVE_U_DEV_PRCI].size);
>      qemu_fdt_setprop_string(fdt, nodename, "compatible",
>          "sifive,fu540-c000-prci");
>      g_free(nodename);
> @@ -256,7 +256,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>          g_free(nodename);
>      }
>      nodename = g_strdup_printf("/soc/interrupt-controller@%lx",
> -        (long)memmap[SIFIVE_U_PLIC].base);
> +        (long)memmap[SIFIVE_U_DEV_PLIC].base);
>      qemu_fdt_add_subnode(fdt, nodename);
>      qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", 1);
>      qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,plic0");
> @@ -264,8 +264,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
>          cells, (ms->smp.cpus * 4 - 2) * sizeof(uint32_t));
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
> -        0x0, memmap[SIFIVE_U_PLIC].base,
> -        0x0, memmap[SIFIVE_U_PLIC].size);
> +        0x0, memmap[SIFIVE_U_DEV_PLIC].base,
> +        0x0, memmap[SIFIVE_U_DEV_PLIC].size);
>      qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", 0x35);
>      qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
>      plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
> @@ -274,7 +274,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>
>      gpio_phandle = phandle++;
>      nodename = g_strdup_printf("/soc/gpio@%lx",
> -        (long)memmap[SIFIVE_U_GPIO].base);
> +        (long)memmap[SIFIVE_U_DEV_GPIO].base);
>      qemu_fdt_add_subnode(fdt, nodename);
>      qemu_fdt_setprop_cell(fdt, nodename, "phandle", gpio_phandle);
>      qemu_fdt_setprop_cells(fdt, nodename, "clocks",
> @@ -284,8 +284,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_cell(fdt, nodename, "#gpio-cells", 2);
>      qemu_fdt_setprop(fdt, nodename, "gpio-controller", NULL, 0);
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
> -        0x0, memmap[SIFIVE_U_GPIO].base,
> -        0x0, memmap[SIFIVE_U_GPIO].size);
> +        0x0, memmap[SIFIVE_U_DEV_GPIO].base,
> +        0x0, memmap[SIFIVE_U_DEV_GPIO].size);
>      qemu_fdt_setprop_cells(fdt, nodename, "interrupts", SIFIVE_U_GPIO_IRQ0,
>          SIFIVE_U_GPIO_IRQ1, SIFIVE_U_GPIO_IRQ2, SIFIVE_U_GPIO_IRQ3,
>          SIFIVE_U_GPIO_IRQ4, SIFIVE_U_GPIO_IRQ5, SIFIVE_U_GPIO_IRQ6,
> @@ -304,15 +304,15 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>
>      phy_phandle = phandle++;
>      nodename = g_strdup_printf("/soc/ethernet@%lx",
> -        (long)memmap[SIFIVE_U_GEM].base);
> +        (long)memmap[SIFIVE_U_DEV_GEM].base);
>      qemu_fdt_add_subnode(fdt, nodename);
>      qemu_fdt_setprop_string(fdt, nodename, "compatible",
>          "sifive,fu540-c000-gem");
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
> -        0x0, memmap[SIFIVE_U_GEM].base,
> -        0x0, memmap[SIFIVE_U_GEM].size,
> -        0x0, memmap[SIFIVE_U_GEM_MGMT].base,
> -        0x0, memmap[SIFIVE_U_GEM_MGMT].size);
> +        0x0, memmap[SIFIVE_U_DEV_GEM].base,
> +        0x0, memmap[SIFIVE_U_DEV_GEM].size,
> +        0x0, memmap[SIFIVE_U_DEV_GEM_MGMT].base,
> +        0x0, memmap[SIFIVE_U_DEV_GEM_MGMT].size);
>      qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
>      qemu_fdt_setprop_string(fdt, nodename, "phy-mode", "gmii");
>      qemu_fdt_setprop_cell(fdt, nodename, "phy-handle", phy_phandle);
> @@ -333,19 +333,19 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      g_free(nodename);
>
>      nodename = g_strdup_printf("/soc/ethernet@%lx/ethernet-phy@0",
> -        (long)memmap[SIFIVE_U_GEM].base);
> +        (long)memmap[SIFIVE_U_DEV_GEM].base);
>      qemu_fdt_add_subnode(fdt, nodename);
>      qemu_fdt_setprop_cell(fdt, nodename, "phandle", phy_phandle);
>      qemu_fdt_setprop_cell(fdt, nodename, "reg", 0x0);
>      g_free(nodename);
>
>      nodename = g_strdup_printf("/soc/serial@%lx",
> -        (long)memmap[SIFIVE_U_UART0].base);
> +        (long)memmap[SIFIVE_U_DEV_UART0].base);
>      qemu_fdt_add_subnode(fdt, nodename);
>      qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,uart0");
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
> -        0x0, memmap[SIFIVE_U_UART0].base,
> -        0x0, memmap[SIFIVE_U_UART0].size);
> +        0x0, memmap[SIFIVE_U_DEV_UART0].base,
> +        0x0, memmap[SIFIVE_U_DEV_UART0].size);
>      qemu_fdt_setprop_cells(fdt, nodename, "clocks",
>          prci_phandle, PRCI_CLK_TLCLK);
>      qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
> @@ -377,7 +377,7 @@ static void sifive_u_machine_init(MachineState *machine)
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>      MemoryRegion *flash0 = g_new(MemoryRegion, 1);
> -    target_ulong start_addr = memmap[SIFIVE_U_DRAM].base;
> +    target_ulong start_addr = memmap[SIFIVE_U_DEV_DRAM].base;
>      uint32_t start_addr_hi32 = 0x00000000;
>      int i;
>      uint32_t fdt_load_addr;
> @@ -392,13 +392,13 @@ static void sifive_u_machine_init(MachineState *machine)
>      /* register RAM */
>      memory_region_init_ram(main_mem, NULL, "riscv.sifive.u.ram",
>                             machine->ram_size, &error_fatal);
> -    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DRAM].base,
> +    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DEV_DRAM].base,
>                                  main_mem);
>
>      /* register QSPI0 Flash */
>      memory_region_init_ram(flash0, NULL, "riscv.sifive.u.flash0",
> -                           memmap[SIFIVE_U_FLASH0].size, &error_fatal);
> -    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_FLASH0].base,
> +                           memmap[SIFIVE_U_DEV_FLASH0].size, &error_fatal);
> +    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DEV_FLASH0].base,
>                                  flash0);
>
>      /* register gpio-restart */
> @@ -424,14 +424,14 @@ static void sifive_u_machine_init(MachineState *machine)
>
>      switch (s->msel) {
>      case MSEL_MEMMAP_QSPI0_FLASH:
> -        start_addr = memmap[SIFIVE_U_FLASH0].base;
> +        start_addr = memmap[SIFIVE_U_DEV_FLASH0].base;
>          break;
>      case MSEL_L2LIM_QSPI0_FLASH:
>      case MSEL_L2LIM_QSPI2_SD:
> -        start_addr = memmap[SIFIVE_U_L2LIM].base;
> +        start_addr = memmap[SIFIVE_U_DEV_L2LIM].base;
>          break;
>      default:
> -        start_addr = memmap[SIFIVE_U_DRAM].base;
> +        start_addr = memmap[SIFIVE_U_DEV_DRAM].base;
>          break;
>      }
>
> @@ -459,7 +459,7 @@ static void sifive_u_machine_init(MachineState *machine)
>      }
>
>      /* Compute the fdt load address in dram */
> -    fdt_load_addr = riscv_load_fdt(memmap[SIFIVE_U_DRAM].base,
> +    fdt_load_addr = riscv_load_fdt(memmap[SIFIVE_U_DEV_DRAM].base,
>                                     machine->ram_size, s->fdt);
>      #if defined(TARGET_RISCV64)
>      start_addr_hi32 = start_addr >> 32;
> @@ -491,10 +491,10 @@ static void sifive_u_machine_init(MachineState *machine)
>          reset_vec[i] = cpu_to_le32(reset_vec[i]);
>      }
>      rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
> -                          memmap[SIFIVE_U_MROM].base, &address_space_memory);
> +                          memmap[SIFIVE_U_DEV_MROM].base, &address_space_memory);
>
> -    riscv_rom_copy_firmware_info(memmap[SIFIVE_U_MROM].base,
> -                                 memmap[SIFIVE_U_MROM].size,
> +    riscv_rom_copy_firmware_info(memmap[SIFIVE_U_DEV_MROM].base,
> +                                 memmap[SIFIVE_U_DEV_MROM].size,
>                                   sizeof(reset_vec), kernel_entry);
>  }
>
> @@ -634,8 +634,8 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>
>      /* boot rom */
>      memory_region_init_rom(mask_rom, OBJECT(dev), "riscv.sifive.u.mrom",
> -                           memmap[SIFIVE_U_MROM].size, &error_fatal);
> -    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
> +                           memmap[SIFIVE_U_DEV_MROM].size, &error_fatal);
> +    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DEV_MROM].base,
>                                  mask_rom);
>
>      /*
> @@ -648,8 +648,8 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>       * too generous to misbehaving guests.
>       */
>      memory_region_init_ram(l2lim_mem, NULL, "riscv.sifive.u.l2lim",
> -                           memmap[SIFIVE_U_L2LIM].size, &error_fatal);
> -    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_L2LIM].base,
> +                           memmap[SIFIVE_U_DEV_L2LIM].size, &error_fatal);
> +    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DEV_L2LIM].base,
>                                  l2lim_mem);
>
>      /* create PLIC hart topology configuration string */
> @@ -667,7 +667,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      }
>
>      /* MMIO */
> -    s->plic = sifive_plic_create(memmap[SIFIVE_U_PLIC].base,
> +    s->plic = sifive_plic_create(memmap[SIFIVE_U_DEV_PLIC].base,
>          plic_hart_config,
>          SIFIVE_U_PLIC_NUM_SOURCES,
>          SIFIVE_U_PLIC_NUM_PRIORITIES,
> @@ -677,26 +677,26 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>          SIFIVE_U_PLIC_ENABLE_STRIDE,
>          SIFIVE_U_PLIC_CONTEXT_BASE,
>          SIFIVE_U_PLIC_CONTEXT_STRIDE,
> -        memmap[SIFIVE_U_PLIC].size);
> +        memmap[SIFIVE_U_DEV_PLIC].size);
>      g_free(plic_hart_config);
> -    sifive_uart_create(system_memory, memmap[SIFIVE_U_UART0].base,
> +    sifive_uart_create(system_memory, memmap[SIFIVE_U_DEV_UART0].base,
>          serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART0_IRQ));
> -    sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
> +    sifive_uart_create(system_memory, memmap[SIFIVE_U_DEV_UART1].base,
>          serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ));
> -    sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
> -        memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
> +    sifive_clint_create(memmap[SIFIVE_U_DEV_CLINT].base,
> +        memmap[SIFIVE_U_DEV_CLINT].size, ms->smp.cpus,
>          SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
>
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->prci), errp)) {
>          return;
>      }
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_DEV_PRCI].base);
>
>      qdev_prop_set_uint32(DEVICE(&s->gpio), "ngpio", 16);
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
>          return;
>      }
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, memmap[SIFIVE_U_GPIO].base);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, memmap[SIFIVE_U_DEV_GPIO].base);
>
>      /* Pass all GPIOs to the SOC layer so they are available to the board */
>      qdev_pass_gpios(DEVICE(&s->gpio), dev, NULL);
> @@ -712,7 +712,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->otp), errp)) {
>          return;
>      }
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_DEV_OTP].base);
>
>      /* FIXME use qdev NIC properties instead of nd_table[] */
>      if (nd->used) {
> @@ -724,15 +724,15 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->gem), errp)) {
>          return;
>      }
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem), 0, memmap[SIFIVE_U_GEM].base);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem), 0, memmap[SIFIVE_U_DEV_GEM].base);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem), 0,
>                         qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_GEM_IRQ));
>
>      create_unimplemented_device("riscv.sifive.u.gem-mgmt",
> -        memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
> +        memmap[SIFIVE_U_DEV_GEM_MGMT].base, memmap[SIFIVE_U_DEV_GEM_MGMT].size);
>
>      create_unimplemented_device("riscv.sifive.u.dmc",
> -        memmap[SIFIVE_U_DMC].base, memmap[SIFIVE_U_DMC].size);
> +        memmap[SIFIVE_U_DEV_DMC].base, memmap[SIFIVE_U_DEV_DMC].size);
>  }
>
>  static Property sifive_u_soc_props[] = {
> --
> 2.26.2
>
>

