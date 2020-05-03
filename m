Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3112C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 17:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 809A3206A5
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 17:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDn3TSoR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809A3206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVIH3-00016F-Lq
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 13:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVIG9-0007bm-9B
 for qemu-devel@nongnu.org; Sun, 03 May 2020 13:18:33 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVIG7-0007LU-8p
 for qemu-devel@nongnu.org; Sun, 03 May 2020 13:18:32 -0400
Received: by mail-pf1-x444.google.com with SMTP id p25so4364304pfn.11
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KGIW5W7BgT3oIKOmWT+7ki2S7423w+LxIvwe9IaaH4Q=;
 b=PDn3TSoRsk/PRdvsZMA1VcX0LExYFAI1AG5YwP4b1PV4e9LFjBeTdtMRdgBXbrrP5g
 9x4vDskQM636vUZ242oRHd9GZwGr1AMuBVv9PGlWMfDmC6620Ok0zh874blWLwH9m60X
 spZuPiYnWOvMrq7DA542anV9d4WiX9hC+LEA8FetIN5kxuzE2FzeuxhW1Dvn7HLMzmAm
 +jEdSKPQYnFVZAKIXpOq4FAlyrUZbztntoQPtSXcItA1BUWJIuBvs+XaiwbYSyQaTvWT
 pliLCONPYjZNmmxiiuEw1Sh9VWA6p6Gqxtx0XWCRqq+g3la0Hj+0oEiRux421dophJaZ
 ENVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KGIW5W7BgT3oIKOmWT+7ki2S7423w+LxIvwe9IaaH4Q=;
 b=k/gcrFspm1HzNngzd1Uup33Rhz9r3rNYkeYxSTiLTg2aKZmNGczx1Eru0ruZbWU6D/
 nKUUvIIQNxwJKRRmkOWAovIt6gA1NQ9w5vQOqsDn4etwkca05cUxMrAeH+z+1s2HGh+1
 9+2bmkBSpzUi18rYB0s32fBtSc7McmENjnsTI3GPbw5rHtejschKTSSKg29U2HTacqwL
 G2eIJcBCeG80U6ljH7q9WA1zM7sTdRpLjYpsg9l5l6gleOBYs4GrU73lHO3nhIUAeAe1
 H2mCne3mlmJMNPg8TbjdZFoOWgLwv7hKRt9vLGcUaX2qccE5VAMZXanbbfmrO7y6xcgW
 50+A==
X-Gm-Message-State: AGi0PuZGonpEjvZMRaPVAUDGO2KiaVqHjF0Q92koosICg6ja3nj1fGlI
 N4jUzbqXpXswuEcO3Z51F2TtqA==
X-Google-Smtp-Source: APiQypIJ+v1FaltfSk1XL74NfJG4CWgckDvRZFTLuvKABx96kJGWcP0VSYPw3JpNpQehPFqHEq5MXA==
X-Received: by 2002:a62:1bd0:: with SMTP id
 b199mr13751624pfb.283.1588526309745; 
 Sun, 03 May 2020 10:18:29 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h14sm4548356pjc.46.2020.05.03.10.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 May 2020 10:18:29 -0700 (PDT)
Subject: Re: [RFC PATCH 2/2] linux-user/mmap: Fix Clang 'type-limit-compare'
 warning
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200503113220.30808-1-f4bug@amsat.org>
 <20200503113220.30808-3-f4bug@amsat.org>
 <CAHiYmc61KAjFHuYCMyRunkfMdf4DD83TFTo4DJF-58KZ5YQ+Jg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cf98c9d2-a671-3efe-3e12-858f46a4a746@linaro.org>
Date: Sun, 3 May 2020 10:18:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc61KAjFHuYCMyRunkfMdf4DD83TFTo4DJF-58KZ5YQ+Jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Riku Voipio <riku.voipio@iki.fi>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/3/20 5:49 AM, Aleksandar Markovic wrote:
> нед, 3. мај 2020. у 13:33 Philippe Mathieu-Daudé <f4bug@amsat.org> је
> написао/ла:
>>
>> When building with Clang 10 on Fedora 32, we get:
>>
>>     CC      linux-user/mmap.o
>>   linux-user/mmap.c:720:49: error: result of comparison 'unsigned long' > 18446744073709551615 is always false [-Werror,-Wtautological-type-limit-compare]
>>           if ((unsigned long)host_addr + new_size > (abi_ulong)-1) {
>>               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
>>
>> Fix by restricting the check for when target sizeof(abi_ulong) is
>> smaller than target sizeof(unsigned long).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  linux-user/mmap.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>> index e378033797..b14652d894 100644
>> --- a/linux-user/mmap.c
>> +++ b/linux-user/mmap.c
>> @@ -714,6 +714,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
>>              errno = ENOMEM;
>>              host_addr = MAP_FAILED;
>>          }
>> +#if TARGET_ABI_BITS < TARGET_LONG_BITS
>>          /* Check if address fits target address space */
>>          if ((unsigned long)host_addr + new_size > (abi_ulong)-1) {
>>              /* Revert mremap() changes */
>> @@ -721,6 +722,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
>>              errno = ENOMEM;
>>              host_addr = MAP_FAILED;
>>          }
>> +#endif /* TARGET_ABI_BITS < TARGET_LONG_BITS */
> 
> Hm, Philippe, this will silence the clang error, but is this the right
> thing to do?
> 
> Why do you think the case:
> 
> TARGET_ABI_BITS < TARGET_LONG_BITS
> 
> doesn't need this check?

I think that's quite obvious from the clang warning -- the test is always false
due to type limits.

That said, this is at minimum the second occurrence of having to add ifdefs to
work around this particular new warning, because there does not seem to be any
other way to suppress the warning, and I'm not keen on that.

I would prefer that we disable the warning on the compiler command line in
configure.


r~

