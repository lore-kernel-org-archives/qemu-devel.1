Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964CEC7114E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 03:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5548A2072D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 03:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQH/xF+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5548A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3AVP-0004EJ-H9
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 22:22:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3AUm-0003n2-G6
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 22:21:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3AUk-0000Ow-Ud
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 22:21:24 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:34844)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3AUk-0000MW-OT
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 22:21:22 -0500
Received: by mail-pj1-x1043.google.com with SMTP id q39so5731726pjc.0
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 19:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dEek3nyMv+LdhHdEYfCw8Vxa8VojL44cf12/+u+RZ0g=;
 b=IQH/xF+Fzqz62V998WJXef+ZjK1WfMQnYU8wEyrhcDQQznhyNp6NnH75ESplAtke+u
 Nbo0dRxMGQAkcfoWocVM913W5AO6V9xO/Wqqkdg7jVv2q8byZoZbDzmP7eZE2LbilBM7
 OXVNmrXm6ljlw20AyWuTN8jz5uAsonA4OY/TYOQG+Ef2/J8AsyhVX+NGtmrseMIhJjAo
 4u/X7yIiWFIFArfeh4Ulr0Sa9VDaWafnWdZk3Oc+izPbMfIgdB+h1nhTc61KG6yoFMJ1
 +r64nB/tLnpxDwIINwB53I7bxlIVsE4tr3QBw3S3wz5OtD0xpQ1DHNtMduwih/6gMQoY
 Ar9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dEek3nyMv+LdhHdEYfCw8Vxa8VojL44cf12/+u+RZ0g=;
 b=CLygrl0ZELhCeMU4K+zeZZ3udqWgA4FQDfyjFe+vjRmMHBBI6cppLBC8sAJZq/qKpM
 qPoxz2Aap4a3WH9Z4iz1tECyPG+oLazmCWJBXCCcnYMrLjkC3kBlbisaUR0rt2HsQ91j
 HNeG73t71wgSCQmSeT0HCuM4nTM0f2r4eLL9PgfSqAMs8BoE9cDmRO0kUIB008vuV++c
 au/SiwwiWgNEXnSYvUQdNpA7W4wz+2w2R339qQueox6cHudWxtXZ4L400lhRr3xAn4+j
 BzUCaHWHTC5pBocEkT7TxxBhR3CaAxijh5d0NoarCIXIpLQWxvR/BCr6rNcAFM0nGsN/
 boSg==
X-Gm-Message-State: APjAAAV0m+dw4+W9XbK6xUAOOteFlNGg/K+MBqfTnA/sODZwocnmPavO
 12eXV0bsfy+oj1gjoUGd7Qmx3A==
X-Google-Smtp-Source: APXvYqxIsd7fcPw2XJLQ81LGa8aVZhum4DPXMYr25McX5WG88URmZKGiRN+YkHjDC0TtJSXjaZ97KA==
X-Received: by 2002:a17:90a:f0c8:: with SMTP id
 fa8mr12480733pjb.136.1581823281256; 
 Sat, 15 Feb 2020 19:21:21 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 q11sm11625629pff.111.2020.02.15.19.21.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2020 19:21:20 -0800 (PST)
Subject: Re: [PATCH v2] compiler.h: Don't use compile-time assert when
 __NO_INLINE__ is defined
To: Zenghui Yu <yuzenghui@huawei.com>, pbonzini@redhat.com, tony.nguyen@bt.com
References: <20200205141545.180-1-yuzenghui@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6d5dc618-744d-d5e8-d507-8a2c3e69c11a@linaro.org>
Date: Sat, 15 Feb 2020 19:21:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205141545.180-1-yuzenghui@huawei.com>
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
Cc: wanghaibin.wang@huawei.com, qemu-devel@nongnu.org,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 6:15 AM, Zenghui Yu wrote:
> Our robot reported the following compile-time warning while compiling
> Qemu with -fno-inline cflags:
> 
> In function 'load_memop',
>     inlined from 'load_helper' at /qemu/accel/tcg/cputlb.c:1578:20,
>     inlined from 'full_ldub_mmu' at /qemu/accel/tcg/cputlb.c:1624:12:
> /qemu/accel/tcg/cputlb.c:1502:9: error: call to 'qemu_build_not_reached' declared with attribute error: code path is reachable
>          qemu_build_not_reached();
>          ^~~~~~~~~~~~~~~~~~~~~~~~
>     [...]
> 
> It looks like a false-positive because only (MO_UB ^ MO_BSWAP) will
> hit the default case in load_memop() while need_swap (size > 1) has
> already ensured that MO_UB is not involved.
> 
> So the thing is that compilers get confused by the -fno-inline and
> just can't accurately evaluate memop_size(op) at compile time, and
> then the qemu_build_not_reached() is wrongly triggered by (MO_UB ^
> MO_BSWAP).  Let's carefully don't use the compile-time assert when
> no functions will be inlined into their callers.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
> 
> v2 is actually written by Richard Henderson.
> 
> v1: https://lore.kernel.org/r/20200205081703.631-1-yuzenghui@huawei.com
> 
>  include/qemu/compiler.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Queued to tcg-next.


r~

