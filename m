Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B8BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DA220708
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMxPLU7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DA220708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnJD2-0008Gt-BL
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnJ86-0002dx-Jt; Mon, 22 Jun 2020 05:52:42 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnJ84-0005NN-Og; Mon, 22 Jun 2020 05:52:42 -0400
Received: by mail-wr1-x441.google.com with SMTP id z13so4225957wrw.5;
 Mon, 22 Jun 2020 02:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/Bvc7IsiddAczfGywgS8QiU6znkFI4k8Pw0/SuBT2Ic=;
 b=HMxPLU7Cu5ZWxof0tuSUzLdixGhDOx3ufZWz5zNqp3yV2UYQSEKJLjn3bdhZz+/3QT
 GLnnFBL2CLC9xGuhWSHYVrN6v9vVbb9utyEsFtvH/4/FxsthLRdy8hq8JhCXCbhoda0Y
 YFNq2pVm+JGRZy6AVASoM8NEv36x288pS3sHIa1Up1j50XCVHq+NvMVZCkd3P+Kir1AL
 vurFUjHfAJpdTCRfN2MbjY+zuoaU70FThWklvO4Lh5A+ZSHSG/xjDgwXZy8HIer+JOZk
 MhlqdGPgFJXlBlcFC3SYDnda8kD5nX5ttAvSV9j66qhAHrxECKOO/rhq7VtJHp/7odzx
 Lqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/Bvc7IsiddAczfGywgS8QiU6znkFI4k8Pw0/SuBT2Ic=;
 b=A61plawTCgnzxhDhyLNqr6eAE5lB7K5GuTFLIHbHh52i6fmaaGO5hZ3r2HF9ipOOoS
 WBkQSciK5cJlLKGVUSRl1zUmFqOdxI7w/83DU6UBHyjfLfUot/1N3FOiocXHlUPcy/w/
 4i2vflgBoHoRkD4ZvTUTfwqspfIPxfGWo3rbMIvScJO9Lbm+0qJptn1MqH4fZ0CZ9KSy
 mhe6wzPlG8GeZgiEldjO52+/k1cLb8rqHB0TVTQhW3MkgQHbXqeym5eN9mGkHjecQj2M
 A1Syrd9QqohukFuX3roY/w4/jj4AD9SDmPCIozyADgLUPTkrokWGalb8ZnQ0pdJZ4Rh8
 /XnA==
X-Gm-Message-State: AOAM530TqnEP39Ic/a+LZ7WJfXcTT5t4iOjDYinVQneBX3DNUaHOYzAb
 qAYlYZtHbdLXH3Wwr7AysCo=
X-Google-Smtp-Source: ABdhPJw/ucUKURLSPMNs2K7fZ62YbPy7a0TeonrgVF0e2LSmpf+wEtj2QsVVBqv3SNExqGZxb86Vng==
X-Received: by 2002:a05:6000:ce:: with SMTP id
 q14mr10372311wrx.294.1592819558680; 
 Mon, 22 Jun 2020 02:52:38 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id c70sm15823500wme.32.2020.06.22.02.52.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 02:52:38 -0700 (PDT)
Subject: Re: [PATCH v4 7/8] hw/misc/pca9552: Trace GPIO change events
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
References: <20200620225854.31160-1-f4bug@amsat.org>
 <20200620225854.31160-8-f4bug@amsat.org>
 <fb024d85-9730-e31d-622c-60601d75c7f3@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a4ad6480-c2f2-75bc-12d0-71000905a45f@amsat.org>
Date: Mon, 22 Jun 2020 11:52:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <fb024d85-9730-e31d-622c-60601d75c7f3@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Corey Minyard <cminyard@mvista.com>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 9:01 AM, Cédric Le Goater wrote:
> On 6/21/20 12:58 AM, Philippe Mathieu-Daudé wrote:
>> Emit a trace event when a GPIO change its state.
> 
> I understand now why you need 'pin_status'. 
> 
> We could compute 'pin_status' and 'pin_changed' in routine 
> pca9552_update_pin_input() when updating the PCA9552_INPUT0/1 
> register values and pass them to pca9552_display_pins_status()
> or something like that.

Good idea, thanks!

> 
> Maybe add two different display routines also. 
>  
>>
>> Example booting obmc-phosphor-image:
>>
>>   $ qemu-system-arm -M witherspoon-bmc -trace pca9552_gpio_change
>>   1592690552.687372:pca9552_gpio_change pca1 GPIO id:0 status: 0 -> 1
>>   1592690552.690169:pca9552_gpio_change pca1 GPIO id:1 status: 0 -> 1
>>   1592690552.691673:pca9552_gpio_change pca1 GPIO id:2 status: 0 -> 1
>>   1592690552.696886:pca9552_gpio_change pca1 GPIO id:3 status: 0 -> 1
>>   1592690552.698614:pca9552_gpio_change pca1 GPIO id:13 status: 0 -> 1
>>   1592690552.699833:pca9552_gpio_change pca1 GPIO id:14 status: 0 -> 1
>>   1592690552.700842:pca9552_gpio_change pca1 GPIO id:15 status: 0 -> 1
>>   1592690683.841921:pca9552_gpio_change pca1 GPIO id:14 status: 1 -> 0
>>   1592690683.861660:pca9552_gpio_change pca1 GPIO id:14 status: 0 -> 1
>>   1592690684.371460:pca9552_gpio_change pca1 GPIO id:14 status: 1 -> 0
>>   1592690684.882115:pca9552_gpio_change pca1 GPIO id:14 status: 0 -> 1
>>   1592690685.391411:pca9552_gpio_change pca1 GPIO id:14 status: 1 -> 0
>>   1592690685.901391:pca9552_gpio_change pca1 GPIO id:14 status: 0 -> 1
>>   1592690686.411678:pca9552_gpio_change pca1 GPIO id:14 status: 1 -> 0
>>   1592690686.921279:pca9552_gpio_change pca1 GPIO id:14 status: 0 -> 1
>>
>> We notice the GPIO #14 (front-power LED) starts to blink.
>>
>> This LED is described in the witherspoon device-tree [*]:
>>
>>   front-power {
>>       retain-state-shutdown;
>>       default-state = "keep";
>>       gpios = <&pca0 14 GPIO_ACTIVE_LOW>;
>>   };
>>
>> [*] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts?id=b1f9be9392f0#n140
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/misc/pca9552.c    | 15 +++++++++++++++
>>  hw/misc/trace-events |  1 +
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
>> index f0d435e310..85557b78d9 100644
>> --- a/hw/misc/pca9552.c
>> +++ b/hw/misc/pca9552.c
>> @@ -60,6 +60,21 @@ static void pca9552_display_pins_status(PCA9552State *s)
>>          buf[i] = '\0';
>>          trace_pca9552_gpio_status(s->description, buf);
>>      }
>> +    if (trace_event_get_state_backends(TRACE_PCA9552_GPIO_CHANGE)) {
>> +        for (i = 0; i < s->nr_leds; i++) {
>> +            if (extract32(pins_changed, i, 1)) {
>> +                unsigned new_state = extract32(pins_status, i, 1);
>> +
>> +                /*
>> +                 * We display the state using the PCA logic ("active-high").
>> +                 * This is not the state of the LED, which signal might be
>> +                 * wired "active-low" on the board.
>> +                 */
>> +                trace_pca9552_gpio_change(s->description, i,
>> +                                          !new_state, new_state);
>> +            }
>> +        }
>> +    }
>>  }
>>  
>>  static void pca9552_update_pin_input(PCA9552State *s)
>> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
>> index 7630e59652..805d2110e0 100644
>> --- a/hw/misc/trace-events
>> +++ b/hw/misc/trace-events
>> @@ -209,3 +209,4 @@ grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx6
>>  
>>  # pca9552.c
>>  pca9552_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
>> +pca9552_gpio_change(const char *description, unsigned id, unsigned prev_state, unsigned current_state) "%s GPIO id:%u status: %u -> %u"
>>
> 
> 

