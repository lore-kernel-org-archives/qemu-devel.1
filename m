Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0056AC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F262064B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="co89W7Ol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F262064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8YE-0007Lf-Uu
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD89H-0003i0-Tw; Tue, 01 Sep 2020 11:24:39 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:53027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD89G-000734-8G; Tue, 01 Sep 2020 11:24:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id q9so1571635wmj.2;
 Tue, 01 Sep 2020 08:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6CDUTU1D+7Ao3iWeCaQFsPzGscbCBBSxZK330pNOH+c=;
 b=co89W7Olc02pGyV1Epaiscfzch8qtL9BJ1+0kFvG9MUOTAuVdcA0JbBWWFUKph8km8
 ZIjz8qxRx99FKwca1yytAwwWdCWGXsiDhclaTMZgsPc86r46YWpg8ihUHITkVFYHvWsa
 NZawQUDMJaasbZ8xzutGFiTps7s/SGv520Y8h0CMzTqPM2UzR/pGGthSJvIObpZxbkX2
 nzGf2HGoHmIQJMx/R7FLvrZ5RuKu8x3z37gC1HUo6lw7lF16uQh+rD0BdTQh3bICdbzk
 zL9DOHbt19twpZFK1fQT/kv+39W5NjtE2vYK3BIHTkr6ni+VxhWN7qolF26zQcDv/hYf
 1pBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6CDUTU1D+7Ao3iWeCaQFsPzGscbCBBSxZK330pNOH+c=;
 b=ptMcmfjFyI0z8teYCjCQ2XjyzNjCQWt24xhRpjazpc4CYqb1tuuIH7Xbg4jewXXVE0
 LlQvrKcYjLpxokoRzqwDldco71p4ZtDkDoiE7fWuUX3ClELAvs9bT47LPLVNIFapHPAH
 Crn3kXe2EsYcaUFjqhjA0cldEckDxVGr6izqIniveGFALX/27KfT/mtymhig7B06Te2y
 OuAQLUeFQDFvxkdT2e9cUeBRKxOlCBTuTrrkZZTxMjv+wqnyd0TCqvTid4Yi+lOctuGB
 w8q+5l8YNB+wquTdrjAEYDCVNIXSncmD8ZTEUHnrfiT1UutSmdV/DcxDb4OhfOpvWdW0
 45JA==
X-Gm-Message-State: AOAM533cUmUPNp8e0wu50rVGTIu+GBERPPzb7X5J4Akqy05XE/0hS0Sj
 KhRd7XZ3123UdCx6XlYdvm4r4yAa2Ow=
X-Google-Smtp-Source: ABdhPJzl4q4KcAgNKCq/vOoP96C1+mz2VkxQyIzR+lT/5vOdrI2TPlcVib4k92kEPJINWUNf1bzn9Q==
X-Received: by 2002:a1c:4303:: with SMTP id q3mr2250298wma.158.1598973876003; 
 Tue, 01 Sep 2020 08:24:36 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id v12sm2905740wri.47.2020.09.01.08.24.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 08:24:35 -0700 (PDT)
Subject: Re: [PATCH-for-5.1] hw/misc/milkymist-pfpu: Fix pFPU region size
To: Laurent Vivier <laurent@vivier.eu>
References: <20200718093705.7271-1-f4bug@amsat.org>
 <b0eb3028f61e6eaaf9c1f4aedefeaa20@walle.cc>
 <1819668f-4747-0cb7-69c0-e167af71e8ba@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <86a4c1c1-04b2-6a36-47ec-0cd0fba699df@amsat.org>
Date: Tue, 1 Sep 2020 17:24:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1819668f-4747-0cb7-69c0-e167af71e8ba@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.13,
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
Cc: qemu-trivial@nongnu.org, Michael Walle <michael@walle.cc>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 8:57 AM, Laurent Vivier wrote:
> Le 19/07/2020 à 19:23, Michael Walle a écrit :
>> Hi Philippe,
>>
>> Am 2020-07-18 11:37, schrieb Philippe Mathieu-Daudé:
>>> The last microcode word (address 0x6000.6ffc) is not reachable.
>>> Correct the programmable FPU I/O size (which is 4 KiB) to be
>>> able to use all the microcode area.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  hw/misc/milkymist-pfpu.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
>>> index 516825e83d..4fbe3e8971 100644
>>> --- a/hw/misc/milkymist-pfpu.c
>>> +++ b/hw/misc/milkymist-pfpu.c
>>> @@ -507,7 +507,7 @@ static void milkymist_pfpu_realize(DeviceState
>>> *dev, Error **errp)
>>>      sysbus_init_irq(sbd, &s->irq);
>>>
>>>      memory_region_init_io(&s->regs_region, OBJECT(dev),
>>> &pfpu_mmio_ops, s,
>>> -            "milkymist-pfpu", MICROCODE_END * 4);
>>> +                          "milkymist-pfpu", 0x1000);
>>
>> Could you use one of the MICROCODE_ macros instead? maybe
>> (MICROCODE_WORDS * 2)?
>>
>> With that fixed:
>> Reviewed-by: Michael Walle <michael@walle.cc>
>>
> 
> Philippe,
> 
> do you plan to repost with the change suggested by Michael?

Unfortunately I won't :( I spent 3h trying to do that, then found
myself rewriting half of the pfpu because this is not that easy, and
this code is now scheduled for deprecation. Not worth my time :(

> 
> Thanks,
> Laurent
> 

