Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F810C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4612020774
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZliVlTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4612020774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GXP-0002Dx-Fd
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6GWp-0001os-52
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:56:35 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:37501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6GWn-0004nx-1M
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:56:34 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mw10so3035202pjb.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 09:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=7WXBwvey9BXP65hoVqdPfrNGwtcI7TkVLlNyPPBP9gs=;
 b=bZliVlTzZXvTAHqAZllcXoHJNXb38OMUqXDXrTRfoweflXDpvcJPHAdaexUT6M8HWo
 cT8sIfsDzv1Frv2xN7ye4nyZgQ9ZyvcHpG54dT7uzEHWH6G0MnTTGN/5/zJn6pEOz2nX
 kl+/jpnd9rAnZ8nwXyR1tYexfjUOXj/G4uGmwUgmhs7dOwE4RbxxF1G5W+6TvLu4WBs8
 mbirw9WTYmdldOcXrSwxbI7ckkoMmynpoh0ivM32/ZEQbLZHqS8ryCzEZuoXNbyVIQSa
 y2KTTmYmCdptgctE2rpdbflmn7crDbFCZsPwBEQ6ScVBQaW9o3TJ3XuDqx5KveTxU7a7
 DQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7WXBwvey9BXP65hoVqdPfrNGwtcI7TkVLlNyPPBP9gs=;
 b=akYms0nOapRdxMXxr/PWHWvbekWIHbceyBgFm7l60m8GqokRHfZICpVrLYizja0viM
 zIR3KErU+Yv7cNjkDjO7xd466C+UyjUL1t3Sw+RhYkQ+4OVMvH4Qk4fRQvgmnmn8KMGm
 k7qatIxgjgWaAw0a8dYWEi9z9dBUVoIFJ/+OkDqx0oqdIT5SyVwdsl7HW2A3P2uHS/ZL
 rEohIuSShd8Jes+PtpatFz2cBoPnEgvpGnCPhDnogewA9VkFLi5w0hrEbYTtQoI/AiGV
 BbjDNj5dPswnVYf6DMKd7BgVqwOpDycTiQvzQtEb/habb8Q4dx1N+FelYG0bA6LtY+HG
 xeIg==
X-Gm-Message-State: AOAM530MjNJCJbnPqSlFJrzsl3gzl/oKZtZzlm7aUik8cXkgG71/H1Rb
 Gdv//yxLuZv4gjxeKQWTO9YSJfRSZns=
X-Google-Smtp-Source: ABdhPJxyqU38WA4+zaZu6XusTxmEch8xAgnTepvV/L6nxz7a4xwKb5UQuRO/nyjchyVhF75dhMJOIw==
X-Received: by 2002:a17:90b:1116:: with SMTP id
 gi22mr6229781pjb.209.1597337791107; 
 Thu, 13 Aug 2020 09:56:31 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id u191sm5650916pgu.56.2020.08.13.09.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 09:56:30 -0700 (PDT)
Subject: Re: [PATCH v2] tcg: Fix tcg gen for vectorized absolute value
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200813161818.190-1-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a61e17c-bcf5-9e7b-63ed-48be0d5a5dcf@linaro.org>
Date: Thu, 13 Aug 2020 09:56:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813161818.190-1-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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

On 8/13/20 9:18 AM, Stephen Long wrote:
> Signed-off-by: Stephen Long <steplong@quicinc.com>
> ---
>  tcg/tcg-op-gvec.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Whoops, I forgot to add the signed off line.

Queued, copying the patch description from v1.

Which, by the way, should have been above the "---" line there as well, so that
it gets included in the commit message.


r~

