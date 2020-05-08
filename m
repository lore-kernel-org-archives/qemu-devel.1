Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FD4C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 03:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B692220731
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 03:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4BNc+QU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B692220731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWtvL-0004GA-Sy
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 23:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rth7680@gmail.com>) id 1jWtuh-0003rQ-AQ
 for qemu-devel@nongnu.org; Thu, 07 May 2020 23:43:03 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33405)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rth7680@gmail.com>) id 1jWtug-0004RG-8Q
 for qemu-devel@nongnu.org; Thu, 07 May 2020 23:43:02 -0400
Received: by mail-pf1-x444.google.com with SMTP id x77so255077pfc.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 20:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pMbi7iquNQD7u7ceQnQ/FROgpEUJ26+C3qNVd8jsCZc=;
 b=L4BNc+QUM/o8pAP8qjq9P3rQgQTNFFBxoBk6NaL7ZjQFhtAiSbMJp+FLaEJ+n7qPu9
 bYVdFtV0qcDeQbOwTXZVhr/qDMnfl0qCOryxFn5JAgyvCII3CM70YvzEsoj47ni7YcCX
 DztvrL7qt9H03qgIo/ufVp6k68dKrpfz/NkH+eyZVqPgs3OK5kDsOC3XsAR/FoHK+lub
 ZgXZTaq0M3PbNHRaBe4ho/xFOiNwHdr72icLYwBrpLdF1tkEir39XhXbrV7cm2Xv9nWa
 rwJKQw7L17lw3GnkdA423NtjgJpHeWsj5saYwS6rzm/DnuOEg2BYlE4irbK9kNNaG0XD
 JqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=pMbi7iquNQD7u7ceQnQ/FROgpEUJ26+C3qNVd8jsCZc=;
 b=ugx9z6OnUb1WHoQG3B2gmzfHpKxqX2Gscujhl+2H40Wz+ih7ZLcr9fh/LXIiupMAMc
 8VYW9WEHfFhru1Q9Hb3YbDjUm0IWl1rZPkZ1I8K+0zWFFNe0h4xK4Y1jKH60XUEtbsDz
 ED8ipTp7pml7wu/OYvUEIWimCFjvN6Xd9NMQw6nvOsBhe+2TzxA7Ce7nyfd/fIFZyD7e
 /zreXnG5uJsV0yn+qc1d2ZseUyHOx55dbMn691n/SmMKUbJMyApgOpsx7sVz4pJ9ndP3
 bpmClXWtSKZPOt4GrLTXfhvNVeyCk33qWRsYCEexbyHo4VFNDyTc5zWbzk+mAMINfpjd
 M1KQ==
X-Gm-Message-State: AGi0PuZTAI3AqKBrfw0Ca21EZq6CjTzdaHr+8Pnfuk5XVJ34obX+XKfE
 9PyJisQNoyAKjPEPfWkFfEw=
X-Google-Smtp-Source: APiQypIvVSxHHHk4SRNXJ1uk1z7FD4BlY4uRAKhY8sCcIqossQnDRtlWgK64dBA+3iFHuXbq3M0mRw==
X-Received: by 2002:a62:ed14:: with SMTP id u20mr676943pfh.69.1588909380315;
 Thu, 07 May 2020 20:43:00 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.googlemail.com with ESMTPSA id s76sm284769pgc.85.2020.05.07.20.42.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2020 20:42:59 -0700 (PDT)
Subject: Re: [PATCH 0/5] target/i386: fxtract, fscale fixes
To: Joseph Myers <joseph@codesourcery.com>, qemu-devel@nongnu.org
References: <158881758425.4109.8939056494235923582@45ef0f9c86ae>
 <alpine.DEB.2.21.2005071449350.26071@digraph.polyomino.org.uk>
From: Richard Henderson <rth@twiddle.net>
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
 mQENBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
 n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
 rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
 Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
 n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
 AAG0I1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+iQFYBBMBAgBCAhsDBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAIZARYhBJyxjdr46EmtKvwWpK0ScMxN0CebBQJdweUY
 BQkP1h/pAAoJEK0ScMxN0CebqDsH/0YyfnXk+Dc++H37VCEKgRet2i1ATFzxRnifkvmdxha0
 V+PVptQ2fwSe+w3KxoFecD8W75nysmUjrU/FicW9yU5YRlGONPZjruG02/KzmhA5PzWJdYO3
 i/t0qRayvWIcX2qA/flsXEbmb/BbAFM05LQIdcOu74eiBFe5CBCOWBDJeneE1urIE0hSYxoh
 nCcG60ULrNj13ohZ4zAEluoY32qIo7/OPWmtR88cPrEbZT8k+RqgZbsotzaPT1/RlL74fL8k
 ofYfTgKAFH7eEy6fF2nzDp2GThVn+3sA62xtpSXUf/X1m75B40KOcq1EQbHypNTmBc1wt13e
 ibhPNEVX2am5AQ0EUa4sLwEIALITHfH3gciRNfQIe7awDTDvn6H3C6gDyCAnv5LiuLTLZiyK
 NZp3lNO3rPowyKrGT2RIDlumlqPgdeHzqEEX91YK0yk2vdFvwU04rJ4D+qRgdUPoeICLD1zo
 PwOv2FaY6Tf8dKYas1RHF5QU5yQNey8j7IYYoE2yGPn2PtBmvtmK4iLataUEvx0U385Zr+jf
 HscqwTiToryeDC8Io/9BsMvAssE5Yf5URS2nJ7LFOvc4njsQJPF1i9egBXaIloqv7p2hVCKJ
 Hl5UWIxitQ9QQIl6iU4LCpz8mVYTXwv48IAVpbUf7+ak9V9Kk3jCeQnlxCJBUHjUhoIzinbS
 JHPHtkkAEQEAAYkBPAQYAQIAJgIbDBYhBJyxjdr46EmtKvwWpK0ScMxN0CebBQJdweVIBQkP
 1iAZAAoJEK0ScMxN0CebGHUH/RtouOlWl6To97tQsTJUq/2YwmRpFOsvV0/zCX4fKBGAbeZi
 VaELSt2+3UEErA+n8HwbQmjJ6IrdhA9GustOpOyCcbLVSMwql/OlAwBtDzCcC8dTU4zcuY2a
 rGG2A8i5krU85G9r1wowVcWZBsdmW7/dKiNoadLQiig4bHNiSaV4ograas5efyEjqTxiY+yG
 hzPw5DK2kbp2co8iDF1vW0LWPeLFBinCgItcI9LvgHWaB3rwjOfvNpMn5m64SoQYHB8wbnid
 erAjOzkBzmqnfS1tAUr8mtESStEwrEmNv0ZoA6S0Wt+c9pyTr+BpG4OFlhj7ZI+Eh7zOrr33
 q9OBIdA=
Message-ID: <729a0fb1-5432-e9f5-ed48-57088e303463@twiddle.net>
Date: Thu, 7 May 2020 20:42:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005071449350.26071@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=rth7680@gmail.com; helo=mail-pf1-x444.google.com
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
Cc: patchew-devel@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 7:57 AM, Joseph Myers wrote:
> On Thu, 7 May 2020, no-reply@patchew.org wrote:
> 
>> === OUTPUT BEGIN ===
>> 1/5 Checking commit 69eed0bcaaaf (target/i386: implement special cases for fxtract)
>> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> 
> I don't think any MAINTAINERS update is needed for a new testcase in an 
> existing directory.
> 
>> ERROR: Use of volatile is usually wrong, please add a comment
> 
> I think the justification for volatile in such testcase code is obvious 
> without comments in individual cases - to avoid any code movement or 
> optimization that might break what the tests are intending to test (these 
> tests are making heavy use of mixed C and inline asm to test how emulated 
> instructions behave, including on input representations that are not valid 
> long double values in the ABI and with the rounding precision changed 
> behind the compiler's back).  I think making everything possibly relevant 
> volatile in these tests is better than trying to produce a fragile 
> argument that in fact certain data does not need to be volatile to avoid 
> problematic code movement.
> 
>> ERROR: spaces required around that '-' (ctx:VxV)
>> #139: FILE: tests/tcg/i386/test-i386-fxtract.c:80:
>> +                      "0" (0x1p-16445L));
>>                                 ^
> 
> No, this is a C99 hex float contstant, not a subtraction.  There are 
> already such constants in tests/tcg/multiarch/float_helpers.c and 
> tests/tcg/multiarch/float_madds.c at least, so I assume they are OK in 
> QEMU floating-point tests and this style checker should not be objecting 
> to them.
> 

Correct, these are all false positives.


r~

