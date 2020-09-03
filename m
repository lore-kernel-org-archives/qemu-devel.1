Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEF6C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E1120758
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GrsvskKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E1120758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDs46-0005eP-H9
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDs3B-0004mc-SU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:25:25 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDs39-0001sZ-5r
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:25:25 -0400
Received: by mail-pg1-x543.google.com with SMTP id 67so2526474pgd.12
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 09:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=d55bjfYXbIsQpM11ZH3ArJgmncniHoUsc9n8g/hvS9w=;
 b=GrsvskKegSWpkZmawPLF6i9hwKpDysPHBPo50N/Mb6qU5go/tEB6im10njk8YzvFBd
 BYZYmAXxZydDY1ohw64zNd31eekMxEdim/XbDSUJ0gRYhTx9shdiLspVZuzO+ult3aUa
 CGq3Lr61hcO85/1WVKj34InXQImqMrSAbmGSiPPcaMC2cY+DjktfR0P4cn7DTBsVylJb
 QcaHhNJyz69MvVUNvIP7SMJy3znK5trMR3KSN/pkKd/JEwGaaGnJIzv6RbCM3PyLOSCj
 EpUMyVgkMLUlBxLP+El3iANjmIIVhHbB841VIbcmwRBsOquez7Rs+g1J02MK5tV5PGbz
 V2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d55bjfYXbIsQpM11ZH3ArJgmncniHoUsc9n8g/hvS9w=;
 b=RvwGDZIGacuTm13SVxQBMjPU//9ovJK2CzHoxKgZquhf1smQJd3Y8eBDrNoQQuAWk0
 6SA2kRSuk8CpL1j52cIfxU+PtklkzU391hVFjZmEDopiPMTwg1sfLKINzQppE2h6MRdl
 FKNhvfBYulKSy6keVRk8CPWq/3uFG9V3nQtsSnSoeHoJgqYqsj/DqJ4QqoE1nkFpyreN
 xgZPOPIYx1LgceFBNSFiBwz7n/arM7/6QFIpGlxM6yoeF5u6vc1CBX1QjLqK661drymY
 zfYsX79cF+tv5ky1AOE9KciS0lGu4BKkFNRMZtJrDMuW+ZCg/UXThXsGlKLNp+ASwmD3
 PCsw==
X-Gm-Message-State: AOAM532hDF6OPNvwf6g9BAx/gFOVCWmChWwt2ik4uxchVSD1Qa7oU6sB
 Vswf1bVi8LuEz7A//MdJdsLXnWCxp5X14A==
X-Google-Smtp-Source: ABdhPJzg7xlKAX6lcW2i4SCZrN4xzbT9NJBOKpVYiWHLf7FkjWlwIsr3Tqwnumap78U62/FPtJta4Q==
X-Received: by 2002:a63:3d41:: with SMTP id k62mr3438216pga.87.1599150320475; 
 Thu, 03 Sep 2020 09:25:20 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q71sm3132304pja.9.2020.09.03.09.25.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 09:25:19 -0700 (PDT)
Subject: Re: [PATCH 1/3] target/arm: Convert Neon 3-same-fp size field to MO_*
 in decode
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200903133209.5141-1-peter.maydell@linaro.org>
 <20200903133209.5141-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d4329a97-d20b-f47a-ddca-cc42cb190ee7@linaro.org>
Date: Thu, 3 Sep 2020 09:25:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903133209.5141-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.403,
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

On 9/3/20 6:32 AM, Peter Maydell wrote:
> In the Neon instructions, some instruction formats have a 2-bit size
> field which corresponds exactly to QEMU's MO_8/16/32/64.  However the
> floating-point insns in the 3-same group have a 1-bit size field
> which is "0 for 32-bit float and 1 for 16-bit float".  Currently we
> pass these values directly through to trans_ functions, which means
> that when reading a particular trans_ function you need to know if
> that insn uses a 2-bit size or a 1-bit size.
> 
> Move the handling of the 1-bit size to the decodetree file, so that
> all these insns consistently pass a size to the trans_ function which
> is an MO_8/16/32/64 value.
> 
> In this commit we switch over the insns using the 3same_fp and
> 3same_fp_q0 formats.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> ---
> I wanted to call the field %3same_fp_size, but decodetree
> doesn't seem to allow a field starting with a digit, even
> though it does allow a format that starts with a digit.
> So it's %fp_3same_size...

Odd.  All of the names get prefixed, so we don't have a problem of a digit
beginning a C identifier...  I can look at fixing this if you want.


r~

