Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C940C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 23:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E0F2073B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 23:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVVQ64jS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E0F2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9zjM-00072p-DS
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 18:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j9ziV-0006UI-Rh
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 18:15:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j9ziT-0008BL-A7
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 18:15:47 -0500
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941]:33262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j9ziT-0008Ah-1d; Thu, 05 Mar 2020 18:15:45 -0500
Received: by mail-ua1-x941.google.com with SMTP id 94so53185uat.0;
 Thu, 05 Mar 2020 15:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5wFdJSUv8OJDWHyAv6VOM4BEjKHjrrhV5SGaHLR1Gs4=;
 b=aVVQ64jSd0M1uz+ux0GZkSeGSJGszdBOamwvr7ypYBsluDWt6nQiUGsPYksBz2NUL3
 uzAhnDy+uSNNGW80fQkRdOl5940f+XteX46ve6qeukUMuTyW9u6tI7M/ZOHBkYbKnqXx
 /sV/fDyDDGuApIvZNM6c9AOxmleDF50emW3OfnXEHd7T/ejzAUQGlZ6KPJ4jmg9aFIAl
 encxuIf973TzpBaHR/rRxh+O7e8MQtLLTILNLVrmADNF3sT1P5kUlYO90GEwnTtenzrX
 DK+3JCz7EITELl/7hvdd7wCBgHB1VEr9BoYDG3yBpUWyZI7cNy+K9RTUQ7c0QsFTGmK7
 cwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5wFdJSUv8OJDWHyAv6VOM4BEjKHjrrhV5SGaHLR1Gs4=;
 b=hJpCCsSBXRFSdkBeNKhBZCi8rOT0OuIHt6QFXY4rcG1YX8uGBBfAqNOeCZiUnuTbCM
 z2Lpo/33D0dWb77M5zEbuauSYSZgkSPuRTm1mL3gpoq4zUk4/foH/lBNLaUpT5NsbjG6
 39rEFLCz0x/QCuQYRxVwJGztPuOuof+jSSP0lSfTFg5jX62GV3GygVg6LQYK1G/f3S27
 RUx3XXr/tNe09dcrCSrNm8rBz71zZLs5n7iNfwEMWJ6KiRZgcoHGNY8V9RhV+JrG4Jxu
 2XB3LjTKoxdMzlETbsIsmzRXS2foxhYF469fyjgvFJAA/G7Hp21S18afanX+Sn4Cs3Dx
 sHKA==
X-Gm-Message-State: ANhLgQ2/WF6SRBz6s3IPQx5HZJ90YvazvkDsiB/RuADn2bcwWbLCkiIE
 7Nn/2iqQhHrXMJ8wT8jtnSjKL6fVyR5L1VPMyjLuMLsh
X-Google-Smtp-Source: ADFU+vu/QnIOfL9NxM3XPiHpBAXEFoZF0QCkgH5f7GLYTDL7s4djKIG49vEEFy4hpayOrICIcy7DLOLHjV0afJfrhaI=
X-Received: by 2002:a9f:3311:: with SMTP id o17mr186190uab.30.1583450143823;
 Thu, 05 Mar 2020 15:15:43 -0800 (PST)
MIME-Version: 1.0
References: <20200301084427.93823-1-root@stephanos.io>
In-Reply-To: <20200301084427.93823-1-root@stephanos.io>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Mar 2020 15:08:01 -0800
Message-ID: <CAKmqyKNJ_qR2P72RXNGHC-3iuN+HL5Rhy5V_ehTGTmBDpUdi0Q@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/stm32f405: Add preliminary flash interface
 emulation support
To: Stephanos Ioannidis <root@stephanos.io>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::941
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
 Alistair Francis <alistair@alistair23.me>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 1, 2020 at 12:47 AM Stephanos Ioannidis <root@stephanos.io> wrote:
>
> The flash interface (FLASHIF) peripheral provides a control interface
> for the SoC embedded flash memory on the STM32F4xx series devices.
>
> This commit adds preliminary support for the flash interface peripheral
> emulation, in order to support proper emulation of the firmware images
> that use the STM32Cube driver, which configures and validates the
> FLASH_ACR register during system initialisation.
>
> Signed-off-by: Stephanos Ioannidis <root@stephanos.io>

Hey Stephanos,

I think a lot of comments from your other patch apply to this patch as
well (about bit fields and splitting the patch specifically).

Do you mind sending a v2 addressing those comments?

Alistair

> ---
>  hw/arm/Kconfig                      |   1 +
>  hw/arm/stm32f405_soc.c              |  15 +-
>  hw/misc/Kconfig                     |   3 +
>  hw/misc/Makefile.objs               |   1 +
>  hw/misc/stm32f4xx_flashif.c         | 215 ++++++++++++++++++++++++++++
>  hw/misc/trace-events                |   4 +
>  include/hw/arm/stm32f405_soc.h      |   2 +
>  include/hw/misc/stm32f4xx_flashif.h | 144 +++++++++++++++++++
>  8 files changed, 384 insertions(+), 1 deletion(-)
>  create mode 100644 hw/misc/stm32f4xx_flashif.c
>  create mode 100644 include/hw/misc/stm32f4xx_flashif.h
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 3d86691ae0..179696ec91 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -314,6 +314,7 @@ config STM32F205_SOC
>  config STM32F405_SOC
>      bool
>      select ARM_V7M
> +    select STM32F4XX_FLASHIF
>      select STM32F4XX_SYSCFG
>      select STM32F4XX_EXTI
>
> diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
> index 9bcad97853..72b16910c7 100644
> --- a/hw/arm/stm32f405_soc.c
> +++ b/hw/arm/stm32f405_soc.c
> @@ -30,6 +30,7 @@
>  #include "hw/arm/stm32f405_soc.h"
>  #include "hw/misc/unimp.h"
>
> +#define FLASHIF_ADDR                   0x40023C00
>  #define SYSCFG_ADD                     0x40013800
>  static const uint32_t usart_addr[] = { 0x40011000, 0x40004400, 0x40004800,
>                                         0x40004C00, 0x40005000, 0x40011400,
> @@ -59,6 +60,9 @@ static void stm32f405_soc_initfn(Object *obj)
>      sysbus_init_child_obj(obj, "armv7m", &s->armv7m, sizeof(s->armv7m),
>                            TYPE_ARMV7M);
>
> +    sysbus_init_child_obj(obj, "flashif", &s->flashif, sizeof(s->flashif),
> +                          TYPE_STM32F4XX_FLASHIF);
> +
>      sysbus_init_child_obj(obj, "syscfg", &s->syscfg, sizeof(s->syscfg),
>                            TYPE_STM32F4XX_SYSCFG);
>
> @@ -130,6 +134,16 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
>          return;
>      }
>
> +    /* Flash interface */
> +    dev = DEVICE(&s->flashif);
> +    object_property_set_bool(OBJECT(&s->flashif), true, "realized", &err);
> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    busdev = SYS_BUS_DEVICE(dev);
> +    sysbus_mmio_map(busdev, 0, FLASHIF_ADDR);
> +
>      /* System configuration controller */
>      dev = DEVICE(&s->syscfg);
>      object_property_set_bool(OBJECT(&s->syscfg), true, "realized", &err);
> @@ -261,7 +275,6 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
>      create_unimplemented_device("GPIOI",       0x40022000, 0x400);
>      create_unimplemented_device("CRC",         0x40023000, 0x400);
>      create_unimplemented_device("RCC",         0x40023800, 0x400);
> -    create_unimplemented_device("Flash Int",   0x40023C00, 0x400);
>      create_unimplemented_device("BKPSRAM",     0x40024000, 0x400);
>      create_unimplemented_device("DMA1",        0x40026000, 0x400);
>      create_unimplemented_device("DMA2",        0x40026400, 0x400);
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index bdd77d8020..e333a955b2 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -79,6 +79,9 @@ config IMX
>      select SSI
>      select USB_EHCI_SYSBUS
>
> +config STM32F4XX_FLASHIF
> +    bool
> +
>  config STM32F2XX_SYSCFG
>      bool
>
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index da993f45b7..1aea0b9bb9 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -58,6 +58,7 @@ common-obj-$(CONFIG_RASPI) += bcm2835_thermal.o
>  common-obj-$(CONFIG_SLAVIO) += slavio_misc.o
>  common-obj-$(CONFIG_ZYNQ) += zynq_slcr.o
>  common-obj-$(CONFIG_ZYNQ) += zynq-xadc.o
> +common-obj-$(CONFIG_STM32F4XX_FLASHIF) += stm32f4xx_flashif.o
>  common-obj-$(CONFIG_STM32F2XX_SYSCFG) += stm32f2xx_syscfg.o
>  common-obj-$(CONFIG_STM32F4XX_SYSCFG) += stm32f4xx_syscfg.o
>  common-obj-$(CONFIG_STM32F4XX_EXTI) += stm32f4xx_exti.o
> diff --git a/hw/misc/stm32f4xx_flashif.c b/hw/misc/stm32f4xx_flashif.c
> new file mode 100644
> index 0000000000..d280fc5b2c
> --- /dev/null
> +++ b/hw/misc/stm32f4xx_flashif.c
> @@ -0,0 +1,215 @@
> +/*
> + * STM32F4xx FLASHIF
> + *
> + * Copyright (c) 2020 Stephanos Ioannidis <root@stephanos.io>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +#include "hw/irq.h"
> +#include "migration/vmstate.h"
> +#include "hw/misc/stm32f4xx_flashif.h"
> +
> +static void stm32f4xx_flashif_reset(DeviceState *dev)
> +{
> +    STM32F4xxFlashIfState *s = STM32F4XX_FLASHIF(dev);
> +
> +    /* Initialise states */
> +    s->cr_key_index = 0;
> +    s->optcr_key_index = 0;
> +
> +    /* Initialise register values */
> +    s->flash_acr.reg = 0x00000000;
> +    s->flash_keyr.reg = 0x00000000;
> +    s->flash_optkeyr.reg = 0x00000000;
> +    s->flash_sr.reg = 0x00000000;
> +    s->flash_cr.reg = 0x80000000;
> +    s->flash_optcr.reg = 0x0FFFAAED;
> +}
> +
> +static uint64_t stm32f4xx_flashif_read(void * opaque, hwaddr addr,
> +                                       unsigned int size)
> +{
> +    STM32F4xxFlashIfState *s = opaque;
> +
> +    trace_stm32f4xx_flashif_read(addr);
> +
> +    switch (addr) {
> +    case FLASH_ACR:
> +        return s->flash_acr.reg;
> +    case FLASH_SR:
> +        return s->flash_sr.reg;
> +    case FLASH_CR:
> +        return s->flash_cr.reg;
> +    case FLASH_OPTCR:
> +        return s->flash_optcr.reg;
> +    default:
> +        qemu_log_mask(
> +            LOG_GUEST_ERROR,
> +            "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
> +        return 0;
> +    }
> +}
> +
> +static void flash_acr_write(STM32F4xxFlashIfState *s, FlashAcrType val)
> +{
> +    /* Set latency */
> +    s->flash_acr.latency = val.latency;
> +    /* Set prefetch status */
> +    s->flash_acr.prften = val.prften;
> +    /* Set instruction cache status */
> +    s->flash_acr.icen = val.icen;
> +    /* Set data cache status */
> +    s->flash_acr.dcen = val.dcen;
> +}
> +
> +static void flash_cr_write(STM32F4xxFlashIfState *s, FlashCrType val)
> +{
> +    /* Lock FLASH_CR if lock bit is set */
> +    if (val.lock) {
> +        s->flash_cr.lock = 1;
> +        s->cr_key_index = 0;
> +        return;
> +    }
> +}
> +
> +static void flash_optcr_write(STM32F4xxFlashIfState *s, FlashOptcrType val)
> +{
> +    /* Lock FLASH_OPTCR if lock bit is set */
> +    if (val.optlock) {
> +        s->flash_optcr.optlock = 1;
> +        s->optcr_key_index = 0;
> +        return;
> +    }
> +}
> +
> +static void stm32f4xx_flashif_write(void *opaque, hwaddr addr,
> +                                    uint64_t val64, unsigned int size)
> +{
> +    STM32F4xxFlashIfState *s = opaque;
> +    uint32_t value = val64;
> +
> +    trace_stm32f4xx_flashif_write(value, addr);
> +
> +    switch (addr) {
> +    case FLASH_ACR:
> +        flash_acr_write(s, (FlashAcrType)value);
> +        return;
> +    case FLASH_KEYR:
> +        if (s->cr_key_index == 0 && value == 0x45670123) {
> +            s->cr_key_index = 1;
> +        } else if (s->cr_key_index == 1 && value == 0xCDEF89AB) {
> +            /* Valid key; unlock FLASH_CR */
> +            s->flash_cr.lock = 0;
> +            s->cr_key_index = 0;
> +        } else {
> +            /* Invalid key; permanently lock FLASH_CR until reset */
> +            s->flash_cr.lock = 1;
> +            s->cr_key_index = -1;
> +        }
> +        return;
> +    case FLASH_OPTKEYR:
> +        if (s->optcr_key_index == 0 && value == 0x08192A3B) {
> +            s->optcr_key_index = 1;
> +        } else if (s->optcr_key_index == 1 && value == 0x4C5D6E7F) {
> +            /* Valid key; unlock FLASH_OPTCR */
> +            s->flash_optcr.optlock = 0;
> +            s->optcr_key_index = 0;
> +        } else {
> +            /* Invalid key; lock FLASH_OPTCR until reset */
> +            s->flash_optcr.optlock = 1;
> +            s->optcr_key_index = -1;
> +        }
> +        return;
> +    case FLASH_SR:
> +        if (s->flash_sr.eop)        s->flash_sr.eop = 0;
> +        if (s->flash_sr.operr)      s->flash_sr.operr = 0;
> +        if (s->flash_sr.wrperr)     s->flash_sr.wrperr = 0;
> +        if (s->flash_sr.pgaerr)     s->flash_sr.pgaerr = 0;
> +        if (s->flash_sr.pgperr)     s->flash_sr.pgperr = 0;
> +        if (s->flash_sr.pgserr)     s->flash_sr.pgserr = 0;
> +        return;
> +    case FLASH_CR:
> +        flash_cr_write(s, (FlashCrType)value);
> +        return;
> +    case FLASH_OPTCR:
> +        flash_optcr_write(s, (FlashOptcrType)value);
> +        return;
> +    default:
> +        qemu_log_mask(
> +            LOG_GUEST_ERROR,
> +            "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
> +    }
> +}
> +
> +static const MemoryRegionOps stm32f4xx_flashif_ops = {
> +    .read = stm32f4xx_flashif_read,
> +    .write = stm32f4xx_flashif_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN
> +};
> +
> +static void stm32f4xx_flashif_init(Object *obj)
> +{
> +    STM32F4xxFlashIfState *s = STM32F4XX_FLASHIF(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &stm32f4xx_flashif_ops, s,
> +                          TYPE_STM32F4XX_FLASHIF, 0x400);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +}
> +
> +static const VMStateDescription vmstate_stm32f4xx_flashif = {
> +    .name = TYPE_STM32F4XX_FLASHIF,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(flash_acr.reg, STM32F4xxFlashIfState),
> +        VMSTATE_UINT32(flash_keyr.reg, STM32F4xxFlashIfState),
> +        VMSTATE_UINT32(flash_optkeyr.reg, STM32F4xxFlashIfState),
> +        VMSTATE_UINT32(flash_sr.reg, STM32F4xxFlashIfState),
> +        VMSTATE_UINT32(flash_cr.reg, STM32F4xxFlashIfState),
> +        VMSTATE_UINT32(flash_optcr.reg, STM32F4xxFlashIfState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void stm32f4xx_flashif_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = stm32f4xx_flashif_reset;
> +    dc->vmsd = &vmstate_stm32f4xx_flashif;
> +}
> +
> +static const TypeInfo stm32f4xx_flashif_info = {
> +    .name          = TYPE_STM32F4XX_FLASHIF,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(STM32F4xxFlashIfState),
> +    .instance_init = stm32f4xx_flashif_init,
> +    .class_init    = stm32f4xx_flashif_class_init
> +};
> +
> +static void stm32f4xx_flashif_register_types(void)
> +{
> +    type_register_static(&stm32f4xx_flashif_info);
> +}
> +
> +type_init(stm32f4xx_flashif_register_types)
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 7f0f5dff3a..bd9a5dd483 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -84,6 +84,10 @@ mos6522_set_sr_int(void) "set sr_int"
>  mos6522_write(uint64_t addr, uint64_t val) "reg=0x%"PRIx64 " val=0x%"PRIx64
>  mos6522_read(uint64_t addr, unsigned val) "reg=0x%"PRIx64 " val=0x%x"
>
> +# stm32f4xx_flashif
> +stm32f4xx_flashif_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
> +stm32f4xx_flashif_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
> +
>  # stm32f4xx_syscfg
>  stm32f4xx_syscfg_set_irq(int gpio, int line, int level) "Interupt: GPIO: %d, Line: %d; Level: %d"
>  stm32f4xx_pulse_exti(int irq) "Pulse EXTI: %d"
> diff --git a/include/hw/arm/stm32f405_soc.h b/include/hw/arm/stm32f405_soc.h
> index 1fe97f8c3a..a94c3c51ac 100644
> --- a/include/hw/arm/stm32f405_soc.h
> +++ b/include/hw/arm/stm32f405_soc.h
> @@ -25,6 +25,7 @@
>  #ifndef HW_ARM_STM32F405_SOC_H
>  #define HW_ARM_STM32F405_SOC_H
>
> +#include "hw/misc/stm32f4xx_flashif.h"
>  #include "hw/misc/stm32f4xx_syscfg.h"
>  #include "hw/timer/stm32f2xx_timer.h"
>  #include "hw/char/stm32f2xx_usart.h"
> @@ -57,6 +58,7 @@ typedef struct STM32F405State {
>
>      ARMv7MState armv7m;
>
> +    STM32F4xxFlashIfState flashif;
>      STM32F4xxSyscfgState syscfg;
>      STM32F4xxExtiState exti;
>      STM32F2XXUsartState usart[STM_NUM_USARTS];
> diff --git a/include/hw/misc/stm32f4xx_flashif.h b/include/hw/misc/stm32f4xx_flashif.h
> new file mode 100644
> index 0000000000..e364ca39c7
> --- /dev/null
> +++ b/include/hw/misc/stm32f4xx_flashif.h
> @@ -0,0 +1,144 @@
> +/*
> + * STM32F4xx FLASHIF
> + *
> + * Copyright (c) 2020 Stephanos Ioannidis <root@stephanos.io>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef HW_STM_FLASHIF_H
> +#define HW_STM_FLASHIF_H
> +
> +#include "hw/sysbus.h"
> +#include "hw/hw.h"
> +
> +#define TYPE_STM32F4XX_FLASHIF "stm32f4xx-flashif"
> +#define STM32F4XX_FLASHIF(obj) \
> +    OBJECT_CHECK(STM32F4xxFlashIfState, (obj), TYPE_STM32F4XX_FLASHIF)
> +
> +#define FLASH_ACR       0x00
> +#define FLASH_KEYR      0x04
> +#define FLASH_OPTKEYR   0x08
> +#define FLASH_SR        0x0C
> +#define FLASH_CR        0x10
> +#define FLASH_OPTCR     0x14
> +
> +typedef union {
> +    struct {
> +        uint32_t latency : 3;
> +        uint32_t reserved0 : 5;
> +        uint32_t prften : 1;
> +        uint32_t icen : 1;
> +        uint32_t dcen : 1;
> +        uint32_t icrst : 1;
> +        uint32_t dcrst : 1;
> +        uint32_t reserved1 : 19;
> +    };
> +    uint32_t reg;
> +} FlashAcrType;
> +
> +typedef union {
> +    struct {
> +        uint32_t key : 32;
> +    };
> +    uint32_t reg;
> +} FlashKeyrType;
> +
> +typedef union {
> +    struct {
> +        uint32_t optkey : 32;
> +    };
> +    uint32_t reg;
> +} FlashOptkeyrType;
> +
> +typedef union {
> +    struct {
> +        uint32_t eop : 1;
> +        uint32_t operr : 1;
> +        uint32_t reserved0 : 2;
> +        uint32_t wrperr : 1;
> +        uint32_t pgaerr : 1;
> +        uint32_t pgperr : 1;
> +        uint32_t pgserr : 1;
> +        uint32_t reserved1 : 8;
> +        uint32_t bsy : 1;
> +        uint32_t reserved2 : 15;
> +    };
> +    uint32_t reg;
> +} FlashSrType;
> +
> +typedef union {
> +    struct {
> +        uint32_t pg : 1;
> +        uint32_t ser : 1;
> +        uint32_t mer : 1;
> +        uint32_t snb : 4;
> +        uint32_t reserved0 : 1;
> +        uint32_t psize : 2;
> +        uint32_t reserved1 : 6;
> +        uint32_t strt : 1;
> +        uint32_t reserved2 : 7;
> +        uint32_t eopie : 1;
> +        uint32_t reserved3 : 6;
> +        uint32_t lock : 1;
> +    };
> +    uint32_t reg;
> +} FlashCrType;
> +
> +typedef union {
> +    struct {
> +        uint32_t optlock : 1;
> +        uint32_t optstrt : 1;
> +        uint32_t bor_lev : 2;
> +        uint32_t reserved0 : 1;
> +        uint32_t wdg_sw : 1;
> +        uint32_t nrst_stop : 1;
> +        uint32_t nrst_stdby : 1;
> +        uint32_t rdp : 8;
> +        uint32_t nwrp : 12;
> +        uint32_t reserved1 : 4;
> +    };
> +    uint32_t reg;
> +} FlashOptcrType;
> +
> +typedef struct {
> +    /* <private> */
> +    SysBusDevice parent_obj;
> +
> +    /* <public> */
> +    MemoryRegion mmio;
> +
> +    int32_t cr_key_index;
> +    int32_t optcr_key_index;
> +
> +    /* Access control register (FLASH_ACR) */
> +    FlashAcrType flash_acr;
> +    /* Key register (FLASH_KEYR) */
> +    FlashKeyrType flash_keyr;
> +    /* Option key register (FLASH_OPTKEYR) */
> +    FlashOptkeyrType flash_optkeyr;
> +    /* Status register (FLASH_SR) */
> +    FlashSrType flash_sr;
> +    /* Control register (FLASH_CR) */
> +    FlashCrType flash_cr;
> +    /* Option control register (FLASH_OPTCR) */
> +    FlashOptcrType flash_optcr;
> +} STM32F4xxFlashIfState;
> +
> +#endif
> --
> 2.17.1
>
>

