Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAB7C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:18:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 717DE20578
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLPOecBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717DE20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIy3n-0001zY-Kb
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rth7680@gmail.com>) id 1jIxzZ-0004um-9m
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1jIxzY-0001dt-87
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:14:29 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:36713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1jIxzY-0001cz-2C
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:14:28 -0400
Received: by mail-pl1-x633.google.com with SMTP id g2so6984726plo.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 10:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=70bzJN1qO5RDpjuxTBn0QpGQ8ANhtCNC3t8UJuvFBgA=;
 b=gLPOecBP/zsGUt9U+YBkUQhA6wKUkS8SetIV6FD4O6UFY5uUJGHTEIqzE8bkMaF5f0
 0uGfeCNn7XqDz52Lxv580IcUJ/K6H3O0IygPoCXjpdHdaZdWMbKjb2y3AkLhZbmgXZmy
 yzvbI2dp5edPXaCNNoe0pMv/6j3Ykl/YFgkKNLQPZ+x/eL4hkkSoCgiXycI83jzAufhZ
 wDdZWjE4yif3qqxGy+JMk3yWKkAHYtIl0vjdF6utm4XdoKxOUKUmUWzZvIG8qvQ56xkw
 5QY8DG5aOcOpYSpDknaoOaO0FDOoY3kWeTFHMajKapghCYt/kwM5bViJvO0xgGZXDyip
 Lx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=70bzJN1qO5RDpjuxTBn0QpGQ8ANhtCNC3t8UJuvFBgA=;
 b=NNZidktIvNnxTo51I7Am0Wmr/kAZIVTL6eTtFJIhzPRFQj8Zp7uIKP6eIrfSewsl8j
 74Z8M94se9gEm66zheH3YLsDU4nQsxqKnI9c3ylICWFUKtxzSBUNPCcEHnbFiGQpLuMh
 a71v9BLGpHyB1LuWHCSE07+WMchQy+qGc0zlaubJDPBJ4Eoh3rQNJwaaAASwt/4jUwmr
 TWPE6Ea+nDoxCMfJYnyGXMNtgNt573efFQfIoBcalLvBqFgivayPmkHje1As1H60IfxF
 BFwcB+UPvfI8rOZfd3ea9Y6UlLwLCfF7kmPFUvle826tPVat75ZTv2Ss9MY+vu8XbYza
 OIdA==
X-Gm-Message-State: ANhLgQ3DWeaJr7YPRVSCG3W2oBKnNsxkxBmmcv1Nzt3eEHT0FaaKU7M0
 cH50Vc+WegSv24hVACmZsxRRfXb2
X-Google-Smtp-Source: ADFU+vtMbI78GjYk3TijKNN0XU8zgeui8iHMSi8pZwezNbJ3YHF0Y2kMTEf9eFrS0aYDGkYCtQ05Yg==
X-Received: by 2002:a17:902:a603:: with SMTP id
 u3mr13770774plq.105.1585588466649; 
 Mon, 30 Mar 2020 10:14:26 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.googlemail.com with ESMTPSA id s12sm10062734pgi.38.2020.03.30.10.14.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2020 10:14:25 -0700 (PDT)
Subject: Re: [PATCH-for-5.0?] decodetree: Use Python3 floor division operator
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200330121345.14665-1-f4bug@amsat.org>
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
Message-ID: <ed9ac5c8-0654-3c74-3e35-5d7b02a548b6@twiddle.net>
Date: Mon, 30 Mar 2020 10:14:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200330121345.14665-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::633
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/30/20 5:13 AM, Philippe Mathieu-Daudé wrote:
> This script started using Python2, where the 'classic' division
> operator returns the floor result. In commit 3d004a371 we started
> to use Python3, where the division operator returns the float
> result ('true division').
> To keep the same behavior, use the 'floor division' operator "//"
> which returns the floor result.
> 
> Fixes: 3d004a371
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> We didn't notice it because only the RX port (which uses the
> --varinsnwidth option, and got merged very recently) triggers
> these problems.
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  scripts/decodetree.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

