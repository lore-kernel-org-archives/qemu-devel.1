Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A21AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 06:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4FA2053B
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 06:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECc+kTBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4FA2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbHqg-0005JN-7Z
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 02:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jbHpj-0004Nj-F3; Wed, 20 May 2020 02:04:03 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jbHpi-00021N-M0; Wed, 20 May 2020 02:04:03 -0400
Received: by mail-wr1-x443.google.com with SMTP id j5so1865870wrq.2;
 Tue, 19 May 2020 23:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7vKBNr6qqiUPzvsUDA/Kg/96d5JxxrR5dwrnToNSbP8=;
 b=ECc+kTBv5hwtA95kzU5zyr0hZE5pq6+/sFrZQAT18cl6d0pej0x7ozg+HkWCxmp06e
 ZbNl/1jnvf2c5j2dYNcx72UrYLJ5u+UzyvzE9+SPjzA6x5FJjt/5lHfiSLXY5k18bwha
 ngpYgWVrbSK7Db5UTuMJJyLSvq4x8BYVnTL/bHv+JxpBgFVdglhLqEqYWPeLP8XeA5f9
 eyM+fAbUYgS4LnLznM/MNKtfiNdW0ZOCi70nv0HobDKsTlluyhtYNJtUfMaFKnNzBTVD
 vb2kniqmZGVP5btnSLQRBfjSRUugichSI1JdBJxT8P1XlWHyxr1my9tGfLprpxc8qbTT
 /jpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7vKBNr6qqiUPzvsUDA/Kg/96d5JxxrR5dwrnToNSbP8=;
 b=CogdbXMMsfgNgi2gpfOKeq0xRSeNDEGjqTDy+944skvxY0A+cn1nvKsYR/4HPedKDI
 zPshU9FWoxG52u9FpK1Tk/oKzpoeVg3wMnFfLpKe2v0/fmJB4KQcgbhMxxnTBThmZRht
 BH2GGTdKvTCFGZkX54mueSFaxoWKas6ie4sg8/ZRLWlbdLcsSjoEH0LPpgt9MHXCf6TG
 1curk2ks5OXYKCYo89NO7YeuOUATzXL+ks5Gdf7RAbWrBd4InpXRajUlQ46sfalK8ZjB
 hr8gHQekNrMx3glbXOS8fPsvXaOHy0K38Uu13kEcFUSf76zrBn127Tf5aW9IbkIThwfn
 QJqw==
X-Gm-Message-State: AOAM531KLK2nwSI00gXBYmv8Gw7M2yVcxKz96sgzQ/d2rSxStfEaGEIl
 NzvQaIYYEFxVOZ73DWQZmQGhChWMI0E=
X-Google-Smtp-Source: ABdhPJzb62JbNd3K9Uek/VHmeZdttRGfXd5UMcHJVrZjVAfbgwdvpSjQlatAtsTlFeEqPsOID5pWCg==
X-Received: by 2002:a5d:5492:: with SMTP id h18mr190725wrv.330.1589954641121; 
 Tue, 19 May 2020 23:04:01 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id p4sm1721035wrq.31.2020.05.19.23.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 23:04:00 -0700 (PDT)
Subject: Re: [PATCH v3 8/9] riscv/opentitan: Connect the UART device
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1589923785.git.alistair.francis@wdc.com>
 <eb6069a05d18f4a1c9c7dbc97a0c521ae4b3674f.1589923785.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <47d26423-bf54-c0af-5043-5e6a93ead552@amsat.org>
Date: Wed, 20 May 2020 08:03:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <eb6069a05d18f4a1c9c7dbc97a0c521ae4b3674f.1589923785.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 11:31 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Bin Meng <bin.meng@windriver.com>
> ---
>   include/hw/riscv/opentitan.h | 13 +++++++++++++
>   hw/riscv/opentitan.c         | 24 ++++++++++++++++++++++--
>   2 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
> index 8d6a09b696..825a3610bc 100644
> --- a/include/hw/riscv/opentitan.h
> +++ b/include/hw/riscv/opentitan.h
> @@ -21,6 +21,7 @@
>   
>   #include "hw/riscv/riscv_hart.h"
>   #include "hw/intc/ibex_plic.h"
> +#include "hw/char/ibex_uart.h"
>   
>   #define TYPE_RISCV_IBEX_SOC "riscv.lowrisc.ibex.soc"
>   #define RISCV_IBEX_SOC(obj) \
> @@ -33,6 +34,7 @@ typedef struct LowRISCIbexSoCState {
>       /*< public >*/
>       RISCVHartArrayState cpus;
>       IbexPlicState plic;
> +    IbexUartState uart;
>   
>       MemoryRegion flash_mem;
>       MemoryRegion rom;
> @@ -63,4 +65,15 @@ enum {
>       IBEX_USBDEV,
>   };
>   
> +enum {
> +    IBEX_UART_RX_PARITY_ERR_IRQ = 0x28,
> +    IBEX_UART_RX_TIMEOUT_IRQ = 0x27,
> +    IBEX_UART_RX_BREAK_ERR_IRQ = 0x26,
> +    IBEX_UART_RX_FRAME_ERR_IRQ = 0x25,
> +    IBEX_UART_RX_OVERFLOW_IRQ = 0x24,
> +    IBEX_UART_TX_EMPTY_IRQ = 0x23,
> +    IBEX_UART_RX_WATERMARK_IRQ = 0x22,
> +    IBEX_UART_TX_WATERMARK_IRQ = 0x21
> +};
> +
>   #endif
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index 3926321d8c..a6c0b949ca 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -96,6 +96,9 @@ static void riscv_lowrisc_ibex_soc_init(Object *obj)
>   
>       sysbus_init_child_obj(obj, "plic", &s->plic,
>                             sizeof(s->plic), TYPE_IBEX_PLIC);
> +
> +    sysbus_init_child_obj(obj, "uart", &s->uart,
> +                          sizeof(s->uart), TYPE_IBEX_UART);
>   }
>   
>   static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
> @@ -137,8 +140,25 @@ static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
>       busdev = SYS_BUS_DEVICE(dev);
>       sysbus_mmio_map(busdev, 0, memmap[IBEX_PLIC].base);
>   
> -    create_unimplemented_device("riscv.lowrisc.ibex.uart",
> -        memmap[IBEX_UART].base, memmap[IBEX_UART].size);
> +    /* UART */
> +    dev = DEVICE(&(s->uart));
> +    qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> +    object_property_set_bool(OBJECT(&s->uart), true, "realized", &err);
> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    busdev = SYS_BUS_DEVICE(dev);
> +    sysbus_mmio_map(busdev, 0, memmap[IBEX_UART].base);
> +    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DEVICE(&s->plic),
> +                       IBEX_UART_TX_WATERMARK_IRQ));
> +    sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(DEVICE(&s->plic),
> +                       IBEX_UART_RX_WATERMARK_IRQ));
> +    sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(DEVICE(&s->plic),
> +                       IBEX_UART_TX_EMPTY_IRQ));
> +    sysbus_connect_irq(busdev, 3, qdev_get_gpio_in(DEVICE(&s->plic),
> +                       IBEX_UART_RX_OVERFLOW_IRQ));
> +
>       create_unimplemented_device("riscv.lowrisc.ibex.gpio",
>           memmap[IBEX_GPIO].base, memmap[IBEX_GPIO].size);
>       create_unimplemented_device("riscv.lowrisc.ibex.spi",
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


