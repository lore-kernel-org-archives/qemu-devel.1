Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43233C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:01:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2392071A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2QQstd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2392071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkqc8-00056g-7X
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 11:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1jkqaX-0003xb-4V; Mon, 15 Jun 2020 10:59:53 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1jkqaV-00043P-6z; Mon, 15 Jun 2020 10:59:52 -0400
Received: by mail-pg1-x542.google.com with SMTP id s10so7726142pgm.0;
 Mon, 15 Jun 2020 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OO0w3uVnv3TBcjEAMx/SA8ptSXyEaj7w2t3ZvIFQMts=;
 b=U2QQstd+rmTYQksOEhWUgMP98sCR8Sc6AGC8uF1IETB8HCtAHkye8KW7C9TIGX8ltY
 ixhefjOhhMhF9JpUgF8e8n2Gq4lYrGjJb2k9m5KOmYvfue4FsVztxdAK49n3weu4fEk+
 YQ+rKuFG22DRHmGiS92lDc44++z7G/tDvDgkfz8Ux3CPfH7p3XbsX+MPtGt082t5Ppva
 qrH+x3+ACPQp5yhFjyQiETfVV05nX/fa7dSkpdojOXhi0CuEmMVF/baKWRu0PctfQ2RJ
 E3/MXYgDyl4UnAkG2O/eNnsMvaRVM6t7toIaXjJ/2lg4HCXLLSkqkJkXr8Reu2aDQCFF
 VGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=OO0w3uVnv3TBcjEAMx/SA8ptSXyEaj7w2t3ZvIFQMts=;
 b=GPwLlY1789LIKfSpL2+KKDWRL/Rw0OV1ELptonO6b/gVvR9dJr2wRgcLAIVW5+vQJA
 +qv2EAIJFrdXZrx+mrpNxmJg+Vk8H/uSwQ20q4WdBNTIDsVttJmTMYLu3qf0b24xHtwq
 TwuksJJL/wom3A1do0rcWZKR2jY9G1CPkjy39Gi62zCfP+1S8rF1NU3s8sHb+3p0RXX2
 BJFFYX7auWddpnxyRo0DJSi3egzxj+KKlZ+7VPFNJeu+IGfnmn+JizgUSIVsl8wBGq3w
 GtrZVr9GxYPgGzw+MKxNRvzBhs41kLmL5zzJmEV3goqxNOeS86w0g31l3sqvzn6KmyKn
 X4sw==
X-Gm-Message-State: AOAM533FdxuSW5HqX6E8eUGbJqRrGsUtmrbbowe1buoAStKOguVi9FRo
 N8kYjoANFj2YL5/+L4UwKBpD5PpN
X-Google-Smtp-Source: ABdhPJxcwDReBqzn9WcP8RibxTgcXWTrTjv1RIbtLkbL9KVcAg5+Jpw/UzJdxKtS5a0wRdsLECC24w==
X-Received: by 2002:a63:7844:: with SMTP id t65mr21943592pgc.382.1592233188703; 
 Mon, 15 Jun 2020 07:59:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 k18sm14366448pfp.208.2020.06.15.07.59.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 07:59:47 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] hw: arm: Set vendor property for IMX SDHCI
 emulations
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200603145258.195920-1-linux@roeck-us.net>
 <20200603145258.195920-3-linux@roeck-us.net>
 <CAFEAcA9HE0Be9QNfGKxp4YL-V_+khUNS4KOL43LBC9mQd75eLA@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <5fcdc717-9313-010b-e713-8bf09921dae8@roeck-us.net>
Date: Mon, 15 Jun 2020 07:59:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9HE0Be9QNfGKxp4YL-V_+khUNS4KOL43LBC9mQd75eLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 6:18 AM, Peter Maydell wrote:
> On Wed, 3 Jun 2020 at 15:53, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Set vendor property to IMX to enable IMX specific functionality
>> in sdhci code.
>>
>> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Added missing error checks
>>     Added Philippe's Tested-by: tag
>>
>>  hw/arm/fsl-imx25.c  | 6 ++++++
>>  hw/arm/fsl-imx6.c   | 6 ++++++
>>  hw/arm/fsl-imx6ul.c | 2 ++
>>  hw/arm/fsl-imx7.c   | 2 ++
>>  4 files changed, 16 insertions(+)
>>
>> diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
>> index cdaa79c26b..a853ffcc00 100644
>> --- a/hw/arm/fsl-imx25.c
>> +++ b/hw/arm/fsl-imx25.c
>> @@ -274,6 +274,12 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
>>                                   &err);
>>          object_property_set_uint(OBJECT(&s->esdhc[i]), IMX25_ESDHC_CAPABILITIES,
>>                                   "capareg", &err);
>> +        object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
>> +                                 "vendor", &err);
>> +        if (err) {
>> +            error_propagate(errp, err);
>> +            return;
>> +        }
> 
> The existing error handling in this function is wrong -- for multiple
> calls that take a pointer to a local Error*, the
> check-and-error_propagate() has to be done after each call, it can't
> be rolled up into a single check after all the calls. (see
> include/qapi/error.h for the patterns that are valid).
> 

A fix for that problem was submitted by Philippe:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg695544.html

Thanks,
Guenter

