Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8741CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552FB20760
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGeijXxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552FB20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSsP-0005J1-MJ
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSrl-0004n6-UU; Wed, 17 Jun 2020 03:52:14 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSrk-0007Av-00; Wed, 17 Jun 2020 03:52:13 -0400
Received: by mail-wm1-x341.google.com with SMTP id l26so866634wme.3;
 Wed, 17 Jun 2020 00:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IakhfcRiFB3BaluWdRrTXWeTY2CyZNOzuL7AZak9664=;
 b=dGeijXxmc0HKO5zcqmvWDrhoMYiMj2dTF/b43Ex37Gah9gLsBfjkQAbJyinbnDSoN1
 WuHbZbAYzBKFVjBY5qgLN9ENQZQxMbLwRLR+ErlX5k/CG17X4o1xv4QYY8yoJYHWjf+K
 mdj7aLXtCcDAtC+qkZwNEsIe23AvYZ7Xnt9wYmSdBElhpVEb9iSYz5bwKXdsg1Wq8ccB
 OFI6lJXO0LYiEEke7yhR15Dp3+B7FXemVoYnug9B/lT2DOePyCj9YBYWDl/lZQJGTFMd
 L7cmBymnKypBud06mKy6mFOsyS79IAFPVS6kzqpUE7C/j6uonG6bbeRf4FiT0cdufRPV
 JMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IakhfcRiFB3BaluWdRrTXWeTY2CyZNOzuL7AZak9664=;
 b=QOC/0d8/58w9yM2HZhFUzR5D1nb3Dm7asafaNtQzWLZomSYY5gqWQhR7ZuYrZ0zMss
 0Xx52XDSuKKTF5UIMPwItQP4Zru9FQnwTnQ9FaBI8/ejRgn21TsYJz25N77u5tZxDSKt
 SjitbCSnxw6LdNn+rMXxslzWJdYAS2WGL7pzmwEn2IJc0n3XLHh4ze1055oYFHHNxonD
 h2OiHeolqYuzrL3pR/8pGT9ipQbGvkkBp7nj2b3yprlpWc5pzJcZXIiolqPMR6EKW3i4
 QCd9c58097DzYcIBPBeuuLT+HelJyTDyh+xWvGr3gr9whAX4E+plWKOi7SOSOOiPqYLw
 vUFQ==
X-Gm-Message-State: AOAM533bm2XAnyyWn9lhHHfbNVnK1Oc7exx2y2dQ00+h3leDFzVBgX77
 YxMI84ykkKYe4e3vdZjEfuw=
X-Google-Smtp-Source: ABdhPJy3ufDHHxdhkCks/7zJ7aY4AkohfgjcHg9uo6leyQCZx5Qgd520DGBURhc5yyo5ys05+yHRTA==
X-Received: by 2002:a7b:cbd0:: with SMTP id n16mr7466921wmi.38.1592380330123; 
 Wed, 17 Jun 2020 00:52:10 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id u9sm7634451wme.16.2020.06.17.00.52.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2020 00:52:09 -0700 (PDT)
Subject: Re: [PATCH v2] hw/misc/pca9552: Trace LED On/Off events
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
References: <20200617064734.26956-1-f4bug@amsat.org>
 <46689112-c5cc-0cac-fc93-0bfb57f404fc@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <56194006-6a95-2169-a9ef-603c70b54f60@amsat.org>
Date: Wed, 17 Jun 2020 09:52:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <46689112-c5cc-0cac-fc93-0bfb57f404fc@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 9:39 AM, Cédric Le Goater wrote:
> On 6/17/20 8:47 AM, Philippe Mathieu-Daudé wrote:
>> Example booting obmc-phosphor-image:
>>
>>   $ qemu-system-arm -M witherspoon-bmc -trace pca\*
>>   26033@1592376001.873828:pca9552_led_state 0x5594a9f57560 LEDs [........ ........]
>>   26033@1592376001.874169:pca9552_led_state 0x5594a9f57560 LEDs [........ ........]
>>   26033@1592376001.874348:pca9552_led_state 0x5594a9f57560 LEDs [........ ........]
>>   26033@1592376001.874514:pca9552_led_state 0x5594a9f57560 LEDs [........ ........]
>>   26033@1592376001.879601:pca9552_led_state 0x5594a9f57560 LEDs [........ .......*]
>>   26033@1592376001.880507:pca9552_led_state 0x5594a9f57560 LEDs [........ ......**]
>>   26033@1592376001.880885:pca9552_led_state 0x5594a9f57560 LEDs [........ .....***]
>>   26033@1592376001.881228:pca9552_led_state 0x5594a9f57560 LEDs [........ ....****]
>>   26033@1592376001.881601:pca9552_led_state 0x5594a9f57560 LEDs [..*..... ....****]
>>   26033@1592376001.881952:pca9552_led_state 0x5594a9f57560 LEDs [.**..... ....****]
>>   26033@1592376001.882299:pca9552_led_state 0x5594a9f57560 LEDs [***..... ....****]
>>   26033@1592376065.090910:pca9552_led_state 0x5594a9f57560 LEDs [*.*..... ....****]
>>   26033@1592376065.600649:pca9552_led_state 0x5594a9f57560 LEDs [***..... ....****]
>>   26033@1592376066.110565:pca9552_led_state 0x5594a9f57560 LEDs [*.*..... ....****]
>>   26033@1592376066.620390:pca9552_led_state 0x5594a9f57560 LEDs [***..... ....****]
> 
> It looks better but the ordering is wrong.

The order is [15, 14, ..., 3, 2, 1, 0].

This one is blinking?

    front-power {
        retain-state-shutdown;
        default-state = "keep";
        gpios = <&pca0 14 GPIO_ACTIVE_LOW>;
    };

> 
>> Suggested-by: Cédric Le Goater <clg@kaod.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/misc/pca9552.c    | 18 ++++++++++++++++++
>>  hw/misc/trace-events |  3 +++
>>  2 files changed, 21 insertions(+)
>>
>> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
>> index cac729e35a..693f6c3b24 100644
>> --- a/hw/misc/pca9552.c
>> +++ b/hw/misc/pca9552.c
>> @@ -17,6 +17,7 @@
>>  #include "migration/vmstate.h"
>>  #include "qapi/error.h"
>>  #include "qapi/visitor.h"
>> +#include "trace.h"
>>  
>>  #define PCA9552_LED_ON   0x0
>>  #define PCA9552_LED_OFF  0x1
>> @@ -95,6 +96,23 @@ static void pca9552_write(PCA9552State *s, uint8_t reg, uint8_t data)
>>      case PCA9552_LS3:
>>          s->regs[reg] = data;
>>          pca9552_update_pin_input(s);
>> +        if (trace_event_get_state_backends(TRACE_PCA9552_LED_STATE)) {
>> +            char buf[2][9];
>> +
>> +            for (int i = 0; i < 2; i++) {
>> +                uint8_t val = s->regs[PCA9552_INPUT0 + i];
>> +                sprintf(buf[i], "%c%c%c%c%c%c%c%c",
>> +                        val & 0x80 ? '*' : '.',
>> +                        val & 0x40 ? '*' : '.',
>> +                        val & 0x20 ? '*' : '.',
>> +                        val & 0x10 ? '*' : '.',
>> +                        val & 0x08 ? '*' : '.',
>> +                        val & 0x04 ? '*' : '.',
>> +                        val & 0x02 ? '*' : '.',
>> +                        val & 0x01 ? '*' : '.');
>> +            }
>> +            trace_pca9552_led_state(s, buf[1], buf[0]);
>> +        }
>>          break;
> 
> or something like this : 
> 
>  static void pca9552_update_pin_input(PCA9552State *s)
>  {
>      int i;
> +    char state[s->nr_leds + 1];
>  
>      for (i = 0; i < s->nr_leds; i++) {
>          uint8_t input_reg = PCA9552_INPUT0 + (i / 8);
> @@ -45,9 +47,11 @@ static void pca9552_update_pin_input(PCA
>          switch (config) {
>          case PCA9552_LED_ON:
>              s->regs[input_reg] |= 1 << input_shift;
> +            state[i] = '*';
>              break;
>          case PCA9552_LED_OFF:
>              s->regs[input_reg] &= ~(1 << input_shift);
> +            state[i] = '.';
>              break;
>          case PCA9552_LED_PWM0:
>          case PCA9552_LED_PWM1:
> @@ -56,6 +60,9 @@ static void pca9552_update_pin_input(PCA
>              break;
>          }
>      }
> +    state[i] = 0;
> +
> +    trace_pca9552_led_state(s, state);
>  }
> 
> 
> 
> The pin usage is described in the witherspoon DTS : 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts?id=b1f9be9392f0#n78
> 
> The front-power led is blinking. I suppose it means the BMC is on but not the host.￼
> 
> 
> Cheers,
> 
> C. 
> 
>>  
>>      case PCA9552_INPUT0:
>> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
>> index 5561746866..21e52f192d 100644
>> --- a/hw/misc/trace-events
>> +++ b/hw/misc/trace-events
>> @@ -206,3 +206,6 @@ via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "secto
>>  # grlib_ahb_apb_pnp.c
>>  grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" data:0x%08x"
>>  grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx64" data:0x%08x"
>> +
>> +# pca9552.c
>> +pca9552_led_state(void *object, const char *bufhi, const char *buflo) "%p LEDs [%s %s]"
>>
> 
> 

