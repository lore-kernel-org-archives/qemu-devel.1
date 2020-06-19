Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07424C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 22:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37B7222D5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 22:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="un3NuQLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37B7222D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmPjC-0001xC-43
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 18:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmPib-0001PO-61
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 18:42:41 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmPiY-0001Lk-G3
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 18:42:40 -0400
Received: by mail-pf1-x441.google.com with SMTP id z63so5090689pfb.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 15:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=OZkbslW/VWfc47vVxvNtc4rLvveYgyUlE6+otFgqMDQ=;
 b=un3NuQLFhgTKB5/hzHU3YHyCCj2u0oiT8bKg9Hsly2WIB3qYdyFymAEAUD/DYfkVxD
 D7SAb/Fxo+oW1gcbxtnASDr6e8XjWLtFGWI/Xdi/yq7KtWz1ACV8WM2UNtB9m4Pd0kmy
 cYj6nngfyHYJoyU0D5j2EdpMpgPJ8ZO/AG4KwASwb0dTsuu0d+poIUdjBJptaBNpQdQW
 xvOjXVz69F7ULOrJTNlehb1emPIgjvkg0FP+6v9xk6EZOS0GVvTRgFdfyPKy8JZSxbSh
 xNCOcHrV9bmc0QU3/xstOFHySY5nj86zNWfabHpJELGn0RtPAOwNSdywUyJK8gtL9abH
 HZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OZkbslW/VWfc47vVxvNtc4rLvveYgyUlE6+otFgqMDQ=;
 b=idOu8kCKzCb75LycDgXQ8JNiZrhXBBzyhfor3GO/AjOodAMBIlm8czdIigMjnFsc11
 oO9xt9AmiWAugHD8ffDmhOlSeOWUMoDoY6ghbxnTs9AHqlQdQAZErNd8t+9w8y2585Mm
 4ezYNj0LBwQrc/AkRjpU6bsMvE7jWCzrSvHk6ET7Urs2UgN3cXi3XNv/K21KKPogreu4
 q5D09s6fKfBgapE5bUoCdZ3vbYrF5eGS/yLARKIJlhzWqdgilvBXFQpE0l1gx0UGGgUO
 +tDfVTeN9+ONBcqGFxdzXFESWuCtQahvRlfzXBG0u5fpjWyzh6zwL5wO+TWSIlRuGqYf
 dqsQ==
X-Gm-Message-State: AOAM5336shasgWmJfGMo5MaZkRGRhpEa4z1I63y74pDKmK00cbQ6JsnX
 cSfpyW2slyR5m7vvaq4RinhlsZqqw44=
X-Google-Smtp-Source: ABdhPJwl2Ba+YZzSOp1exAUkDTHv87Q7sPXlP4d+IX3OS7agPZnPeuLKHEYEM5K6PWjqO9Tj9bIO4w==
X-Received: by 2002:a63:ca4a:: with SMTP id o10mr4609035pgi.182.1592606556828; 
 Fri, 19 Jun 2020 15:42:36 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id n9sm6257402pjj.23.2020.06.19.15.42.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 15:42:36 -0700 (PDT)
Subject: Re: [PATCH 02/21] target/arm: Convert Neon 2-reg-misc pairwise ops to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616170844.13318-1-peter.maydell@linaro.org>
 <20200616170844.13318-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <acea6be7-496d-846a-01c4-49348d73a179@linaro.org>
Date: Fri, 19 Jun 2020 15:42:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616170844.13318-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/16/20 10:08 AM, Peter Maydell wrote:
> Convert the pairwise ops VPADDL and VPADAL in the 2-reg-misc grouping
> to decodetree.
> 
> At this point we can get rid of the weird CPU_V001 #define that was
> used to avoid having to explicitly list all the arguments being
> passed to some TCG gen/helper functions.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |   6 ++
>  target/arm/translate-neon.inc.c | 149 ++++++++++++++++++++++++++++++++
>  target/arm/translate.c          |  35 +-------
>  3 files changed, 157 insertions(+), 33 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


