Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E706C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58AED20663
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CupwCTMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58AED20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkrpw-0000Bg-Kx
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkroX-0007A1-RH; Mon, 15 Jun 2020 12:18:25 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:40071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkroW-0004B7-0H; Mon, 15 Jun 2020 12:18:25 -0400
Received: by mail-ed1-x544.google.com with SMTP id p18so11956526eds.7;
 Mon, 15 Jun 2020 09:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zC4goslGunDLLrNxY4ATSQMQcFz/lPFddQgtcjnZqng=;
 b=CupwCTMOUfSPgQPbktUrbFB2lbOSeajPPY4L1qlAjtuHSD2rXpOfsFzT7Ck46gl832
 aREtpQYp7HItdSj+3fauiwZKhJZeT0oOQ/L25ObpuXYAzqwMxI/VPZd101Iz4szdmNN2
 v+cZ9FZJ9nJ3MyDgTh1hWik7BA/XCoBSJU6SS2YAbt4eYVIm51apwYmVwyTwhBbiQRim
 AUP/P8GpXXu5G/AVVsBwL+4g3duT7ht/tEzrAbDKeVrg3Rb8s4rSqzboZ1r2Uowj/t0O
 OlQRNLVRgGsGGdaPGEG1O6IxUblEOW8yzY/KFYoljMJPJnm7Q8CeracGw8+hREdlpFjq
 bI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zC4goslGunDLLrNxY4ATSQMQcFz/lPFddQgtcjnZqng=;
 b=Zz27/UENbbf5Sx8xew4JrZDEN+nXAhO9AGQRmHIq56iwjq5XHEA3+H3CXkuvkyqlBD
 izEmf97wcExdGOHoE2elUGkqjo35T3uiKkQFvGzAezr59fDZUk45iC43q8m4rooYPAKF
 42Rgo80B6hVy/Me+4hSdqaT0Id57L3uyklYVyoN83g7XlFKLmkWWGFFbBLAN/497od5s
 W7USbLsEwE0UG95G/t26bP7WOeRfr++qMOk3E3Uez7hYGKxFggvWFmZWICZ4ntpWMCnH
 N3x5Xxh1WrEVqiCwzfFXHRluID879BuWV3w1BS9JYVVrpkiqPLvYut7LotNuoQST79ze
 4iPQ==
X-Gm-Message-State: AOAM53065H7gZViyenEgczfEYBz3iWp37+IYv2kuRiNoj/jbICCEfU7V
 xvndXa4L6Hajn82hdo+sFyWIEf82
X-Google-Smtp-Source: ABdhPJyoRFAdV2eP4lLeGb9/JfwVlgRLtlGFEf3MyV3X7DmdmuGAkNQ1whkcAqOAXdrqNG9bSy7WwA==
X-Received: by 2002:a50:a701:: with SMTP id h1mr23910970edc.170.1592237901453; 
 Mon, 15 Jun 2020 09:18:21 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id g22sm8676688edj.63.2020.06.15.09.18.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 09:18:20 -0700 (PDT)
Subject: Re: [RFC PATCH v2 5/5] hw/arm/tosa: Use LED device for the Bluetooth
 led
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200612175440.9901-1-f4bug@amsat.org>
 <20200612175440.9901-6-f4bug@amsat.org>
 <CAFEAcA9tMd0VxEm_O1yre36kWp0U48SZj8tMna25h5M02X-_VQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d2f6adcc-a796-26bf-9463-5e9bbc143197@amsat.org>
Date: Mon, 15 Jun 2020 18:18:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9tMd0VxEm_O1yre36kWp0U48SZj8tMna25h5M02X-_VQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 6:00 PM, Peter Maydell wrote:
> On Fri, 12 Jun 2020 at 18:54, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/arm/tosa.c  | 7 +++----
>>  hw/arm/Kconfig | 1 +
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
>> index 5dee2d76c6..86d7e0283a 100644
>> --- a/hw/arm/tosa.c
>> +++ b/hw/arm/tosa.c
>> @@ -24,6 +24,7 @@
>>  #include "hw/irq.h"
>>  #include "hw/ssi/ssi.h"
>>  #include "hw/sysbus.h"
>> +#include "hw/misc/led.h"
>>  #include "exec/address-spaces.h"
>>
>>  #define TOSA_RAM    0x04000000
>> @@ -68,9 +69,6 @@ static void tosa_microdrive_attach(PXA2xxState *cpu)
>>  static void tosa_out_switch(void *opaque, int line, int level)
>>  {
>>      switch (line) {
>> -        case 0:
>> -            fprintf(stderr, "blue LED %s.\n", level ? "on" : "off");
>> -            break;
>>          case 1:
>>              fprintf(stderr, "green LED %s.\n", level ? "on" : "off");
>>              break;
> 
> Why convert the blue LED and not the green, amber or wlan LEDs ?

I don't have the schematics to verify the mapping is correct:

#define TOSA_GPIO_BT_LED		(TOSA_SCOOP_JC_GPIO_BASE + 0)
#define TOSA_GPIO_NOTE_LED		(TOSA_SCOOP_JC_GPIO_BASE + 1)
#define TOSA_GPIO_CHRG_ERR_LED		(TOSA_SCOOP_JC_GPIO_BASE + 2)
#define TOSA_GPIO_TC6393XB_L3V_ON	(TOSA_SCOOP_JC_GPIO_BASE + 5)
#define TOSA_GPIO_WLAN_LED		(TOSA_SCOOP_JC_GPIO_BASE + 7)

static void tosa_out_switch(void *opaque, int line, int level)
{
    switch (line) {
        case 0:
            fprintf(stderr, "blue LED %s.\n", level ? "on" : "off");
            break;
        case 1:
            fprintf(stderr, "green LED %s.\n", level ? "on" : "off");
            break;
        case 2:
            fprintf(stderr, "amber LED %s.\n", level ? "on" : "off");
            break;
        case 3:
            fprintf(stderr, "wlan LED %s.\n", level ? "on" : "off");
            break;
        default:
            fprintf(stderr, "Uhandled out event: %d = %d\n", line, level);
            break;
    }
}

    qdev_connect_gpio_out(scp1, TOSA_GPIO_BT_LED, outsignals[0]);
    qdev_connect_gpio_out(scp1, TOSA_GPIO_NOTE_LED, outsignals[1]);
    qdev_connect_gpio_out(scp1, TOSA_GPIO_CHRG_ERR_LED, outsignals[2]);
    qdev_connect_gpio_out(scp1, TOSA_GPIO_WLAN_LED, outsignals[3]);

I wanted a simple proof-of-concept I could test with a board,
to show how easy this API can be used.

Using the binaries from here:
https://www.omegamoon.com/blog/static.php?page=ZaurusAndroid

the blue LED never blinks, probably because we remove the
bluetooth stack. Or maybe I haven't figured the correct
command line options.

For the next RFC I plan to rework to have a single LED container
per board, to have a unique singleton object that generates QMP
events.

> 
> thanks
> -- PMM
> 

