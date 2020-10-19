Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E232C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936032240C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EzJJAQpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936032240C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUeDk-0006ht-Do
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 19:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUeCc-0005sV-AI
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:04:30 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUeCZ-0006JI-Q8
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:04:29 -0400
Received: by mail-pg1-x543.google.com with SMTP id q21so868952pgi.13
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 16:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=S/RuWL8oYOCUXTso7Nqfx9W2PPmdQxEGf4Ab6PSlrSc=;
 b=EzJJAQpJI5E02fF+S48b7SLmn5XIcrIpKiF8Kb7eRRA+gvCF2BNCMQ9jMpVH7gF++5
 cBy6NLmvOM6rWdKq3mKFMwGAXcQWpKfa+chCbDOnYHbn+KaSQOGOgQlFezOVGILiAb3h
 mVu8PgAvdaAIgRo6yQuHzFiyK0QR1dQ1FZ2sUV/VZx4FHXJPH+EhIHN7n/Rgx8KLgLG5
 AycDuWHsUiH+ESqPIoPu9Eq5QCro2PMlxmsMoNsZKBZOCQS8kquVgbnKjjXdy4mfEBvR
 KKUlOZM0JXUGgVjND0osn73WhRbUET8EcLgCtgdYpKM+l5u2HtZN1y+4FEPhRO3n++Fd
 ajUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S/RuWL8oYOCUXTso7Nqfx9W2PPmdQxEGf4Ab6PSlrSc=;
 b=EvG65+E9QOIbUjeKHlvtSDBGULPRix/Q/0eUHfGLzuCqQJQ/e4d+M3XiSL3eKkoD+9
 fXjVeLzfrqNVIXDyV6rGOdd2cKyPnUhdivsyipXWm+/YW8GMFOX/wIVNervq7U+bD4/o
 rsv3JGfbuCgad8jWqWoZZgx+JDoycNfIXlBv2EqBvOZc+kdJACj/qYnZ5Ylh2ckSidSM
 OHWC9HhY8PneboWPGSykj0OAyESFgMGW7ta1VR/WdUkNgr3nkJDkRMUFPEVFlcRdXFSg
 LcRNapIwNbyK4tJjrowx5AI+zFh8V0vInhFsV53SKXyXi++tkirnrc106fx05UWUxBoJ
 5jRw==
X-Gm-Message-State: AOAM5314rVjUwOc7Q+5iCqaUxslOboHOxQElnWsJggDOiaPRzu3ti4bm
 yX9HN2Qf6v4AuASmC7cOMgkkmQ==
X-Google-Smtp-Source: ABdhPJx/DzOaPbtIZz+E7BVEGYpH76o2d+IYc5j6F0qnZcA1Y+I4b0FSUs6xe2Mt6Sx8gI7FWwwZXQ==
X-Received: by 2002:a63:fd45:: with SMTP id m5mr162113pgj.60.1603148665973;
 Mon, 19 Oct 2020 16:04:25 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id bj17sm39969pjb.15.2020.10.19.16.04.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 16:04:25 -0700 (PDT)
Subject: Re: [PATCH 0/2] tcg: optimize across branches
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20201013222330.173525-1-richard.henderson@linaro.org>
Message-ID: <895139b7-491c-f181-be40-762b7c2dfb1f@linaro.org>
Date: Mon, 19 Oct 2020 16:04:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013222330.173525-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping.

On 10/13/20 3:23 PM, Richard Henderson wrote:
> In several cases, it's easy to optimize across a non-taken branch
> simply by *not* flushing the relevant tables.  This is true both
> for value propagation and register allocation.
> 
> This comes up in quite a number of cases with arm, most simply in
> how conditional execution is implemented.  But it also came up in
> discussion of how to implement low-overhead looping for v8.1m.
> 
> 
> r~
> 
> 
> Richard Henderson (2):
>   tcg: Do not kill globals at conditional branches
>   tcg/optimize: Flush data at labels not TCG_OPF_BB_END
> 
>  include/tcg/tcg-opc.h |  7 +++---
>  include/tcg/tcg.h     |  4 +++-
>  tcg/optimize.c        | 35 ++++++++++++++-------------
>  tcg/tcg.c             | 55 +++++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 78 insertions(+), 23 deletions(-)
> 


