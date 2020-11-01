Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68308C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 15:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFDFB2223F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 15:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/pGTBdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDFB2223F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZEzZ-000703-Lf
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 10:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZEz1-0006XF-AD
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 10:09:27 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZEyy-0004vl-1E
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 10:09:26 -0500
Received: by mail-pg1-x543.google.com with SMTP id n16so8616316pgv.13
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2020 07:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=slk5pB+JpVUDaJs8/EuJGFpbSROm1a1H+wOTfnTFmbw=;
 b=r/pGTBdX0Wr0fVnbAoJ9M/gof5917+PHfGvpNyk2bOqdnwAWveX3OJo3I+5VYkMBba
 xucCoQ6cJUbeZNocMtv8Jb3GXP8LsQZuj/1JYCM3PfnqEz9Wx5GKijMc+FoG64p9U0ia
 LGE17U3tbB8sbQZPvkWyryCHPxoXlE/kZs1Sp5CKQGJSxvJOlftciACGcs/21ZgKo7W9
 B++uVKhTWO4XiX3tt232B49i+DgQiKsI8w7CLDtumuDyPdT39MsfCgrSqoYzOQQod8+w
 ub1/bS7bja9BocNJpeeaBsLfEDABLjWuKnZ+mJTvrWj2xuehzMr2ZvUOaEHmjQXixJIP
 Wxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=slk5pB+JpVUDaJs8/EuJGFpbSROm1a1H+wOTfnTFmbw=;
 b=efGH72pMDBA7xqJQjjjddFY89EeSbbvLpcHzA/R5FEXKHy4IR4gMr+i6Uf/taMfA2I
 1RZjz5dnwVtLdF1SX1DaTERS6pZaMSwGY0nlIpqWKhcffX/SkEC1MVH6dlCOxVGgr2MC
 P9IiXAmtYQWFfGSYDsmadx9oaXf3b1gKrUkurVss2pPTiMU56ot5ezbIw+Zd1iZh5+S8
 T1ZexgERiSdVgV74x6Ng7Jq0d8fgBTYYFY2faL7tYsOeEqEmvv1EXs7zGoOn556WcLoi
 DtohaKVtnOBXlG2ESe8DfUqR9d7OGywUPdM+OnNsxVmNE99GEbAULZbga/4AzewguL4N
 bTwA==
X-Gm-Message-State: AOAM530XNi3FEHFtEi2uQ2mhIKEwkIotnbBJemYl3OmXEmePpgSrIk43
 yU4/mEOxVBb+rIOfs/ulOuNmxPuQksuUFg==
X-Google-Smtp-Source: ABdhPJwG5hLyz8ADtrg0XMUWcVmDQcW/oR5fs7nXZJ1pwfouolbcE7ABEZNypC+lRvgwzC99Ei/j9g==
X-Received: by 2002:a65:5606:: with SMTP id l6mr10078344pgs.49.1604243360030; 
 Sun, 01 Nov 2020 07:09:20 -0800 (PST)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id e14sm10340764pga.61.2020.11.01.07.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2020 07:09:18 -0800 (PST)
Subject: Re: [PATCH v2 18/19] tcg/aarch64: Implement flush_idcache_range
 manually
To: Joelle van Dyne <j@getutm.app>
References: <20201030004921.721096-1-richard.henderson@linaro.org>
 <20201030004921.721096-19-richard.henderson@linaro.org>
 <CA+E+eSB64cm8GPsuEYNQJLkF2gPiF2oueYPOOTtxpYy7hWzTRg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <29b4f60b-bc5e-d966-7913-9f64cc8b4006@linaro.org>
Date: Sun, 1 Nov 2020 07:09:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+E+eSB64cm8GPsuEYNQJLkF2gPiF2oueYPOOTtxpYy7hWzTRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/31/20 6:25 PM, Joelle van Dyne wrote:
> Another thing, for x86 (and maybe other archs), the icache is cache
> coherent but does it apply if we are aliasing the memory address? I
> think in that case, it's like we're doing a DMA right and still need
> to do flushing+invalidating?

No, it is not like dma.  The x86 caches are physically tagged, so virtual
aliasing does not matter.


r~

