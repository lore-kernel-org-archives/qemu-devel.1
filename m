Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2A4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:16:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E934721726
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmcWoxbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E934721726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JjY-0001GG-65
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 20:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i1JQa-0008NO-2z
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i1JQY-0003e7-PN
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:57:07 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:41698)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i1JQY-0003ct-Fl; Fri, 23 Aug 2019 19:57:06 -0400
Received: by mail-lf1-x143.google.com with SMTP id 62so8271072lfa.8;
 Fri, 23 Aug 2019 16:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u6H4THZtN0W3yNUCSY6CT9DMaBee0SyXiFEg6yb4GnE=;
 b=NmcWoxbFck/dkfzgKmpbLm+cNXBzGMRxcFbp03xTwuiEFJe8oB6lu2J5FnK6lTqD1j
 jNlA/JXfVMtBcDEBk9YbpgALPqgb3ePq73W18p/AJNep4tWA1UJWn6A24kkshvyebXVr
 Kr9NMkGfw47WuKSSOv4l9XK7mOnWRP3RExfLagPS+pC2Tj+x7cHlYb8WCfjUzB9G0E9f
 x4Ww8cMtAEFXFvQ6Je1DxXlx8XOaJlS4VDgaALqx33UeYd90Lyp0Tri7zm8YWsN2htYj
 sBYsPQmp+/sE8HQiikCPp+9Rq5RK++BaB2tINtLRtJ5CaovwHnhhKb50M/vUBzIDBquH
 oT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u6H4THZtN0W3yNUCSY6CT9DMaBee0SyXiFEg6yb4GnE=;
 b=pr4MqWCsx0rNRA+st2WJRduQuf2PFU5b83936chDRnsRnvLvoxfxC46zh5m3hcO5cG
 tDvIAZ+OE8q/jbDchxRPWnBoIYcIzd6NnorS4WfBp9RQ6uWx+2MVShHIuFyUnV+qzjen
 KZ1CqmYu6HSc3cY/H6fzh83ugl9/1Dtlus+ecD0uQHyu5jrqV2FyWImu4L/HtUqVq2ID
 Vm8xqad9EpLEsLtMs1O+U3doURuQsjZ9ArEkZrpjVQHl43eCkbC3rETTWxnbj5uorQKf
 nNdU2FApREAwZ2QH2iDRturVm7LhnzrJPfS9jRG1LxppJ9d55UVj5464XYrADSpaF7/l
 Tq4Q==
X-Gm-Message-State: APjAAAUqj2xL25faMIqR8QWOjw1xzg2wC7F4SgQVy+H3c2W4xC8hNrdn
 qHwNqX53YAqe2Aw3i7VrlFhGiNjlhJd82EWnWgY=
X-Google-Smtp-Source: APXvYqx0DWoUndgdkEyjUJglnM7iA4Z3oW0czS5R19uV05y9vN1iCPnMOmKOKQLj/Sugs+EccF19Q3ITr94iL1Ef6iY=
X-Received: by 2002:ac2:528c:: with SMTP id q12mr3328511lfm.135.1566604625030; 
 Fri, 23 Aug 2019 16:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
 <1566537069-22741-22-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1566537069-22741-22-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Aug 2019 16:52:58 -0700
Message-ID: <CAKmqyKOQKTj4zOvVo5zaP4EprBka7R0RfD58MV_5a7C3ON_3LQ@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH v5 21/30] riscv: sifive_u: Add PRCI block
 to the SoC
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

On Thu, Aug 22, 2019 at 10:35 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Add PRCI mmio base address and size mappings to sifive_u machine,
> and generate the corresponding device tree node.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> Changes in v5:
> - create sifive_u_prci block directly in the machine codes, instead
>   of calling sifive_u_prci_create()
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>  hw/riscv/sifive_u.c         | 24 +++++++++++++++++++++++-
>  include/hw/riscv/sifive_u.h |  3 +++
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 08db741..c777d41 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -9,6 +9,7 @@
>   * 0) UART
>   * 1) CLINT (Core Level Interruptor)
>   * 2) PLIC (Platform Level Interrupt Controller)
> + * 3) PRCI (Power, Reset, Clock, Interrupt)
>   *
>   * This board currently generates devicetree dynamically that indicates at least
>   * two harts and up to five harts.
> @@ -61,6 +62,7 @@ static const struct MemmapEntry {
>      [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
>      [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
>      [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
> +    [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
>      [SIFIVE_U_UART0] =    { 0x10013000,     0x1000 },
>      [SIFIVE_U_UART1] =    { 0x10023000,     0x1000 },
>      [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
> @@ -78,7 +80,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      uint32_t *cells;
>      char *nodename;
>      char ethclk_names[] = "pclk\0hclk\0tx_clk";
> -    uint32_t plic_phandle, ethclk_phandle, phandle = 1;
> +    uint32_t plic_phandle, prci_phandle, ethclk_phandle, phandle = 1;
>      uint32_t uartclk_phandle;
>      uint32_t hfclk_phandle, rtcclk_phandle;
>
> @@ -189,6 +191,21 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      g_free(cells);
>      g_free(nodename);
>
> +    prci_phandle = phandle++;
> +    nodename = g_strdup_printf("/soc/clock-controller@%lx",
> +        (long)memmap[SIFIVE_U_PRCI].base);
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_cell(fdt, nodename, "phandle", prci_phandle);
> +    qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x1);
> +    qemu_fdt_setprop_cells(fdt, nodename, "clocks",
> +        hfclk_phandle, rtcclk_phandle);
> +    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> +        0x0, memmap[SIFIVE_U_PRCI].base,
> +        0x0, memmap[SIFIVE_U_PRCI].size);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible",
> +        "sifive,fu540-c000-prci");
> +    g_free(nodename);
> +
>      plic_phandle = phandle++;
>      cells =  g_new0(uint32_t, ms->smp.cpus * 4 - 2);
>      for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
> @@ -411,6 +428,8 @@ static void riscv_sifive_u_soc_init(Object *obj)
>                                  "cpu-type", &error_abort);
>      }
>
> +    sysbus_init_child_obj(obj, "prci", &s->prci, sizeof(s->prci),
> +                          TYPE_SIFIVE_U_PRCI);
>      sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
>                            TYPE_CADENCE_GEM);
>  }
> @@ -484,6 +503,9 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>          memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
>          SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
>
> +    object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
> +
>      for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
>          plic_gpios[i] = qdev_get_gpio_in(DEVICE(s->plic), i);
>      }
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index debbf28..2a023be 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -21,6 +21,7 @@
>
>  #include "hw/net/cadence_gem.h"
>  #include "hw/riscv/sifive_cpu.h"
> +#include "hw/riscv/sifive_u_prci.h"
>
>  #define TYPE_RISCV_U_SOC "riscv.sifive.u.soc"
>  #define RISCV_U_SOC(obj) \
> @@ -36,6 +37,7 @@ typedef struct SiFiveUSoCState {
>      RISCVHartArrayState e_cpus;
>      RISCVHartArrayState u_cpus;
>      DeviceState *plic;
> +    SiFiveUPRCIState prci;
>      CadenceGEMState gem;
>  } SiFiveUSoCState;
>
> @@ -54,6 +56,7 @@ enum {
>      SIFIVE_U_MROM,
>      SIFIVE_U_CLINT,
>      SIFIVE_U_PLIC,
> +    SIFIVE_U_PRCI,
>      SIFIVE_U_UART0,
>      SIFIVE_U_UART1,
>      SIFIVE_U_DRAM,
> --
> 2.7.4
>
>

