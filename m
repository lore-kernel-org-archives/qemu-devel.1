Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB470C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 08:51:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43DB5214F1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 08:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFEAsr83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DB5214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH1Fy-0003GF-E7
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 04:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH1FG-0002io-UG; Sat, 12 Sep 2020 04:50:54 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH1FF-0004Uf-9T; Sat, 12 Sep 2020 04:50:54 -0400
Received: by mail-wr1-x444.google.com with SMTP id e16so13664942wrm.2;
 Sat, 12 Sep 2020 01:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Dmc99agAnDVzyuJsSeHagbG/xUJi7YNXwJj8YYiPS/M=;
 b=HFEAsr83QKHRs4j4BjJm3YLvjcsAb7OwlYy+08VinHoWgGsKvTc4TO255seJr9XmdC
 JIeuW1iAjlSSFvXa7ImwyQxdV4b24ev7wRZJb7Vf1lh2Yw9KP1e3X9fPi1uZRV3jfJy1
 4lsYE+COgMFr0ryPBulBRFsldX0YHB1/GBuesCKbew8Fhz/gsPnzjtpajCVUOY5RTKr7
 zlNnpYgV5b2ngveSm9nUks/Tf4A4AD5hRYYIbAZdHHfw0AgbejvyMJFhcbvJjAO/i+0G
 xe2ewR4EAUOfVs2gz2G0JH/3A3nha+DA0EhxcTbwhVVBpFYB/zXL5unA9LsNkv2MJewp
 JivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Dmc99agAnDVzyuJsSeHagbG/xUJi7YNXwJj8YYiPS/M=;
 b=tUgP5jRwAWtjYEAxzYcTHih3BxMe/crbLrxSWnzq2HE4vIcEmYFIzfy3zSoIRYfL02
 O4FLtE88wUWvmFegSirQrPjuAdXfshb/kzaXb7TJu0s8RkShC9SoltXx2Yik70gS1oSH
 O93LW1eeCCZAs8LHneaJQlSwAZl0WIqy1jjyJJtnbZLhHTMBanwhPNcnae8qiyFJsk3W
 26GuqUwrexXz1PHy6071c1px3lnULu2VpSzaTQqyjolisico/enV0I68MZSvS60xEdld
 wdxBaQi+QlosWQ20djJPzsIWNW/g7RZFJzUtjq+SloEy8XKhWK4OAmBaMgBSwlLVFq+g
 +zRQ==
X-Gm-Message-State: AOAM533dPGIBXXXJzXy0clPGDwq2t2Y/5JsijVsVtnNhjeD/2dvRfgkB
 rrDoXQ2jX1Vmq7LOAZOXaT0=
X-Google-Smtp-Source: ABdhPJweJ9MJsZrl2V6UmGe8HoSCrXUeP+OtuY8t3XlR10La/AIzTUoaVWvbSvqJYxNMkIpsJNPlWA==
X-Received: by 2002:a5d:44cc:: with SMTP id z12mr6137485wrr.189.1599900651409; 
 Sat, 12 Sep 2020 01:50:51 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id f23sm16746310wmc.3.2020.09.12.01.50.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2020 01:50:50 -0700 (PDT)
Subject: Re: [PATCH v5 2/7] hw/misc/led: Allow connecting from GPIO output
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20200910205429.727766-1-f4bug@amsat.org>
 <20200910205429.727766-3-f4bug@amsat.org>
 <071b68a6-58e4-0d68-e056-ee7ae19e2227@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <db55f80e-ca2d-d432-134b-a05333a7e124@amsat.org>
Date: Sat, 12 Sep 2020 10:50:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <071b68a6-58e4-0d68-e056-ee7ae19e2227@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-2.469,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo is already in Cc, adding Markus.

On 9/12/20 12:44 AM, Richard Henderson wrote:
> On 9/10/20 1:54 PM, Philippe Mathieu-Daudé wrote:
>> Some devices expose GPIO lines.
>>
>> Add a GPIO qdev input to our LED device, so we can
>> connect a GPIO output using qdev_connect_gpio_out().
>>
>> When used with GPIOs, the intensity can only be either
>> minium or maximum. This depends of the polarity of the
>> GPIO (which can be inverted).
>> Declare the GpioPolarity type to model the polarity.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/hw/misc/led.h  |  8 ++++++++
>>  include/hw/qdev-core.h |  8 ++++++++
>>  hw/misc/led.c          | 17 ++++++++++++++++-
>>  3 files changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
>> index f5afaa34bfb..71c9b8c59bf 100644
>> --- a/include/hw/misc/led.h
>> +++ b/include/hw/misc/led.h
>> @@ -38,10 +38,16 @@ typedef struct LEDState {
>>      /* Public */
>>  
>>      uint8_t intensity_percent;
>> +    qemu_irq irq;
>>  
>>      /* Properties */
>>      char *description;
>>      char *color;
>> +    /*
>> +     * When used with GPIO, the intensity at reset is related
>> +     * to the GPIO polarity.
>> +     */
>> +    bool inverted_polarity;
> 
> Why are you not using the GpioPolarity enum that you added?

Because it is migrated...

Using DEFINE_PROP_BOOL() is simpler that adding hardware specific
enum visitor in hw/core/qdev-properties.c (which is included in
user-mode builds because pulled by the CPU type).

A sane cleanup would be to make get_enum(), set_enum()
and set_default_value_enum() public (prefixed with 'qdev_')
in include/hw/qdev-properties.h.

Out of the scope of this series, but might be worth it.

Eduardo, Markus, what do you think?

Thanks Richard for reviewing this series!

Phil.

