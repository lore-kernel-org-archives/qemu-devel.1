Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2333C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F44B2073F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b+xfDvwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F44B2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3MQS-00081I-C1
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 11:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i3MOf-000730-3j
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:31:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i3MOc-000836-O9
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:31:36 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i3MOa-0007wC-Eu
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:31:32 -0400
Received: by mail-pf1-x443.google.com with SMTP id b24so2321146pfp.1
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 08:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lG4wnEBKOURmPAWI6cgMoVHRIFycnOyEEDw6ontZl3s=;
 b=b+xfDvwucMjCUUDo6f8TSHbnr1XQsGedbbrGrCYb8h/RBhRw+1XL+9WncLuaTtzeXs
 Sfb+To4zpa6QV2tjX+/HlI2hj3UB22FF438rk++FTQ3mTTSC13mgnEuLlwUjU+/+wGEY
 dM2AeT2kIFORGzxo5LUjrDsnLBOu3TvGEFmtw3FJKNzKo5E+P8pGyxMPcU2NSFdyqDES
 F07Xg/VG4jfaScA7SuwsN9m55J7UXzIQbUDW+YOhwgapteTtUhzwU11W1pwSCUn81+DX
 HM4/iPePfjnh5ajQ9U6BN2H8sYoWmE+FpWv5/A2+ugwbloyPHxDmD2zQcXR+25hqSsV6
 avwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lG4wnEBKOURmPAWI6cgMoVHRIFycnOyEEDw6ontZl3s=;
 b=DJ3PGiV818zhQdi3RLxngwy2Js4E/jkVt4AN842S/Xtns3/uFQ3YqSGCEU4biDfr/s
 aLN7tINrL1zicYPEnM06YbdI6u+Kb39Fjyg81KysrS21w+zJYc6+L6fEtK9CXs0Uatc6
 hCuEreHdljq/mMJHtaPblAS2XQZgKolad7Sk0td0Ox4b+Di/KvDusr9/8V+khIxYY1bc
 U0a24sokx2ytGBrAkV/9hzwCVk6LLLEYdcf0VfyfhfMJkX7oVHi8wk4HnZ1c+VImTz7S
 ibxmWHUUaQ8d3NrlgiHaqTuZkotafdYSK1Fv9LS5kfJH4IGODkoCneacqB/4ekgHmh1R
 I3dA==
X-Gm-Message-State: APjAAAVvQPZ3vJCb6Eq2/WTw2SK69VdWXpR2kxT17y8Po2vY1DKo3SLH
 wBkrteSvWFSUAyIqQG9t9tzUVXnmiUw=
X-Google-Smtp-Source: APXvYqwlKXlyTEH0UBiHcw6Kh6D0SCsQ2Us7rqolJHEOsqnz0ait+Dn+KLch5BqGTg+Zi1qF4tjKqA==
X-Received: by 2002:a17:90a:37a7:: with SMTP id
 v36mr10105776pjb.3.1567092688599; 
 Thu, 29 Aug 2019 08:31:28 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e17sm2686184pjt.6.2019.08.29.08.31.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Aug 2019 08:31:27 -0700 (PDT)
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1566898663-25858-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1566898663-25858-2-git-send-email-stefan.brankovic@rt-rk.com>
 <64b614b6-cb05-bd16-dd0b-1ffbdc7db94a@linaro.org>
 <bdc9fb4f-b247-5919-c691-62f46f14360f@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5b676467-7887-990a-bdd6-dbd6d5c4e495@linaro.org>
Date: Thu, 29 Aug 2019 08:31:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bdc9fb4f-b247-5919-c691-62f46f14360f@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v6 1/3] target/ppc: Optimize emulation of
 vpkpx instruction
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/19 6:34 AM, Stefan Brankovic wrote:
> Then I run my performance tests and I got following results(test is calling
> vpkpx 100000 times):
> 
> 1) Current helper implementation: ~ 157 ms
> 
> 2) helper implementation you suggested: ~94 ms
> 
> 3) tcg implementation: ~75 ms

I assume you tested in a loop.  If you have just the one expansion, you'll not
see the penalty for the icache expansion.  To show the other extreme, you'd
want to test as separate sequential invocations.

That said, I'd be more interested in a real test case that isn't just calling
one instruction over and over.  Is there a real test case that shows vpkpx in
the top 25 of the profile?  With more than 0.5% of runtime?


r~

