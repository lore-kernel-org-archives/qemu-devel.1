Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7621C41604
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FEF2067B
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKUgRI7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FEF2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOl2p-0001Hk-2q
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 13:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>) id 1kOl1r-0000qu-NH
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:09:03 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:45521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>) id 1kOl1o-0007nD-TZ
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:09:03 -0400
Received: by mail-qt1-x843.google.com with SMTP id 10so5609435qtx.12
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 10:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ilIT2A6KDytNUQYId5lOPmZOyrq+B/OUqe4NuRLCB18=;
 b=uKUgRI7Ok8Vupq9BgRpAV5rXmIonwBAyxi13nCZAv9H0faAzCZyzmOtDzBpodmFSYA
 TMvwEdhjlSuNcurxDhCThoY4CihTtqLmtdYOmXVmABiZPLV7udFustykZpwRc73WSpRa
 aZ+pnSLcgcF1cmpQbQ1E/mKILCxKpg51q3WmUVv891vnXGPJXSy5JyMZyYMYORbZAPDH
 iXRIEjVfdXBmegcWMYlutg3+2X22Gcw/yrzNjHKyKETLv1v0dFDtHYYBfE3Ft+7hW622
 cLN3PBYToyESO0BpEeP2iwsXImLmUS/SVC//YQXGlintKKuXAtyks1D3tl0e7xbBZq5/
 P2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ilIT2A6KDytNUQYId5lOPmZOyrq+B/OUqe4NuRLCB18=;
 b=FM9iKLfd9W1iy0UgSMBthoT2iEtZbUCMdz7xN+BzfXNxjo1mqG6hITqleIqSNALFRd
 7p4WThhQR45EFVVHrWA4FrAPng5XbVy9IhD+de7RB11MG2SnL2m/FO0OdrZDhamHVytB
 sMcYKdwJlmTxl999PMNKDQIjInCiJ+dwrcqOZdHgrXii/qnxE7x9bSPkXL6aHizu3qRf
 zE8YttbPfwfaBlXnK0FUJERrYXv4x5I3OmrV8nLAl5Q3VA3QNHbDBZKLMclQ/x+od4hp
 +ArsgwmxtibHWrqGGYdNfvIaBPYSKG/w+pXtugad7JbET9CrYIwvDP5j5Dje/UKsk/sk
 0hKQ==
X-Gm-Message-State: AOAM530E0/6Nr7imo87dDFfLEp0fxkSl8mW/vjwKWIqbi5z8CkjJqXEV
 PSFu2f1JjAadlKWBiqH21p6n9Ne74bBX8tW6fDc=
X-Google-Smtp-Source: ABdhPJxjRP7VesQNxMK/fbbJKEQ15/WxW72aeUmVJ6IYhWUpbCAz7viMG6VFnwAeH/dRPkxBfiuw8/ibh9ikWQoqExM=
X-Received: by 2002:ac8:7281:: with SMTP id v1mr7132613qto.229.1601744939444; 
 Sat, 03 Oct 2020 10:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR16MB2473C5A77E009CA2FEF3D8ECE60E0@DM6PR16MB2473.namprd16.prod.outlook.com>
In-Reply-To: <DM6PR16MB2473C5A77E009CA2FEF3D8ECE60E0@DM6PR16MB2473.namprd16.prod.outlook.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Sat, 3 Oct 2020 20:08:23 +0300
Message-ID: <CAK4993iaxbABCnc++axP3gnLDwAp7iEkWcKKD4HT6F4L3PArxg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/avr: Add limited support for avr gpio registers
To: Heecheol Yang <heecheol.yang@outlook.com>
Content-Type: multipart/alternative; boundary="00000000000022efd105b0c74ec0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=mrolnik@gmail.com; helo=mail-qt1-x843.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000022efd105b0c74ec0
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 3, 2020 at 3:39 PM Heecheol Yang <heecheol.yang@outlook.com>
wrote:

> Add some of these features for avr gpio:
>
>   - GPIO I/O : PORTx registers
>   - Data Direction : DDRx registers
>
> Following things are not supported yet:
>   - PINx registers
>   - MCUR registers
>   - Even though read/write for DDRx registers are
>     implemented, actual direction controls are not
>     supported yet.
>
> Signed-off-by: Heecheol Yang <heecheol.yang@outlook.com>
> ---
>  hw/avr/Kconfig             |   1 +
>  hw/avr/atmega.c            |   7 ++-
>  hw/avr/atmega.h            |   2 +
>  hw/gpio/Kconfig            |   3 +
>  hw/gpio/avr_gpio.c         | 112 +++++++++++++++++++++++++++++++++++++
>  hw/gpio/meson.build        |   2 +
>  include/hw/gpio/avr_gpio.h |  46 +++++++++++++++
>  7 files changed, 171 insertions(+), 2 deletions(-)
>  create mode 100644 hw/gpio/avr_gpio.c
>  create mode 100644 include/hw/gpio/avr_gpio.h
>
> diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
> index d31298c3cc..16a57ced11 100644
> --- a/hw/avr/Kconfig
> +++ b/hw/avr/Kconfig
> @@ -3,6 +3,7 @@ config AVR_ATMEGA_MCU
>      select AVR_TIMER16
>      select AVR_USART
>      select AVR_POWER
> +    select AVR_GPIO
>
>  config ARDUINO
>      select AVR_ATMEGA_MCU
> diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
> index 44c6afebbb..ad942028fd 100644
> --- a/hw/avr/atmega.c
> +++ b/hw/avr/atmega.c
> @@ -283,8 +283,11 @@ static void atmega_realize(DeviceState *dev, Error
> **errp)
>              continue;
>          }
>          devname = g_strdup_printf("atmega-gpio-%c", 'a' + (char)i);
> -        create_unimplemented_device(devname,
> -                                    OFFSET_DATA + mc->dev[idx].addr, 3);
> +        object_initialize_child(OBJECT(dev), devname, &s->gpio[i],
> +                                TYPE_AVR_GPIO);
> +        sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &error_abort);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0,
> +            OFFSET_DATA + mc->dev[idx].addr);
>          g_free(devname);
>      }
>
> diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h
> index a99ee15c7e..e2289d5744 100644
> --- a/hw/avr/atmega.h
> +++ b/hw/avr/atmega.h
> @@ -13,6 +13,7 @@
>
>  #include "hw/char/avr_usart.h"
>  #include "hw/timer/avr_timer16.h"
> +#include "hw/gpio/avr_gpio.h"
>  #include "hw/misc/avr_power.h"
>  #include "target/avr/cpu.h"
>  #include "qom/object.h"
> @@ -44,6 +45,7 @@ struct AtmegaMcuState {
>      DeviceState *io;
>      AVRMaskState pwr[POWER_MAX];
>      AVRUsartState usart[USART_MAX];
> +    AVRGPIOState gpio[GPIO_MAX];
>      AVRTimer16State timer[TIMER_MAX];
>      uint64_t xtal_freq_hz;
>  };
> diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
> index b6fdaa2586..1752d0ce56 100644
> --- a/hw/gpio/Kconfig
> +++ b/hw/gpio/Kconfig
> @@ -10,3 +10,6 @@ config GPIO_KEY
>
>  config SIFIVE_GPIO
>      bool
> +
> +config AVR_GPIO
> +    bool
> diff --git a/hw/gpio/avr_gpio.c b/hw/gpio/avr_gpio.c
> new file mode 100644
> index 0000000000..6ca8e8703a
> --- /dev/null
> +++ b/hw/gpio/avr_gpio.c
> @@ -0,0 +1,112 @@
> +/*
> + * AVR processors GPIO registers emulation.
> + *
> + * Copyright (C) 2020 Heecheol Yang <heecheol.yang@outlook.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "hw/sysbus.h"
> +#include "hw/irq.h"
> +#include "hw/gpio/avr_gpio.h"
> +#include "hw/qdev-properties.h"
> +
> +static void avr_gpio_reset(DeviceState *dev)
> +{
> +    AVRGPIOState *gpio = AVR_GPIO(dev);
> +    gpio->ddr_val = 0u;
> +    gpio->port_val = 0u;
> +}
> +static uint64_t avr_gpio_read(void *opaque, hwaddr offset, unsigned int
> size)
> +{
> +    AVRGPIOState *s = (AVRGPIOState *)opaque;
> +    switch (offset) {
> +    case GPIO_PIN:
> +        /* Not implemented yet */
> +        break;
> +    case GPIO_DDR:
> +        return s->ddr_val;
>
Why do you need `break` after `return` ?

> +        break;
> +    case GPIO_PORT:
> +        return s->port_val;
> +    default:
> +        g_assert_not_reached();
> +        break;
> +    }
> +    return 0;
> +}
> +
> +static void avr_gpio_write(void *opaque, hwaddr offset, uint64_t value,
> +                                unsigned int size)
> +{
> +    AVRGPIOState *s = (AVRGPIOState *)opaque;
> +    switch (offset) {
> +    case GPIO_PIN:
> +        /* Not implemented yet */
> +        break;
> +    case GPIO_DDR:
> +        s->ddr_val = value & 0xF;
> +        break;
> +    case GPIO_PORT:
> +        s->port_val = value & 0xF;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps avr_gpio_ops = {
> +    .read = avr_gpio_read,
> +    .write = avr_gpio_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void avr_gpio_init(Object *obj)
> +{
> +    AVRGPIOState *s = AVR_GPIO(obj);
> +    memory_region_init_io(&s->mmio, obj, &avr_gpio_ops, s, TYPE_AVR_GPIO,
> 3);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +}
> +static void avr_gpio_realize(DeviceState *dev, Error **errp)
> +{
> +    avr_gpio_reset(dev);
> +}
> +
> +
> +static void avr_gpio_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = avr_gpio_reset;
> +    dc->realize = avr_gpio_realize;
> +}
> +
> +static const TypeInfo avr_gpio_info = {
> +    .name          = TYPE_AVR_GPIO,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(AVRGPIOState),
> +    .instance_init = avr_gpio_init,
> +    .class_init    = avr_gpio_class_init,
> +};
> +
> +static void avr_gpio_register_types(void)
> +{
> +    type_register_static(&avr_gpio_info);
> +}
> +
> +type_init(avr_gpio_register_types)
> diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
> index 86cae9a0f3..258bd5dcfc 100644
> --- a/hw/gpio/meson.build
> +++ b/hw/gpio/meson.build
> @@ -11,3 +11,5 @@ softmmu_ss.add(when: 'CONFIG_OMAP', if_true:
> files('omap_gpio.c'))
>  softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
>  softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
>  softmmu_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true:
> files('sifive_gpio.c'))
> +
> +softmmu_ss.add(when: 'CONFIG_AVR_GPIO', if_true: files('avr_gpio.c'))
> diff --git a/include/hw/gpio/avr_gpio.h b/include/hw/gpio/avr_gpio.h
> new file mode 100644
> index 0000000000..84d783f8fc
> --- /dev/null
> +++ b/include/hw/gpio/avr_gpio.h
> @@ -0,0 +1,46 @@
> +/*
> + * AVR processors GPIO registers definition.
> + *
> + * Copyright (C) 2020 Heecheol Yang <heecheol.yang@outlook.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef AVR_GPIO_H
> +#define AVR_GPIO_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +
> +/* Offsets of registers. */
> +#define GPIO_PIN   0x00
> +#define GPIO_DDR   0x01
> +#define GPIO_PORT  0x02
> +
> +#define TYPE_AVR_GPIO "avr-gpio"
> +OBJECT_DECLARE_SIMPLE_TYPE(AVRGPIOState, AVR_GPIO)
> +
> +struct AVRGPIOState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    MemoryRegion mmio;
> +
> +    uint8_t ddr_val;
> +    uint8_t port_val;
> +
> +};
> +
> +#endif /* AVR_GPIO_H */
> --
> 2.17.1
>
>

-- 
Best Regards,
Michael Rolnik

--00000000000022efd105b0c74ec0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Oct 3, 2020 at 3:39 PM Heeche=
ol Yang &lt;<a href=3D"mailto:heecheol.yang@outlook.com">heecheol.yang@outl=
ook.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Add some of these features for avr gpio:<br>
<br>
=C2=A0 - GPIO I/O : PORTx registers<br>
=C2=A0 - Data Direction : DDRx registers<br>
<br>
Following things are not supported yet:<br>
=C2=A0 - PINx registers<br>
=C2=A0 - MCUR registers<br>
=C2=A0 - Even though read/write for DDRx registers are<br>
=C2=A0 =C2=A0 implemented, actual direction controls are not<br>
=C2=A0 =C2=A0 supported yet.<br>
<br>
Signed-off-by: Heecheol Yang &lt;<a href=3D"mailto:heecheol.yang@outlook.co=
m" target=3D"_blank">heecheol.yang@outlook.com</a>&gt;<br>
---<br>
=C2=A0hw/avr/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A01 +<br>
=C2=A0hw/avr/atmega.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A07 ++-<br>
=C2=A0hw/avr/atmega.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A02 +<br>
=C2=A0hw/gpio/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A03 +<br>
=C2=A0hw/gpio/avr_gpio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 112 +++++++++++=
++++++++++++++++++++++++++<br>
=C2=A0hw/gpio/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0include/hw/gpio/avr_gpio.h |=C2=A0 46 +++++++++++++++<br>
=C2=A07 files changed, 171 insertions(+), 2 deletions(-)<br>
=C2=A0create mode 100644 hw/gpio/avr_gpio.c<br>
=C2=A0create mode 100644 include/hw/gpio/avr_gpio.h<br>
<br>
diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig<br>
index d31298c3cc..16a57ced11 100644<br>
--- a/hw/avr/Kconfig<br>
+++ b/hw/avr/Kconfig<br>
@@ -3,6 +3,7 @@ config AVR_ATMEGA_MCU<br>
=C2=A0 =C2=A0 =C2=A0select AVR_TIMER16<br>
=C2=A0 =C2=A0 =C2=A0select AVR_USART<br>
=C2=A0 =C2=A0 =C2=A0select AVR_POWER<br>
+=C2=A0 =C2=A0 select AVR_GPIO<br>
<br>
=C2=A0config ARDUINO<br>
=C2=A0 =C2=A0 =C2=A0select AVR_ATMEGA_MCU<br>
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c<br>
index 44c6afebbb..ad942028fd 100644<br>
--- a/hw/avr/atmega.c<br>
+++ b/hw/avr/atmega.c<br>
@@ -283,8 +283,11 @@ static void atmega_realize(DeviceState *dev, Error **e=
rrp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0devname =3D g_strdup_printf(&quot;atmega-=
gpio-%c&quot;, &#39;a&#39; + (char)i);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 create_unimplemented_device(devname,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + mc-&gt;d=
ev[idx].addr, 3);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_initialize_child(OBJECT(dev), devname, =
&amp;s-&gt;gpio[i],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_AVR_GPIO);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;gpio[=
i]), &amp;error_abort);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gpio=
[i]), 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + mc-&gt;dev[idx].ad=
dr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(devname);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h<br>
index a99ee15c7e..e2289d5744 100644<br>
--- a/hw/avr/atmega.h<br>
+++ b/hw/avr/atmega.h<br>
@@ -13,6 +13,7 @@<br>
<br>
=C2=A0#include &quot;hw/char/avr_usart.h&quot;<br>
=C2=A0#include &quot;hw/timer/avr_timer16.h&quot;<br>
+#include &quot;hw/gpio/avr_gpio.h&quot;<br>
=C2=A0#include &quot;hw/misc/avr_power.h&quot;<br>
=C2=A0#include &quot;target/avr/cpu.h&quot;<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
@@ -44,6 +45,7 @@ struct AtmegaMcuState {<br>
=C2=A0 =C2=A0 =C2=A0DeviceState *io;<br>
=C2=A0 =C2=A0 =C2=A0AVRMaskState pwr[POWER_MAX];<br>
=C2=A0 =C2=A0 =C2=A0AVRUsartState usart[USART_MAX];<br>
+=C2=A0 =C2=A0 AVRGPIOState gpio[GPIO_MAX];<br>
=C2=A0 =C2=A0 =C2=A0AVRTimer16State timer[TIMER_MAX];<br>
=C2=A0 =C2=A0 =C2=A0uint64_t xtal_freq_hz;<br>
=C2=A0};<br>
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig<br>
index b6fdaa2586..1752d0ce56 100644<br>
--- a/hw/gpio/Kconfig<br>
+++ b/hw/gpio/Kconfig<br>
@@ -10,3 +10,6 @@ config GPIO_KEY<br>
<br>
=C2=A0config SIFIVE_GPIO<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
+<br>
+config AVR_GPIO<br>
+=C2=A0 =C2=A0 bool<br>
diff --git a/hw/gpio/avr_gpio.c b/hw/gpio/avr_gpio.c<br>
new file mode 100644<br>
index 0000000000..6ca8e8703a<br>
--- /dev/null<br>
+++ b/hw/gpio/avr_gpio.c<br>
@@ -0,0 +1,112 @@<br>
+/*<br>
+ * AVR processors GPIO registers emulation.<br>
+ *<br>
+ * Copyright (C) 2020 Heecheol Yang &lt;<a href=3D"mailto:heecheol.yang@ou=
tlook.com" target=3D"_blank">heecheol.yang@outlook.com</a>&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU General Public License as<br>
+ * published by the Free Software Foundation; either version 2 or<br>
+ * (at your option) version 3 of the License.<br>
+ *<br>
+ * This program is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the<br>
+ * GNU General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License along=
<br>
+ * with this program; if not, see &lt;<a href=3D"http://www.gnu.org/licens=
es/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/licenses/</a>&=
gt;.<br>
+ */<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/log.h&quot;<br>
+#include &quot;qemu/module.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;hw/irq.h&quot;<br>
+#include &quot;hw/gpio/avr_gpio.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
+<br>
+static void avr_gpio_reset(DeviceState *dev)<br>
+{<br>
+=C2=A0 =C2=A0 AVRGPIOState *gpio =3D AVR_GPIO(dev);<br>
+=C2=A0 =C2=A0 gpio-&gt;ddr_val =3D 0u;<br>
+=C2=A0 =C2=A0 gpio-&gt;port_val =3D 0u;<br>
+}<br>
+static uint64_t avr_gpio_read(void *opaque, hwaddr offset, unsigned int si=
ze)<br>
+{<br>
+=C2=A0 =C2=A0 AVRGPIOState *s =3D (AVRGPIOState *)opaque;<br>
+=C2=A0 =C2=A0 switch (offset) {<br>
+=C2=A0 =C2=A0 case GPIO_PIN:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Not implemented yet */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case GPIO_DDR:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return s-&gt;ddr_val;<br></blockquote><div>Why=
 do you need `break` after `return` ?=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case GPIO_PORT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return s-&gt;port_val;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static void avr_gpio_write(void *opaque, hwaddr offset, uint64_t value,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int size)<br>
+{<br>
+=C2=A0 =C2=A0 AVRGPIOState *s =3D (AVRGPIOState *)opaque;<br>
+=C2=A0 =C2=A0 switch (offset) {<br>
+=C2=A0 =C2=A0 case GPIO_PIN:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Not implemented yet */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case GPIO_DDR:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;ddr_val =3D value &amp; 0xF;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case GPIO_PORT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;port_val =3D value &amp; 0xF;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static const MemoryRegionOps avr_gpio_ops =3D {<br>
+=C2=A0 =C2=A0 .read =3D avr_gpio_read,<br>
+=C2=A0 =C2=A0 .write =3D avr_gpio_write,<br>
+=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
+};<br>
+<br>
+static void avr_gpio_init(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRGPIOState *s =3D AVR_GPIO(obj);<br>
+=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;mmio, obj, &amp;avr_gpio_op=
s, s, TYPE_AVR_GPIO, 3);<br>
+=C2=A0 =C2=A0 sysbus_init_mmio(SYS_BUS_DEVICE(obj), &amp;s-&gt;mmio);<br>
+}<br>
+static void avr_gpio_realize(DeviceState *dev, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 avr_gpio_reset(dev);<br>
+}<br>
+<br>
+<br>
+static void avr_gpio_class_init(ObjectClass *klass, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
+<br>
+=C2=A0 =C2=A0 dc-&gt;reset =3D avr_gpio_reset;<br>
+=C2=A0 =C2=A0 dc-&gt;realize =3D avr_gpio_realize;<br>
+}<br>
+<br>
+static const TypeInfo avr_gpio_info =3D {<br>
+=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AVR_GPIO,<b=
r>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEVICE,<=
br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(AVRGPIOState),<br>
+=C2=A0 =C2=A0 .instance_init =3D avr_gpio_init,<br>
+=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D avr_gpio_class_init,<br>
+};<br>
+<br>
+static void avr_gpio_register_types(void)<br>
+{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;avr_gpio_info);<br>
+}<br>
+<br>
+type_init(avr_gpio_register_types)<br>
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build<br>
index 86cae9a0f3..258bd5dcfc 100644<br>
--- a/hw/gpio/meson.build<br>
+++ b/hw/gpio/meson.build<br>
@@ -11,3 +11,5 @@ softmmu_ss.add(when: &#39;CONFIG_OMAP&#39;, if_true: file=
s(&#39;omap_gpio.c&#39;))<br>
=C2=A0softmmu_ss.add(when: &#39;CONFIG_RASPI&#39;, if_true: files(&#39;bcm2=
835_gpio.c&#39;))<br>
=C2=A0softmmu_ss.add(when: &#39;CONFIG_ASPEED_SOC&#39;, if_true: files(&#39=
;aspeed_gpio.c&#39;))<br>
=C2=A0softmmu_ss.add(when: &#39;CONFIG_SIFIVE_GPIO&#39;, if_true: files(&#3=
9;sifive_gpio.c&#39;))<br>
+<br>
+softmmu_ss.add(when: &#39;CONFIG_AVR_GPIO&#39;, if_true: files(&#39;avr_gp=
io.c&#39;))<br>
diff --git a/include/hw/gpio/avr_gpio.h b/include/hw/gpio/avr_gpio.h<br>
new file mode 100644<br>
index 0000000000..84d783f8fc<br>
--- /dev/null<br>
+++ b/include/hw/gpio/avr_gpio.h<br>
@@ -0,0 +1,46 @@<br>
+/*<br>
+ * AVR processors GPIO registers definition.<br>
+ *<br>
+ * Copyright (C) 2020 Heecheol Yang &lt;<a href=3D"mailto:heecheol.yang@ou=
tlook.com" target=3D"_blank">heecheol.yang@outlook.com</a>&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU General Public License as<br>
+ * published by the Free Software Foundation; either version 2 or<br>
+ * (at your option) version 3 of the License.<br>
+ *<br>
+ * This program is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the<br>
+ * GNU General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License along=
<br>
+ * with this program; if not, see &lt;<a href=3D"http://www.gnu.org/licens=
es/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/licenses/</a>&=
gt;.<br>
+ */<br>
+<br>
+#ifndef AVR_GPIO_H<br>
+#define AVR_GPIO_H<br>
+<br>
+#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;qom/object.h&quot;<br>
+<br>
+/* Offsets of registers. */<br>
+#define GPIO_PIN=C2=A0 =C2=A00x00<br>
+#define GPIO_DDR=C2=A0 =C2=A00x01<br>
+#define GPIO_PORT=C2=A0 0x02<br>
+<br>
+#define TYPE_AVR_GPIO &quot;avr-gpio&quot;<br>
+OBJECT_DECLARE_SIMPLE_TYPE(AVRGPIOState, AVR_GPIO)<br>
+<br>
+struct AVRGPIOState {<br>
+=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
+=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
+<br>
+=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
+=C2=A0 =C2=A0 MemoryRegion mmio;<br>
+<br>
+=C2=A0 =C2=A0 uint8_t ddr_val;<br>
+=C2=A0 =C2=A0 uint8_t port_val;<br>
+<br>
+};<br>
+<br>
+#endif /* AVR_GPIO_H */<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div></div>

--00000000000022efd105b0c74ec0--

