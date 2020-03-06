Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2262CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:44:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0D22073D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mv1MvAWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0D22073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA9Wb-0008JI-4z
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 04:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jA9Us-0006cI-Vx
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jA9Ur-0004Rt-AZ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:42:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25414
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jA9Ur-0004P8-09
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583487737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFMbEHostk5C52OS/PX7OJDehoiQSgYxKZVQ/CemZEs=;
 b=Mv1MvAWW/vCXhd0Lxsd3WRmjjZARfyXzkIFPHbhxwgVtenPCB2vL+dR38IoECv80NfCBhN
 JRC/qKfUcdcPmk26YcIL78cROmSw4p7ZuDDNZkTEwZhcI/HF2v2TBt3AHhon3cbLyKz95S
 ybsBvA5oFnBJO+S6bJB7bGjlMXKJDQU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-QMZPpWhtN7uyCBs2H6DHMQ-1; Fri, 06 Mar 2020 04:42:14 -0500
X-MC-Unique: QMZPpWhtN7uyCBs2H6DHMQ-1
Received: by mail-wm1-f71.google.com with SMTP id k65so414564wmf.7
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 01:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cFMbEHostk5C52OS/PX7OJDehoiQSgYxKZVQ/CemZEs=;
 b=lSZgthiaHT8cG/ZiDHz/QCQ81rVYIeVy+5lEBUf3VZ6vCjQnByMxNp+ecMaDKXK2GK
 x6X7bFWaSEwDKrvVx4L9CXFc+52dy8D9lHTkHblhwyobaOD+QNarDa0mCDEVyoTQg71g
 uGr1mY/Dw9hz3gdzPuHXS0Yf+MIGnhNMtGnsXtJ1rg3lm97OB1k7RdGzSQ9TNnaBaJpW
 ALSROD7+G6ykdmXbSjxTJMaCmnx/d0zi3LT7F4euLvSn7t+Cko4vifDHVbrxPba5kYSf
 bezmhD4OW9kink/haKmG/4CQER4CKRfR6NzFHqOwoHlvPcEbdWbuuVlZEz+IfZ0sKF1R
 d4WA==
X-Gm-Message-State: ANhLgQ1otMHBt6hQ0MUnwk8zmpIP9mi2MbDdQkOxX8448zgVAfAkA8J5
 KT57VzjATo+gvXwVHOxnbgsNBuXlD5bfB57K2ERNIOtOj2RlKKpUJ7Ips9EROO2NB2UGZK3H6nR
 X+xuPl4Sn9Rs/+Uw=
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr3019996wrw.383.1583487732993; 
 Fri, 06 Mar 2020 01:42:12 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvXcHPxPypTaJTscuhtnH/coj0/jCxot1vW9SofMrf7FdzDOwaK9A4t4QD6DqDFN2ANEgosVw==
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr3019973wrw.383.1583487732733; 
 Fri, 06 Mar 2020 01:42:12 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id h10sm14203577wml.18.2020.03.06.01.42.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2020 01:42:12 -0800 (PST)
Subject: Re: [PATCH] hw/arm/stm32f405: Add preliminary flash interface
 emulation support
To: Stephanos Ioannidis <root@stephanos.io>
References: <20200301084427.93823-1-root@stephanos.io>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bce274e1-711c-3687-5090-21c14daa3a51@redhat.com>
Date: Fri, 6 Mar 2020 10:42:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200301084427.93823-1-root@stephanos.io>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 3/1/20 9:45 AM, Stephanos Ioannidis wrote:
> The flash interface (FLASHIF) peripheral provides a control interface
> for the SoC embedded flash memory on the STM32F4xx series devices.
> 
> This commit adds preliminary support for the flash interface peripheral
> emulation, in order to support proper emulation of the firmware images
> that use the STM32Cube driver, which configures and validates the
> FLASH_ACR register during system initialisation.
> 
> Signed-off-by: Stephanos Ioannidis <root@stephanos.io>
> ---
>   hw/arm/Kconfig                      |   1 +
>   hw/arm/stm32f405_soc.c              |  15 +-
>   hw/misc/Kconfig                     |   3 +
>   hw/misc/Makefile.objs               |   1 +
>   hw/misc/stm32f4xx_flashif.c         | 215 ++++++++++++++++++++++++++++
>   hw/misc/trace-events                |   4 +
>   include/hw/arm/stm32f405_soc.h      |   2 +
>   include/hw/misc/stm32f4xx_flashif.h | 144 +++++++++++++++++++

Consider using the scripts/git.orderfile configuration.

>   8 files changed, 384 insertions(+), 1 deletion(-)
>   create mode 100644 hw/misc/stm32f4xx_flashif.c
>   create mode 100644 include/hw/misc/stm32f4xx_flashif.h
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 3d86691ae0..179696ec91 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -314,6 +314,7 @@ config STM32F205_SOC
>   config STM32F405_SOC
>       bool
>       select ARM_V7M
> +    select STM32F4XX_FLASHIF
>       select STM32F4XX_SYSCFG
>       select STM32F4XX_EXTI
>   
> diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
> index 9bcad97853..72b16910c7 100644
> --- a/hw/arm/stm32f405_soc.c
> +++ b/hw/arm/stm32f405_soc.c
> @@ -30,6 +30,7 @@
>   #include "hw/arm/stm32f405_soc.h"
>   #include "hw/misc/unimp.h"
>   
> +#define FLASHIF_ADDR                   0x40023C00
>   #define SYSCFG_ADD                     0x40013800
>   static const uint32_t usart_addr[] = { 0x40011000, 0x40004400, 0x40004800,
>                                          0x40004C00, 0x40005000, 0x40011400,
> @@ -59,6 +60,9 @@ static void stm32f405_soc_initfn(Object *obj)
>       sysbus_init_child_obj(obj, "armv7m", &s->armv7m, sizeof(s->armv7m),
>                             TYPE_ARMV7M);
>   
> +    sysbus_init_child_obj(obj, "flashif", &s->flashif, sizeof(s->flashif),
> +                          TYPE_STM32F4XX_FLASHIF);
> +
>       sysbus_init_child_obj(obj, "syscfg", &s->syscfg, sizeof(s->syscfg),
>                             TYPE_STM32F4XX_SYSCFG);
>   
> @@ -130,6 +134,16 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
>           return;
>       }
>   
> +    /* Flash interface */
> +    dev = DEVICE(&s->flashif);

You might want to add a 'link property' to the s->flash memory region 
here, so you can lock/unlock/program/fuse it later.

> +    object_property_set_bool(OBJECT(&s->flashif), true, "realized", &err);
> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    busdev = SYS_BUS_DEVICE(dev);
> +    sysbus_mmio_map(busdev, 0, FLASHIF_ADDR);
> +
>       /* System configuration controller */
>       dev = DEVICE(&s->syscfg);
>       object_property_set_bool(OBJECT(&s->syscfg), true, "realized", &err);
> @@ -261,7 +275,6 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
>       create_unimplemented_device("GPIOI",       0x40022000, 0x400);
>       create_unimplemented_device("CRC",         0x40023000, 0x400);
>       create_unimplemented_device("RCC",         0x40023800, 0x400);
> -    create_unimplemented_device("Flash Int",   0x40023C00, 0x400);
>       create_unimplemented_device("BKPSRAM",     0x40024000, 0x400);
>       create_unimplemented_device("DMA1",        0x40026000, 0x400);
>       create_unimplemented_device("DMA2",        0x40026400, 0x400);
[...]


