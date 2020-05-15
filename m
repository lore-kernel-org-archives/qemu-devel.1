Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACA4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 22:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958E7206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 22:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Thhe0Jgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958E7206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZj9b-0004bs-O9
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 18:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZj8T-0003Pz-Gl
 for qemu-devel@nongnu.org; Fri, 15 May 2020 18:48:57 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZj8S-0006m1-Fi
 for qemu-devel@nongnu.org; Fri, 15 May 2020 18:48:57 -0400
Received: by mail-pl1-x644.google.com with SMTP id t16so1496648plo.7
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 15:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=R72cI1LNjHoQ6XVJOuHXxzQMiC0tIJsRCfUGgOWKcPA=;
 b=Thhe0JggEfdkklN0D9uvRERplbdyAi44cVjiGGAb3SCVCKLr5W1KaDXFqtIhCdM2Si
 Bw75/+AWPKzlJU0exVjkXBR/WsFvSCT9lAdqxcmFhI0n96LPFiDQ8X1faV1lPffHOd+m
 2dtqAPoK6P3bElGQGZRcIkeSp4YNvIKiUlrlloVc5fWXv/3OK2onmNVUzx/CntzgaAXw
 14Qetzl4MJ0FSvQWEnyiryfXn7/EHE7PrHTrBMx677ESfX4i2Qq5PM71Eugl34ju0VXH
 R5yrMpUUOnHKpARrKFtdOmv+Y8LxsKI0hB7vn8AaLYwUll9V11/ycWrGm7Ph+NrDb7nk
 iSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R72cI1LNjHoQ6XVJOuHXxzQMiC0tIJsRCfUGgOWKcPA=;
 b=W+MJSrnEKVoxkyp4mPJ9ancbF+NYNahQdOkD0prJJvD3KfX8hPWn+j6O71sRlwyb7a
 YwgK33CUWz5uXH0ubUgI5Esnas44hCdBU6m2AyLe3Y6UZcr2dekd8mJym7tW85S6uVuW
 P+6vvtpTsXcrxbEoITRlCQopN8p+7hoRNsgN7MRqSOvJihMN/FYxclTFWduV7//Um5VD
 aTxBHS5VdBrLHLqKhTFfUB34cQTJIYKHsgSbuwVHFwc1dbBp924/FoUGtwH4aEckTgmE
 91qF+S1EDh4BK9sq5W8UKuTvopGa0u9h3DgC0qEFkjxWTX0tqgAMP6Zt2cMB5a6YcujR
 sGvQ==
X-Gm-Message-State: AOAM5319eWwicvzrLIs1FNsZMhNykdkJka0p6P9wJkhA0A85HJSrrOW8
 x/xkIT1fE0qGXn8l/N0p6j6Pxc0GpQ8=
X-Google-Smtp-Source: ABdhPJzWm2UvXBklKz5G6WmIYZz4QGIajfiuLIlTa14ogL0HPrJg5hjRVyESNAvudpupXerJFhJk1g==
X-Received: by 2002:a17:902:b217:: with SMTP id
 t23mr5968367plr.132.1589582934560; 
 Fri, 15 May 2020 15:48:54 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gv7sm2285455pjb.16.2020.05.15.15.48.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 15:48:53 -0700 (PDT)
Subject: Re: [PATCH 03/10] target/arm: Convert Neon VSHR 2-reg-shift insns to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200515142056.21346-1-peter.maydell@linaro.org>
 <20200515142056.21346-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bb092cca-f5cf-f0fa-40ff-56b405e5035b@linaro.org>
Date: Fri, 15 May 2020 15:48:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515142056.21346-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 7:20 AM, Peter Maydell wrote:
> +VSHR_S_2sh       1111 001 0 1 .  ......     .... 0000 1 . . 1 .... \
> +                 @2reg_shift size=3 shift=%neon_rshift_i6
> +VSHR_S_2sh       1111 001 0 1 . 1 .....     .... 0000 0 . . 1 .... \
> +                 @2reg_shift size=2 shift=%neon_rshift_i5
> +VSHR_S_2sh       1111 001 0 1 . 01 ....     .... 0000 0 . . 1 .... \
> +                 @2reg_shift size=1 shift=%neon_rshift_i4
> +VSHR_S_2sh       1111 001 0 1 . 001 ...     .... 0000 0 . . 1 .... \
> +                 @2reg_shift size=0 shift=%neon_rshift_i3

It would be worth creating new @formats for each of these, since there are 9
uses of each, between this patch and the next.

E.g.

@2reg_shr_b    .... .... ..00 1... .... .... . q:1 0. .... \
               &2reg_shift vm=%vm_dp vd=%vd_dp size=0 \
               shift=%neon_rshift_i3
@2reg_shr_h    .... .... ..01 .... .... .... . q:1 0. .... \
               &2reg_shift vm=%vm_dp vd=%vd_dp size=1 \
               shift=%neon_rshift_i4
@2reg_shr_s    .... .... ..1. .... .... .... . q:1 0. .... \
               &2reg_shift vm=%vm_dp vd=%vd_dp size=2 \
               shift=%neon_rshift_i5
@2reg_shr_d    .... .... .... .... .... .... . q:1 1. .... \
               &2reg_shift vm=%vm_dp vd=%vd_dp size=2 \
               shift=%neon_rshift_i6


r~

