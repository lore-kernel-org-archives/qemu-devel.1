Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C44CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F0B2078B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PwqyYJZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F0B2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvW4-00045e-IM
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtvVM-000375-VQ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:04:05 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:37760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtvVK-0003Jc-W7
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:04:04 -0400
Received: by mail-pj1-x1044.google.com with SMTP id o22so2809260pjw.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=mn5jpHrE3w7uofC/IDA3jOmsg5PYtCdD8dkmLEEZGSk=;
 b=PwqyYJZdf1zU3w9Ps7pAVlLxnfQ9Iv/BQpBqedl66aOsd6AXJEO/yXB36fBTSFoefL
 yREpfOhAEYPgG28nPbRED2IpB6fyg/saNwR7rBuihbzNS+un6AIgpE0iXSuRu1KKakWb
 IKJXtjsNm8yb+rEZ0H6CPo4r15EY1tFt35hy5VhnctkUyxCOVIec9VGVALhpZtKOeAUr
 z8bVvwjoLTsWonUrI2QQRb9sHHCQ7RxtYWnOmW51O5qASs2jDux/rN5VeLvv8vnyMv93
 Igh8fO+YNsJWskaJMdLbrdUkYVp2vUky635R4t7UJQWhSRHxOOfCDExq4pl1yn778uC9
 yx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mn5jpHrE3w7uofC/IDA3jOmsg5PYtCdD8dkmLEEZGSk=;
 b=npy+683V1UE0C1QFCYnMGMOBn3ZZfRwQdd6dN6Teum0zy07hpUVuasS1juGWOtWYxG
 9TDx0rRwyvONTOy1hR5JOhE/DYvyWGK9NzvXY3Z3HBOy+ANz7LFnJMTAzS6yLaLqD97l
 yKB2mSj5Oq//H2dVJg+Iykh1VoRgzkqO/bhz6P2YTOCeccRt2xUTD/j6Av3OWSQcDQRs
 xo4/DR5FXykaOjfIE5hLQ/OUmyDqtkmd7ydp3Cc6DSlnC7ej8202ElkfQnx488dv7abB
 zS9si92ziOR4yNTaLcWuYvI4mtQoZQb9kiqyqBBM5qOp2BhDahUGQlYnnutkE6f34fhj
 j/WQ==
X-Gm-Message-State: AOAM530LMgTKc6ElkSwYRVQjpO+5O4FSgJKW+M+I3tc6DzYbgcARJVLG
 /2CGl9Y5HaWu7l86NokTvfAH2g==
X-Google-Smtp-Source: ABdhPJwDmlZFyijDiwZoct/wiusNbcJKFWWuENWsv5GDs7q56gmrHSYjalZFU5woM6zCIML77lLNBg==
X-Received: by 2002:a17:90b:3555:: with SMTP id
 lt21mr6851750pjb.234.1594397041110; 
 Fri, 10 Jul 2020 09:04:01 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id ev14sm6158728pjb.0.2020.07.10.09.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 09:04:00 -0700 (PDT)
Subject: Re: [PATCH 0/6] target/riscv: NaN-boxing for multiple precison
To: LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Chih-Min Chao <chihmin.chao@sifive.com>
References: <20200626205917.4545-1-zhiwei_liu@c-sky.com>
 <6d2e6876-18a8-b32a-0879-565693b6d446@linaro.org>
 <3c139607-9cac-a28a-c296-b0e147b3b20f@c-sky.com>
 <53a00d93-be8b-6cc2-e091-215c71661453@c-sky.com>
 <0d484d59-ceeb-862b-4c44-e57065b914c0@linaro.org>
 <2d2eb1ec-22fa-cf2c-9a45-ee954a23fa63@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cbdeae92-7eed-dcf2-f552-be3757af4d9f@linaro.org>
Date: Fri, 10 Jul 2020 09:03:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2d2eb1ec-22fa-cf2c-9a45-ee954a23fa63@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 12:03 AM, LIU Zhiwei wrote:
> The comment is moving both inputs check and the result nan-boxing code to
> helper functions.
> 
> In my opinion, it doesn't matter whether put them into helper functions or into
> translation functions.
> More importantly, we should add inputs check and result nan-boxing for all
> single float point instructions.
> 
> If you insist on we should move it to helper functions, I'd like to.:-)

I don't insist, but I think it makes sense to do so.

Less code in translate means less time in the JIT, and more sharing of the icache.

Sometimes it's a tradeoff, but in this case because we will always call a
helper, I think that the benefits are all positive to move the extra code into
the helper.


r~


