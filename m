Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDDBC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 20:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5B920897
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 20:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OdJMW06B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5B920897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBkeG-0006io-Ms
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 16:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBkda-000604-EL
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 16:06:14 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBkdY-00012V-LN
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 16:06:14 -0400
Received: by mail-pl1-x642.google.com with SMTP id q3so167667pls.11
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 13:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=5LGxAUBIe/ldoq1ephnDySUKsX8JZ2P7+aD69ClJqLs=;
 b=OdJMW06BXCzyhhFc1jQUU25UK6B/rf0kDvmyjASa0rKriSgBNB2LlEXC/+Zo/Ilhw2
 EVJl1Du5eqJXfXLcCdWASmrsgRCNguWPg/MawI4wG7NJEuhdJ/o5a2CFEfUYwSHQrquH
 PRnPT/UfGjaKTp9th0HonwIXo0Cy41+r5+2C4GNXWQ1gHcTRdjX2EEGxRF01yjht000r
 yF80ERQYSpXGYqci4N5i125uIX02w0gqLygoyFhYXiNi83gHIqF5K+lVw+WqtUHLo8Q+
 cBK/98aoMXvwdSG56SXT2XeE1c9++qYM01TqhFGULUQbrt5WEBzuzh89h5Be0KyeST6j
 NhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5LGxAUBIe/ldoq1ephnDySUKsX8JZ2P7+aD69ClJqLs=;
 b=rfvFiJ65i/DZksMmNBa9+oeuS1CmGru8HZtlNCsXVKIiMG7cmQXas9qn0znn5JnpIt
 M8yqYlBO+Ihai3of8KC+3bDgFLkl/ltvAIDE9mgNtbp1dAw6UK4tf+VuqmZ4LWgLmzGK
 y7cZDWm6hTCLE2FeggBqK33pwRYVJjRr5GhvB1OhUpyYmjFO0993HXkj2S9oBr8/ongV
 1AL6L67/Umzrz7qXIbppVuMJquuvMYs0NN+Fyr29KrR8Vajg6z89cojOpvxAQ8zWeQUc
 cquduJgzVlLHUbOVYVozGKM8RxSl/kq5+vBur2sCf8UEr5t8LSecNRPuB1O073cQXLjN
 M73Q==
X-Gm-Message-State: AOAM532oG7zAXI0m75uxqajx9kxYzuobBJCXw8arg7YUTIPlRm5fpBA2
 iBUhZx6I79xspa5q5CcVBi38dZ0YZxKW2g==
X-Google-Smtp-Source: ABdhPJzvRUhoEJ6iE/xywXniC+70NnXtVlkC3EHuRbg7o1j4r5xuZ5aA3lGXymYNsD8gmPUp9x8YYQ==
X-Received: by 2002:a17:90a:34c4:: with SMTP id
 m4mr554648pjf.222.1598645170970; 
 Fri, 28 Aug 2020 13:06:10 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id i20sm232541pfq.204.2020.08.28.13.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 13:06:10 -0700 (PDT)
Subject: Re: [PATCH v2 23/45] target/arm: Implement FP16 for Neon VADD, VSUB, 
 VABD, VMUL
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-24-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a90d9b04-ddfd-46c2-6a41-1d654cda2c6e@linaro.org>
Date: Fri, 28 Aug 2020 13:06:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828183354.27913-24-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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

On 8/28/20 11:33 AM, Peter Maydell wrote:
> Implement FP16 support for the Neon insns which use the DO_3S_FP_GVEC
> macro: VADD, VSUB, VABD, VMUL.
> 
> For VABD this requires us to implement a new gvec_fabd_h helper
> using the machinery we have already for the other helpers.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h             |  1 +
>  target/arm/vec_helper.c         |  6 ++++++
>  target/arm/translate-neon.c.inc | 36 +++++++++++++++++----------------
>  3 files changed, 26 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

