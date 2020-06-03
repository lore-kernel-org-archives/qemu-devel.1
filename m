Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96513C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:13:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65105205CB
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AzUM2XXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65105205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgW0l-0007xE-Kh
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgVzz-0007VX-Rj
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:12:15 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgVzy-0003Ot-EK
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:12:15 -0400
Received: by mail-pf1-x444.google.com with SMTP id x22so1917377pfn.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DI/6qUylfopUN2h+tUyaByoCaFs1JPylzBNRTIc+Ak0=;
 b=AzUM2XXvt5I0j4eCzdqMHqPs2xO+FCXSuybdR05uXyGu0QVWcskGuo7bChE2+J8MJt
 F4lG9TH8DoHQZBepg/tnEUj4SNat8IsexTTa1+q2ge2WaBu/Rr5htxhszIdphTqDIpIM
 44z+XY2P17ZG2ZFpMUXJHjs3LpMoBwIwo01r6W3hOPUDHaVVlHVeVKDC7zbAX44NUV8p
 FjNkktiKuikKBG2p0VrgMGdlKj1LHRglEmVBoObwn0mNDHFTUgNKZOZe0dwjXC/OjyCm
 NBB9cbQa2YHNuqcna+bS0034wH2rSthMrJkfIcAGz3llTIWeDHO8ZWayDmCgPRbl5ts1
 sGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DI/6qUylfopUN2h+tUyaByoCaFs1JPylzBNRTIc+Ak0=;
 b=Mvhz1jFf/WZk1kohkfXH4B5Ooo5BVFpGncvoxZ1rDPgl/4/9albqxysv/rKG9FOv6V
 PKuNK7KaITYnksDNrj98ofTqPSbpLR6gS3jKa1DuBbhBW0mLGIKCGwZc20MTuy+jecHJ
 WSUtXX8sP203MjFNI7bZaGlkROjK0yEjhPUmaKA2t0JS/0dojrnKA7U40teQ/IcpyLUm
 w5hCgpEpgsqvhl7vbynfFJRPpwr8mQh5kVfzaaU3zUornhN4eNHCWg/GboGeDslzZ3Fe
 5HZSvxWak7mkG+0CJntDIOGfeNruftfpZc9LS3ivMAFCjcpaXFuxQPUzQIp/VA7tJcgc
 Xe6A==
X-Gm-Message-State: AOAM530O3CWObWaq0oCUgewI6/rvxVT4xCrsn7w89Y6dKT6UFmrp4kWQ
 EEL2kcFH10001xtnPg/RFIuwZA==
X-Google-Smtp-Source: ABdhPJwQc3vOF0Z4T0/JYtEQnPigAxJYveiZOcExbN/U//XGwIu0mU/SdBq3giYXMadMAOHDbb55yw==
X-Received: by 2002:a17:90a:f508:: with SMTP id
 cs8mr529526pjb.16.1591200732872; 
 Wed, 03 Jun 2020 09:12:12 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id fv7sm1870685pjb.41.2020.06.03.09.12.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 09:12:11 -0700 (PDT)
Subject: Re: [PATCH v2] exec: flush the whole TLB if a watchpoint crosses a
 page boundary
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200603112442.22833-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1d870b62-91fd-3065-43a3-d033d5e646ac@linaro.org>
Date: Wed, 3 Jun 2020 09:12:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603112442.22833-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/20 4:24 AM, Alex Bennée wrote:
> There is no particular reason why you can't have a watchpoint in TCG
> that covers a large chunk of the address space. We could be clever
> about it but these cases are pretty rare and we can assume the user
> will expect a little performance degradation.
> 
> NB: In my testing gdb will silently squash a watchpoint like:
> 
>   watch (char[0x7fffffffff]) *0x0
> 
> to a 4 byte watchpoint. Practically it will limit the maximum size
> based on max-value-size. However given enough of a tweak the sky is
> the limit.
> 
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - use cleaner in_page = -(addr | TARGET_PAGE_MASK) logic per rth
> ---
>  exec.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued to tcg-next.


r~

