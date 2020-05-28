Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F3CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D56F8208A7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V749CZhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56F8208A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGpO-0003OI-0i
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeGoc-0002BH-1o; Thu, 28 May 2020 07:35:14 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeGob-0004Mt-7l; Thu, 28 May 2020 07:35:13 -0400
Received: by mail-wm1-x342.google.com with SMTP id j198so4311109wmj.0;
 Thu, 28 May 2020 04:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+GGkv7NtlRBFkOlRZdJjHeT9o5MV8pqyEnMXcfIx5FE=;
 b=V749CZhecvGzTN5dU8i1dVplK/pwOolqp1B/FuubvwKqhPjMRFmSnceS/nz5wjT3bY
 nnNhmWAey5tis/u5bEmtGcoVdnoA/GHi/AuC4/AyG0JgCtF5+SzHpb5uHSxuWCuFSAXS
 dlk1mH/DMpPyOUFYDUb1z2iiF8LxoTH5qsRQTGrUgyljWb7Cg60U6PER1TB1NpiE6gWz
 5hwPF1GnyBYGLeM3+z8/8vHub+rJ/Sa7aSotP4j1/fsjGCbdW1HKa10RtDcSjL655q1S
 /3YvJ05dclMYi0E1nhdPenRE+zNMMMShwYjGB+Xft/Jpek6u2P4n4mrexhweLXnFFuqB
 /yWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+GGkv7NtlRBFkOlRZdJjHeT9o5MV8pqyEnMXcfIx5FE=;
 b=VaEpbr/v5b2frw6TO3IsVjXZ5QVuylNRLr6bp4Be5f3pq7FDNO3vbC0dyBlwfR57AO
 lk9EI4MHaOPRWOqr+JMCJfVfaQm6j+7ormQgrIcfRShnVRmDqJ5jLKWGJNYoC6Tfhc08
 XSbN2e+Nr4h6XGmqSP/sTWSs4fXjApDW7zEifHgXa2YlIxdHqGv0Bp5iA0goSWyLvvmF
 jkNW6qpUEIqXX+L9xAUoFOF1pBJw54NIcswVb7WaSsbqtjHYVdStX3xgnNblEo1FOFj+
 pnFvfrJhN8XaeXzlyFy2gIDc0weHlCbytCaTg05zvpZq5nMMOdbbqB4GOJ2DeBMbGk6Q
 hAqQ==
X-Gm-Message-State: AOAM532lcS8xyNm9YT3pqd6Gl+yvzfJOHIqnO0AJW6lghNjm8DOGvo5M
 huGq8cTD8Xfd+kJ3NxdeqqM=
X-Google-Smtp-Source: ABdhPJyLzydRh9xHzILThqnjCmqZu1/0nqHg1t6kknykGc4eBDAIr4nti46wW6FpAfM3HaAGHPO09w==
X-Received: by 2002:a1c:9802:: with SMTP id a2mr2985210wme.74.1590665711324;
 Thu, 28 May 2020 04:35:11 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id n23sm3366465wmc.21.2020.05.28.04.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 04:35:09 -0700 (PDT)
Subject: Re: [PATCH v2 01/24] arm/stm32f405: Fix realization of
 "stm32f2xx-adc" devices
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200528110444.20456-1-armbru@redhat.com>
 <20200528110444.20456-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a3017ada-11cc-2c55-b232-9d4bb6447916@amsat.org>
Date: Thu, 28 May 2020 13:35:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200528110444.20456-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 ehabkost@redhat.com, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 1:04 PM, Markus Armbruster wrote:
> stm32f405_soc_initfn() creates six such devices, but
> stm32f405_soc_realize() realizes only one.  Affects machine
> netduinoplus2.
> 
> In theory, a device becomes real only on realize.  In practice, the
> transition from unreal to real is a fuzzy one.  The work to make a
> device real can be spread between realize methods (fine),
> instance_init methods (wrong), and board code wiring up the device
> (fine as long as it effectively happens on realize).  Depending on
> what exactly is done where, a device can work even when we neglect
> to realize it.
> 
> The five unrealized devices appear to stay unreal: neither MMIO nor
> IRQ get wired up.
> 
> Fix stm32f405_soc_realize() to realize and wire up all six.  Visible
> in "info qtree":
> 
>      bus: main-system-bus
>        type System
>        dev: stm32f405-soc, id ""
>          cpu-type = "cortex-m4-arm-cpu"
>        dev: stm32f2xx-adc, id ""
>          gpio-out "sysbus-irq" 1
>     -    mmio ffffffffffffffff/00000000000000ff
>     +    mmio 0000000040012000/00000000000000ff
>        dev: stm32f2xx-adc, id ""
>          gpio-out "sysbus-irq" 1
>     -    mmio ffffffffffffffff/00000000000000ff
>     +    mmio 0000000040012100/00000000000000ff
>        dev: stm32f2xx-adc, id ""
>          gpio-out "sysbus-irq" 1
>     -    mmio ffffffffffffffff/00000000000000ff
>     +    mmio 0000000040012200/00000000000000ff
>        dev: stm32f2xx-adc, id ""
>          gpio-out "sysbus-irq" 1
>     -    mmio ffffffffffffffff/00000000000000ff
>     +    mmio 0000000040012300/00000000000000ff
>        dev: stm32f2xx-adc, id ""
>          gpio-out "sysbus-irq" 1
>     -    mmio 0000000040012000/00000000000000ff
>     +    mmio 0000000040012400/00000000000000ff
>        dev: stm32f2xx-adc, id ""
>          gpio-out "sysbus-irq" 1
>     -    mmio ffffffffffffffff/00000000000000ff
>     +    mmio 0000000040012500/00000000000000ff
>        dev: armv7m, id ""
> 
> Fixes: 529fc5fd3e18ace8f739afd02dc0953354f39442
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/arm/stm32f405_soc.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
> index 4f10ce6176..c9a530eecf 100644
> --- a/hw/arm/stm32f405_soc.c
> +++ b/hw/arm/stm32f405_soc.c
> @@ -37,7 +37,8 @@ static const uint32_t usart_addr[] = { 0x40011000, 0x40004400, 0x40004800,
>  /* At the moment only Timer 2 to 5 are modelled */
>  static const uint32_t timer_addr[] = { 0x40000000, 0x40000400,
>                                         0x40000800, 0x40000C00 };
> -#define ADC_ADDR                       0x40012000
> +static const uint32_t adc_addr[] = { 0x40012000, 0x40012100, 0x40012200,
> +                                     0x40012300, 0x40012400, 0x40012500 };
>  static const uint32_t spi_addr[] =   { 0x40013000, 0x40003800, 0x40003C00,
>                                         0x40013400, 0x40015000, 0x40015400 };
>  #define EXTI_ADDR                      0x40013C00
> @@ -185,16 +186,18 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
>      qdev_connect_gpio_out(DEVICE(&s->adc_irqs), 0,
>                            qdev_get_gpio_in(armv7m, ADC_IRQ));
>  
> -    dev = DEVICE(&(s->adc[i]));
> -    object_property_set_bool(OBJECT(&s->adc[i]), true, "realized", &err);
> -    if (err != NULL) {
> -        error_propagate(errp, err);
> -        return;
> +    for (i = 0; i < STM_NUM_ADCS; i++) {

Correct fix.

Problem will come back when we'll want to implement a STM SoC with 8
ADCs, modifying the definition... We'll need to remember to unref() again.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +        dev = DEVICE(&(s->adc[i]));
> +        object_property_set_bool(OBJECT(&s->adc[i]), true, "realized", &err);
> +        if (err != NULL) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +        busdev = SYS_BUS_DEVICE(dev);
> +        sysbus_mmio_map(busdev, 0, adc_addr[i]);
> +        sysbus_connect_irq(busdev, 0,
> +                           qdev_get_gpio_in(DEVICE(&s->adc_irqs), i));
>      }
> -    busdev = SYS_BUS_DEVICE(dev);
> -    sysbus_mmio_map(busdev, 0, ADC_ADDR);
> -    sysbus_connect_irq(busdev, 0,
> -                       qdev_get_gpio_in(DEVICE(&s->adc_irqs), i));
>  
>      /* SPI devices */
>      for (i = 0; i < STM_NUM_SPIS; i++) {
> 


