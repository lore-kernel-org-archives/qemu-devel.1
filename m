Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA77C0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 17:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596452085B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 17:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsaoN68m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596452085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwrTI-0001PO-MS
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 13:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59632)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hwrSN-0000qb-UN
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 13:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hwrSL-0007Er-Kk
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 13:16:35 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:46027)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hwrSL-0007Co-Cj; Sun, 11 Aug 2019 13:16:33 -0400
Received: by mail-lj1-x241.google.com with SMTP id t3so7801279ljj.12;
 Sun, 11 Aug 2019 10:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vj2nByuqrqEEK7HuRdkCKJ1Bgizk53hEE72UOe7vC4Q=;
 b=tsaoN68mHOA5y8EzTaq+lbqM+cuklK0FCCA2TgigMSRilgtwudPam8tJ64Ll9fcPro
 /57cRmWFOllZzsLwCvfC4vQ9tDkf1ORXciNfHW0YhJAAVlInc7mAdpC4se49Wiu+M/yp
 a5j0S2t40+KuIK8/wfqcaHd1zfWh85On9WQUvdjo4L7KWsNoHrO2w8ZpmBzr1e0jG+W+
 7TCJqgsL532XcBnWxmzejmhUmmaFTjMGSBDy5ptsaF7/04z+QETmjzmV1Pg2praZk+Xo
 aWd4TqIfnphgjGc9iUF3IJoVzhxjLyOTPm07o7MZNU3H3aIivcOWLSH5bN2c9twCjl/K
 2vCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vj2nByuqrqEEK7HuRdkCKJ1Bgizk53hEE72UOe7vC4Q=;
 b=ipYYO7dZZPqYjGYOV4SOs2Y8VI/xEbBB6TDtVXpK4xmHfNsMpeWU1ahayrP/pjktG5
 u1fdnIDVe1JiOQwtImbYaCSSvwiJtjyxmS93SpnbxqWnx6g2ayFgJJ906QwBMku/Kstc
 xKJyOd+snVV7mGKxBX/blXbcMA9Z68aFQaYfCUHcu57t8fK1lCp9tr3HUfCHH8j659C5
 5W/Kr8iECwleU7DzEA00V0aZD64dNUHqV6toEJOGC1HshShaHycmvFO+uUNQLqSnhXYk
 8xhfUkrKUGP3p5UE6luCL3M0iHN7wShtdLPQjoaCVhUm7zaeKp3vw+K33fAuyWwxNIy5
 3keA==
X-Gm-Message-State: APjAAAX3tQdQ0ZpwJPgnY6uv1MHEvjk9pl/VXZ4aHjy+nDbD21NvRY1Z
 CZVAt655sB513tS5WTf4t/Di6kMqFM5HDRUEBck=
X-Google-Smtp-Source: APXvYqyETbqC3iyj52XvLHGdnzxdwR6vjOXOBygMiB2vdXu/IPvs3DqiqJa60IZofShhOeukMtH0n1yU9n9HxDhnTh8=
X-Received: by 2002:a2e:3604:: with SMTP id d4mr16761932lja.85.1565543791490; 
 Sun, 11 Aug 2019 10:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
 <1565510821-3927-24-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565510821-3927-24-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sun, 11 Aug 2019 10:16:03 -0700
Message-ID: <CAKmqyKOUrQagYux7j3t04w0XHYg9w0xMgvpwELZbSQ4xW+VO1g@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v3 23/28] riscv: sifive_u: Fix broken GEM
 support
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
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 11, 2019 at 1:15 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> At present the GEM support in sifive_u machine is seriously broken.
>
> - The GEM block register base was set to a weird number (0x100900FC),
>   which for no way could work with the cadence_gem model in QEMU.
> - The generated DT node for GEM has a "clocks-names" which is an
>   invalid property name.
>
> Not like other GEM variants, the FU540-specific GEM has a management
> block to control 10/100/1000Mbps link speed changes, that is mapped
> to 0x100a0000. We can simply map it into MMIO space without special
> handling using create_unimplemented_device().
>
> Update the GEM node compatible string to use the official name used
> by the upstream Linux kernel, and add the management block reg base
> & size to the <reg> property encoding.
>
> Tested with upstream U-Boot and Linux kernel MACB drivers.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> Changes in v3: None
> Changes in v2:
> - use create_unimplemented_device() to create the GEM management
>   block instead of sifive_mmio_emulate()
> - add "phy-handle" property to the ethernet node
>
>  hw/riscv/sifive_u.c         | 23 ++++++++++++++++++-----
>  include/hw/riscv/sifive_u.h |  3 ++-
>  2 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 0c1a89f..e8bef44 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
>   * Copyright (c) 2017 SiFive, Inc.
> + * Copyright (c) 2019 Bin Meng <bmeng.cn@gmail.com>
>   *
>   * Provides a board compatible with the SiFive Freedom U SDK:
>   *
> @@ -11,6 +12,7 @@
>   * 2) PLIC (Platform Level Interrupt Controller)
>   * 3) PRCI (Power, Reset, Clock, Interrupt)
>   * 4) OTP (One-Time Programmable) memory with stored serial number
> + * 5) GEM (Gigabit Ethernet Controller) and management block
>   *
>   * This board currently generates devicetree dynamically that indicates at least
>   * two harts and up to five harts.
> @@ -38,6 +40,7 @@
>  #include "hw/loader.h"
>  #include "hw/sysbus.h"
>  #include "hw/char/serial.h"
> +#include "hw/misc/unimp.h"
>  #include "target/riscv/cpu.h"
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/riscv/sifive_plic.h"
> @@ -69,7 +72,8 @@ static const struct MemmapEntry {
>      [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
>      [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
>      [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
> -    [SIFIVE_U_GEM] =      { 0x100900FC,     0x2000 },
> +    [SIFIVE_U_GEM] =      { 0x10090000,     0x2000 },
> +    [SIFIVE_U_GEM_MGMT] = { 0x100a0000,     0x1000 },
>  };
>
>  #define SIFIVE_OTP_SERIAL   1
> @@ -84,7 +88,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      char *nodename;
>      char ethclk_names[] = "pclk\0hclk";
>      uint32_t plic_phandle, prci_phandle, phandle = 1;
> -    uint32_t hfclk_phandle, rtcclk_phandle;
> +    uint32_t hfclk_phandle, rtcclk_phandle, phy_phandle;
>
>      fdt = s->fdt = create_device_tree(&s->fdt_size);
>      if (!fdt) {
> @@ -242,20 +246,25 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      g_free(cells);
>      g_free(nodename);
>
> +    phy_phandle = phandle++;
>      nodename = g_strdup_printf("/soc/ethernet@%lx",
>          (long)memmap[SIFIVE_U_GEM].base);
>      qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "cdns,macb");
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible",
> +        "sifive,fu540-c000-gem");
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
>          0x0, memmap[SIFIVE_U_GEM].base,
> -        0x0, memmap[SIFIVE_U_GEM].size);
> +        0x0, memmap[SIFIVE_U_GEM].size,
> +        0x0, memmap[SIFIVE_U_GEM_MGMT].base,
> +        0x0, memmap[SIFIVE_U_GEM_MGMT].size);
>      qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
>      qemu_fdt_setprop_string(fdt, nodename, "phy-mode", "gmii");
> +    qemu_fdt_setprop_cell(fdt, nodename, "phy-handle", phy_phandle);
>      qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
>      qemu_fdt_setprop_cell(fdt, nodename, "interrupts", SIFIVE_U_GEM_IRQ);
>      qemu_fdt_setprop_cells(fdt, nodename, "clocks",
>          prci_phandle, PRCI_CLK_GEMGXLPLL, prci_phandle, PRCI_CLK_GEMGXLPLL);
> -    qemu_fdt_setprop(fdt, nodename, "clocks-names", ethclk_names,
> +    qemu_fdt_setprop(fdt, nodename, "clock-names", ethclk_names,
>          sizeof(ethclk_names));
>      qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", 1);
>      qemu_fdt_setprop_cell(fdt, nodename, "#size-cells", 0);
> @@ -264,6 +273,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      nodename = g_strdup_printf("/soc/ethernet@%lx/ethernet-phy@0",
>          (long)memmap[SIFIVE_U_GEM].base);
>      qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_cell(fdt, nodename, "phandle", phy_phandle);
>      qemu_fdt_setprop_cell(fdt, nodename, "reg", 0x0);
>      g_free(nodename);
>
> @@ -456,6 +466,9 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem), 0, memmap[SIFIVE_U_GEM].base);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem), 0,
>                         plic_gpios[SIFIVE_U_GEM_IRQ]);
> +
> +    create_unimplemented_device("riscv.sifive.u.gem-mgmt",
> +        memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
>  }
>
>  static void riscv_sifive_u_machine_init(MachineClass *mc)
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index 2a7877e..27b87cf 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -56,7 +56,8 @@ enum {
>      SIFIVE_U_UART1,
>      SIFIVE_U_OTP,
>      SIFIVE_U_DRAM,
> -    SIFIVE_U_GEM
> +    SIFIVE_U_GEM,
> +    SIFIVE_U_GEM_MGMT
>  };
>
>  enum {
> --
> 2.7.4
>
>

