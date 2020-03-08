Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB61C10F25
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 03:01:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B8720656
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 03:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q930sKNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B8720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAmBa-0000d6-Jb
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 22:01:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jAmAv-00006Y-8K
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 22:00:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jAmAu-00048U-51
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 22:00:21 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:41348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jAmAt-00046x-Tv
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 22:00:20 -0500
Received: by mail-pf1-x436.google.com with SMTP id z65so3179639pfz.8
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2020 19:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=tBqfnFkFQY/k9Ptq8V4GpFDrM8ab5im4XpVbMWNUr90=;
 b=q930sKNJeg+aNroqk8GG3e4lqlCYc9tBbf5VmSpLEFohd50Qu7ed399wvtql7LWnfE
 XIfyyqwmnb/pNz5TfAa72tNzDPn7HwqhGizmk3Wwx/3h4mDcVy3S8bDwzP/tjgIxNoNg
 yDZleFmdiF102URTA+2PKqx7p0KhUDbqFjDMgnNMa4CZBxCACVrkxDovIfIyLiTBjFrO
 vPHu/JQQ31fBgtwm1u0CJRNPcHJM+3kzMI5vuzQG8aW5BvlaQM0Hd8wlEqRFp39BoljT
 5IVIKaMKIyTFp4rOR6q1Gv25jYZKD/wPQWOkWZCh+1Ra3GUc5VquUkiuUfoJYnjL8rlZ
 T4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tBqfnFkFQY/k9Ptq8V4GpFDrM8ab5im4XpVbMWNUr90=;
 b=LA9HVJaHqjNMbzmnCTf7nkD2TIm71OE1TjNtpXUHpgr7TYL2o6ksZvjxlUJkoeRuei
 nAtu+R9guAKayt0Rb2HICsUq1HOGL1yv6nftKWwbICmHGZTKaAuQPbxodtQYJJP0aLuD
 XbLzx3JRlzACk/v6yRFTU7d2UYVrlEWhiVzvMCStwUnH5ubSQ+ueX9L8GbPQODP16BSu
 8xXiTku0Pj0QbwLC+3H57TgSPQskwOpTtJQRilrNuqGmWRdG6Xj5Z9lEIxE1+3l6hm+u
 Rb9qDFIBdZ9j2swPucBV4xlHl16LSy2xL/+/x/EP/ix94Ic8oUXUVxdrwSXtYCNw3zl3
 IQWQ==
X-Gm-Message-State: ANhLgQ1BqNSjkANCdhlOURfmD6NdCyEq8cMhiAxT0nbQVGsx6ib/0imM
 S4zteGjI7Bn2NF/ZSnFVnTQ5nknE+xs=
X-Google-Smtp-Source: ADFU+vvvh2nCiN5jnMgvrpm6VzVXLvYO7BmZdF8o2NM6YiEKXyG2DyxpLmCtdTPSeurubyc166tw4Q==
X-Received: by 2002:a63:f962:: with SMTP id q34mr10034007pgk.229.1583636417094; 
 Sat, 07 Mar 2020 19:00:17 -0800 (PST)
Received: from ?IPv6:2601:1c0:6100:5580:6886:21be:91dd:78be?
 ([2601:1c0:6100:5580:6886:21be:91dd:78be])
 by smtp.gmail.com with ESMTPSA id s21sm12059414pfd.99.2020.03.07.19.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Mar 2020 19:00:16 -0800 (PST)
Subject: Re: TCG global variable aliasing/optimization question
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <BYAPR02MB4886920CEE376F484A49BAEFDEE30@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1df4b6d0-39ba-2e5f-6be6-544414783d40@linaro.org>
Date: Sat, 7 Mar 2020 19:00:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB4886920CEE376F484A49BAEFDEE30@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::436
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

On 3/6/20 7:55 AM, Taylor Simpson wrote:
> Does the TCG optimizer assume all global variables are unique?

Yes.

> If so, is there a method to indicate that two global variables alias?

No.

This is why combined fpu+vector register sets, such as ARM NEON, are modeled as
a block of memory within CPUARMState against which we issue explicit loads and
stores.

It has been a long-term goal to improve the TCG optimizer to be able to do
register allocation across these memory operations, at which point "global
variables" would be lowered to loads and stores, at which point the kind of
aliasing you're talking about would work.

However, it's been 2 years since this goal came up, and I've not really gotten
around to doing anything about it.  It's not high priority because x86 does
such a good job of store-forwarding that it would be difficult to make up for
the extra computation required.  :-P


r~

