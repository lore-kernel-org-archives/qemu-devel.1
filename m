Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577B9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23DBC20720
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GLpdZrGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DBC20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtCcO-00037u-AQ
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 12:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtCbq-0002iu-N2
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:07:46 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:40782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtCbo-0002nT-K1
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:07:46 -0400
Received: by mail-pj1-x1041.google.com with SMTP id t15so1382255pjq.5
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SQl+MVhqr/sC6MkWYzcTIi6xaFLm4F3ff68mqDMkyME=;
 b=GLpdZrGq7F+FITwSk+HB/MJoF6Er54RdlE2HlzZ2T3xKYM5TzKyxGeIGpD5OrL/scr
 aPxCy/8gWriSEdy3qXZXm1qEFosn07EbbZkAcDno9fJUrTRMIC4mQeVtFtFaT9CwL+NE
 tj8DlF/iWjimsF7GAmczMgmtXJ527wRWkRwXh5vorJslv5jzThissSYsW+v89R0A6Ebp
 8IxoQspFgEdSYEo8Cbc+WRqRlhWrIdKPkFc4IDxmzJfIZAuGgjHVSJA1+kYferf481ZT
 qitJkpLL/y/Q6iChmOuFRRCF3NHGALZTzx8TIJQWslNlQ3W+zc3pOfMoN2i2pIgvD0xU
 XAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SQl+MVhqr/sC6MkWYzcTIi6xaFLm4F3ff68mqDMkyME=;
 b=jGli2OUoHTKBAhkuoKQuUKv3VtOO8JQjDTOW3lPzc1MM4jJyx5WrN0LNL5nadqteQh
 9K4kGEPld/4/V3fJFY6hw4lkSjjZxOpmO7mmf0SsXq7p3flMupwdduE4H7mJXG7fbOIx
 xGecsAThtRdayxmTp1Xo4Hg2ocleXWzM9ehwBD8Qa7w1ES5iwEhZfKK11yZabktXzA/F
 WTew1MXpztBYe5sOpku4aUlYa8JixFpNhqe3D+0xTvANgE664vgx5KWP5SrnfrLxd/42
 diFtoTqC2mjgaVY5LJisIqBckPbS90wCDd1ISBeP5wW5zuXbpGIMbhO7cBPYwW+0aWSD
 dNbg==
X-Gm-Message-State: AOAM531XYQ6IACjE2RjHY+UV5I8X4QkSx2ecIfzAwyYd2ybopUaqXC/L
 25423rrTbQplmNJ458jUPUY8AQ==
X-Google-Smtp-Source: ABdhPJzlrx/fvBGxMAv3sxQkD/gkJnw1fiHUuiSW8hwWxiDT/8MkMwmZczgRn6lhOEbI6HSEq921zg==
X-Received: by 2002:a17:902:d892:: with SMTP id
 b18mr52507299plz.335.1594224462954; 
 Wed, 08 Jul 2020 09:07:42 -0700 (PDT)
Received: from [192.168.7.121] (24-113-145-216.wavecable.com. [24.113.145.216])
 by smtp.gmail.com with ESMTPSA id z11sm285852pfk.46.2020.07.08.09.07.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 09:07:41 -0700 (PDT)
Subject: Re: [PATCH 03/21] softfloat: add xtensa specialization for
 pickNaNMulAdd
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
 <20200706234737.32378-4-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ed5c1993-1aa9-1c53-9038-1b32b863deee@linaro.org>
Date: Wed, 8 Jul 2020 09:07:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200706234737.32378-4-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/6/20 4:47 PM, Max Filippov wrote:
> pickNaNMulAdd logic on Xtensa is the same as pickNaN when applied to
> the expression (a * b) + c. So with two pickNaN variants there must be
> two pickNaNMulAdd variants.

"Is the same as"?

I question the non-use of the infzero parameter.

When infzero, (a * b) = (Inf * 0), which will produce a default QNaN.  Your
sentence above would suggest that pickNaN is applied twice, so that if
use_first_nan, the default nan is chosen above any nan within c.

In addition, is the invalid flag raised for (Inf * 0) + NaN?  Does that happen
regardless of the use_first_nan setting, or does the whole operation short-circuit?


r~

