Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B76C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7132B20714
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AU3b7+YD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7132B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k07Xe-00069i-Ne
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 14:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k07X3-0005dn-Fv; Mon, 27 Jul 2020 14:07:25 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:40044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k07X1-0000Vk-KR; Mon, 27 Jul 2020 14:07:25 -0400
Received: by mail-ej1-x641.google.com with SMTP id o18so17972468eje.7;
 Mon, 27 Jul 2020 11:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KAU1M+AAynEk88PvX4I8a1FblWiiR/zsU26DBDecjQM=;
 b=AU3b7+YD9tkv8FqxFUyQlj/ZST2W2iIid61u1WiPGGSlqrlkLoS2nwYSPl8O8zxorN
 Oq7zsz74hQxZgYGKRoJUnyYS2pixKXIS1cUW6awVNigymgvH9A0FtbWpS3wQ5LWNAu1b
 4OWyx5dtf2XHMajjMaaEiG3u01U9D3C7EdP1ILrDG2RnUh0rDVMwhQe5w9xWnObHWyOd
 GhrO3EuFIoyty1AnN55+HE9kRaVgd6l9ZGh2Xpg1e7oBietOp0gqcPFKsfA1Lwlu/JyF
 bPmd+EkoeSNAhYAUDMzAw6ZQrQg5vf3ZGTxgq/i3SebDgG7agnHi96MNq52zWPOTqLxT
 HyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=KAU1M+AAynEk88PvX4I8a1FblWiiR/zsU26DBDecjQM=;
 b=P/a8j7FXld4uzXetLp7mdyPMOUucZrh5ATLnQtoC3o2PZNGN5WSWjLgwFGLe0dhZpY
 LbFeORKN3bwtwxFxcCDSy+52fHzCpHeLuLN7ZKz6PiXO/fDYy0hNgv7HQWeSBOfQ1Qh0
 qrraYeQcA9n9rdLwtoL0KhQO0/KjFcp4D2iDr5YQ8PlJyeguMLasY2L9+x0DW8fnO+zO
 Dd1ijN8/IsFzmzcihdkG9ZKh1FOdYdvLaXhMZW5+LptOgQClBbUDfeoPK9Qtze3utk9K
 aLm5bdHaN6ub007QRZszGrC7Z7c5GL3oBFuWgcYJ8mT5QOPf3jquBWmwl56MpDd5kZWd
 GQqw==
X-Gm-Message-State: AOAM532eNUD/39AdA/Ej3eY3DcC31KNJ5WNkEh/Z/HnaE2z4paTsJ2MU
 id5ll18L+DPhdic2jo4aSlc=
X-Google-Smtp-Source: ABdhPJwxZSNxFdRsvjc542lEvbjQLnnFxP8bmwdzjIHV/ESqPAs1b7kCHM+EUKwIbgp1Zz5sWgdajw==
X-Received: by 2002:a17:906:80c:: with SMTP id
 e12mr8548118ejd.128.1595873241593; 
 Mon, 27 Jul 2020 11:07:21 -0700 (PDT)
Received: from [192.168.1.39] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id ce12sm8077284edb.4.2020.07.27.11.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 11:07:21 -0700 (PDT)
Subject: Re: [PATCH for-5.1] hw/arm/netduino2, netduinoplus2: Set
 system_clock_scale
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200727162617.26227-1-peter.maydell@linaro.org>
 <e549c6d3-9fbb-ec47-f6c3-c84e4c625647@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <4743e83e-d893-c719-5fe0-ce105c0650f8@amsat.org>
Date: Mon, 27 Jul 2020 20:07:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e549c6d3-9fbb-ec47-f6c3-c84e4c625647@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/27/20 8:05 PM, Philippe Mathieu-Daudé wrote:
> On 7/27/20 6:26 PM, Peter Maydell wrote:
>> The netduino2 and netduinoplus2 boards forgot to set the system_clock_scale
>> global, which meant that if guest code used the systick timer in "use
>> the processor clock" mode it would hang because time never advances.
>>
>> Set the global to match the documented CPU clock speed of these boards.
>> Judging by the data sheet this is slightly simplistic because the
>> SoC allows configuration of the SYSCLK source and frequency via the
>> RCC (reset and clock control) module, but we don't model that.
>>
>> Fixes: https://bugs.launchpad.net/qemu/+bug/1876187
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> NB: tested with "make check" only...
> 
> What about adding another patch with:
> 
> -- >8 --
> --- a/hw/timer/armv7m_systick.c
> +++ b/hw/timer/armv7m_systick.c
> @@ -17,6 +17,7 @@
>  #include "qemu/timer.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> +#include "qapi/error.h"
>  #include "trace.h"
> 
>  /* qemu timers run at 1GHz.   We want something closer to 1MHz.  */
> @@ -221,6 +222,11 @@ static void systick_instance_init(Object *obj)
>  static void systick_realize(DeviceState *dev, Error **errp)
>  {
>      SysTickState *s = SYSTICK(dev);
> +
> +    if (!system_clock_scale) {
> +        error_setg(errp, "can not use systick with 'system_clock_scale
> = 0'");
> +        return;
> +    }
>      s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, systick_timer_tick, s);
>  }

Hmm testing the microbit:

$ qemu-system-arm -M microbit
qemu-system-arm: can not use systick with 'system_clock_scale = 0'

> 
> ---
> 
> I'll try to review with the datasheets tomorrow morning in case you want
> to get it merged during the day.
> 
>>
>>  hw/arm/netduino2.c     | 10 ++++++++++
>>  hw/arm/netduinoplus2.c | 10 ++++++++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
>> index 79e19392b56..8f103341443 100644
>> --- a/hw/arm/netduino2.c
>> +++ b/hw/arm/netduino2.c
>> @@ -30,10 +30,20 @@
>>  #include "hw/arm/stm32f205_soc.h"
>>  #include "hw/arm/boot.h"
>>  
>> +/* Main SYSCLK frequency in Hz (120MHz) */
>> +#define SYSCLK_FRQ 120000000ULL
>> +
>>  static void netduino2_init(MachineState *machine)
>>  {
>>      DeviceState *dev;
>>  
>> +    /*
>> +     * TODO: ideally we would model the SoC RCC and let it handle
>> +     * system_clock_scale, including its ability to define different
>> +     * possible SYSCLK sources.
>> +     */
>> +    system_clock_scale = NANOSECONDS_PER_SECOND / SYSCLK_FRQ;
>> +
>>      dev = qdev_new(TYPE_STM32F205_SOC);
>>      qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
>>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>> diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
>> index 958d21dd9f9..68abd3ec69d 100644
>> --- a/hw/arm/netduinoplus2.c
>> +++ b/hw/arm/netduinoplus2.c
>> @@ -30,10 +30,20 @@
>>  #include "hw/arm/stm32f405_soc.h"
>>  #include "hw/arm/boot.h"
>>  
>> +/* Main SYSCLK frequency in Hz (168MHz) */
>> +#define SYSCLK_FRQ 168000000ULL
>> +
>>  static void netduinoplus2_init(MachineState *machine)
>>  {
>>      DeviceState *dev;
>>  
>> +    /*
>> +     * TODO: ideally we would model the SoC RCC and let it handle
>> +     * system_clock_scale, including its ability to define different
>> +     * possible SYSCLK sources.
>> +     */
>> +    system_clock_scale = NANOSECONDS_PER_SECOND / SYSCLK_FRQ;
>> +
>>      dev = qdev_new(TYPE_STM32F405_SOC);
>>      qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
>>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>
> 
> 

