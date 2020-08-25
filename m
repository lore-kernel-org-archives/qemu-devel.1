Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6568C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E642071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ndU3Mmvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E642071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAdc7-0000kY-Tw
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 14:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdaq-0008AQ-KU
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:22:48 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33610)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdap-0006wB-85
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:22:48 -0400
Received: by mail-pf1-x441.google.com with SMTP id u20so8000937pfn.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=aFDCwZmNhs5+cnnNn2vq4fmaRA2Pz1zbjkvEmGCy9uE=;
 b=ndU3MmvfhlDn+R2aNg989faH79FgYDylfMGIi/gemclZEQX2035qCPpqnQk7mGpLGx
 FNq0dt7hYrEu2MxGwXz0/Sji2A2CDiSxyNEYQqnZiNiO/JMRUpK0AwRisb1uwlbrVvRC
 EyENzyKKhFNlvQIowPBlLCWzjojymFlGLtcOtbYj2iVsA5511ASLBA3eYCrbH+6aRGN2
 UzoNhxaHb5mwPB4K4sInjNnlGzqYFKkAUXt1e5WYi0nZRknzLB1BORJV9RCC6A/kgORG
 haS32TWLDvRy1uT2Odnmb5W9pa3MZSKa2ZM1LNajTN/k/u06B+6PViHwU/RYsKmJNzTG
 g6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aFDCwZmNhs5+cnnNn2vq4fmaRA2Pz1zbjkvEmGCy9uE=;
 b=F9alC8shzxf4PC/BjZNVlZm8PTN8s8upDU4qaQ1KdID42gWfx/jLs+DU6woP5+/9cn
 Pjv0Ht9uXGtBPDi38HfNXc7ugGsCgeXxm5aOuXv0njEO/7nZPrQro2TRPlSJ1VQo44a7
 DILcsALhyaRgH833wv71pNkyi61gIHAH6iqzb+hxOtY79OXIYKbAfq/4Ptb6vD8VVZCT
 qMA+C33yINddRjbhup5vuzNIL1+djjIirr1lM6zVoDha4RmnW6q3JAWs0a0IAA1+C4/h
 QvfKyCwMuB9i1dxlBfApIdq3UCmmMssh8Jwb4j+yVhvWWJ5wH1UtAR/D2KSOY/Csa7jn
 8qwg==
X-Gm-Message-State: AOAM532ERgAUO6JgxRsAZyQuYlTWbLckQjnQ/7mf2n5ZahrKQF7MJrMR
 CuHPmNajkixfwAa5NVCpRvl4VtIOE2VEOg==
X-Google-Smtp-Source: ABdhPJwrN8IbGr8VVrpy+n9oghrtZgkvmctvMtkXb40KWEuv4kDL/w9XV+nK5hqxie/6Dn49PP8w/Q==
X-Received: by 2002:a63:9c1:: with SMTP id 184mr7405427pgj.265.1598379765659; 
 Tue, 25 Aug 2020 11:22:45 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id d23sm13567613pgm.11.2020.08.25.11.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 11:22:45 -0700 (PDT)
Subject: Re: [PATCH 07/22] target/arm: Macroify uses of do_vfp_2op_sp() and
 do_vfp_2op_dp()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200824142934.20850-1-peter.maydell@linaro.org>
 <20200824142934.20850-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <67580ead-e223-51a7-93c6-491678bc50c2@linaro.org>
Date: Tue, 25 Aug 2020 11:22:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824142934.20850-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
> Macroify the uses of do_vfp_2op_sp() and do_vfp_2op_dp(); this will
> make it easier to add the halfprec support.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.c.inc | 49 ++++++++++------------------------
>  1 file changed, 14 insertions(+), 35 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

