Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1E0C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:39:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8341521789
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8341521789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQX4s-0002I7-J5
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kQX3l-0001QA-Bg
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:38:21 -0400
Received: from mail-co1nam11olkn2050.outbound.protection.outlook.com
 ([40.92.18.50]:56801 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kQX3h-0007ao-9x
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:38:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAO7MSkQ2f+9N0xQBZa3hH9XxbKHX+JYuXAKlTesz2DWEVUecoobQMUxmQr2SBprjNvY/GvSfuvMLUPbg6CbvT5rtWEshBV5azggXi9l5vsWW0QTB4vdiq5moSGWA2+JcZU3KV/CiaAQIH3NTE6qegWjHjP2vlyrc55BT8kuTWN09k+NFUJgYGeol2wTflag9VoHamkW6gci34ieSWGBf1QbxtQxc8biUdguB5tB1r1JXDL4mcT0do4PzoSaXe92kxe097QGxlF/7rJidhpJxg0HRUB8+ZWsBHnnG2n0a4F94Bn8ACoPJi6tLxQt0gkESnXc1cgI8rDjZZgBtFSqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsVaqxIervkG/dJx9YRxCysdT7XkygoUXAyG0TQHttk=;
 b=RtKQN3Fqg8ECM1D4Vv0JcSYMyICuGpgD1nEJ2ZiQ+BDYCq+dpz41JsEuUj6yHnJ//+fmrLIAhnx7ACDXYkvU/bh875crLFDio/o4c+K0ltKfN/L7Q62f/vlFvv3xGvoc/zakuxM/yYLste0pzPLNSq4vy6N3BJvCkaz05OVCX/MzLJD318SS1cHYY0xeZ2kk+en7Dc4lj1UNg0ilx2VLDdmuSpXe3SCHKwf1JHTghobjmSGeFIRcnVCfRQUStMM8llK2c1RaKVcaRjw4F33sjA92uhuUo2yuIp2W0F8ilvQgB9iwETR7sJO8Li/wslIB1iCSqmAOGNSQq8D9n2nCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsVaqxIervkG/dJx9YRxCysdT7XkygoUXAyG0TQHttk=;
 b=jEAu61TRTzxz5peZ8Y7WR+rdcyS247aBHYKNUaDZz/jXEpT3kZYROb6XawRBg/rGpSrKLhctKLW0f/8+e5jPUpOQyI4KSQygke/Z7q+E25KvL+2+Y8j0PJSzCTlVcecJRP/W4by1xPecOy8dFY4eelCdZd8xbUeRv45Y+Xnc0qwQw8WlWcUxqOckckkXlTPuZKI/uD/Rbed+d1OshiBi4VCrXJSJtmp4Fi8m+b9HOJKm1xm9vIQLBR8CzVnI9oq3xL3EP1JmTQDqhjNGQzJvark61y+cT/Mp4SbnhQLTFWiErpKhF7nCmMGXTNJB8jwUjqy3OAutkF43Nr3oZPggEw==
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:3861::45) by
 CO1NAM11HT161.eop-nam11.prod.protection.outlook.com (2a01:111:e400:3861::163)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Thu, 8 Oct
 2020 14:23:10 +0000
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 (2a01:111:e400:3861::50) by CO1NAM11FT041.mail.protection.outlook.com
 (2a01:111:e400:3861::217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend
 Transport; Thu, 8 Oct 2020 14:23:10 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:97CCF229649D41EB5E9FF2F8876AD9F4E275844425C974CCE58BFFC1590365B6;
 UpperCasedChecksum:1A9A62D3BBD9766A9DEE107E468A4077AD30368F9959E565B13D84B5BFCEF78A;
 SizeAsReceived:8827; Count:48
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1]) by DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1%3]) with mapi id 15.20.3455.024; Thu, 8 Oct 2020
 14:23:10 +0000
Subject: Re: [PATCH v5] hw/avr: Add limited support for avr gpio registers
To: qemu-devel@nongnu.org
References: <DM6PR16MB2473681AE7F2EE705C7300A6E60D0@DM6PR16MB2473.namprd16.prod.outlook.com>
From: Heecheol Yang <heecheol.yang@outlook.com>
Message-ID: <DM6PR16MB2473942A5014037E46AE2659E60B0@DM6PR16MB2473.namprd16.prod.outlook.com>
Date: Thu, 8 Oct 2020 23:23:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM6PR16MB2473681AE7F2EE705C7300A6E60D0@DM6PR16MB2473.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=euc-kr; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TMN: [hBvUY3JWirNJ0Tn0dIpeG4u4Irpueqwz]
X-ClientProxiedBy: SLXP216CA0010.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:6::20) To DM6PR16MB2473.namprd16.prod.outlook.com
 (2603:10b6:5:6e::28)
X-Microsoft-Original-Message-ID: <57d9efb2-c6f9-0b23-43ea-cd0efb5adfd3@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [121.168.203.43] (121.168.203.43) by
 SLXP216CA0010.KORP216.PROD.OUTLOOK.COM (2603:1096:100:6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 14:23:09 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: d50552bc-e2bb-4dd6-5782-08d86b95aee8
X-MS-TrafficTypeDiagnostic: CO1NAM11HT161:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j8rCQQDnnrwkCUQiacyLURG5WRhRaOldfzf3+MmsSrU6XJUJ1dh53Qa4EMzM/9QT4mNR9Bcc4RD7yI6wl4RtDlP4x6ki7aWh1i0oey7AE34cwjC+Z2X0mEps/aBjlWUVwzWBFuUjjDBcJcBVuLiP0j7RHP4QoAcUFDQs/foLbHdZ7rFhRdQl7yRP3GVX8r4cEeuq/5D2Rs9P47cjA1xDT9VNhfXY77p16GnywCEHSx/NVENWxJ7GCitfFpsPHGoY
X-MS-Exchange-AntiSpam-MessageData: CH1niOkyHONYyBScwxTWsx6VxU9CtcqLk0+/0NsktXoxFSW7LoAC63OD3l4ZmpTVOb2OpsMm0qW/iq807WYYLZjaQBFRt5+d6WWqToeU7OUttFC02vzyoHH1G+yHALXpCRoAFL40fhmku0iJEyvrfw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50552bc-e2bb-4dd6-5782-08d86b95aee8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 14:23:10.7883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1NAM11HT161
Received-SPF: pass client-ip=40.92.18.50;
 envelope-from=heecheol.yang@outlook.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 10:38:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_MUA_MOZILLA=2.309, FREEMAIL_FROM=0.001, MSGID_FROM_MTA_HEADER=0.001,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

I've submitted this patch below, but couldn't get any review for it.

Because I am very first at this kind of work, I'm afraid that I am doing 
something wrong or rude.

Please can I know if there was something inappropriate?

Thanks a lot!


Best regards

Heecheol Yang


> Add some of these features for AVR GPIO:
>
>    - GPIO I/O : PORTx registers
>    - Data Direction : DDRx registers
>    - DDRx toggling : PINx registers
>
> Following things are not supported yet:
>    - MCUR registers
>
> Signed-off-by: Heecheol Yang <heecheol.yang@outlook.com>
> ---
>   hw/avr/Kconfig             |   1 +
>   hw/avr/atmega.c            |   7 +-
>   hw/avr/atmega.h            |   2 +
>   hw/gpio/Kconfig            |   3 +
>   hw/gpio/avr_gpio.c         | 136 +++++++++++++++++++++++++++++++++++++
>   hw/gpio/meson.build        |   2 +
>   include/hw/gpio/avr_gpio.h |  53 +++++++++++++++
>   7 files changed, 202 insertions(+), 2 deletions(-)
>   create mode 100644 hw/gpio/avr_gpio.c
>   create mode 100644 include/hw/gpio/avr_gpio.h
>
> diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
> index d31298c3cc..16a57ced11 100644
> --- a/hw/avr/Kconfig
> +++ b/hw/avr/Kconfig
> @@ -3,6 +3,7 @@ config AVR_ATMEGA_MCU
>       select AVR_TIMER16
>       select AVR_USART
>       select AVR_POWER
> +    select AVR_GPIO
>   
>   config ARDUINO
>       select AVR_ATMEGA_MCU
> diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
> index 44c6afebbb..ad942028fd 100644
> --- a/hw/avr/atmega.c
> +++ b/hw/avr/atmega.c
> @@ -283,8 +283,11 @@ static void atmega_realize(DeviceState *dev, Error **errp)
>               continue;
>           }
>           devname = g_strdup_printf("atmega-gpio-%c", 'a' + (char)i);
> -        create_unimplemented_device(devname,
> -                                    OFFSET_DATA + mc->dev[idx].addr, 3);
> +        object_initialize_child(OBJECT(dev), devname, &s->gpio[i],
> +                                TYPE_AVR_GPIO);
> +        sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &error_abort);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0,
> +            OFFSET_DATA + mc->dev[idx].addr);
>           g_free(devname);
>       }
>   
> diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h
> index a99ee15c7e..e2289d5744 100644
> --- a/hw/avr/atmega.h
> +++ b/hw/avr/atmega.h
> @@ -13,6 +13,7 @@
>   
>   #include "hw/char/avr_usart.h"
>   #include "hw/timer/avr_timer16.h"
> +#include "hw/gpio/avr_gpio.h"
>   #include "hw/misc/avr_power.h"
>   #include "target/avr/cpu.h"
>   #include "qom/object.h"
> @@ -44,6 +45,7 @@ struct AtmegaMcuState {
>       DeviceState *io;
>       AVRMaskState pwr[POWER_MAX];
>       AVRUsartState usart[USART_MAX];
> +    AVRGPIOState gpio[GPIO_MAX];
>       AVRTimer16State timer[TIMER_MAX];
>       uint64_t xtal_freq_hz;
>   };
> diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
> index b6fdaa2586..1752d0ce56 100644
> --- a/hw/gpio/Kconfig
> +++ b/hw/gpio/Kconfig
> @@ -10,3 +10,6 @@ config GPIO_KEY
>   
>   config SIFIVE_GPIO
>       bool
> +
> +config AVR_GPIO
> +    bool
> diff --git a/hw/gpio/avr_gpio.c b/hw/gpio/avr_gpio.c
> new file mode 100644
> index 0000000000..29e799670d
> --- /dev/null
> +++ b/hw/gpio/avr_gpio.c
> @@ -0,0 +1,136 @@
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
> + * with this program; if not, see <https://eur06.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.gnu.org%2Flicenses%2F&amp;data=02%7C01%7C%7Ce26698a8102d4e9717a408d869ff32ea%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C637375892070440761&amp;sdata=aG9o2gjQXkz9otB3VItryZUyfUCgbBZgpSkuDtvR4xg%3D&amp;reserved=0>.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/sysbus.h"
> +#include "hw/irq.h"
> +#include "hw/gpio/avr_gpio.h"
> +#include "hw/qdev-properties.h"
> +
> +static void avr_gpio_reset(DeviceState *dev)
> +{
> +    AVRGPIOState *gpio = AVR_GPIO(dev);
> +    gpio->reg.pin = 0u;
> +    gpio->reg.ddr = 0u;
> +    gpio->reg.port = 0u;
> +}
> +
> +static void avr_gpio_write_port(AVRGPIOState *s, uint64_t value)
> +{
> +    uint8_t pin;
> +    uint8_t cur_port_val = s->reg.port;
> +    uint8_t cur_ddr_val = s->reg.ddr;
> +
> +    for (pin = 0u; pin < 8u ; pin++) {
> +        uint8_t cur_port_pin_val = cur_port_val & 0x01u;
> +        uint8_t cur_ddr_pin_val = cur_ddr_val & 0x01u;
> +        uint8_t new_port_pin_val = value & 0x01u;
> +
> +        if (cur_ddr_pin_val && (cur_port_pin_val != new_port_pin_val)) {
> +            qemu_set_irq(s->out[pin], new_port_pin_val);
> +        }
> +        cur_port_val >>= 1u;
> +        cur_ddr_val >>= 1u;
> +        value >>= 1u;
> +    }
> +    s->reg.port = value & s->reg.ddr;
> +}
> +static uint64_t avr_gpio_read(void *opaque, hwaddr offset, unsigned int size)
> +{
> +    AVRGPIOState *s = (AVRGPIOState *)opaque;
> +    switch (offset) {
> +    case GPIO_PIN:
> +        return s->reg.pin;
> +    case GPIO_DDR:
> +        return s->reg.ddr;
> +    case GPIO_PORT:
> +        return s->reg.port;
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
> +    value = value & 0xF;
> +    switch (offset) {
> +    case GPIO_PIN:
> +        s->reg.pin = value;
> +        s->reg.port ^= s->reg.pin;
> +        break;
> +    case GPIO_DDR:
> +        s->reg.ddr = value;
> +        break;
> +    case GPIO_PORT:
> +        avr_gpio_write_port(s, value);
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
> +    qdev_init_gpio_out(DEVICE(obj), s->out, ARRAY_SIZE(s->out));
> +    memory_region_init_io(&s->mmio, obj, &avr_gpio_ops, s, TYPE_AVR_GPIO, 3);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +}
> +static void avr_gpio_realize(DeviceState *dev, Error **errp)
> +{
> +    /* Do nothing currently */
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
> @@ -11,3 +11,5 @@ softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
>   softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
>   softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
>   softmmu_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
> +
> +softmmu_ss.add(when: 'CONFIG_AVR_GPIO', if_true: files('avr_gpio.c'))
> diff --git a/include/hw/gpio/avr_gpio.h b/include/hw/gpio/avr_gpio.h
> new file mode 100644
> index 0000000000..498a7275f0
> --- /dev/null
> +++ b/include/hw/gpio/avr_gpio.h
> @@ -0,0 +1,53 @@
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
> + * with this program; if not, see <https://eur06.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.gnu.org%2Flicenses%2F&amp;data=02%7C01%7C%7Ce26698a8102d4e9717a408d869ff32ea%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C637375892070440761&amp;sdata=aG9o2gjQXkz9otB3VItryZUyfUCgbBZgpSkuDtvR4xg%3D&amp;reserved=0>.
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
> +#define AVR_GPIO_COUNT 8
> +
> +struct AVRGPIOState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    MemoryRegion mmio;
> +
> +    struct {
> +        uint8_t pin;
> +        uint8_t ddr;
> +        uint8_t port;
> +    } reg;
> +
> +    /* PORTx data changed IRQs */
> +    qemu_irq out[8u];
> +
> +};
> +
> +#endif /* AVR_GPIO_H */

