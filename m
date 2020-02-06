Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A31C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C5C206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwf38x0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C5C206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izeTS-0001mc-TI
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rth7680@gmail.com>) id 1izeOn-00005F-N0
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1izeOm-0001JN-Jy
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:28:41 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55093)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1izeOm-000164-CZ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:28:40 -0500
Received: by mail-wm1-x344.google.com with SMTP id g1so5682533wmh.4
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=62+/egQfC/qaJqd1bACLWI/4S4BEOAdrScAqprINvvs=;
 b=kwf38x0f0reuBI9H59UGKY+aMWKfzwXycKeJMbcvPUPMf71bGD3yJCSQbcWGtpOPtN
 eJHfFdcEzO4cLrKq4CNCT4Uzreqlu/pc1Z+7QEiAJYmctCtL03vUtttvkcKZOqSF/Y8R
 dmM1E0TWF4nvOuQaW0LKzjDWe7MuJ6r7KTSXGV0n+Ssy8b3zyT+LqCNrv1L9nQy8ha5+
 zZ51m4JVu1/1pMwfXkod52Ahu1tKolo1PCtPm9xIxrAKEhgmed/k42Cz43ExpLkAgEwm
 VRfwTSvM2QJYQ22s8K/JXKXnc5BgTeXufMv0P/Q75dDb4kaImnvuU4HG5uverL1pcxr3
 z09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=62+/egQfC/qaJqd1bACLWI/4S4BEOAdrScAqprINvvs=;
 b=CNdhF3uHSLD3GYY0E41/cXWm6OXpRN0qYyMErXpcl1uAfiGolgQr2uRaEqK0jFbrPF
 ddX+vt3T6Ltng9PxTpgzw4PMTmd+cIJ+K+6+E0qV1yk0Fm9Yd9vJVAxZuCkn76bwL5cR
 r/TeUdR4aZnS8/kTV9t9nvbpHgjdU6f+o4JKvlo4cvaAH/2lVZ3dJuoIiNftNoTF+nxH
 Jt5cpN1iTt58wavTmwAbvPUG5lPO9rz9vyeRDvkcNY8SGE0TZE8lVHfbLX7pz1V4vIYs
 nghZTPf6YkTyoMT9kt3HBo9m//Ylj3qcji54xK1ih+o/arNjdIZgIzuu/J+bn0KGI+nU
 u/PQ==
X-Gm-Message-State: APjAAAUV/BVIwKUPGicplasMDIXeotbMYm5slT0U52T5iJvJ5HxTD40H
 UJKPDHQX72GmPzMTYqjNsMQ=
X-Google-Smtp-Source: APXvYqzOT6xgLk/FjGiMLexyyEjqijoDboxDROUnEl1CTrphLKFqDG2Hs0ohXSlkYdJa0FqqXQ3WhA==
X-Received: by 2002:a1c:9849:: with SMTP id a70mr3682537wme.76.1580984918239; 
 Thu, 06 Feb 2020 02:28:38 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.googlemail.com with ESMTPSA id t10sm3086333wmi.40.2020.02.06.02.28.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 02:28:37 -0800 (PST)
Subject: Re: [PATCH] Add support for a helper with 7 arguments
From: Richard Henderson <rth@twiddle.net>
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1580942510-2820-1-git-send-email-tsimpson@quicinc.com>
 <09def3cf-6833-ccf5-457e-1755a7fd0e04@twiddle.net>
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
Message-ID: <640ffa37-a70b-dfa9-55ef-cde5c7f0dfcb@twiddle.net>
Date: Thu, 6 Feb 2020 10:28:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <09def3cf-6833-ccf5-457e-1755a7fd0e04@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 6:02 AM, Richard Henderson wrote:
> On 2/5/20 10:41 PM, Taylor Simpson wrote:
>> Currently, helpers can only take up to 6 arguments.  This patch adds the
>> capability for up to 7 arguments.  I have tested it with the Hexagon port
>> that I am preparing for submission.
> 
> This is not safe, in general, without other changes.
> 
>>From include/tcg/tcg.h:
> 
>> /* While we limit helpers to 6 arguments, for 32-bit hosts, with padding,
>>    this imples a max of 6*2 (64-bit in) + 2 (64-bit out) = 14 operands.
>>    There are never more than 2 outputs, which means that we can store all
>>    dead + sync data within 16 bits.  */
>> #define DEAD_ARG  4
>> #define SYNC_ARG  1
>> typedef uint16_t TCGLifeData;
> 
> Thus 7 uint64_t inputs, on a 32-bit host, will overflow TCGLifeData.

My bad, no it won't.  For some reason I had two outputs in my head, but they'll
both be uint32_t not two uint64_t.  7 uint64_t inputs with 1 uint64_t output
will *just* fit.


> What are you doing that requires so many arguments?

But I'd still like to know why you need so many.


r~

