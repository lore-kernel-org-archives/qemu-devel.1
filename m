Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F4CC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160F920674
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4cS1wby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160F920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrlRE-0005ah-DU
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrlQg-00053c-IL; Sat, 04 Jul 2020 12:54:18 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrlQe-0008Kc-Vj; Sat, 04 Jul 2020 12:54:18 -0400
Received: by mail-wr1-x442.google.com with SMTP id f18so27893726wrs.0;
 Sat, 04 Jul 2020 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fO+tXrfCfBSO/ZEgw8svjFvRYJwYMgQJLIxHnOYe2QA=;
 b=b4cS1wbyFlKgeRS6fOi/7BE/y4cILmkgaLe8ywltjleByv5tVXzq+MOjAQn/TICclJ
 aSEAz9RjoTo8x7XaZnWNVd263VskNO7z4pBqoNFPsrxTsxSugFRwMk5Y1rF3HGdQ+WxP
 duX0UUHqfuq6uFpyYEJBqHg6OWsHMfhV9atKYcKtJn5h9JuZ1EGjiLwXiaNtsKDgZfLy
 jGAY8R3oMHaVdXWgLpQMO2k0bpzlT0931Fx9q6rIDMNzRFQz/1UKW2a7WRCc9cu++n7e
 NB+fr/93R8ppmWn9lkNYbEbomHEnJibmRmBaoheRNHhrzcUzs7EbLrgsZtpMDiliAxQW
 vbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fO+tXrfCfBSO/ZEgw8svjFvRYJwYMgQJLIxHnOYe2QA=;
 b=fon9qA6RkGil+opfyHXApq6hHldB07psIcekCA8rhhbJrwXGHrmvGCB1EW+jSWpk99
 lG5YVGIrvG1kcECluDiwZ44nxzRPfFGtbxdUOOD3bMO/7G0PwVdCBqSpmvTQBCs3BF38
 HBDuni+s8Ol27+HiNOGk7D0m157EAankxiq3LbAL/2/McquD5Alh34PZ/oNtqqkJKx+0
 g2QWF6wZRq0QTogpdkLJ+o44VOzPr0u/FcNnNvU3XAKsrUADGS5ZtFOD1GOP9qxzdgF2
 0V761XpyhxucgzBCZBtd4c1uKztxXNAQBaDm8RedpT8sv+34zF1629jOhjewSm2rxAys
 ky6Q==
X-Gm-Message-State: AOAM530xnjAUDEn7IBN1yXvHJn/+LstJ5A8UdVS8FlhGBaf80c7j0Fme
 2xywA+xT/3+FtxCWbXd+3ZQ=
X-Google-Smtp-Source: ABdhPJwLtPgQKKFlia7fAFYeW0e+JRhaA1BKx8fZjMex8iHmmeZUSyKMOrT+S8iUOPQalHzIBRC6wg==
X-Received: by 2002:adf:ee05:: with SMTP id y5mr43094676wrn.185.1593881654865; 
 Sat, 04 Jul 2020 09:54:14 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r1sm16903548wrw.24.2020.07.04.09.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 09:54:14 -0700 (PDT)
Subject: Re: [RFC PATCH v2 3/3] hw/misc/auxbus: Fix MOT/classic I2C mode
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20200623063123.20776-1-f4bug@amsat.org>
 <20200623063123.20776-4-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2006231304300.23200@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <04fd281c-4d52-5121-c38d-237ed65883d1@amsat.org>
Date: Sat, 4 Jul 2020 18:54:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2006231304300.23200@zero.eik.bme.hu>
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Frederic Konrad <konrad@adacore.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 1:06 PM, BALATON Zoltan wrote:
> On Tue, 23 Jun 2020, Philippe Mathieu-Daudé wrote:
>> Since its introduction in commit 6fc7f77fd2 i2c_start_transfer()
>> uses incorrectly the direction of the transfer. Fix it now.
>>
>> Fixes: 6fc7f77fd2 ("introduce aux-bus")
>> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
> 
> One of the above is probably enough, maybe Reported-by because I wasn't
> sure what's the solution. I'm also happy with your changes to the whole
> series, thanks for fixing it.

Hopefully the maintainer taking this series can simply remove
the Suggested-by tag directly. Else I can respin if it is easier.

> 
> Regards,
> BALATON Zoltan
> 
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> RFC because untested (probably never was anyway)
>> Cc: Frederic Konrad <konrad@adacore.com>
>> Cc: Alistair Francis <alistair@alistair23.me>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> hw/misc/auxbus.c | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
>> index cef0d0d6d0..dc4a5dd10d 100644
>> --- a/hw/misc/auxbus.c
>> +++ b/hw/misc/auxbus.c
>> @@ -141,7 +141,7 @@ AUXReply aux_request(AUXBus *bus, AUXCommand cmd,
>> uint32_t address,
>>             i2c_end_transfer(i2c_bus);
>>         }
>>
>> -        if (i2c_start_transfer(i2c_bus, address, is_write)) {
>> +        if (i2c_start_transfer(i2c_bus, address, !is_write)) {
>>             ret = AUX_I2C_NACK;
>>             break;
>>         }
>> @@ -172,7 +172,7 @@ AUXReply aux_request(AUXBus *bus, AUXCommand cmd,
>> uint32_t address,
>>             /*
>>              * No transactions started..
>>              */
>> -            if (i2c_start_transfer(i2c_bus, address, is_write)) {
>> +            if (i2c_start_transfer(i2c_bus, address, !is_write)) {
>>                 break;
>>             }
>>         } else if ((address != bus->last_i2c_address) ||
>> @@ -181,7 +181,7 @@ AUXReply aux_request(AUXBus *bus, AUXCommand cmd,
>> uint32_t address,
>>              * Transaction started but we need to restart..
>>              */
>>             i2c_end_transfer(i2c_bus);
>> -            if (i2c_start_transfer(i2c_bus, address, is_write)) {
>> +            if (i2c_start_transfer(i2c_bus, address, !is_write)) {
>>                 break;
>>             }
>>         }
>>

