Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41675C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06ED221019
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06ED221019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57645 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNevf-0000M1-8Q
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 10:49:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNeuS-00087P-I9
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNeuR-0006is-5T
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:48:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNeuQ-0006i5-Vd
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:48:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id v10so5360703wrt.6
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 07:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=c1YvHkmMjP1rzwHXZ7yx4s7qHLytPSqXmaeBvpZtmhE=;
	b=foat21pziUTsdJmb/TvvSynMciC6UUPOLXGcGIwgi/Z95zdkUztV4piqLrGX/A94Bc
	Zb7iGnt2jjIMCBdFwfNAPkOTxg1yPIeBH6VgZjLiwqPempEygBXM/1zey8q7AEgXQnYZ
	vXOqpKG7Xiiuzv2uEBycGWZD3pckYI7+fcOOnRm7lLQJNCsrMRK976myjHuEx1gAWF9y
	9gtTs2g5smkvr1f/gER9KorIAnOoRNRlqqyro4wC6uO2hNQmvkT0KeGqP/dkh4Palzmw
	SsLywF/hytJZRFJVyxVzX5abd1fVt36ysGVFK9+5pymH9f2ZFk6MseOui5HJ9OBc72jj
	aouQ==
X-Gm-Message-State: APjAAAV5MJGcAFes9KsytN7RKZKK3yefQiaR3UJ6DY7U7r9zkK8fomsm
	4p0oW+wGCEn9rXKaPJWSlN2lAQ==
X-Google-Smtp-Source: APXvYqy42JkG7i4tLOivJ81HtnCPYHqEbyQnuCwfic2UHf/oSADHeiEf5L/upNClEVTRQOh1UoJWAA==
X-Received: by 2002:adf:ec51:: with SMTP id w17mr1218009wrn.326.1557154081433; 
	Mon, 06 May 2019 07:48:01 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	j10sm32114529wrb.0.2019.05.06.07.48.00
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 07:48:00 -0700 (PDT)
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	Peter Maydell <peter.maydell@linaro.org>
References: <20190506142042.28096-1-clg@kaod.org>
	<20190506142042.28096-2-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9e9e4978-f010-f1ba-330c-ae51e7e65f0a@redhat.com>
Date: Mon, 6 May 2019 16:47:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506142042.28096-2-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 1/3] aspeed: add a per SoC mapping for
 the interrupt space
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cédric,

On 5/6/19 4:20 PM, Cédric Le Goater wrote:
> This will simplify the definition of new SoCs, like the AST2600 which
> should use a different CPU and a different IRQ number layout.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
> 
>  Changes since v1:
> 
>  - moved enum defining the Aspeed controller names under aspeed_soc.h
>  
>  include/hw/arm/aspeed_soc.h | 37 ++++++++++++++++++++++++
>  hw/arm/aspeed_soc.c         | 57 +++++++++++++++++++++++++++++++------
>  2 files changed, 86 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 11ec0179db50..2dd968092c69 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -57,6 +57,7 @@ typedef struct AspeedSoCInfo {
>      const char *fmc_typename;
>      const char **spi_typename;
>      int wdts_num;
> +    const int *irqmap;
>  } AspeedSoCInfo;
>  
>  typedef struct AspeedSoCClass {
> @@ -69,4 +70,40 @@ typedef struct AspeedSoCClass {
>  #define ASPEED_SOC_GET_CLASS(obj)                               \
>      OBJECT_GET_CLASS(AspeedSoCClass, (obj), TYPE_ASPEED_SOC)
>  
> +enum {
> +    ASPEED_IOMEM,
> +    ASPEED_UART1,
> +    ASPEED_UART2,
> +    ASPEED_UART3,
> +    ASPEED_UART4,
> +    ASPEED_UART5,
> +    ASPEED_VUART,
> +    ASPEED_FMC,
> +    ASPEED_SPI1,
> +    ASPEED_SPI2,
> +    ASPEED_VIC,
> +    ASPEED_SDMC,
> +    ASPEED_SCU,
> +    ASPEED_ADC,
> +    ASPEED_SRAM,
> +    ASPEED_GPIO,
> +    ASPEED_RTC,
> +    ASPEED_TIMER1,
> +    ASPEED_TIMER2,
> +    ASPEED_TIMER3,
> +    ASPEED_TIMER4,
> +    ASPEED_TIMER5,
> +    ASPEED_TIMER6,
> +    ASPEED_TIMER7,
> +    ASPEED_TIMER8,
> +    ASPEED_WDT,
> +    ASPEED_PWM,
> +    ASPEED_LPC,
> +    ASPEED_IBT,
> +    ASPEED_I2C,
> +    ASPEED_ETH1,
> +    ASPEED_ETH2,
> +    ASPEED_SDRAM,

I'd add ...:

       ASPEED_IRQMAP_COUNT /* keep last */

> +};
> +
>  #endif /* ASPEED_SOC_H */
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index a27233d4876b..29bce5c9188c 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -38,12 +38,42 @@
>  #define ASPEED_SOC_ETH1_BASE        0x1E660000
>  #define ASPEED_SOC_ETH2_BASE        0x1E680000
>  
> -static const int uart_irqs[] = { 9, 32, 33, 34, 10 };
> -static const int timer_irqs[] = { 16, 17, 18, 35, 36, 37, 38, 39, };
> +static const int aspeed_soc_ast2400_irqmap[] = {

... and use it here:

static const int aspeed_soc_ast2400_irqmap[ASPEED_IRQMAP_COUNT] = {

because you define ASPEED_SDRAM, and if some code access
aspeed_soc_ast2400_irqmap[ASPEED_SDRAM] it would be uninitialized.
Specifying the array size, the uninitialized entries are
zero-initialized (not sure this is the default you expect although).

> +    [ASPEED_UART1]  = 9,
> +    [ASPEED_UART2]  = 32,
> +    [ASPEED_UART3]  = 33,
> +    [ASPEED_UART4]  = 34,
> +    [ASPEED_UART5]  = 10,
> +    [ASPEED_VUART]  = 8,
> +    [ASPEED_FMC]    = 19,
> +    [ASPEED_SDMC]   = 0,
> +    [ASPEED_SCU]    = 21,
> +    [ASPEED_ADC]    = 31,
> +    [ASPEED_GPIO]   = 20,
> +    [ASPEED_RTC]    = 22,
> +    [ASPEED_TIMER1] = 16,
> +    [ASPEED_TIMER2] = 17,
> +    [ASPEED_TIMER3] = 18,
> +    [ASPEED_TIMER4] = 35,
> +    [ASPEED_TIMER5] = 36,
> +    [ASPEED_TIMER6] = 37,
> +    [ASPEED_TIMER7] = 38,
> +    [ASPEED_TIMER8] = 39,
> +    [ASPEED_WDT]    = 27,
> +    [ASPEED_PWM]    = 28,
> +    [ASPEED_LPC]    = 8,
> +    [ASPEED_IBT]    = 8, /* LPC */
> +    [ASPEED_I2C]    = 12,
> +    [ASPEED_ETH1]   = 2,
> +    [ASPEED_ETH2]   = 3,
> +};
>  
>  #define AST2400_SDRAM_BASE       0x40000000
>  #define AST2500_SDRAM_BASE       0x80000000
>  
> +/* AST2500 uses the same IRQs as the AST2400 */
> +#define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
> +
>  static const hwaddr aspeed_soc_ast2400_spi_bases[] = { ASPEED_SOC_SPI_BASE };
>  static const char *aspeed_soc_ast2400_typenames[] = { "aspeed.smc.spi" };
>  
> @@ -64,6 +94,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
>          .fmc_typename = "aspeed.smc.fmc",
>          .spi_typename = aspeed_soc_ast2400_typenames,
>          .wdts_num     = 2,
> +        .irqmap       = aspeed_soc_ast2400_irqmap,
>      }, {
>          .name         = "ast2400-a1",
>          .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
> @@ -75,6 +106,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
>          .fmc_typename = "aspeed.smc.fmc",
>          .spi_typename = aspeed_soc_ast2400_typenames,
>          .wdts_num     = 2,
> +        .irqmap       = aspeed_soc_ast2400_irqmap,
>      }, {
>          .name         = "ast2400",
>          .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
> @@ -86,6 +118,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
>          .fmc_typename = "aspeed.smc.fmc",
>          .spi_typename = aspeed_soc_ast2400_typenames,
>          .wdts_num     = 2,
> +        .irqmap       = aspeed_soc_ast2400_irqmap,
>      }, {
>          .name         = "ast2500-a1",
>          .cpu_type     = ARM_CPU_TYPE_NAME("arm1176"),
> @@ -97,9 +130,17 @@ static const AspeedSoCInfo aspeed_socs[] = {
>          .fmc_typename = "aspeed.smc.ast2500-fmc",
>          .spi_typename = aspeed_soc_ast2500_typenames,
>          .wdts_num     = 3,
> +        .irqmap       = aspeed_soc_ast2500_irqmap,
>      },
>  };
>  
> +static qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int ctrl)
> +{
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +
> +    return qdev_get_gpio_in(DEVICE(&s->vic), sc->info->irqmap[ctrl]);
> +}
> +
>  static void aspeed_soc_init(Object *obj)
>  {
>      AspeedSoCState *s = ASPEED_SOC(obj);
> @@ -226,14 +267,14 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0, ASPEED_SOC_TIMER_BASE);
> -    for (i = 0; i < ARRAY_SIZE(timer_irqs); i++) {
> -        qemu_irq irq = qdev_get_gpio_in(DEVICE(&s->vic), timer_irqs[i]);
> +    for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
> +        qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_TIMER1 + i);
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
>      }
>  
>      /* UART - attach an 8250 to the IO space as our UART5 */
>      if (serial_hd(0)) {
> -        qemu_irq uart5 = qdev_get_gpio_in(DEVICE(&s->vic), uart_irqs[4]);
> +        qemu_irq uart5 = aspeed_soc_get_irq(s, ASPEED_UART5);
>          serial_mm_init(get_system_memory(),
>                         ASPEED_SOC_IOMEM_BASE + ASPEED_SOC_UART_5_BASE, 2,
>                         uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN);
> @@ -247,7 +288,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>      }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, ASPEED_SOC_I2C_BASE);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), 0,
> -                       qdev_get_gpio_in(DEVICE(&s->vic), 12));
> +                       aspeed_soc_get_irq(s, ASPEED_I2C));
>  
>      /* FMC, The number of CS is set at the board level */
>      object_property_set_bool(OBJECT(&s->fmc), true, "realized", &err);
> @@ -259,7 +300,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 1,
>                      s->fmc.ctrl->flash_window_base);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
> -                       qdev_get_gpio_in(DEVICE(&s->vic), 19));
> +                       aspeed_soc_get_irq(s, ASPEED_FMC));
>  
>      /* SPI */
>      for (i = 0; i < sc->info->spis_num; i++) {
> @@ -307,7 +348,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>      }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0, ASPEED_SOC_ETH1_BASE);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
> -                       qdev_get_gpio_in(DEVICE(&s->vic), 2));
> +                       aspeed_soc_get_irq(s, ASPEED_ETH1));
>  }
>  
>  static void aspeed_soc_class_init(ObjectClass *oc, void *data)
> 

With the array explicit size:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

