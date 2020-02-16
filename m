Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC54CC7114E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 01:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE342082F
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 01:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ae0sBntk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE342082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j390E-0001Xw-Ld
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 20:45:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rth7680@gmail.com>) id 1j38zM-0000Xt-GK
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 20:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1j38zL-0006j4-JQ
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 20:44:52 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44115)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1j38zL-0006hn-Dc
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 20:44:51 -0500
Received: by mail-pl1-x641.google.com with SMTP id d9so5316038plo.11
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 17:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UQOXj5mhcDoQ0eBIMaxh7Eo40zO+a4FVdr9pILple80=;
 b=ae0sBntk0Ugd/cDz43rKBNhEJELB89OqhVF5QLoTZA/i2pdYUm/L1FCLfO0iNqIkld
 uIrRflzaIWrn5PUA//9auhrPxMQ2mZen26/vymUJ8X9MD3cGBE6Sy/QFS4tOgthMMXSU
 q5GQqjQjSAqPKtxd+cRNZH7QV94NE8kVckWWeu/weXUAHW9GsVlqvfNCUlu9BT0FJExW
 XVyGxgOyR7Sgd0y93HVptr7AtGHElzEojdSG+EOUAzDWQxTDf+NW+QSYipjR62mYTFce
 q9hiuBmYSIyxrKFGm0btLMa7wyzY/m70BQt2FEYeksh4gh9ZVIa+nRS+gaEMfSYP58pq
 2KyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=UQOXj5mhcDoQ0eBIMaxh7Eo40zO+a4FVdr9pILple80=;
 b=gKAJTQdHdLLs68AKGrWWgJuV6FrIQlWKRshrx4zT/kxGIs90jMLOaWj8lVaXP0minQ
 CpNzAlIa3X/6HfzJs8uu0H6rSrWchUUzpEodozht9XBNAeUsuBaS7YlEQ60qvi6tlPOH
 frM6dHjjGbV4RilTvcXJVU1ATrdULyXpYwRAR/MbwLx7KaNJXk+GN9hjDX5uTaGRahFn
 ui2fP5NJngsHB9k3UOAH/Jg9yn5f1uCDxupdJn2zMC1r26Uq5DHuLh/CtMSvFPB/P9ZJ
 nXgEQ6ryOH7lKW04PrDwBpFRQFcYwAyMVKhQrTMv/h2/De6zHj7aMvWEPg1CPcEoviye
 w4xw==
X-Gm-Message-State: APjAAAUul9dFBNAW2rSSPDveGkwOfuw94mDUfmtyEZvKOGESMV+6bEiW
 WKowESvD9D8Emv9EcdjWUfQ=
X-Google-Smtp-Source: APXvYqzKqBs+fe88z/pWRz2xFNs+n4nH50G+evEUCaWX/ff6rko5VUbqiqJbrHviop5CKa1VjXziDg==
X-Received: by 2002:a17:902:8f8a:: with SMTP id
 z10mr10341826plo.169.1581817489935; 
 Sat, 15 Feb 2020 17:44:49 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.googlemail.com with ESMTPSA id
 o19sm17364422pjr.2.2020.02.15.17.44.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2020 17:44:48 -0800 (PST)
Subject: Re: [PATCH 0/4] hw/hppa/dino: Fix Coverity 1419393 & 1419394
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>
References: <20200213234148.8434-1-f4bug@amsat.org>
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
Message-ID: <9ef99271-1fa9-7f55-4196-cdfa093aa83c@twiddle.net>
Date: Sat, 15 Feb 2020 17:44:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213234148.8434-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 3:41 PM, Philippe Mathieu-Daudé wrote:
> Easy fix for the overrun reported by Coverity.
> 
> Last 2 patches are RFC because I haven't tested them,
> I simply took note while reviewing the datasheet (I
> also checked the errata).
> 
> Philippe Mathieu-Daudé (4):
>   hw/hppa/dino: Add comments with register name
>   hw/hppa/dino: Fix reg800_keep_bits[] overrun (CID 1419393 & 1419394)
>   hw/hppa/dino: Fix bitmask for the PCIROR register
>   hw/hppa/dino: Do not accept accesses to registers 0x818 and 0x82c
> 
>  hw/hppa/dino.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 

Queued to tgt-hppa.


r~

