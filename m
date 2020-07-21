Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF82C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 09:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0605220714
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 09:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ufJ/79TG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0605220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxoEl-00035t-AB
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 05:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxoEA-0002a1-0y; Tue, 21 Jul 2020 05:06:22 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44409)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxoE8-0006YF-Bh; Tue, 21 Jul 2020 05:06:21 -0400
Received: by mail-wr1-x443.google.com with SMTP id b6so20386712wrs.11;
 Tue, 21 Jul 2020 02:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kkQkCi99vHx+eDY9rO9FaACF0oMgwEEUz5GYDaZPIU0=;
 b=ufJ/79TG8DMuZqWPxwClxJHAndwxw/6WaV7ZEqeDxa/1+eh7Hb7+OLqNiVq98D+bJb
 D/u0FrINwSGTVc1Z0R3604r4lls0wAxknak7herMjeFdc1oLqSwLk+ydNa91DkkH4Oi4
 H/Pi8uFPmdURx2DSTwWGeCtdV5Ft8Jr2VQ/+qhl/OtBMQ+TANKpIwG8aC7HGQpI23849
 kP32czq5fgbkGlsiARJcnCCFiNUzLK5j4YO9wI7RTm0Y81GZbfSRNrnnE/KPJvRyQuTm
 f3jIV+aNnGr/qffzOlY91g9qGuSLcwcp4JTp3iUawjfoE+C/N5SCcnkfx92rbS9bUvMp
 oyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kkQkCi99vHx+eDY9rO9FaACF0oMgwEEUz5GYDaZPIU0=;
 b=etWcETtwufKv7U4zB1ga29BCw3H6L+cdgqJh0MKz5EhAyHRKGkctGb+Q/pLhbEGMhV
 MS03C5h9ZvHt92gmRW4/LVbtsM1eAqb4LZYR0j31nNLkpJM3bMMt+9raGH9onSqC3mQd
 xnB2PT8sfclhP2DMhfvtWSvPLC+fCLTpnlf5IirPSg4X5XXfW3xROvpeh2O+lFB4FIAH
 6Lal6uFtQoqvCm6n+HQwELBWqL7vsS9egc/8GRgs0oyNZonvgO7uTdSMQkxuH6935aGu
 ygBw/N/SqSJHc2qW7WlBLUR35rHQHuxKCJdyPZ0sl0fUlop4dMLy67Y7CVtHm6zUCuAj
 WVLw==
X-Gm-Message-State: AOAM533/SXElP1H9ptQ4dS8SUjbr+toE2gxnMJqkmlxaXBHhx8aOOv/g
 J0h8nrw1ymkJEMWZF3HKjkM=
X-Google-Smtp-Source: ABdhPJw6/1ChpwfkvdPS5oCTLR7iTYOLa5jWyukGAM+d+EefHZBwFz7puG3/GLsTMOghswADlePBdw==
X-Received: by 2002:adf:de08:: with SMTP id b8mr7799820wrm.4.1595322378162;
 Tue, 21 Jul 2020 02:06:18 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id q7sm37147789wra.56.2020.07.21.02.06.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 02:06:17 -0700 (PDT)
Subject: Re: [PATCH-for-5.1] hw/misc/aspeed_sdmc: Fix incorrect memory size
To: Markus Armbruster <armbru@redhat.com>
References: <20200720095829.22839-1-f4bug@amsat.org>
 <ed5e6bd0-0962-b182-3348-d3c6655ef35e@kaod.org>
 <f7dc7d48-6fd7-e1ba-f94b-cd2764490eb7@amsat.org>
 <877duxb819.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cf4153b1-e92d-d12a-6535-c4cf40d87953@amsat.org>
Date: Tue, 21 Jul 2020 11:06:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <877duxb819.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/21/20 10:13 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> On 7/20/20 6:07 PM, Cédric Le Goater wrote:
>>> On 7/20/20 11:58 AM, Philippe Mathieu-Daudé wrote:
>>>> The SDRAM Memory Controller has a 32-bit address bus, thus
>>>> supports up to 4 GiB of DRAM. There is a signed to unsigned
>>>> conversion error with the AST2600 maximum memory size:
>>>>
>>>>   (uint64_t)(2048 << 20) = (uint64_t)(-2147483648)
>>>>                          = 0xffffffff40000000
>>>>                          = 16 EiB - 2 GiB
>>>>
>>>> Fix by using the IEC suffixes which are usually safer, and add
>>>> a check to verify the memory is valid. This would have catched
> 
> caught
> 
>>>> this bug:
>>>>
>>>>     Unexpected error in aspeed_sdmc_realize() at hw/misc/aspeed_sdmc.c:261:
>>>>     qemu-system-arm: Invalid RAM size 16 EiB
>>>
>>> Indeed :/
>>>
>>>>
>>>> Fixes: 1550d72679 ("aspeed/sdmc: Add AST2600 support")
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>>  hw/misc/aspeed_sdmc.c | 12 +++++++++---
>>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
>>>> index 0737d8de81..76dd7e6a20 100644
>>>> --- a/hw/misc/aspeed_sdmc.c
>>>> +++ b/hw/misc/aspeed_sdmc.c
>>>> @@ -256,6 +256,12 @@ static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
>>>>      AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
>>>>  
>>>>      s->max_ram_size = asc->max_ram_size;
>>>> +    if (s->max_ram_size >= 4 * GiB) {
>>>> +        char *szstr = size_to_str(s->max_ram_size);
>>>> +        error_setg(errp, "Invalid RAM size %s", szstr);
>>>> +        g_free(szstr);
>>>> +        return;
>>>> +    }
>>>>
>>>
>>> I would put an assert() since the max RAM size is not user configurable. 
>>
>> As you wish, at this point I'm completely lost with error reporting.
> 
> :-/
> 
>> Per the manual
>> (https://www.mail-archive.com/qemu-devel@nongnu.org/msg723217.html):
>>
>>  "Many, many devices neglect to clean up properly on error, and get away
>>   with it only because all callers treat errors as fatal.
>>
>>   If you decide to take cleanup shortcuts, say because the cleanup is
>>   untestable, consider adding a comment at least."
>>
>> So I'll go for address + comment:
>>
>>   assert(s->max_ram_size < 4 * GiB); /* 32-bit address bus */
> 
> Makes sense.
> 
> Note this is *not* a cleanup shortcut, at least not the kind I had in
> mind.
> 
> What I had in mind is unclean failure, i.e. returning on error without
> proper cleanup: revert changes made so far, free resources.  This is
> *wrong*.  But the wrongness doesn't matter when all callers treat errors
> as fatal.
> 
> Checking an impossible condition with assert() is better than treating
> it as an error and bungling its handling.  If you treat it as an error,
> do it properly.  Since I'm quite skeptical about the chances of pulling
> off "properly" for untestable things, I prefer assertions.
> 
> There's another reason.  User errors need to be handled gracefully.
> Programming errors should (in my opinion) trigger abort(), so they get
> fixed.
> 
> When the spot that detects the error can't know which kind it is, you
> have to fail cleanly and let the caller decide how to handle the error.
> 
> Example: object_property_find() errors out when the property doesn't
> exist.  This may be a programming error, e.g. a well-known property
> isn't found, because a programmer mistyped the property name.  Or it may
> be a user error, e.g. a user mistyped the property name argument of
> qom-get.
> 
> When functions have multiple failure modes, and only some of them are
> programming errors, the caller typically can't tell them apart, and errs
> on the side of user error.  Programming errors then get reported as
> (typically confusing!) user errors.

A big part of your reply is worth adding in a "How to correctly use the
Error* propagation API for dummies" in docs/devel document.

> 
> The #1 reason for such awkward functions is lazy thinking + eager
> typing: by treating anything that can go wrong as an error for the
> caller to handle, I can replace thinking about what may go wrong and
> what must not go wrong by typing up a bunch of error paths.  Great time
> saver as long as I stick to the time-honored strategy of not bothering
> to test my error paths.

Not all are easily testable :( Or do you have a recomendation? Like
forcing an error in the code while developing, so the path is checked?

