Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE70CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 21:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A14520869
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 21:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t5XJlnsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A14520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLZUF-0007D8-MM
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 17:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iLZRS-000504-N7
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 17:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iLZRR-00082z-DJ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 17:05:46 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:36248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iLZRN-00081n-IW; Fri, 18 Oct 2019 17:05:41 -0400
Received: by mail-lj1-x244.google.com with SMTP id v24so7579809ljj.3;
 Fri, 18 Oct 2019 14:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KgHlsHld5RGqmgOTGu4JGwdSVBEvr0bFnd2VlFlogOE=;
 b=t5XJlnsrp4TBbqIixzO24k3LpXweaqRYQRE2+DsiTsbxr66TtHUyZ0VYqRWRWkZKNd
 isims9NUNZ0oA0BfvwxHvDss0NwD6uX9Z2ArwgPKhTdvKpWG5414kk9JftOdlGeu1SIW
 OXcABdYJzvOXVRZgpawy0DvwZ5g7jLa+qNe4+MhWmB2/MdLpKRCaSI/ViutdGY+YSaQl
 DnCQbtRvWq68vBrMXolmPE2dptQfKmxb/3V+Sv1Z8Z2SKVEkrpHTrURLyxV5DJcFDEBl
 8vvAg2G+e4Ae2/C5FlHLa8SgZg1I9qx4tX+dOtrlslOqZSnY9Z24XnWb2ESw8l6w+Wzo
 T+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KgHlsHld5RGqmgOTGu4JGwdSVBEvr0bFnd2VlFlogOE=;
 b=r+hrjCQA8qkVeOUCezJObv+Y2lRNlHXcj5sSFJn2BIk4TTVPEJdhNjeVEt8euIZAP1
 YNpFe8baUMsOflTHgY1pP9yN2dpf+FPQfqjPr+FI5wL98keKONqBuLXqqD0MRAHoS56F
 fKSsRx+QZ70sv0RSppAu/YoSL6/5loq9FbHptAL2kkWZ6FVx3ZajyEz3AZGrxUZoI4bV
 59AvAI6gakKLO6caDRByLXiiE3r6nIuLSBEDmbu2/77yMZ6CmvWYz3IXmK3jgTapOFyB
 K+opd7RjhxtkIxnGQnV/+PtS2qtKZOmPR2RDptvIKHuyXl0+GXXZ8uA3eY6IRzqbm95U
 g12w==
X-Gm-Message-State: APjAAAVXeSpMZt5WEFEmfcfaC4BBy7QIrhwjDNw30vvhBPFcFYjNgGpG
 QVV2E3ZR5J6Dcdeh05AXJ6B1d6LNrRwed8awROI=
X-Google-Smtp-Source: APXvYqzLv901giZzgoddfh+ppF6xhP7T6yHQiInBTuv2s2EcjVpMkGAHjOrpE8Z51fmo1M9LKHMXJi2+CSjzlixZV2c=
X-Received: by 2002:a2e:82cd:: with SMTP id n13mr7471781ljh.156.1571432740204; 
 Fri, 18 Oct 2019 14:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191015083459.76959-1-anup.patel@wdc.com>
 <20191015083459.76959-3-anup.patel@wdc.com>
In-Reply-To: <20191015083459.76959-3-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 18 Oct 2019 14:00:27 -0700
Message-ID: <CAKmqyKPhDwf2cgoAeV27pSVZWfwakDRZZdDiSH5wVaScPBtgYQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] riscv: virt: Use Goldfish RTC device
To: Anup Patel <Anup.Patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 15, 2019 at 1:37 AM Anup Patel <Anup.Patel@wdc.com> wrote:
>
> We extend QEMU RISC-V virt machine by adding Goldfish RTC device
> to it. This will allow Guest Linux to sync it's local date/time
> with Host date/time via RTC device.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/Kconfig        |  1 +
>  hw/riscv/virt.c         | 15 +++++++++++++++
>  include/hw/riscv/virt.h |  2 ++
>  3 files changed, 18 insertions(+)
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index fb19b2df3a..b33753c780 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -34,6 +34,7 @@ config RISCV_VIRT
>      select PCI
>      select HART
>      select SERIAL
> +    select GOLDFISH_RTC
>      select VIRTIO_MMIO
>      select PCI_EXPRESS_GENERIC_BRIDGE
>      select SIFIVE
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d36f5625ec..95c42ab993 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -57,6 +57,7 @@ static const struct MemmapEntry {
>      [VIRT_DEBUG] =       {        0x0,         0x100 },
>      [VIRT_MROM] =        {     0x1000,       0x11000 },
>      [VIRT_TEST] =        {   0x100000,        0x1000 },
> +    [VIRT_RTC] =         {   0x101000,        0x1000 },
>      [VIRT_CLINT] =       {  0x2000000,       0x10000 },
>      [VIRT_PLIC] =        {  0xc000000,     0x4000000 },
>      [VIRT_UART0] =       { 0x10000000,         0x100 },
> @@ -310,6 +311,17 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
>      qemu_fdt_setprop_cell(fdt, nodename, "interrupts", UART0_IRQ);
>
> +    nodename = g_strdup_printf("/rtc@%lx",
> +        (long)memmap[VIRT_RTC].base);
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible",
> +        "google,goldfish-rtc");
> +    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> +        0x0, memmap[VIRT_RTC].base,
> +        0x0, memmap[VIRT_RTC].size);
> +    qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
> +    qemu_fdt_setprop_cell(fdt, nodename, "interrupts", RTC_IRQ);
> +
>      qemu_fdt_add_subnode(fdt, "/chosen");
>      qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
>      if (cmdline) {
> @@ -496,6 +508,9 @@ static void riscv_virt_board_init(MachineState *machine)
>          0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
>          serial_hd(0), DEVICE_LITTLE_ENDIAN);
>
> +    sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
> +        qdev_get_gpio_in(DEVICE(s->plic), RTC_IRQ));
> +
>      g_free(plic_hart_config);
>  }
>
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 6e5fbe5d3b..e6423258d3 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -37,6 +37,7 @@ enum {
>      VIRT_DEBUG,
>      VIRT_MROM,
>      VIRT_TEST,
> +    VIRT_RTC,
>      VIRT_CLINT,
>      VIRT_PLIC,
>      VIRT_UART0,
> @@ -49,6 +50,7 @@ enum {
>
>  enum {
>      UART0_IRQ = 10,
> +    RTC_IRQ = 11,
>      VIRTIO_IRQ = 1, /* 1 to 8 */
>      VIRTIO_COUNT = 8,
>      PCIE_IRQ = 0x20, /* 32 to 35 */
> --
> 2.17.1
>
>

