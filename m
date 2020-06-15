Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E9BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9220E2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWSl4OeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9220E2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jksFf-0005Pg-S2
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jksES-0004rV-Vb; Mon, 15 Jun 2020 12:45:12 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:33146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jksER-0002Og-6o; Mon, 15 Jun 2020 12:45:12 -0400
Received: by mail-il1-x143.google.com with SMTP id z2so15938129ilq.0;
 Mon, 15 Jun 2020 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GxNE/Ziez4cPfywLHTGMClUB/FtlfEo8Us1ntedSN6k=;
 b=PWSl4OeFnGtgRFJeId32Nl7H1d/Xw6VkdEfIqCXr9MSHqtNy4okR0zMzQHfMhBmrJz
 4wFlLUkMDad1c2G+aSKW14FnYmGDj6QxvXhXxTVXa0NOv7hdSlOc0F4K/KRU6/EQkJDu
 DXxAD7xSSsQOeeGliWwQsni7XK37Nnv3XZOGX6Ly97k56DYDsBKjnZTWghUleg99iUyb
 KVdPVjXBjMxHahFTnx7lFxQ5YntYFSxyNq1lVfcrxeFzmHtCLOpSLX1ga9fPZJF0VGiO
 0wnrfI7N+HSV6YTHiVjhh0YNxUSA8Be+mk7y/1CoA3QL+nEqvJ7DVeTOuLHSvtj9kgaw
 WYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GxNE/Ziez4cPfywLHTGMClUB/FtlfEo8Us1ntedSN6k=;
 b=SPTEuGzPB0O5xIPo588DviVe+cP6T11kHfwJ6+BsJYMAgUMjPIJy6Kuf2sQqcu8X7C
 DCmdwu6UChswMzLGJfWGAJ3ThDxwJXIQ32hO0h4Dge4oviD5HZ6Aonwjsvb6LdaWhWiZ
 I8Qa08iWP3cqirlI4KvZUF/b3p8BIwEnmbci8KQFKd+I+EIrRl1cNb5pN31dAKL22Zb9
 yo3huYw3TQzqCnRfLDrakCVRR7MmLXmyBIiQNJouTFkzlIHZQuV37aYuwcSeC2P48hWk
 sQboh/kzIC2uzp0EAeAhtutAgDlctN9jnOCJmAXfs3BF51uPITcwxktda7FgXvlrzreE
 yytw==
X-Gm-Message-State: AOAM533ZiZrZBAvQbTjpZ4zPAlY6dX4yndZ5aIKC9dz3wxirnd8rwi9f
 ixTd4ARoE42T4YI4KyU7owwLslG1ieRA4I8vxaY=
X-Google-Smtp-Source: ABdhPJzMLXA4Iv+4WNuMTizolkuI41FiH7KRC5EQf0a1fky4MBrrrwxCjKZSUDOT+yNBd0KpJ5CuFOBf1Nzr1EV9HBA=
X-Received: by 2002:a92:c94b:: with SMTP id i11mr28306635ilq.177.1592239509661; 
 Mon, 15 Jun 2020 09:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
 <1591625864-31494-10-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1591625864-31494-10-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2020 09:35:46 -0700
Message-ID: <CAKmqyKMKzKeBECiUXDii7MdYp4gxU8zaStjXckfVEgNOqSF=4Q@mail.gmail.com>
Subject: Re: [PATCH 09/15] hw/riscv: sifive_u: Add reset functionality
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 8, 2020 at 7:23 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> The HiFive Unleashed board wires GPIO pin#10 to the input of the
> system reset signal. Let's set up the GPIO pin#10 and insert a
> "gpio-restart" device tree node so that reboot is now functional
> with QEMU 'sifive_u' machine.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/sifive_u.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 881949b..ef51874 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -37,6 +37,7 @@
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
>  #include "hw/boards.h"
> +#include "hw/irq.h"
>  #include "hw/loader.h"
>  #include "hw/sysbus.h"
>  #include "hw/char/serial.h"
> @@ -53,6 +54,7 @@
>  #include "net/eth.h"
>  #include "sysemu/arch_init.h"
>  #include "sysemu/device_tree.h"
> +#include "sysemu/runstate.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/address-spaces.h"
>
> @@ -96,7 +98,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      uint32_t *cells;
>      char *nodename;
>      char ethclk_names[] = "pclk\0hclk";
> -    uint32_t plic_phandle, prci_phandle, phandle = 1;
> +    uint32_t plic_phandle, prci_phandle, gpio_phandle, phandle = 1;
>      uint32_t hfclk_phandle, rtcclk_phandle, phy_phandle;
>
>      fdt = s->fdt = create_device_tree(&s->fdt_size);
> @@ -270,9 +272,11 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      g_free(cells);
>      g_free(nodename);
>
> +    gpio_phandle = phandle++;
>      nodename = g_strdup_printf("/soc/gpio@%lx",
>          (long)memmap[SIFIVE_U_GPIO].base);
>      qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_cell(fdt, nodename, "phandle", gpio_phandle);
>      qemu_fdt_setprop_cells(fdt, nodename, "clocks",
>          prci_phandle, PRCI_CLK_TLCLK);
>      qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", 2);
> @@ -292,6 +296,12 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,gpio0");
>      g_free(nodename);
>
> +    nodename = g_strdup_printf("/gpio-restart");
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_cells(fdt, nodename, "gpios", gpio_phandle, 10, 1);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "gpio-restart");
> +    g_free(nodename);
> +
>      phy_phandle = phandle++;
>      nodename = g_strdup_printf("/soc/ethernet@%lx",
>          (long)memmap[SIFIVE_U_GEM].base);
> @@ -352,6 +362,14 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      g_free(nodename);
>  }
>
> +static void sifive_u_machine_reset(void *opaque, int n, int level)
> +{
> +    /* gpio pin active low triggers reset */
> +    if (!level) {
> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +    }
> +}
> +
>  static void sifive_u_machine_init(MachineState *machine)
>  {
>      const struct MemmapEntry *memmap = sifive_u_memmap;
> @@ -383,6 +401,10 @@ static void sifive_u_machine_init(MachineState *machine)
>      memory_region_add_subregion(system_memory, memmap[SIFIVE_U_FLASH0].base,
>                                  flash0);
>
> +    /* register gpio-restart */
> +    qdev_connect_gpio_out(DEVICE(&(s->soc.gpio)), 10,
> +                          qemu_allocate_irq(sifive_u_machine_reset, NULL, 0));
> +
>      /* create device tree */
>      create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
>
> --
> 2.7.4
>
>

