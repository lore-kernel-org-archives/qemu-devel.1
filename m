Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFA8C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A75A821527
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga6jhpnq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75A821527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMHOb-000750-Jd
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 17:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMHNT-00067N-Ai; Sat, 26 Sep 2020 17:05:07 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMHNR-000564-Cm; Sat, 26 Sep 2020 17:05:07 -0400
Received: by mail-wr1-x442.google.com with SMTP id z1so7623350wrt.3;
 Sat, 26 Sep 2020 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2fIe/UboE6G20FxsOIVruBbijWPh46qff+9P5UXZqk4=;
 b=ga6jhpnqnCaJUvTHLnlSF9+V+GBqD3JVLJcBg88rgnDpHJjFLRV65wqvN1r9ovy9Ae
 XtfoevOkD3q8Q1LJIQJ916GujxdYl8J2qtyU9rEA/2PypHpqYlm+1ZlaGt+im5g+/dwq
 tFoB5RUDXhmCyTNaQaGyRuZ41KQfmiLkopvO4J/eTnHztzMie24BHypuvYndotkhMYMf
 kak6cvO67dC9xe5GsBzlSfx2lRdqV9khA5my1uVgIovupegJnLh6S/pw9wGE2cnm4xW6
 cz4jh8SOi40wDIqS7J4vVwSqFJaRCMEJqXZaVd7QNWbbPZq8VuATua7VM5FH9LGOX0Ui
 o+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2fIe/UboE6G20FxsOIVruBbijWPh46qff+9P5UXZqk4=;
 b=PJGrgxs1MtIFJh6ODIQBjAXZAnGEqmwIZ0CgNQ7WRRHhU7iF52QYcBCn3YyiC22Si+
 w1SPf8CTk+E9eabfj+OLSvMciNIv/fKbdfmEQGhG+3DhazoX7f3BdLcqKZxcXwT4GQO9
 agTrkgq6aBO5hj+NjxrmzdEFNfe/G/AY9U4YElWK9HQGAFvydtLTxAL65L4HAUSAMoze
 wZZCRhs0YroSi86yXcADpQc/P0833mrkaPNiUbtuAB5MjLAJTwPJpCcxV79sht+8vEMc
 fSHurBIR4v0WdiMETz9+II0VjLLTesMKH8UbUxvsOXsTsePOVoRlr+APLCwVYJuRZA6y
 XMoA==
X-Gm-Message-State: AOAM532Umg1o2XFLhu5gmfazaJoBO7Ocg6k3f0GtmjQLaNxiUbU6LyHA
 GLIs9a3fn/4aYF18RzOK5L0=
X-Google-Smtp-Source: ABdhPJymBsW4DXXfvskkfYdwc0ukegxDx0lZZlYSL3rzKcGCYMO4yUsYHGM4eHp2HUmTZe18wcmBCg==
X-Received: by 2002:adf:dc47:: with SMTP id m7mr10992533wrj.100.1601154303317; 
 Sat, 26 Sep 2020 14:05:03 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id l17sm3656683wme.11.2020.09.26.14.05.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 14:05:02 -0700 (PDT)
Subject: Re: [PATCH 03/14] hw/arm/raspi: fix cprman base address
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20200925101731.2159827-1-luc@lmichel.fr>
 <20200925101731.2159827-4-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7199251a-58a0-382d-4e80-edeeac19f9ad@amsat.org>
Date: Sat, 26 Sep 2020 23:04:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925101731.2159827-4-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.213,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 12:17 PM, Luc Michel wrote:
> The cprman (clock controller) was mapped at the watchdog/power manager
> address. It was also split into two unimplemented peripherals (cm and
> a2w)

Please use CAPS: CPRMAN, CM, A2W.

> but this is really the same one, as shown by this extract of the
> Raspberry Pi 3 Linux device tree:
> 
>     watchdog@7e100000 {
>             compatible = "brcm,bcm2835-pm\0brcm,bcm2835-pm-wdt";
>             [...]
>             reg = <0x7e100000 0x114 0x7e00a000 0x24>;
>             [...]
>     };
> 
>     [...]
>     cprman@7e101000 {
>             compatible = "brcm,bcm2835-cprman";
>             [...]
>             reg = <0x7e101000 0x2000>;
>             [...]
>     };

I wouldn't take Linux and its device tree as a reference...

Also I'm having hard time accepting a 8KB MMIO block aligned
on a 4KB boundary... But accepting it greatly simplify the
model, so let's assume this is the case.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>  include/hw/arm/bcm2835_peripherals.h | 2 +-
>  include/hw/arm/raspi_platform.h      | 5 ++---
>  hw/arm/bcm2835_peripherals.c         | 4 ++--
>  3 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
> index 13d7c4c553..199088425a 100644
> --- a/include/hw/arm/bcm2835_peripherals.h
> +++ b/include/hw/arm/bcm2835_peripherals.h
> @@ -44,12 +44,12 @@ struct BCM2835PeripheralState {
>      qemu_irq irq, fiq;
>  
>      BCM2835SystemTimerState systmr;
>      BCM2835MphiState mphi;
>      UnimplementedDeviceState armtmr;
> +    UnimplementedDeviceState powermgt;
>      UnimplementedDeviceState cprman;
> -    UnimplementedDeviceState a2w;
>      PL011State uart0;
>      BCM2835AuxState aux;
>      BCM2835FBState fb;
>      BCM2835DMAState dma;
>      BCM2835ICState ic;
> diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
> index 61b04a1bd4..51a477cdc2 100644
> --- a/include/hw/arm/raspi_platform.h
> +++ b/include/hw/arm/raspi_platform.h
> @@ -34,13 +34,12 @@
>  #define ARMCTRL_OFFSET          (ARM_OFFSET + 0x000)
>  #define ARMCTRL_IC_OFFSET       (ARM_OFFSET + 0x200) /* Interrupt controller */
>  #define ARMCTRL_TIMER0_1_OFFSET (ARM_OFFSET + 0x400) /* Timer 0 and 1 */
>  #define ARMCTRL_0_SBM_OFFSET    (ARM_OFFSET + 0x800) /* User 0 (ARM) Semaphores
>                                                        * Doorbells & Mailboxes */
> -#define CPRMAN_OFFSET           0x100000 /* Power Management, Watchdog */
> -#define CM_OFFSET               0x101000 /* Clock Management */
> -#define A2W_OFFSET              0x102000 /* Reset controller */
> +#define PM_OFFSET               0x100000 /* Power Management */
> +#define CPRMAN_OFFSET           0x101000 /* Clock Management */
>  #define AVS_OFFSET              0x103000 /* Audio Video Standard */
>  #define RNG_OFFSET              0x104000
>  #define GPIO_OFFSET             0x200000
>  #define UART0_OFFSET            0x201000
>  #define MMCI0_OFFSET            0x202000
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index a9d7f53f6e..f0802c91e0 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -342,12 +342,12 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->dwc2), 0,
>          qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
>                                 INTERRUPT_USB));
>  
>      create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
> -    create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
> -    create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
> +    create_unimp(s, &s->powermgt, "bcm2835-powermgt", PM_OFFSET, 0x114);
> +    create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x2000);
>      create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
>      create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
>      create_unimp(s, &s->spi[0], "bcm2835-spi0", SPI0_OFFSET, 0x20);
>      create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET, 0x100);
>      create_unimp(s, &s->i2c[0], "bcm2835-i2c0", BSC0_OFFSET, 0x20);
> 

