Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA26C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 21:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5E520826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 21:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXHdplBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5E520826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrThE-0003vU-E6
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 17:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrTg9-0002aE-S9; Fri, 03 Jul 2020 17:57:05 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrTg8-0005UA-7F; Fri, 03 Jul 2020 17:57:05 -0400
Received: by mail-wr1-x442.google.com with SMTP id j4so31714075wrp.10;
 Fri, 03 Jul 2020 14:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=w5Z+RGfsNAIQU/SV50WWMd1/XgW5h3QosAeHkGRArwk=;
 b=BXHdplBWHzhd2cXouSDX4i/S+I85q9/Y8VmTUnzRTiG7S1hsyAI/GscTaHWgJ0UIWE
 Sd4Zo9JJ/bmINPLtlGl/8PAMyVOaJG7lY+eVjhkGI6iw2lNv7fgkRzHzT2KUp/T2jOvk
 qzBgRbLw5HsYi/5kZ06housEN6Wlbs4MN79G37/9n8P0hIDD0zBmDGAT8TatFFT0FZgA
 HNoTS0fjeeI63TLnGxiClzQCZz+ESdvPaj4PWaIqq4fHE886aqkMpWY9o50qV0lcLyMP
 rfjcmQ8tPsMQxI3/Bdtu5Nzyg31gSVSZLSIW5IYfC0y2/9Xu6qzzc3z7cXdwHAD8dvBg
 n14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w5Z+RGfsNAIQU/SV50WWMd1/XgW5h3QosAeHkGRArwk=;
 b=esJtWEoTQh+y8EJcnGHurqqRhYPfvbB0mYc6zTGnT7h/6+4I9xFNQUy8oozyuXBc6Y
 R6X7u/EoZOPJOjm2bowM+UR3oz6vSeoh1NFvOI0s7KSfPrMR9/7jakMsdXMJz4t7zH6G
 yhM4l3tQX3nW3EAnlbVka07aYKLwU4yeQShPujuwNmUleyGGZjiJUOJiW9WWq8MYkFIl
 6Cov/B1ZDGjkH4dX47PY+55kgTaJrooj3amquLtOiCpOlbqDH0MMtPuSZMe6DGWu7rDS
 kYXjpgEMyI3l42I9kh6nJf2B1Xhadr3ybNZzZuCtvAHp8UzO2bTPDho0oXYHvmvbD1wJ
 Wo3Q==
X-Gm-Message-State: AOAM532OQrHs4Z+aFBS0W3TSU1Ulm9SxLzRXeGB02Oc4BHNc5jnxxODs
 Gox+uqKQ15CeYRfKWDgN+zU=
X-Google-Smtp-Source: ABdhPJyEP/Wg/iEXU3TNJKwtl/oSQjbzShYqUTXal/TeXh6CGD8kT85cM7IoLQLyGUzIfOryjzZYBQ==
X-Received: by 2002:adf:ef46:: with SMTP id c6mr38554782wrp.34.1593813421457; 
 Fri, 03 Jul 2020 14:57:01 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id k14sm15025159wrn.76.2020.07.03.14.57.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 14:57:00 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/ppc: Use TYPE_SYSBUS_OHCI instead of hardcoded
 string
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20200703184952.4918-1-f4bug@amsat.org>
 <20200703184952.4918-3-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2007032149250.12670@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fabe84fc-af53-a945-8b43-e2893853da6c@amsat.org>
Date: Fri, 3 Jul 2020 23:57:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2007032149250.12670@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 9:58 PM, BALATON Zoltan wrote:
> On Fri, 3 Jul 2020, Philippe Mathieu-Daudé wrote:
>> By using the TYPE_* definitions for devices, we can:
>> - quickly find where devices are used with 'git-grep'
> 
> You could just as well grep for the type name but it's true if some
> files use name and others the constant then you need to grep for both.
> 
>> - easily rename a non-user-creatable device (one-line change).
> 
> But most devices are user creatable and thus their name is part of the
> CLI so inlikely to change due to preserving backward compatibility of
> command lines. So usefulness of this change seems limited to me.
> 
> But my problem with it is not the above. It's that hcd-ohci.h is not in
> include but in hw/usb so it's internal to the implementation of the
> device model and defines things that users of the device should not
> need, therefore they should not include this header. So if you want to
> use the defined constant then that should be split off to some public
> header instead of including hw/usb/hcd-ohci.h. Maybe we need a new
> header for these TYPE_* constants similar to qemu/typedefs.h?

Indeed you are right. Thanks for noticing the bad effect of my patch.

> 
> Regards,
> BALATON Zoltan
> 
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> hw/display/sm501.c | 3 ++-
>> hw/ppc/sam460ex.c  | 3 ++-
>> 2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
>> index 9cccc68c35..c122a4eca5 100644
>> --- a/hw/display/sm501.c
>> +++ b/hw/display/sm501.c
>> @@ -36,6 +36,7 @@
>> #include "hw/qdev-properties.h"
>> #include "hw/i2c/i2c.h"
>> #include "hw/display/i2c-ddc.h"
>> +#include "hw/usb/hcd-ohci.h"
>> #include "qemu/range.h"
>> #include "ui/pixel_ops.h"
>> #include "qemu/bswap.h"
>> @@ -1961,7 +1962,7 @@ static void sm501_realize_sysbus(DeviceState
>> *dev, Error **errp)
>>     sysbus_init_mmio(sbd, &s->state.mmio_region);
>>
>>     /* bridge to usb host emulation module */
>> -    usb_dev = qdev_new("sysbus-ohci");
>> +    usb_dev = qdev_new(TYPE_SYSBUS_OHCI);
>>     qdev_prop_set_uint32(usb_dev, "num-ports", 2);
>>     qdev_prop_set_uint64(usb_dev, "dma-offset", s->base);
>>     sysbus_realize_and_unref(SYS_BUS_DEVICE(usb_dev), &error_fatal);
>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>> index 1a106a68de..593436937a 100644
>> --- a/hw/ppc/sam460ex.c
>> +++ b/hw/ppc/sam460ex.c
>> @@ -35,6 +35,7 @@
>> #include "hw/char/serial.h"
>> #include "hw/i2c/ppc4xx_i2c.h"
>> #include "hw/i2c/smbus_eeprom.h"
>> +#include "hw/usb/hcd-ohci.h"
>> #include "hw/usb/hcd-ehci.h"
>> #include "hw/ppc/fdt.h"
>> #include "hw/qdev-properties.h"
>> @@ -370,7 +371,7 @@ static void sam460ex_init(MachineState *machine)
>>
>>     /* USB */
>>     sysbus_create_simple(TYPE_PPC4xx_EHCI, 0x4bffd0400, uic[2][29]);
>> -    dev = qdev_new("sysbus-ohci");
>> +    dev = qdev_new(TYPE_SYSBUS_OHCI);
>>     qdev_prop_set_string(dev, "masterbus", "usb-bus.0");
>>     qdev_prop_set_uint32(dev, "num-ports", 6);
>>     sbdev = SYS_BUS_DEVICE(dev);
>>

