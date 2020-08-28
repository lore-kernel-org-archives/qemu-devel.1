Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED26C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 20:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC3E207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 20:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eqdvio5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC3E207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBlHE-0003Kk-Br
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 16:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBlGH-0002TW-8L
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 16:46:13 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:56309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBlGF-0005Sf-OI
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 16:46:12 -0400
Received: by mail-pj1-x1043.google.com with SMTP id 2so124383pjx.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 13:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=IycITABhPsUsLfYZPozRPkYOlc5L72MnAv6fCG/m5+Y=;
 b=eqdvio5MKgz2KVV1WUVxylk5cL31/2uwtN1cg2wUXxuCF+FnVa32APskkaJEdrZEZV
 YX7dtacQ9st3jUIpkdNsaDf74ZZTWRTc2wL4Wvn/EA2/dwDzbYxRmiHu8XDVneuZF/qq
 570HFYaENlA3r7s+RRTAcq9q9A7rL3F8mCivjZ4zSL2KD2r3zTksygp9+cBzvGPcAk+G
 YOb/Dn0Hrj6YFKtj6S/moR+BetSNWhrTag/W0QX/28Qgchozy6hyhOvCseTeidV0lBbG
 7e/5ykRZj4eq0B2K7coUCqnNQp+ZycTHCNgPY2ZjDvQFXrDdIYRzYBoD3dosJQGh1P8l
 x72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IycITABhPsUsLfYZPozRPkYOlc5L72MnAv6fCG/m5+Y=;
 b=q8W5UOOzelW2tkZvzfQ+NvrENTall671dx0DX9wO/nbmb1L30NgHD3moppodwY19zH
 bL+Q/5B55W7k0HnPX+ADJJAuwoccMGkRE9S/rxfwwNqays5pgYW/Kx7nNADoLBn/zTBi
 FRQk41OV4Epjo5bQIe3kh78Sob84Ce3tfqxAaAAwkvD19c+02220uTmufePw+k4hxhXt
 O83K8B6zuNvlR/hcM5SGtDM38cdlAaPnW7n4LmPA42ITrsM+fuygCsrf8pQVDFtouXj1
 GXfSEMN5lXV/AL/6aSHnjEYKqX/5weuPRiaUEgA4x5iP/bapKQmbceeERTrJ/zlvVyKr
 pPvw==
X-Gm-Message-State: AOAM532r/HdQYxqP4qROS8r2vuCYv7EB8xGpKSyahrKgOxvUULuav5ga
 ST85EyNGfBnYviz9WNQ1UrVr/5oO8p8PMQ==
X-Google-Smtp-Source: ABdhPJywdMtj2GNCmDRfzbniM+EApnuWtCmqqBQipNwX2cKATnLj8t7RrtzwTD+TH5kGFv2fuL4cEw==
X-Received: by 2002:a17:902:a617:: with SMTP id
 u23mr534016plq.188.1598647570152; 
 Fri, 28 Aug 2020 13:46:10 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id e16sm310153pfl.100.2020.08.28.13.46.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 13:46:09 -0700 (PDT)
Subject: Re: [PATCH v2 27/45] target/arm: Implement fp16 for VACGE, VACGT
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-28-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7b6198d0-9ac4-1712-784b-47ca17d96c52@linaro.org>
Date: Fri, 28 Aug 2020 13:46:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828183354.27913-28-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
> Convert the neon floating-point vector absolute comparison ops
> VACGE and VACGT over to using a gvec hepler and use this to
> implement the fp16 case.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h             |  6 ++++++
>  target/arm/vec_helper.c         | 26 ++++++++++++++++++++++++++
>  target/arm/translate-neon.c.inc |  4 ++--
>  3 files changed, 34 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


