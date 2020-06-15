Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9EBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F9F207DD
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWyl8BBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F9F207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkrwn-0004sm-0r
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jkrvd-0003dh-G9; Mon, 15 Jun 2020 12:25:45 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:35287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jkrvb-0005ri-K5; Mon, 15 Jun 2020 12:25:45 -0400
Received: by mail-il1-x141.google.com with SMTP id l6so15916144ilo.2;
 Mon, 15 Jun 2020 09:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dQ5LoBJa98wS90Nxh809A9yRdP+gFz2r5u+kWj+K9M8=;
 b=BWyl8BBngJ8Ry47KgF5VZPni6B21QUjdJ/fo3xeKTvNMQ/WGZUM8K2zvmBCkMZF920
 knlVoAPoL81vsJsFqQmGZEyfHWi/ND7Q19VtOxpIDjfXVDbdz3KHeH8kLNjKHW49Yq8o
 F64L7/yCxOB0xlHFErqFQWz1qz5sSJz+Fk23Ind2fqgy5VH2sfsjwM2SoyggbTccEk+U
 4EADLAnot88CDZD8zmfAZyR2F/TYxyt5UDyqk1Nrb/m8uD71Cd5MLja4GNSbwcb7yoGG
 4JdlAd+Zxf67ZSxwH1RDraS5CZ0Uq0nq5+js17PhbGKVuBBfMs4sgTh7p0xJ3JDfSQrB
 RSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dQ5LoBJa98wS90Nxh809A9yRdP+gFz2r5u+kWj+K9M8=;
 b=lCzk8Ey1e21Kr32RHnGZ5iwwcdVy3u9zWgMp5eaH4gNZO0UpjM6u1LE/fN+pfHkq+Q
 MBDRwZatvQQivunHKp9wj4Pw6mJ7wlyi21UG2JiSPn2wj0DTvD2rVDmwMxagkhcI04Ho
 OsfVJIF/OrX6vFGURK8WvLhFPgiqPYKrDRPUb8DWm+Z0tP3MxQXSccBVw0AT/DIE3GIE
 3ebcBHcALW77hrsa4KC0ls4TUTFqDPTVvGzFu6U9gck+R7nfKj+DqD4r2SSZLrtqRHAi
 uDkiRItUt/UCsP2BDtJbjFcvXumn7aQiz57zJHcO7M9AKh5+VYKhnzrBdz6gF4fDS+2P
 hd6Q==
X-Gm-Message-State: AOAM531hYdJXGBTkn7GEXIXvO4p90RHquV0mLypo39OSf+DxHV4evl7Y
 yTNm94EAGgRsgGWgqeSq8KCtqMgt1yQyOUDI2ag=
X-Google-Smtp-Source: ABdhPJxITfSUlRNk80cq2efY+iqSaunDdfDZ98JoN20EIkBp1NXxSU1K1WY9EAG6jpb1MbsdKIu7C6PNFRflIULq9Bs=
X-Received: by 2002:a92:bb45:: with SMTP id w66mr27913427ili.131.1592238342153; 
 Mon, 15 Jun 2020 09:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
 <1591625864-31494-7-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1591625864-31494-7-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2020 09:16:19 -0700
Message-ID: <CAKmqyKOtfnWEABV92Ovj6wWwKwrMq0uTA797VJp7wp3ojkxgbw@mail.gmail.com>
Subject: Re: [PATCH 06/15] hw/riscv: sifive_gpio: Add a new 'ngpio' property
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
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

On Mon, Jun 8, 2020 at 7:22 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Add a new property to represent the number of GPIO pins supported
> by the GPIO controller.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/sifive_gpio.c         | 30 +++++++++++++++++++-----------
>  include/hw/riscv/sifive_gpio.h |  3 +++
>  2 files changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/hw/riscv/sifive_gpio.c b/hw/riscv/sifive_gpio.c
> index c9cffa2..0d0fd2b 100644
> --- a/hw/riscv/sifive_gpio.c
> +++ b/hw/riscv/sifive_gpio.c
> @@ -14,6 +14,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
>  #include "hw/irq.h"
> +#include "hw/qdev-properties.h"
>  #include "hw/riscv/sifive_gpio.h"
>  #include "migration/vmstate.h"
>  #include "trace.h"
> @@ -28,7 +29,7 @@ static void update_output_irq(SIFIVEGPIOState *s)
>      pending |= s->rise_ip & s->rise_ie;
>      pending |= s->fall_ip & s->fall_ie;
>
> -    for (int i = 0; i < SIFIVE_GPIO_PINS; i++) {
> +    for (int i = 0; i < s->ngpio; i++) {
>          pin = 1 << i;
>          qemu_set_irq(s->irq[i], (pending & pin) != 0);
>          trace_sifive_gpio_update_output_irq(i, (pending & pin) != 0);
> @@ -41,7 +42,7 @@ static void update_state(SIFIVEGPIOState *s)
>      bool prev_ival, in, in_mask, port, out_xor, pull, output_en, input_en,
>          rise_ip, fall_ip, low_ip, high_ip, oval, actual_value, ival;
>
> -    for (i = 0; i < SIFIVE_GPIO_PINS; i++) {
> +    for (i = 0; i < s->ngpio; i++) {
>
>          prev_ival = extract32(s->value, i, 1);
>          in        = extract32(s->in, i, 1);
> @@ -346,27 +347,35 @@ static const VMStateDescription vmstate_sifive_gpio = {
>      }
>  };
>
> -static void sifive_gpio_init(Object *obj)
> +static Property sifive_gpio_properties[] = {
> +    DEFINE_PROP_UINT32("ngpio", SIFIVEGPIOState, ngpio, SIFIVE_GPIO_PINS),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void sifive_gpio_realize(DeviceState *dev, Error **errp)
>  {
> -    SIFIVEGPIOState *s = SIFIVE_GPIO(obj);
> +    SIFIVEGPIOState *s = SIFIVE_GPIO(dev);
>
> -    memory_region_init_io(&s->mmio, obj, &gpio_ops, s,
> +    memory_region_init_io(&s->mmio, OBJECT(dev), &gpio_ops, s,
>              TYPE_SIFIVE_GPIO, SIFIVE_GPIO_SIZE);
> -    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>
> -    for (int i = 0; i < SIFIVE_GPIO_PINS; i++) {
> -        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[i]);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
> +
> +    for (int i = 0; i < s->ngpio; i++) {
> +        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
>      }
>
> -    qdev_init_gpio_in(DEVICE(s), sifive_gpio_set, SIFIVE_GPIO_PINS);
> -    qdev_init_gpio_out(DEVICE(s), s->output, SIFIVE_GPIO_PINS);
> +    qdev_init_gpio_in(DEVICE(s), sifive_gpio_set, s->ngpio);
> +    qdev_init_gpio_out(DEVICE(s), s->output, s->ngpio);
>  }
>
>  static void sifive_gpio_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>
> +    device_class_set_props(dc, sifive_gpio_properties);
>      dc->vmsd = &vmstate_sifive_gpio;
> +    dc->realize = sifive_gpio_realize;
>      dc->reset = sifive_gpio_reset;
>      dc->desc = "SiFive GPIO";
>  }
> @@ -375,7 +384,6 @@ static const TypeInfo sifive_gpio_info = {
>      .name = TYPE_SIFIVE_GPIO,
>      .parent = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(SIFIVEGPIOState),
> -    .instance_init = sifive_gpio_init,
>      .class_init = sifive_gpio_class_init
>  };
>
> diff --git a/include/hw/riscv/sifive_gpio.h b/include/hw/riscv/sifive_gpio.h
> index ad915b2..cf12fcf 100644
> --- a/include/hw/riscv/sifive_gpio.h
> +++ b/include/hw/riscv/sifive_gpio.h
> @@ -68,6 +68,9 @@ typedef struct SIFIVEGPIOState {
>      uint32_t out_xor;
>      uint32_t in;
>      uint32_t in_mask;
> +
> +    /* config */
> +    uint32_t ngpio;
>  } SIFIVEGPIOState;
>
>  #endif /* SIFIVE_GPIO_H */
> --
> 2.7.4
>
>

