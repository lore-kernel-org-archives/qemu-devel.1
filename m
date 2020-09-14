Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B59EC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 01:38:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96062168B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 01:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijTFuBMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96062168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHdS6-0005DG-Rv
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 21:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHdRQ-0004lx-5N
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 21:38:00 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHdRO-00068u-DY
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 21:37:59 -0400
Received: by mail-pg1-x543.google.com with SMTP id j34so10216632pgi.7
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 18:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2o58aaIGAcyS67JcPeL6/TEd645Tqc1Ifaso9ImNOCg=;
 b=ijTFuBMJuy/UdLokdkA2k0Jj3exB6QSpde9lKfrbW0udyaZQr5VDLuJE4kMP+3XOTo
 cIv+QZCRx+2PcvL6iGAF+ppP5/RiCGoRZ+E0DFJ48fK7dvBm5UR3d0X8MA7TZGo8OaUn
 fFZzA40WDimEsB5ecr/7EDQcSTxghZ62yYNjuHYhxPlccX6TZCPAKRTlO54G21LIHvS7
 4S1dQAGzqJ1pjkxxb+6XtQmw1gR85p9mAF4Etvj+NzsVF7U5uBWnBog0GTiwmtJiUZLv
 k9CxAzKxmFJqWElIEA5UPmSQrWiHNfNjwIipddU0Yk2sSLRxPT94ypCwgPMdGhI28X78
 YcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2o58aaIGAcyS67JcPeL6/TEd645Tqc1Ifaso9ImNOCg=;
 b=ra7fy4mVFnyTX4izBEXwp/tAKMrcSLxiBr9XkvcE57a/GwAlICwxxJRJFZacX38QNx
 AXvWHKq6xgxsixOCLlEaqsllOBqApzNFw2jyz2Z/1sF578bJEDXEqq9Am8QUiLy0vzUL
 2BVgterWsxfWfXsxCZdvBJkNDDMzcB61/eCLxfxAO/p+ldqU9BCAV6/jITGqmuWCVeca
 1X+l00o3dNpLijZbh4N43KqbpP3laXcqkHfQWyv9sFJLHUzYaiwofwb740hhDaYpgXz1
 YSpG+L+R2jYrG+Q46h0Nbg561mG+pUhkiZxt0WhJsgqTqSFVlaYaPcakmkWyrYLx8KHf
 CPCA==
X-Gm-Message-State: AOAM533H/T7ID1v8V0B5ySZQbFdXX8jc284VsWjf48VDt0jbrFua/hR1
 9JqaHWAMidkYSaMn82Knd2V1Aw==
X-Google-Smtp-Source: ABdhPJyC8bMM99gX9NoA6jd1ZL+41c2murQORdzNY38nckrVznKE9j+jmibvTBJ8WoxOUAmeXz6w+Q==
X-Received: by 2002:a17:902:a509:b029:d0:cb2d:f26e with SMTP id
 s9-20020a170902a509b02900d0cb2df26emr11733956plq.7.1600047476518; 
 Sun, 13 Sep 2020 18:37:56 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x3sm6975572pgg.54.2020.09.13.18.37.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 18:37:55 -0700 (PDT)
Subject: Re: [PATCH 01/11] capstone: Convert Makefile bits to meson bits
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20200914000153.1725632-1-richard.henderson@linaro.org>
 <20200914000153.1725632-2-richard.henderson@linaro.org>
Message-ID: <910ac127-6239-2239-b3f8-bc2d1fcf9f6d@linaro.org>
Date: Sun, 13 Sep 2020 18:37:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914000153.1725632-2-richard.henderson@linaro.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, luoyonggang@gmail.com,
 alex.bennee@linaro.org, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/13/20 5:01 PM, Richard Henderson wrote:
>  case "$capstone" in
> -  git | internal)
> +  git)
>      if test "$capstone" = git; then
>        git_submodules="${git_submodules} capstone"
>      fi

The if here can be removed now.  Alternately...

> -    mkdir -p capstone
> -    if test "$mingw32" = "yes"; then
> -      LIBCAPSTONE=capstone.lib
> -    else
> -      LIBCAPSTONE=libcapstone.a
> -    fi
> -    capstone_libs="-Lcapstone -lcapstone"
> -    capstone_cflags="-I${source_path}/capstone/include"
>      ;;
>  
> -  system)
> -    capstone_libs="$($pkg_config --libs capstone)"
> -    capstone_cflags="$($pkg_config --cflags capstone)"
> +  internal | system | no)
>      ;;
>  
> -  no)
> -    ;;
>    *)
>      error_exit "Unknown state for capstone: $capstone"
>      ;;

... stop trying to validate the set of states and instead remove the outer
case, leaving only the inner if.

Thoughts?


r~

