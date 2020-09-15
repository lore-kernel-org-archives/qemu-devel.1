Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A770C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3FBD206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qOhgJcpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FBD206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIF9A-0003Xt-NO
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIEay-0003gz-9V
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:18:21 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIEan-0003PX-Ta
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:18:18 -0400
Received: by mail-pg1-x542.google.com with SMTP id d13so2327226pgl.6
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=JX2NGJKopv2F4Aesb0bcn5gY4SFKb7vQm4oePneJCaE=;
 b=qOhgJcpr1ItCO8Yb4bCsmSj6cowEa7hBhQOhp9B8iwpepbO6XI1KqIYLLKbbFtYs7D
 BviXuIDpoyBlvsDYZOVAfsZCmeQbVCXV++B53jAbRBjEG+lVFpulxgb0dZ+vH0PPxnvR
 kAbypmoZSWVkoAH8PMkb9eE3EEtYMQYYIRNIzsYEezOPW382VBlfNDl41/a9X3kXJ7lj
 fNVkDtsIAC9N7eWSmf0Qh2AgUqhyYC+b2AraFfRhO0CormzbQNHoqGT2mPBcjXAscJv2
 7892k/Gf9xl4648VvVZcD3kvbbfhSRLt0qp2ZATFdHSDAGFh0JL5xg0x1FKwRm1NcshA
 Y44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JX2NGJKopv2F4Aesb0bcn5gY4SFKb7vQm4oePneJCaE=;
 b=F/ggi3DYU3GWaMmPF9uAKOIEdcuICOOtczascK8zxy69R1YHMvaE3GLhwzUum/UfIz
 FyvHvHkIvb3xeiKHptjVE2OQvoZusdEhk/i9ckje8zZi5y62fuC9sQ80HJUb1AxXz1B6
 bHumk/3nOibxJ5zG3q5Ro0vV7OMN45/rNUqATau3TOegKRabGBDZBZn5gXjjUi/c0sYd
 TZ7MjCFudretQA+kVOOtWfh+oNmracYI3Uy0Kpa7PFFoknwc4xCHTgL8XCCbGvV4aUPR
 9I4ut8VmP511E/UiDr7M2N9yelcYRUavY6aQ9ev6z7vvJ6q/TGgcMD1VM5W09FSxR2o+
 pC+Q==
X-Gm-Message-State: AOAM5311mOBpEiRCLA1rE88SVg+NYEHBp8llEw5dmIaDQNejERYkkStu
 M67O4rhuhDWcQ7gEC7uVhToy0Nhha6fPRA==
X-Google-Smtp-Source: ABdhPJwFGkxdk0n8/uVT4nYPOsu8wG5yA6E0zil0g27CYUdGPMFLKV0ACWZJ2CuI3Ls9Z5J9UW+CmQ==
X-Received: by 2002:a63:521c:: with SMTP id g28mr8485629pgb.43.1600190276889; 
 Tue, 15 Sep 2020 10:17:56 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t24sm12222503pgo.51.2020.09.15.10.17.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 10:17:56 -0700 (PDT)
Subject: Re: [PATCH v2 6/8] configure: include tilegx-linux-user in the
 deprecation logic
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200915134317.11110-1-alex.bennee@linaro.org>
 <20200915134317.11110-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8656547d-0159-0a1c-41ce-615e1abc9e5f@linaro.org>
Date: Tue, 15 Sep 2020 10:17:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915134317.11110-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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

On 9/15/20 6:43 AM, Alex Bennée wrote:
> The target is already marked as deprecated in the documentation.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


