Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9833DC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CA722086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ajhzkvjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA722086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBnOi-0005DJ-KP
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 19:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBnOA-0004eJ-Jz
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:02:30 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBnO8-0003yH-3l
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:02:30 -0400
Received: by mail-pf1-x441.google.com with SMTP id g207so1389234pfb.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=WHPbtsXjB8fAKSE91w0G2VmJKRHKkzNuc2WxO+7mGwA=;
 b=AjhzkvjmXdkW9COPv05gLujnnVgxJdx3Xykesx9ZGRicliduNJoPlvIZzqAUQ2lqeh
 MciPTII0JFXzKk2gAbq70xkfiUrYA44jJpOpJkyxq9yP+TxdQta72kKStTzjIA2Z+3fy
 demkDUkHJdgt83MbCVVUyuLQRjHiNWAufvqrizA14C5k1+UjoudZQqPpIl1zFkxQsaHn
 rqt1pkhgNt+aHmuvVpjkk3r7JcxQ3XHu821SSBknsueJp7+jkr2dv4E1ImU9if5eXu4Y
 HomFUrzRygtMG+SXjZF8m+idBcG+wP09p/aGE5RI+/ihzY/CA4A9aISpLZkXClzOdyet
 MC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WHPbtsXjB8fAKSE91w0G2VmJKRHKkzNuc2WxO+7mGwA=;
 b=YOi1LG5voVq/jYNunOSooyLLN/0D3CJ+gCT1M55o+5ueBW4PFy270f7pR+Efdzz68g
 UlbFG4lS2t5U7sSyx5kQK2LZjSn8l/YB7jZ6VwECTt+GVe9ICZhAtbEWL/PdghGff7fC
 tHnG45En1bP5ghBdjhSKGf2Qkp5TiXaD1Qt7z+xGVCWXIALeFg1wM9OupBcJuLjEeSQ3
 fAUTi5nyrFA43efUOyfwb3o2vtAlJHCgRoY1tC/CHLoaSnddZ7vuCo025Rbj9hPG1Teq
 7fAcDJ0kN2qi9F07AVTsUqANCSzJDcU7wk0IEhgAmg+5YnglXc7EhXRGE6zdbWajQq7M
 5M4w==
X-Gm-Message-State: AOAM5317NtHABs5/IJ+YlnmUCRq+vf9HK8WRBUjvb+yiSRilt6y7Rz8x
 SKaSYT9K2pqbgDKEQGVqS+Xvvh+WJzub5g==
X-Google-Smtp-Source: ABdhPJyMjnWtwKz6j9NLBA2yxfnBGwQVs8NGWpH40nlpRy7EVlHy2ltKmEYj/FWl758eUKkb+5/KCQ==
X-Received: by 2002:a63:1a0c:: with SMTP id a12mr742428pga.24.1598655746414;
 Fri, 28 Aug 2020 16:02:26 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id n22sm333824pjq.25.2020.08.28.16.02.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 16:02:25 -0700 (PDT)
Subject: Re: [PATCH v2 33/45] target/arm: Implement fp16 for Neon VRECPS
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-34-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <25897cee-58e9-a114-b6ce-7705901a724c@linaro.org>
Date: Fri, 28 Aug 2020 16:02:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828183354.27913-34-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
> Convert the Neon VRECPS insn to using a gvec helper, and
> use this to implement the fp16 case.
> 
> The phrasing of the new float32_recps_nf() is slightly different from
> the old recps_f32() so that it parallels the f16 version; for f16 we
> can't assume that flush-to-zero is always enabled.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h             |  4 +++-
>  target/arm/vec_helper.c         | 31 +++++++++++++++++++++++++++++++
>  target/arm/vfp_helper.c         | 13 -------------
>  target/arm/translate-neon.c.inc | 21 +--------------------
>  4 files changed, 35 insertions(+), 34 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


