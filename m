Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE70C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 07:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B983A20674
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 07:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mm4W6kEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B983A20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgNRS-00081x-Vp
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 03:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1jgNQS-0007X5-CC; Wed, 03 Jun 2020 03:03:00 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1jgNQR-0003wJ-FY; Wed, 03 Jun 2020 03:02:59 -0400
Received: by mail-pf1-x441.google.com with SMTP id b16so968496pfi.13;
 Wed, 03 Jun 2020 00:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W8gEcy6pzQDAPp2y85iZFtFSkLFAlCU0ZdRrzjgoa2Y=;
 b=Mm4W6kEdDGgCX4+IF148D/R42u+dsRyS2TB4pB3vPaT8JPghEyvDrkSx7XvbLKEaNx
 eUrFzoLDILoFfqirh6CwrtBnzlbM73aZMQ7r+0s0wLF2vnsvNgbsX498xxDCWHaKegPg
 nhnCa3zeVav6ADC2Tg3IjVsmsI4jxCf0LIvvc/6+Ccl5r4VScvmIQ9YufazXzq57RfNg
 NwfdVgXjnWWMafq9CGjj1WrCjJskB0/Bqks6N/gJB7KeTbhOD2WjTuoDr0NvpvCGLt0m
 ib8Rrfg8KkGgk7JxiZCP1O3kY4tjJoR9XLF34qwpA8izco4msNkjwC7s2M7bRQYzImeB
 mNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=W8gEcy6pzQDAPp2y85iZFtFSkLFAlCU0ZdRrzjgoa2Y=;
 b=Q812Oce57ZMnQO6KNl+GBKxkDsdm22KK6xi2Ul1WOddhu/I1PCYUbuMgO+aH2eOobD
 W64/1AmWiTC3EXuS4hul7jIP3cFyhJU9TIWE9GJDg3ZUOpCnuS4/ATlimPdOCkZD7dnj
 9AwnL0Uzn0P/qdomQLuXQhc6MFEa69CgaJpl59WPbZW1NNkRld2EoC2Xte+chhefhV5X
 UkbUyn1rdYccL3SNmGYm/LXXEg2Sc0D7j5sN3maQ7VkhYoT/rZXcfEhXz3WkOet3G6kl
 Ktns5I+CV2jcsdHnqBM81miWZx9x1Ghf/BHSTEjDDf9qN30siUQkYze0ur7DghNNy5Th
 iWJw==
X-Gm-Message-State: AOAM532BKkgzEO7LbZ18DarWQV5INcgJAonJsUPaJTXJ/Ucn37TE4YVz
 uQ9qqnNj/R2n3WNRj55Wue6Nug1i
X-Google-Smtp-Source: ABdhPJx6fH7nu99VJhoOpAnpKtjeePVp0wwcrPscI4SdFJcdNbI99vwip+dQnHux93N3fIx+b+wLyA==
X-Received: by 2002:a65:5a01:: with SMTP id y1mr19269757pgs.233.1591167777586; 
 Wed, 03 Jun 2020 00:02:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 x11sm1008501pfm.196.2020.06.03.00.02.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 00:02:57 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw: arm: Set vendor property for IMX SDHCI emulations
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200603052404.30788-1-linux@roeck-us.net>
 <20200603052404.30788-3-linux@roeck-us.net>
 <ccd8a8a5-0d40-2060-e9ea-c64c44a7d688@amsat.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <382362f4-fbdc-5756-bc01-272af9e99185@roeck-us.net>
Date: Wed, 3 Jun 2020 00:02:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ccd8a8a5-0d40-2060-e9ea-c64c44a7d688@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 11:35 PM, Philippe Mathieu-Daudé wrote:
> Hi Guenter,
> 
> On 6/3/20 7:24 AM, Guenter Roeck wrote:
>> Set vendor property to IMX to enable IMX specific functionality
>> in sdhci code.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  hw/arm/fsl-imx25.c  | 2 ++
>>  hw/arm/fsl-imx6.c   | 2 ++
>>  hw/arm/fsl-imx6ul.c | 2 ++
>>  hw/arm/fsl-imx7.c   | 2 ++
>>  4 files changed, 8 insertions(+)
>>
>> diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
>> index cdaa79c26b..2cbd985e93 100644
>> --- a/hw/arm/fsl-imx25.c
>> +++ b/hw/arm/fsl-imx25.c
>> @@ -274,6 +274,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
>>                                   &err);
>>          object_property_set_uint(OBJECT(&s->esdhc[i]), IMX25_ESDHC_CAPABILITIES,
>>                                   "capareg", &err);
>> +        object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
>> +                                 "vendor", &err);
> 
> Either check &err, or use &error_abort.
> 

Ok, I'll follow the guidance from the patch pointed to below
and add the error check.

Thanks,
Guenter

> You can see a fix here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg695544.html
> 
> Otherwise:
> 
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
>>          object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized", &err);
>>          if (err) {
>>              error_propagate(errp, err);
>> diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
>> index f58c85aa8c..8e9a94e4d7 100644
>> --- a/hw/arm/fsl-imx6.c
>> +++ b/hw/arm/fsl-imx6.c
>> @@ -350,6 +350,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
>>                                   &err);
>>          object_property_set_uint(OBJECT(&s->esdhc[i]), IMX6_ESDHC_CAPABILITIES,
>>                                   "capareg", &err);
>> +        object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
>> +                                 "vendor", &err);
>>          object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized", &err);
>>          if (err) {
>>              error_propagate(errp, err);
>> diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
>> index 3ecb212da6..ce1462927c 100644
>> --- a/hw/arm/fsl-imx6ul.c
>> +++ b/hw/arm/fsl-imx6ul.c
>> @@ -505,6 +505,8 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
>>              FSL_IMX6UL_USDHC2_IRQ,
>>          };
>>  
>> +        object_property_set_uint(OBJECT(&s->usdhc[i]), SDHCI_VENDOR_IMX,
>> +                                        "vendor", &error_abort);
>>          object_property_set_bool(OBJECT(&s->usdhc[i]), true, "realized",
>>                                   &error_abort);
>>  
>> diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
>> index 89c3b64c06..dbf16b2814 100644
>> --- a/hw/arm/fsl-imx7.c
>> +++ b/hw/arm/fsl-imx7.c
>> @@ -416,6 +416,8 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
>>              FSL_IMX7_USDHC3_IRQ,
>>          };
>>  
>> +        object_property_set_uint(OBJECT(&s->usdhc[i]), SDHCI_VENDOR_IMX,
>> +                                 "vendor", &error_abort);
>>          object_property_set_bool(OBJECT(&s->usdhc[i]), true, "realized",
>>                                   &error_abort);
>>  
>>
> 


