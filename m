Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FA4C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABBD32081C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvyYrSzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBD32081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49646 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVXt-0007yh-Mf
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:23:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLV08-0004JK-Ni
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLV07-0005kF-IC
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:49:00 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:32825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLV07-0005ja-Bh
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:48:59 -0400
Received: by mail-oi1-x244.google.com with SMTP id l1so9789694oib.0
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 08:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=whpXleuULA2tEcHmo7/VDawTgrO7jOewkTpvlTF4ub0=;
	b=UvyYrSzXWv1Vswsuxehsd2gtyWFYyI/cJ2AlkLs+3ZrpDvLYiektREGISm/YRIulRt
	/Fkd8QNBGKUOXrPiW1r4sLVEJ+G61wXA3xDxuSTAb+qj6brBq/vkuXK+OfjEH/1RNeSt
	Ad1ojMuDsgnFbomiFK4rysxWeY2heeCLwfi8RTOO8nyJ+28uDvLMDggfdcKZKXrQU9G+
	hho3fI8PHlegnRnCZc2F1shlT0zpmYqJaS3trnFXrhEA6Y6B3a0iv5pmzoQdV6c2UFJf
	gU/ro5g3u7jDtMmcJE7/aby+FQ0UMZVRkAbLPQmkUJPVhR4u+r8QYs28UXyyX+MtwEXS
	U7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=whpXleuULA2tEcHmo7/VDawTgrO7jOewkTpvlTF4ub0=;
	b=SI0BaZPQDu5FNpvZmsHwa2c9GBz1s98whn93Rhrbp5bjOHTihSK1CMR8zMZJXffbSr
	hxjolE7+VF1fgqXQjnKsQuVnSDXy5rvO496PegPFP7v24eCzv4mvOeabdmQyxYCFX0yA
	WcrQbldj4t5K3nynsC28xBxAq5RXYCvZbDkfxT0GHBurr2M+0kWptIj0/2kLNYBW92/M
	YXPeN9MtjYeXemNQual7JL1Agu2d2+cW2eP4PF7ow0tSjSDdkLnruiqEuYXCfnbxm8aA
	d+N5qVR0T9pz3fWMw22diFddQNcW5qyHTXt+04bD3oG0PNsnq7ocH2KRrudYmFEQibNk
	pE/w==
X-Gm-Message-State: APjAAAVUdJMs7CyYuap04xprbOm3ScYJG9ohujt/3D4U9dUTQ9lUjrtr
	HJJS3Wh90osam3K93AtR8ECYcEpESJ2GiYBzW+Ltmw==
X-Google-Smtp-Source: APXvYqzGQa4xaGuXvHMaOTMR1KkGxTgDvhIS/Nzy8ntZPYff7S0KNXx8DWpWOAoyoCjIuK7Kz1bbYBRzSf5NxBIQcxI=
X-Received: by 2002:aca:4b04:: with SMTP id y4mr3290920oia.170.1556639338089; 
	Tue, 30 Apr 2019 08:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556515687.git.alistair@alistair23.me>
	<PSXP216MB0277D0653D098FF32C5DC07DDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0277D0653D098FF32C5DC07DDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 16:48:47 +0100
Message-ID:
 <CAFEAcA_T7-+de9=V=hnku9f0BXdpLfz6wLFFZYp9LyYDx2KLCw@mail.gmail.com>
To: Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v1 3/5] hw/misc: Add the STM32F4xx EXTI
 device
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
Message-ID: <20190430154847.GHTJUEyLxSooL1ERTt5QlV2w9Ouz9wElTLfaB4To8zo@z>

On Mon, 29 Apr 2019 at 06:37, Alistair Francis <alistair@alistair23.me> wrote:
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  default-configs/arm-softmmu.mak  |   1 +
>  hw/misc/Kconfig                  |   3 +
>  hw/misc/Makefile.objs            |   1 +
>  hw/misc/stm32f4xx_exti.c         | 175 +++++++++++++++++++++++++++++++
>  include/hw/misc/stm32f4xx_exti.h |  57 ++++++++++
>  5 files changed, 237 insertions(+)
>  create mode 100644 hw/misc/stm32f4xx_exti.c
>  create mode 100644 include/hw/misc/stm32f4xx_exti.h

Minor comments here only.

(If Thomas's kconfig patchset gets into master before this
there might be some minor fixups required to the kconfig
stuff, but it shouldn't be too hard to adapt.)

> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "qemu/log.h"
> +#include "hw/misc/stm32f4xx_exti.h"
> +
> +#ifndef STM_EXTI_ERR_DEBUG
> +#define STM_EXTI_ERR_DEBUG 0
> +#endif
> +
> +#define DB_PRINT_L(lvl, fmt, args...) do { \
> +    if (STM_EXTI_ERR_DEBUG >= lvl) { \
> +        qemu_log("%s: " fmt, __func__, ## args); \
> +    } \
> +} while (0)
> +
> +#define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)

Could we use a tracepoint instead?

> +
> +#define NUM_GPIO_EVENT_IN_LINES 16
> +#define NUM_INTERRUPT_OUT_LINES 16
> +
> +static void stm32f4xx_exti_reset(DeviceState *dev)
> +{
> +    STM32F4xxExtiState *s = STM32F4XX_EXTI(dev);
> +
> +    s->exti_imr = 0x00000000;
> +    s->exti_emr = 0x00000000;
> +    s->exti_rtsr = 0x00000000;
> +    s->exti_ftsr = 0x00000000;
> +    s->exti_swier = 0x00000000;
> +    s->exti_pr = 0x00000000;
> +}
> +
> +static void stm32f4xx_exti_set_irq(void *opaque, int irq, int level)
> +{
> +    STM32F4xxExtiState *s = opaque;
> +
> +    DB_PRINT("Set EXTI: %d to %d\n", irq, level);
> +
> +    if (level) {
> +        qemu_irq_pulse(s->irq[irq]);
> +        s->exti_pr |= 1 << irq;
> +    }
> +}

Just to check -- this should definitely be a pulse? I'm always
a little bit wary of uses of qemu_irq_pulse(), though some
hardware does pulse IRQ lines rather than holding them until
dismissed.

> +static void stm32f4xx_exti_init(Object *obj)
> +{
> +    STM32F4xxExtiState *s = STM32F4XX_EXTI(obj);
> +    int i;
> +
> +    s->irq = g_new0(qemu_irq, NUM_INTERRUPT_OUT_LINES);

You could just have the array be inline in the
STM32F4xxExtiState rather than allocating it separately,
right?

> +    for (i = 0; i < NUM_INTERRUPT_OUT_LINES; i++) {
> +        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[i]);
> +    }
> +
> +    memory_region_init_io(&s->mmio, obj, &stm32f4xx_exti_ops, s,
> +                          TYPE_STM32F4XX_EXTI, 0x400);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +
> +    qdev_init_gpio_in(DEVICE(obj), stm32f4xx_exti_set_irq,
> +                      NUM_GPIO_EVENT_IN_LINES);
> +}
> +
> +static void stm32f4xx_exti_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = stm32f4xx_exti_reset;

This one's missing vmstate too.

> +}
> +
> +static const TypeInfo stm32f4xx_exti_info = {
> +    .name          = TYPE_STM32F4XX_EXTI,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(STM32F4xxExtiState),
> +    .instance_init = stm32f4xx_exti_init,
> +    .class_init    = stm32f4xx_exti_class_init,
> +};
> +
> +static void stm32f4xx_exti_register_types(void)
> +{
> +    type_register_static(&stm32f4xx_exti_info);
> +}
> +

thanks
-- PMM

