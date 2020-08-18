Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F745C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 00:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE63D2076D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 00:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGUgvyUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE63D2076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7pRJ-0003fg-0t
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 20:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rth7680@gmail.com>)
 id 1k7pQd-00037F-6p; Mon, 17 Aug 2020 20:24:39 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rth7680@gmail.com>)
 id 1k7pQb-0002Eu-HX; Mon, 17 Aug 2020 20:24:38 -0400
Received: by mail-pg1-x541.google.com with SMTP id o13so8926294pgf.0;
 Mon, 17 Aug 2020 17:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ase5rRBUbnbuHrlRhQDaafwg3DgMFwynlle6JLSY124=;
 b=aGUgvyUG8YIA5cEinsogjthct0fkP1hd8SaY/dPJ+LW8kpcDpOC0rOn+gOLiorUps3
 URAfBj28ifl/KWbWv+eT0T0ggzAKpuSkuaHM3D1wZQsqksWbSoWwCSS9rKOHOasWg50L
 x8HIeTLgRC6uniqkCS2mrUBxJ5+cxakeC9UJ2raxDoEja0g2m3vh5kYqYo0V3vDQROcC
 ypu3OCEjvWrZmkn2upXq+R7YUTBgmZOdVdkcNv3R70iQxV8Tqq2YyvbDxxoDcXwsJ1Qj
 8LdZoIBOxDNmNUr4zZl/PEJ9kBqnqOoGq5jmBVNIE+MuT0dsAJYBj0S4/YezytvXkL9V
 FLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ase5rRBUbnbuHrlRhQDaafwg3DgMFwynlle6JLSY124=;
 b=eIpDDYnusnRhyFiUuO16wDRSQRp8BAt0OjBqNz9a7ggsfaCNXHqxkm6faffS1nW9QF
 yNpScxkAFX9NucUBkLwzQPs4Isfz/EE+cUEym8p+sKJPmtTMBHcZRI9974csXLXbQI6i
 AvjGKuMamJ/ymAYnKy5gS4nxNb717upxT7n9Pmof4Ou/W3c/IrNd0DjmvYhM8l7qedR6
 9KMVySU4uRSRiRG9V7YC0yIIMjHws/k5DOGfh7iHfPFRUhIyRxm1AvN/uisGu91ZKaTT
 Rq7pI0jly9Kui7+K9T+wD8fm2wk8y1ALWY4JCrEAz5wMS+zkzdXt9auD/Pw2K8DXAtqm
 OnUg==
X-Gm-Message-State: AOAM532t46+Tf4NnLB4yiB4Eto5/lZ/Sz1iOOcIP5LVUjaUpRpsd4K52
 wj/0+fRRrRFYYsAH9Q62l7E=
X-Google-Smtp-Source: ABdhPJxzElF/cX8QSp8x2Qf4Hi06uS4qTrqgOc2f6UlwwB21amj5UJaY3p7+/EF1OFnWAWPZyTgbQg==
X-Received: by 2002:aa7:9493:: with SMTP id z19mr13344132pfk.190.1597710274289; 
 Mon, 17 Aug 2020 17:24:34 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.googlemail.com with ESMTPSA id
 u14sm21891238pfm.103.2020.08.17.17.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 17:24:32 -0700 (PDT)
Subject: Re: [PATCH 08/11] tcg/optimize: Remove redundant statement in
 tcg_optimize()
To: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
References: <20200813073712.4001404-1-kuhn.chenqun@huawei.com>
 <20200813073712.4001404-9-kuhn.chenqun@huawei.com>
 <800035ed-a522-a974-1c1d-437efe7ff25b@linaro.org>
 <7412CDE03601674DA8197E2EBD8937E83B8B60E4@dggemm531-mbx.china.huawei.com>
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
Message-ID: <5d0a7f5c-1291-6330-9aad-bdea5b59a707@twiddle.net>
Date: Mon, 17 Aug 2020 17:24:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7412CDE03601674DA8197E2EBD8937E83B8B60E4@dggemm531-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=rth7680@gmail.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Pannengyuan <pannengyuan@huawei.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 6:04 AM, Chenqun (kuhn) wrote:
> Other branches(eg:' CASE_OP_32_64(brcond)') have changed the opc value too. Do we need to assign a value to nb_iargs for it?

In those cases nb_iargs does not change.


r~

