Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E8DC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FA5206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9IacUmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FA5206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIkm-0002yd-Bk
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1idIhf-0007tV-Ha
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1idIhe-0000R5-92
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:51:47 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:41237)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1idIhe-0000MR-0a
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:51:46 -0500
Received: by mail-pj1-x1042.google.com with SMTP id ca19so3102543pjb.8
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 10:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=a58EPA6O8Jok4akFf7VU1F7SW4gGCoeoMRc1Ih6XYmg=;
 b=L9IacUmE6zX/6iUVe2SHqART0JDe4vzcUAPmmrjDdSm8yJk0obbZ9bS6HOX1NzOt67
 iI/qQikWu7PhzeU9iPgY+7BRzc0mtVIL2R7FEvlYu7XuT1hsGO35Rbx0rIYGJYW9wKzQ
 /7hFTJJTXeXprjz0qksnYTf0yr0kZLGLA6NoCLinfc8CnfUl6GwpN1e46EDhFUZijXpG
 B4aC2iQ6TTGFxtrKVQhemnFNgbf36tsuB6+aM0Fm+bwjTHPEk23pHl5FjTuci8iMxuEH
 OBuA8CK7eNprnU7srUudf9ZTiroCmqQ8vSHkBJp+eLKeF353kb8/7kuXLLi5WFFLgvtV
 jMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a58EPA6O8Jok4akFf7VU1F7SW4gGCoeoMRc1Ih6XYmg=;
 b=pxkwdp9iLYk23BzuZOTl010/grGl5+yEks2X/H//o7rUlaA+Qy0+F7AbcQItVeuUeu
 SVZh43v93oYSNyEoX6Sh4fl/ImquZRh6NHL+iiE01sdry5vhdslagbosTiQQTjEMbbHR
 U7/POUFBGF2Aeype8ztLrWHCPu7fLIwpy5Mny+24uwCrk06u+PbWe6LJV+EbnAi1DHbV
 twBScTw6/AoOn9C0neocvNlXFGPY+hvkfqVXnSie62b/pwMb3fC8wnfUFpfJsqkScWyV
 c2sAVqOqvF1mn1g++kL+gx8NDH9eb/EbdwoKsuUHcSPk2Ihw1nWECLe+KLjECg6MURPR
 bLNw==
X-Gm-Message-State: APjAAAXcj2Ojv/sueMFgist+RS5inwBruWsD6IcqFdztMyXsV0zXsDCv
 ekaXrr/S9gmCUb07hWehHgZ4sg==
X-Google-Smtp-Source: APXvYqwxh/A5CUW2Rai6LMBqZm2q8FajTQblKIw8IyauZUNNtQ84nEh5sHB5o05CocNS9ibEgXLFxw==
X-Received: by 2002:a17:902:b204:: with SMTP id
 t4mr16106021plr.137.1575658304641; 
 Fri, 06 Dec 2019 10:51:44 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t5sm3977382pje.6.2019.12.06.10.51.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 10:51:43 -0800 (PST)
Subject: Re: [PATCH v4 35/40] target/arm: Update arm_cpu_do_interrupt_aarch64
 for VHE
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-36-richard.henderson@linaro.org>
 <CAFEAcA_DmXG2QJsLCu_gYSCYVCQ4xr1hPkEbfpVXMTZe_wnb6Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b48552b0-33d0-405f-85ad-59b46e1702d0@linaro.org>
Date: Fri, 6 Dec 2019 10:51:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_DmXG2QJsLCu_gYSCYVCQ4xr1hPkEbfpVXMTZe_wnb6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/6/19 8:03 AM, Peter Maydell wrote:
> So I *think* what the code is doing is:
> 
>  When VHE is enabled, the exception level below EL2 is
>  not EL1, but EL0, and so to identify the entry vector
>  offset for exceptions targeting EL2 we need to look
>  at the width of EL0, not of EL1.
> 
> Is that right?

Correct.  Much better wording, thanks.  Will update.


r~

