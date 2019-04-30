Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7484C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EED52081C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uK/ofntA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EED52081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49737 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVax-0002GB-Hf
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:27:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLVAj-0004vo-29
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLVAg-0004hq-SZ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:59:57 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLVAg-0004hS-Mp
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:59:54 -0400
Received: by mail-oi1-x241.google.com with SMTP id d62so5797024oib.13
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Aet0shfUY8OGFSb1g1Y0WlXxfX0QxQJu8SnrapWHQOQ=;
	b=uK/ofntAD58zxofwXhMFuXY7YJyr8PX4lJJ4VfHGw3n0fwRlFdBpkRf8DWQ878haAd
	sot803DSlzwWCbkVwM1PJAFmGiPBFJzQtPQ2mwE2edin0sSnL92+3OxshvEi5FVlbsir
	ENffm/MPWGAdJjj5Vfc8IUbIgnTvuL1zozhYY5tAp6kAF22RW7fRE7ROlMacM7yGTQLo
	F022jF2mi/BBz87/ZLs+EuJZdNrhQ7f+z6Ct5ERTwmpyqgBOEtaCEHUq0t6bcQTxbZYd
	yTnbyW3Ui+55cLJwCMdUKpD6Uf8ap/Ljupd6myxAap695HP/M5VSoHbT8GgXNcI2ptXd
	+zMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Aet0shfUY8OGFSb1g1Y0WlXxfX0QxQJu8SnrapWHQOQ=;
	b=anQAa2j9hWzRFRAfTyAEbHjj2Ok1ORPunEpdIT4undED40nhwboGN6UE90IRwIfWVh
	Ubqf1NS5+ZinYGZwfjty+42tmm09BOxl0ugLB9zrnaJgo4dxkLgB1khLLL6y4JeWsDFX
	oWLWX8ib+zgmsKWXfQ35Qwo5vkEKfiZo2daSyKfRm+YFUDdSo0sOtiSgZcVdyC8PBqUC
	2Wm0uO67IB5Lj/GeG6RA1OvoppxPfpc/OlD4+XaNcV+lxmn52wABbC++rFpDzICPz+xE
	6qqvlamCreVOQ7okFVdWARY1yRcezvcl0XUrj1QvHvMPozrTgKgZ5Twh5DWhMA+kOKfN
	1wuw==
X-Gm-Message-State: APjAAAXGXSmmWTPlU65HCmc88nRZfhxxqVoOhOPy5aH5ePviikFG2Wha
	aTdShK2qr8dnT/ycRiPGsqN3PrF0bj01nQ1hheTKcw==
X-Google-Smtp-Source: APXvYqz/mRC1mr54eujXPnEq90J7iAswEP57OwLVm/DE74DKalxAWKZUfqX7Ppvj2u7D/3RkPEMY83nNbPs3qiCBFnI=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr3712378oif.98.1556639993674; 
	Tue, 30 Apr 2019 08:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556515687.git.alistair@alistair23.me>
	<PSXP216MB027793B449E7DAAB995E0F33DD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB027793B449E7DAAB995E0F33DD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 16:59:42 +0100
Message-ID:
 <CAFEAcA_rzfL_-zZPpMhqvyGLe7wS-HFh0znd8n2ysnfhg4kHLA@mail.gmail.com>
To: Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v1 4/5] hw/arm: Add the STM32F4xx SoC
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
Cc: "alistair23@gmail.com" <alistair23@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430155942.d37fScGpV08k619IMZLatwWHWGhFAFCrGMpFl-DCW1g@z>

On Mon, 29 Apr 2019 at 06:38, Alistair Francis <alistair@alistair23.me> wrote:
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  MAINTAINERS                     |   8 +
>  default-configs/arm-softmmu.mak |   1 +
>  hw/arm/Kconfig                  |   3 +
>  hw/arm/Makefile.objs            |   1 +
>  hw/arm/stm32f405_soc.c          | 292 ++++++++++++++++++++++++++++++++
>  include/hw/arm/stm32f405_soc.h  |  70 ++++++++
>  6 files changed, 375 insertions(+)
>  create mode 100644 hw/arm/stm32f405_soc.c
>  create mode 100644 include/hw/arm/stm32f405_soc.h

Looks good; a few minor things below.

> +static void stm32f405_soc_initfn(Object *obj)
> +{
> +    STM32F405State *s = STM32F405_SOC(obj);
> +    int i;
> +
> +    sysbus_init_child_obj(obj, "armv7m", &s->armv7m, sizeof(s->armv7m),
> +                          TYPE_ARMV7M);
> +
> +    sysbus_init_child_obj(obj, "syscfg", &s->syscfg, sizeof(s->syscfg),
> +                          TYPE_STM32F4XX_SYSCFG);
> +
> +    for (i = 0; i < STM_NUM_USARTS; i++) {
> +        sysbus_init_child_obj(obj, "usart[*]", &s->usart[i],
> +                              sizeof(s->usart[i]), TYPE_STM32F2XX_USART);
> +    }
> +
> +    for (i = 0; i < STM_NUM_TIMERS; i++) {
> +        sysbus_init_child_obj(obj, "timer[*]", &s->timer[i],
> +                              sizeof(s->timer[i]), TYPE_STM32F2XX_TIMER);
> +    }
> +
> +    s->adc_irqs = OR_IRQ(object_new(TYPE_OR_IRQ));

It would be more in keeping with the style of the rest of this
device to have the device be inline in the STM32F405State
struct and initialized with object_initialize_child() rather
than allocated separately with object_new(). (hw/arm/armsse.c
has an example of doing this with a TYPE_OR_IRQ object.)

> +
> +    for (i = 0; i < STM_NUM_ADCS; i++) {
> +        sysbus_init_child_obj(obj, "adc[*]", &s->adc[i], sizeof(s->adc[i]),
> +                              TYPE_STM32F2XX_ADC);
> +    }
> +
> +    for (i = 0; i < STM_NUM_SPIS; i++) {
> +        sysbus_init_child_obj(obj, "spi[*]", &s->spi[i], sizeof(s->spi[i]),
> +                              TYPE_STM32F2XX_SPI);
> +    }
> +
> +    sysbus_init_child_obj(obj, "exti", &s->exti, sizeof(s->exti),
> +                          TYPE_STM32F4XX_EXTI);
> +}
> +
> +static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
> +{
> +    STM32F405State *s = STM32F405_SOC(dev_soc);
> +    DeviceState *dev, *armv7m;
> +    SysBusDevice *busdev;
> +    Error *err = NULL;
> +    int i;
> +
> +    MemoryRegion *system_memory = get_system_memory();
> +    MemoryRegion *sram = g_new(MemoryRegion, 1);
> +    MemoryRegion *flash = g_new(MemoryRegion, 1);
> +    MemoryRegion *flash_alias = g_new(MemoryRegion, 1);

I would prefer to have these MemoryRegions be in the STM32F405State
struct rather than separately allocated.

> +
> +    memory_region_init_ram(flash, NULL, "STM32F405.flash", FLASH_SIZE,
> +                           &error_fatal);

Better to pass the error back up via errp rather than use error_fatal
in a realize function.

> +    memory_region_init_alias(flash_alias, NULL, "STM32F405.flash.alias",
> +                             flash, 0, FLASH_SIZE);
> +
> +    memory_region_set_readonly(flash, true);
> +    memory_region_set_readonly(flash_alias, true);
> +
> +    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, flash);
> +    memory_region_add_subregion(system_memory, 0, flash_alias);
> +
> +    memory_region_init_ram(sram, NULL, "STM32F405.sram", SRAM_SIZE,
> +                           &error_fatal);
> +    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram);
> +
> +    armv7m = DEVICE(&s->armv7m);
> +    qdev_prop_set_uint32(armv7m, "num-irq", 96);
> +    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
> +    qdev_prop_set_bit(armv7m, "enable-bitband", true);
> +    object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),

You could use OBJECT(system_memory) rather than calling
get_system_memory() again.

> +static Property stm32f405_soc_properties[] = {
> +    DEFINE_PROP_STRING("cpu-type", STM32F405State, cpu_type),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void stm32f405_soc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = stm32f405_soc_realize;
> +    dc->props = stm32f405_soc_properties;

A comment here "No vmstate or reset required: device has no internal state"
would help indicate that dc->vmsd and dc->reset have not merely
been forgotten.

(Eventually I might actually write a patch to let us express
in code "dc->vmsd = device_has_no_state;"...)

> +}

thanks
-- PMM

