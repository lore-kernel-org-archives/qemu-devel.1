Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC33C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 16:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 206E120449
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 16:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206E120449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51999 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEcjJ-0006QE-F4
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 12:39:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEchH-0005TW-Vc
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEchG-0008SZ-PS
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:37:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEchG-0008Rw-IQ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:37:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so8249069wrq.1
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 09:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ZyFLoI1++MpFhBnNON30ujRs74ugrOO4tJ0VvCZj2ik=;
	b=lsEuoxB0ThVd/d0/KhJMkwszAEYmBlQ2k0lTYWQ20fzoNZD/vScDRAtiW/Ggb2XpyQ
	0fl1drRjoGOqRy909QwbEB6NEzGPqiuMST+aOCGKrgln61iINih+gbXhlH20/r79aHid
	Ufy2MrQ/AKmApT4t9L9ivvXUa6khfZqH6Zg2fVwya37NgrQomCPwB8GnCzhTatz4RjIX
	axmTxEcTuFwzfOvL2od3L+F/RfPBdB9mGOfXDLXVSe4RABkrezmqiFtbVAFnwqzT9t7a
	k/gptqENJrqqKcOT4q30PBAXbwB11gxOV+pOwUZW3487DQCDKKgx4q2GxAsL430o9Cpm
	arqA==
X-Gm-Message-State: APjAAAUYwaeckauLsTfZ86/GjOPP/AhUvc86frFeSWi3/aUGiKXcXqD3
	LPago/OBHNhvYLdKdqqub3qDKWBwnmE=
X-Google-Smtp-Source: APXvYqybjsQfRmwTIYpjRt2o2GjuN0RLCTDgTLlk+uU5akCiowmP9rtbnR8lyP4oaqllEmi/Cy+LnQ==
X-Received: by 2002:adf:f088:: with SMTP id n8mr33123113wro.112.1555000624992; 
	Thu, 11 Apr 2019 09:37:04 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	f15sm49672122wru.21.2019.04.11.09.37.03
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 09:37:04 -0700 (PDT)
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>
References: <20190328062222.8409-1-joel@jms.id.au>
	<20190328062222.8409-2-joel@jms.id.au>
	<CAFEAcA_K1Rv1G-s=ndVYX6i_BvWME6ToShL6ZBpB4gnE3zdZdA@mail.gmail.com>
	<89438392-9a54-7f43-5dff-6ceeffaf9f3e@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8d05734c-2744-290f-0dbc-95f9c2502f21@redhat.com>
Date: Thu, 11 Apr 2019 18:36:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <89438392-9a54-7f43-5dff-6ceeffaf9f3e@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 1/2] hw: timer: Add ASPEED RTC device
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411163658.-sG5KWJg2EUX6zOtmjbu_t5voo0YnLoiquydFXY_4_g@z>

Hi Peter,

On 4/11/19 5:30 PM, Cédric Le Goater wrote:
> On 4/11/19 5:25 PM, Peter Maydell wrote:
>> On Thu, 28 Mar 2019 at 06:22, Joel Stanley <joel@jms.id.au> wrote:
>>>
>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> ---
>>>  hw/timer/Makefile.objs        |   2 +-
>>>  hw/timer/aspeed_rtc.c         | 157 ++++++++++++++++++++++++++++++++++
>>>  hw/timer/trace-events         |   4 +
>>>  include/hw/timer/aspeed_rtc.h |  31 +++++++
>>>  4 files changed, 193 insertions(+), 1 deletion(-)
>>>  create mode 100644 hw/timer/aspeed_rtc.c
>>>  create mode 100644 include/hw/timer/aspeed_rtc.h
>>>
>>> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
>>> index 0e9a4530f848..123d92c9692c 100644
>>> --- a/hw/timer/Makefile.objs
>>> +++ b/hw/timer/Makefile.objs
>>> @@ -41,7 +41,7 @@ obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
>>>  obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
>>>
>>>  common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
>>> -common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o
>>> +common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o aspeed_rtc.o
>>>
>>>  common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
>>>  common-obj-$(CONFIG_CMSDK_APB_TIMER) += cmsdk-apb-timer.o
>>> diff --git a/hw/timer/aspeed_rtc.c b/hw/timer/aspeed_rtc.c
>>> new file mode 100644
>>> index 000000000000..daccf00eccdc
>>> --- /dev/null
>>> +++ b/hw/timer/aspeed_rtc.c
>>> @@ -0,0 +1,157 @@
>>> +/*
>>> + * ASPEED Real Time Clock
>>> + * Joel Stanley <joel@jms.id.au>
>>> + *
>>> + * Copyright 2019 IBM Corp
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qemu-common.h"
>>> +#include "hw/timer/aspeed_rtc.h"
>>> +#include "qemu/log.h"
>>> +#include "qemu/timer.h"
>>> +
>>> +#include "trace.h"
>>> +
>>> +#define COUNTER1        (0x00 / 4)
>>> +#define COUNTER2        (0x04 / 4)
>>> +#define ALARM           (0x08 / 4)
>>> +#define CONTROL         (0x10 / 4)
>>> +#define ALARM_STATUS    (0x14 / 4)
>>
>> Not mandatory, but you might like the REG32() macro in
>> hw/registerfields.h which defines A_FOO and R_FOO
>> constants for you for the addresses and the indexes.
> 
> Yes. May be we should start using these macros in all our models.
> 
>>
>>> +
>>> +#define RTC_UNLOCKED    BIT(1)
>>> +#define RTC_ENABLED     BIT(0)
>>> +
>>> +static void aspeed_rtc_calc_offset(AspeedRtcState *rtc)
>>> +{
>>> +    struct tm tm;
>>> +    uint32_t year, cent;
>>> +    uint32_t reg1 = rtc->reg[COUNTER1];
>>> +    uint32_t reg2 = rtc->reg[COUNTER2];
>>> +
>>> +    tm.tm_mday = (reg1 >> 24) & 0x1f;
>>> +    tm.tm_hour = (reg1 >> 16) & 0x1f;
>>> +    tm.tm_min = (reg1 >> 8) & 0x3f;
>>> +    tm.tm_sec = (reg1 >> 0) & 0x3f;
>>
>> Shift by zero ?
>>
>> Consider using extract32() rather than by-hand shift and mask.
> 
> What about the FIELD*() macros in hw/registerfields.h ?
> 
> Thanks,
> 
> C.
> 
>>
>>> +
>>> +    cent = (reg2 >> 16) & 0x1f;
>>> +    year = (reg2 >> 8) & 0x7f;
>>> +    tm.tm_mon = ((reg2 >>  0) & 0x0f) - 1;
>>> +    tm.tm_year = year + (cent * 100) - 1900;
>>> +
>>> +    rtc->offset = qemu_timedate_diff(&tm);
>>> +}
>>> +
>>> +static uint32_t aspeed_rtc_get_counter(AspeedRtcState *rtc, int r)
>>> +{
>>> +    uint32_t year, cent;
>>> +    struct tm now;
>>> +
>>> +    qemu_get_timedate(&now, rtc->offset);
>>> +
>>> +    switch (r) {
>>> +    case COUNTER1:
>>> +        return (now.tm_mday << 24) | (now.tm_hour << 16) |
>>> +            (now.tm_min << 8) | now.tm_sec;
>>> +    case COUNTER2:
>>> +        cent = (now.tm_year + 1900) / 100;
>>> +        year = now.tm_year % 100;
>>> +        return ((cent & 0x1f) << 16) | ((year & 0x7f) << 8) |
>>> +            ((now.tm_mon + 1) & 0xf);
>>> +    default:
>>> +        abort();
>>
>> More usually written g_assert_not_reached().
>>
>>> +    }
>>> +}
>>> +
>>> +static uint64_t aspeed_rtc_read(void *opaque, hwaddr addr,
>>> +                                unsigned size)
>>> +{
>>> +    AspeedRtcState *rtc = opaque;
>>> +    uint64_t val;
>>> +    uint32_t r = addr >> 2;
>>> +
>>> +    switch (r) {
>>> +    case COUNTER1:
>>> +    case COUNTER2:
>>> +        if (rtc->reg[CONTROL] & RTC_ENABLED) {
>>> +            rtc->reg[r] = aspeed_rtc_get_counter(rtc, r);
>>> +        }
>>
>> If this is deliberately going to fall through to the next
>> case then it should have a /* fall through */ comment
>> (ditto in the write fn).
>>
>>> +    case ALARM:
>>> +    case CONTROL:
>>> +    case ALARM_STATUS:
>>> +        val = rtc->reg[r];
>>> +        break;
>>> +    default:
>>> +        qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx "\n", __func__, addr);
>>> +        return 0;
>>> +    }
>>> +
>>> +    trace_aspeed_rtc_read(addr, val);
>>> +
>>> +    return val;
>>> +}
>>
>>> +static void aspeed_rtc_class_init(ObjectClass *klass, void *data)
>>> +{
>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>> +
>>> +    dc->realize = aspeed_rtc_realize;
>>
>> This is missing a reset function and vmstate.

Is vmstate mandatory for new devices?

>>
>> thanks
>> -- PMM
>>
> 
> 

