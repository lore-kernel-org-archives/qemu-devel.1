Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46429C34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F8221D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9oAsOhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F8221D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48WR-0007TL-9h
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rth7680@gmail.com>) id 1j48VU-0006s5-Mw
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:26:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1j48VT-0004e5-R8
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:26:08 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1j48VT-0004aF-KY
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:26:07 -0500
Received: by mail-pg1-x542.google.com with SMTP id o18so594935pgg.13
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 11:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SQogmsxVF+uJ+yvOrYKJ0A80zYYVEQw102BGb2VCZBY=;
 b=n9oAsOhCEUiO+HbydwB/c+tyTUEiBos4wOOqT1gHQ4VDk7kB9BMHdJ9ZH3D0jEjC/U
 IWfmRPcD8v8No/1aCjRnvipwShoOHkmw7yeNt3qiRDhzzN5MAkGD7Jml94pX7YoW30Jy
 d15BYqKX90dhAQDwCFlRIQYu8CbuiRdP5lGcRfpm6RMXrw4e3x20pyEaI2MqRwvQ1hm/
 AhHjfGHWKTzlxE88hGHBZsTb6+elqn4v0G8ONynevcvoDDoXxPhKesqRbfH4SfCQKdAz
 rQ8mHJAo+BaM1uOqHvNBKIcs910O+6qwJWFp/f0sbWRMxec1AYlQNWukz+8lL0ItYSIR
 uK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=SQogmsxVF+uJ+yvOrYKJ0A80zYYVEQw102BGb2VCZBY=;
 b=amANh4vMzMwjlMzQI/Fvd8M09oVFr1NQ3kWmFONNZNXsU3K2UvXqAfhyGW6LzsqBAd
 wjzKo9j8PYhgeTDnbjyAXwdYilPEGSbDscH2lQ7Dsoxpccr/n2a+CuLTIDaC5GNIL4A7
 oevDsNpxuZZusNAYmSp2seiFicfNmy+/o6/GOZGDvfuTm+13ayNp6FNvlZUYOZT+2UVX
 T+UIc3NbwtL11PHA41cPmgmNPToXcyzIdIIgSgPlbVO3ZTDZFSQcyV7aajg1evchfic6
 YV6zAcTNTJsYbEPuIpffjz9xqHAhist6BpVGsrHkRjM8FvMQPHasVsWgyAHpccrk7gHg
 V4rw==
X-Gm-Message-State: APjAAAWrhu3EQw7twgfU+Fl8BnK9y7FWWUTpPrys1XuAKiK7qPj8JBpT
 FD/nZUZIAk46nvjUW9o0K/4=
X-Google-Smtp-Source: APXvYqyoMGnM/hTffBBsqCbhIVaKB1QqRQ3UkFWaOgkNMFFkbjGlclFOy7VjPZp+L4rYkBtB86ypGQ==
X-Received: by 2002:a63:ba05:: with SMTP id k5mr23782474pgf.158.1582053964794; 
 Tue, 18 Feb 2020 11:26:04 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.googlemail.com with ESMTPSA id
 7sm5189901pfc.21.2020.02.18.11.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 11:26:03 -0800 (PST)
Subject: Re: [PATCH v2 0/4] hw/hppa/dino: Fix Coverity 1419387 / 1419393 /
 1419394
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Sven Schnelle <svens@stackframe.org>
References: <20200218063355.18577-1-f4bug@amsat.org>
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
Message-ID: <103311e3-b7c0-9486-672d-4f53660f41df@twiddle.net>
Date: Tue, 18 Feb 2020 11:26:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218063355.18577-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 10:33 PM, Philippe Mathieu-Daudé wrote:
> Easy fix for the overrun reported by Coverity.
> 
> Since v1:
> - Fixed description to cover CID 1419387 (reported by Peter)
>   (no code change)
> 
> Supersedes: <20200213234148.8434-1-f4bug@amsat.org>

Replaced your previous patches in my queue.


r~

