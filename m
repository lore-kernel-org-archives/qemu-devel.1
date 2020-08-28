Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F84C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:16:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA1820838
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nf9s4MBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA1820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBnbJ-0005lI-RB
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 19:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBnaY-0005Ax-UC
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:15:18 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBnaX-0005Sg-Gy
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:15:18 -0400
Received: by mail-pf1-x444.google.com with SMTP id d22so1394812pfn.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 16:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=43WSVJzarsL3eZt2zG/DYCCayJJNxtwu/41CXWtyY8c=;
 b=nf9s4MBe+EU/Mx9cmnB7sa4YyHFcm9xv77nJ7tp2Zd9FurISWNWYp7fHkAMAdw7lvo
 ij1zSGe7DHoIOJype3pqGAYaroPWd6J6USy6CqOjfOBLTAgNmMBKtrrsmNeZYTjbUCRp
 H+2oHTmwrqtldJNah/qiN1k4OCdcg7SEpuTSBoqMmt68X3YokOnDU/uJ5JPbh58Hg0/V
 k/YW8gKfVtLGOruMKGEJ9Top2BE6Xsh6t+wszNP8gAhuZHtpbSnVIY7OsMWqFxsz+6ce
 a1fp8ttCxvDzkBhy1cWCRLjxkQcpt03EfJKIUVJxlNIpXnPRs3UivUwBPohvvF/tjsVn
 0yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=43WSVJzarsL3eZt2zG/DYCCayJJNxtwu/41CXWtyY8c=;
 b=DU28OUw6Is4p2gR7VKDnWbkiof4mmrOZgA6PDTmEDFSIrDWvRzXrhWLhZr5/qDOk4q
 3wBGKka6KePuQx4jhh1w9MHDy8CdA6fTKqLDHrYxD/olESsup8VB/dP39HAHwlCB+6pw
 L6Ib2CqIGYFeu75aD9dwCwrrkf/9OGJy01x/AVSyLaByoPx5ccHoXC22Eyr0OZ9ejiLG
 4LpfgbSYFTpLorwUVHZXzu5tDGqtKC7iig3YEh9hpU+2YfusHG1cenTTw+I4tjnGaau+
 UvQku0yNrX1vfqNVUj012mBCy0MhvRjamTowX8GohBPdVokIhcZ/nBUCzw2b7hmdyPjE
 YEqA==
X-Gm-Message-State: AOAM530avcy9ZxRqlYUzLcMMjK4S4urH88PJaC70yXHroFtjIlgTo/Xd
 bbwsntP1mmFZsP76kVL6T5jfW7TLpUCeqQ==
X-Google-Smtp-Source: ABdhPJxKdlae02kWTuCp03LQIuRPDiSXhhuPlW62qNnJRzQLHeIj7y4yfPps2ISupYZs+LViuJxqdg==
X-Received: by 2002:aa7:8c42:: with SMTP id e2mr1016889pfd.181.1598656515947; 
 Fri, 28 Aug 2020 16:15:15 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c143sm497501pfb.84.2020.08.28.16.15.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 16:15:15 -0700 (PDT)
Subject: Re: [PATCH v2 40/45] target/arm: Implement fp16 for Neon
 VRINT-with-specified-rounding-mode
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-41-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cf4cad38-a1da-ac71-ea60-667b2389abf8@linaro.org>
Date: Fri, 28 Aug 2020 16:15:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828183354.27913-41-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Convert the Neon VRINT-with-specified-rounding-mode insns to gvec,
> and use this to implement the fp16 versions.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h             |  4 +-
>  target/arm/vec_helper.c         | 21 +++++++++++
>  target/arm/vfp_helper.c         | 17 ---------
>  target/arm/translate-neon.c.inc | 67 +++------------------------------
>  4 files changed, 30 insertions(+), 79 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


