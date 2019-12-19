Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EB3C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:45:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93136205ED
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxhoIER1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93136205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihjwK-0003xE-PA
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 19:45:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rth7680@gmail.com>) id 1ihjve-0003Vl-3j
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1ihjvd-0000nB-0p
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:44:34 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:35471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ihjvc-0000l4-Q7
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:44:32 -0500
Received: by mail-pj1-x1043.google.com with SMTP id s7so1673522pjc.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 16:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8Ea9yJMC/Mvb159Sm2Rikuzc1m0q1bIE/j1QdjG+kPQ=;
 b=DxhoIER1KeMim/AUATUaE2l/F55P4lTh1Wl145led60H8GxkX+O4uVyCe+qsSJ5qp4
 5Niu80bK02ts/Xf4YdQDkPgFOS2ORg7fSUcHJ/WpL5xnPih6wspmREkTflUwAwL+wwn8
 VsPEk28rZ5eSwwiRD0bWcgXkskBMRI/VmVz57aYCQYBrHMyoykd3rAFPtcO5UUSmAK+C
 VA+YRtqHuMak6NbAnVfARh7qnI0JsvcgwlcS9GPjGI9H1ZF6v8g7GQXXCvZAPUEKkzpo
 h3y+PV0ZLW4Zy262OvD1jZmZITmDw7Fq04o99e/80hWM81iw0bmoHlmT4Gk075U7LWTR
 XggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=8Ea9yJMC/Mvb159Sm2Rikuzc1m0q1bIE/j1QdjG+kPQ=;
 b=mX8R0ZP75sVhkPwJWV89t8Vg1WrNGv5+i5vCkiUQ0whP1gnWMQGvhnfBbxVXKfWCGt
 z0L7mFlXza6FLBEhqZMRkNLrU6XNQYuQVY0d0eTN1aNLtxUqqDZLqAAxzKDxnmvMgo7M
 DrZE6AW9399CauBStgIRzQNgvk8Q+qlq61ZcwDn3uxyfrU0sXRqCyPTL0qkA4OBntZJi
 5WP2evB+bhuxIkZ/nhredcjscX6gcF1NUrOpD1NI4OZSmRZErvgezNjpdXhwxJIYNmkN
 DCEVsam4/lEPVQm8cjTseK0ewqb7WuwYDNvX/daI512yD2993JmkHBh4O2eOG+gecumm
 5DEw==
X-Gm-Message-State: APjAAAVCdy2ukg49WE/VD7aft270c0bVzNOY2J1MqutpseCvfZZlBurr
 XorX+4X/6Y24vqYdAAdXtzoalaQZ
X-Google-Smtp-Source: APXvYqy+0WkiTJQ9VCgUYfefin3cUJ4osPHPLaRd81Jj/vwq+InPvf7tGJCwICK0x0PsFKS7Gc6wFg==
X-Received: by 2002:a17:902:6a87:: with SMTP id
 n7mr5708679plk.273.1576716270171; 
 Wed, 18 Dec 2019 16:44:30 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.googlemail.com with ESMTPSA id i22sm3121453pfd.19.2019.12.18.16.44.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 16:44:28 -0800 (PST)
Subject: Re: [PATCH v4 0/6] HPPA: i82596, PS/2 and graphics emulation
To: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>
References: <20191103205607.6590-1-svens@stackframe.org>
 <20191123135928.GA5553@stackframe.org>
 <4848d948-063c-826a-a3f3-9bdbad04f9ac@linaro.org>
 <5ce01ea9-3cab-c774-41b1-25dcdc1b6aff@gmx.de>
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
Message-ID: <d71df5d1-e949-aa61-bff4-a09170c6171d@twiddle.net>
Date: Wed, 18 Dec 2019 14:44:25 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5ce01ea9-3cab-c774-41b1-25dcdc1b6aff@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/13/19 10:40 AM, Helge Deller wrote:
> To avoid confusion because we missed qemu 4.2, I've deleted the
> parisc-qemu-4.2 branch at the parisc-seabios git repo [1].
> Instead I've created a parisc-qemu-5.0 branch.
> Please use that instead if you push the prebuilt seabios rom and
> git submodule references.
> 
> Helge
> 
> [1] https://github.com/hdeller/seabios-hppa/tree/parisc-qemu-5.0

I've re-generated patch 6 using the head of that branch.


r~

