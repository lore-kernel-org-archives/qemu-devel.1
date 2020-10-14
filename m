Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C11C43467
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F9692222C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+TJDpiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9692222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSiw2-0004fs-DP
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 11:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSiuE-0003mt-KZ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:41:34 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42438)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSiuD-0007EK-2H
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:41:34 -0400
Received: by mail-wr1-x442.google.com with SMTP id e18so4406567wrw.9
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/xSPNirGI1Nu+wlvJJwPQjGthj8U2WlOOdBH9jpZQU0=;
 b=L+TJDpiND1RKUUw42QizH3CRPS6+noJ8pkmUGggMwNxG1VU/6iXWW9svCzo+g9O4db
 3KwxXZGO8H5FoDFQxECj7wzK+BRgSAEpOhd113HPbWKvkZW5cY9k4urAALRM6KrAFJC3
 D5Pu5hQXvvqh/pdMjZP4+8nF75feZBMgsKYLTs0fG76vbTYNiOKaLPlZsA2590Mh0Vwu
 Lt9s6DuHXuIkYaNGJlXUt2pgOoJdeIiFIKgyxHv52u54zH4EfmjvyUTKqOrMjSI0yJ7V
 uiV4Nz+uHymox+yniSpHH2+gtBt1tVydazLroFPYGZRR847aAV7W4xzAquyhjgh2Fou8
 k0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/xSPNirGI1Nu+wlvJJwPQjGthj8U2WlOOdBH9jpZQU0=;
 b=fdv34pRTUiUy8Oly4KwMeo287KuHlLK2SmurexNn3wYT3E+WErYEmTZlKnsHeC+kFq
 wYkfhoct28BMXdbt+qZcKm2LkuQtqj7YHV7KEIy6ZS88pIdapfmkxDQ1ZGVrtzIR8/wH
 ATgi5XnCvys90IBPvIIzwl9+3d6O7qhcoAp/aUEUUXRE4FyZ7X9g1trpANlHb0ALG2qm
 tFNs2zAzWpYs7QzeY90q2JtnIafusOikH/7JsQ8NuuZZrFF/ua/aXTuWHJtHRHqo9Dda
 i27VjB0WOmjnMOHDIs+r2AxDNpmJUsNtU0t6aBZCuNxeQh6PaEbOIW9hqRhb4Oo82COq
 m9rA==
X-Gm-Message-State: AOAM533XXEF6dvD21aemtUkP5eZOWJWLD5MtsfcOA7sKh2D4UA38F1cG
 NBdvj32pdSG6tEOkV8OspFE=
X-Google-Smtp-Source: ABdhPJxwxRQONPWvfz3POx80slkZ6HpcgI5yIzlcpy9ULWdnhDdxE3EGw1jKiF+h1w/d+WTZx+fNWQ==
X-Received: by 2002:a5d:6cc8:: with SMTP id c8mr3628102wrc.233.1602690090937; 
 Wed, 14 Oct 2020 08:41:30 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id p67sm52770wmp.11.2020.10.14.08.41.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 08:41:30 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] MAINTAINERS: Put myself forward for MIPS target
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20201013101659.3557154-1-f4bug@amsat.org>
 <20201013101659.3557154-2-f4bug@amsat.org>
 <da20213b-7234-a43d-e240-3a97f8c43765@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4e83e8fa-19fc-003f-307d-82eb6f5b8a8f@amsat.org>
Date: Wed, 14 Oct 2020 17:41:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <da20213b-7234-a43d-e240-3a97f8c43765@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Chen Huacai <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 5:13 PM, Jiaxun Yang wrote:
> 在 2020/10/13 18:16, Philippe Mathieu-Daudé 写道:
>> To avoid the MIPS target being orphan, volunteer to keep an eye
>> on it and put together pull requests.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> Thanks for stepping out!

😥 in?

> 
> - Jiaxun
> 
>> ---
>>   MAINTAINERS | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 426f52c1f63..d59e5c05c10 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -221,10 +221,11 @@ F: hw/microblaze/
>>   F: disas/microblaze.c
>>   MIPS TCG CPUs
>> +M: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>   R: Aurelien Jarno <aurelien@aurel32.net>
>>   R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>   R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>> -S: Orphaned
>> +S: Odd Fixes
>>   F: target/mips/
>>   F: default-configs/*mips*
>>   F: disas/*mips*
>> @@ -2815,11 +2816,12 @@ F: tcg/i386/
>>   F: disas/i386.c
>>   MIPS TCG target
>> +M: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>   R: Aurelien Jarno <aurelien@aurel32.net>
>>   R: Huacai Chen <chenhc@lemote.com>
>>   R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>   R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>> -S: Orphaned
>> +S: Odd Fixes
>>   F: tcg/mips/
>>   PPC TCG target
> 

