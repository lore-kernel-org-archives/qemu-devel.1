Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BBFC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C65720782
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Trk79zjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C65720782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAe2P-0008Qv-GV
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 14:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAe0q-0007OM-AG
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:49:40 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAe0o-0001lH-K4
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:49:39 -0400
Received: by mail-pg1-x542.google.com with SMTP id d19so7440533pgl.10
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=rvr6bqVGFj/ysVS5qEZqXwCul5yg7EWzLjB6YbEAgYQ=;
 b=Trk79zjword6lZs7x5FdxzRqEwZBXyuuxKVurOp1jttaKNAkH0e/oR3nHNqCzD6xMV
 XJNt8nfTvRTI/vdx9pv9nrtUQlJLs0z6K+Ddx4gg4CkWdXIoTkue9IWlzYcotR29GQBV
 zJ3kn7sjlRaRXLEm3uL14g0oSem/IMte2xzW8+Aau6w+5duSnOa7nNZWpVAldp4yxjFm
 OYfXgDiBCSqXK4y0/iLsWi1ytxKl+dC/BAPFY7jltQJlQwcKwjtAWkJtBYTmzPI8vAqd
 PuoV5fNd4/2XT9BmmSU0wrRC9see1GAHSP59IJtPb/gv+I0lFN5lCXWY0h8hr5ADPgQj
 vUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rvr6bqVGFj/ysVS5qEZqXwCul5yg7EWzLjB6YbEAgYQ=;
 b=suYMm4LusAdBiaJ9USips0mCsp1P3uU8MfS3TZGPwdW5FM7SQ+OgFYQcJYJb90qMjS
 tqKmBMIpcqPgXLf6m/z9PaNOfLx5bLNX6HUsRtHNPtqf5tkiufkL+C5xEfDm8uN18RE3
 kBlkhCD+U+7sHXENGRJlXLABehxmG0zFnoJZ4WStrLr0kK/YtybEfuTwXfjUJ+88VtGR
 gzyWw6M3NNr2b/Xz9hALkT3H+iHKg4/w6ObvewJEo3+xnL2PU4ksjCjk+enwzUksFJGp
 1spMLC6dALHPhcZ3odoLr1qYdlzKr2mnUACMCuNEFVmMEYTpLMX/WrAr4MnBwRq1d09I
 JGfQ==
X-Gm-Message-State: AOAM532JzUQ/3F+Tg93ug6twb8har2egjn+eVRPsP2P3rhxyyhzH0Sw9
 RMukTGcSqZQY7iX+268QvqigfBdsRMXbZA==
X-Google-Smtp-Source: ABdhPJxaeLQwfh8Qs5+9EXbvyzVXdMFYOYIHfwmcmN4lnwjdKYk9ELLMV1fiPTvEKgviclG01dVlog==
X-Received: by 2002:a17:902:bd07:: with SMTP id
 p7mr8610185pls.26.1598381374534; 
 Tue, 25 Aug 2020 11:49:34 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id l1sm1827743pfc.164.2020.08.25.11.49.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 11:49:33 -0700 (PDT)
Subject: Re: [PATCH 15/22] target/arm: Implement VFP fp16 VCVT between float
 and fixed-point
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200824142934.20850-1-peter.maydell@linaro.org>
 <20200824142934.20850-16-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b8e4c732-169e-2153-98a0-e66407693db2@linaro.org>
Date: Tue, 25 Aug 2020 11:49:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824142934.20850-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
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

On 8/24/20 7:29 AM, Peter Maydell wrote:
> Implement the fp16 versions of the VFP VCVT instruction forms which
> convert between floating point and fixed-point.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/vfp.decode          |  2 ++
>  target/arm/translate-vfp.c.inc | 59 ++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

