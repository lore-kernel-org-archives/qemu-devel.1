Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A97C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 10:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF75020787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 10:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQil5HGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF75020787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBrz-0001vE-0T
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 06:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyBqo-0000ry-ET; Wed, 22 Jul 2020 06:19:50 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:35119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyBqm-0006Wb-TR; Wed, 22 Jul 2020 06:19:50 -0400
Received: by mail-ej1-x642.google.com with SMTP id rk21so1643265ejb.2;
 Wed, 22 Jul 2020 03:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+3cwYKGXMrE5BasGoOhTkvyaax9meai/zFmaQjmOqRo=;
 b=AQil5HGVzw9zkPQNItcpbN3UkaYFQ38KKjzQ3sx8qCKInfIR+endRZHbvuV/9m8YTo
 +UMoFYfc8pHt5DjV6ltPC+iEXElIASYI3Ix90/432ca2BFip1UtoQBbyKVVa9p0I/Gmc
 Ojr6Rp1FXT4UhUXGFoPWm94sJ+YNRsBFuVvHqqAxDODaqEqpPimE0kHIVSOdY0sEhCvH
 6hkR22INiemL3A2FZTtnmWYktUqVwn7PZgNynOP4Fkaf4Lh7Kt2TmF0rc8wkpSUVpctR
 Qbx7MA9FLRsnzCecgmjNVCHNV9VoDDyzvDtLQp4Xi7ohtg3Ifg1lazr1ldS+Tl5+UBDy
 O8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+3cwYKGXMrE5BasGoOhTkvyaax9meai/zFmaQjmOqRo=;
 b=isvW5MZCEJgHbYQ2wq6sQ2Pdrb9KaIK7wStp0ZdgJ2FEm9dRhHH4PZukrm6rM4BaGC
 j0hHyL6TaWSS0bM4uJqqcU6TCvE7tesRU5RMf7JUyjxWNrJzVWSd9bT14LodjB0KzJCJ
 +jiDCGO6VqQelTzHNsOAw/rSTN8UEjWqKv9FHg0ZwNVDILozymtx7lQaRDhYaUEgiuu8
 c71b8N3GIGViHzzxYkoeXhYkSjMTL330QYzAQuRfOrkKPxxBeq6n8CtRqUXLVaeMtJUG
 3bXcprUfpROPFKoGikS8zzl4F/2Dg3sIaUR+8QLGQz8eCN6KGZD7nkky+wOpJmrtZfBx
 AFJw==
X-Gm-Message-State: AOAM530p/FawQ8L/zsG5xpZmUfG8P+4qwxkZK3Tf4EMJ/CtDvIpZs1GP
 ckYWIGcGmGTqQHQcuZqQ9XE=
X-Google-Smtp-Source: ABdhPJzHRWNp5Oky+eutYhjPBplSjuC4dGWf/+I3NTphcwmyu0cgcTYU6FOY6M9lasTJaWZ/dvrG4w==
X-Received: by 2002:a17:906:774d:: with SMTP id
 o13mr29017624ejn.373.1595413186351; 
 Wed, 22 Jul 2020 03:19:46 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id e16sm18393261ejt.14.2020.07.22.03.19.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 03:19:45 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] m25p80: Improve command handling for Jedec commands
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Guenter Roeck <linux@roeck-us.net>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>
References: <20200206183219.3756-1-linux@roeck-us.net>
 <20200206183219.3756-2-linux@roeck-us.net>
 <eb21047a-aa9f-eb39-af8a-b5858e01fee5@kaod.org>
 <0ae638a0-6e74-c32b-a5bb-6a89ae5b819f@roeck-us.net>
 <83f26c3b-cc7e-585a-1eae-2d7d9adb30af@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ad6b4998-a201-fd88-6558-261e641a5322@amsat.org>
Date: Wed, 22 Jul 2020 12:19:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <83f26c3b-cc7e-585a-1eae-2d7d9adb30af@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Erik Smit <erik.lucas.smit@gmail.com>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 10:02 AM, Cédric Le Goater wrote:
> On 7/21/20 9:57 PM, Guenter Roeck wrote:
>> On 7/21/20 10:36 AM, Cédric Le Goater wrote:
>>> Hello,
>>>
>>> On 2/6/20 7:32 PM, Guenter Roeck wrote:
>>>> When requesting JEDEC data using the JEDEC_READ command, the Linux kernel
>>>> always requests 6 bytes. The current implementation only returns three
>>>> bytes, and interprets the remaining three bytes as new commands.
>>>> While this does not matter most of the time, it is at the very least
>>>> confusing. To avoid the problem, always report up to 6 bytes of JEDEC
>>>> data. Fill remaining data with 0.
>>>>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>> v2: Split patch into two parts; improved decription
>>>>
>>>>  hw/block/m25p80.c | 5 ++++-
>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>>>> index 5ff8d270c4..53bf63856f 100644
>>>> --- a/hw/block/m25p80.c
>>>> +++ b/hw/block/m25p80.c
>>>> @@ -1040,8 +1040,11 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>>>>          for (i = 0; i < s->pi->id_len; i++) {
>>>>              s->data[i] = s->pi->id[i];
>>>>          }
>>>> +        for (; i < SPI_NOR_MAX_ID_LEN; i++) {
>>>> +            s->data[i] = 0;
>>>> +        }
>>>
>>> This is breaking an old firmware (Linux version 2.6.28.9) for a SuperMicro
>>> board : 
>>>
>>> 	https://www.supermicro.com/en/products/motherboard/X11SSL-F 
>>>
>>> which expects the flash ID to repeat. Erik solved the problem with the patch 
>>> below and I think it makes sense to wrap around. Anyone knows what should be 
>>> the expected behavior ? 
>>>
>>
>> No idea what the expected behavior is, but I am fine with the code below
>> if it works.
> 
> I checked on a few real systems and indeed the mx25l25635e behaves
> differently.
> 
> AST2400
> 
> [    5.594176] aspeed-smc 1e620000.spi: reading JEDEC ID 20:BA:19:10:00:00
> [    5.602226] aspeed-smc 1e620000.spi: n25q256a (32768 Kbytes)
> ...
> [    6.174052] aspeed-smc 1e630000.spi: reading JEDEC ID C2:20:19:C2:20:19
> [    6.181682] aspeed-smc 1e630000.spi: mx25l25635e (32768 Kbytes)
> 
> AST2500
> 
> [    1.641317] aspeed-smc 1e620000.spi: reading JEDEC ID EF:40:19:00:00:00
> [    1.648174] aspeed-smc 1e620000.spi: w25q256 (32768 Kbytes)
> ...
> [    1.179214] aspeed-smc 1e630000.spi: reading JEDEC ID EF:40:19:00:00:00
> [    1.186737] aspeed-smc 1e630000.spi: w25q256 (32768 Kbytes)
> 
> AST2600
> 
> [    1.020255] aspeed-smc 1e620000.spi: reading JEDEC ID EF:40:20:00:00:00
> [    1.027830] aspeed-smc 1e620000.spi: w25q512jv (65536 Kbytes)
> ...
> [    1.884171] aspeed-smc 1e630000.spi: reading JEDEC ID EF:40:19:00:00:00
> [    1.890937] aspeed-smc 1e630000.spi: w25q256 (32768 Kbytes)

FWIW QEMU models this one as 64KiB.

> 
> 
> I think we need a special case for it.
> 
> C. 
> 


