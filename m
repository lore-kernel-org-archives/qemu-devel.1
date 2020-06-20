Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B24C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 00:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42335229C6
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 00:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gm8NdzWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42335229C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmRIN-0002HN-Jg
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 20:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmRHp-0001pg-71
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 20:23:09 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmRHn-00085U-MX
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 20:23:08 -0400
Received: by mail-pl1-x642.google.com with SMTP id y18so4630349plr.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 17:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Yf0PnAnGLCLY9g+lvYg57egrjljX44v9bJe37LTyOpc=;
 b=gm8NdzWF8uAgAT6qSQOHtErIy4CpfvRG7CTA69A3BVK9pWMFDflncmVLoziB+5XeGc
 xNx/bHQipo5cDuPcGTOgRUXSv3YVoUdGyYoFJzQmMom4CGEya5ikJ9c54FcieqQ5i1G+
 DEt/FyngjMbNSIk4/9uW0Z4k7dMqSOisyQ5OJBzvjvqBD4p+WRaw14sq0SkvVyYhULHL
 Lh/0K4VwdhOyKnCydd6mluwVarH/sBK6I6py9mAOZEJ7hRnZDvIPkRCdtaSl8QYmnTZL
 XJLKBXU5db9HHOCHUN0aQUaA/FcCLMpIPlest0r+qf8RIsIgu60jbouDxOB3djEHf1yX
 CSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Yf0PnAnGLCLY9g+lvYg57egrjljX44v9bJe37LTyOpc=;
 b=FuwDTesUG+y3OmR+buXW4YodqDIiMmogI+uSVG9n7+vHwzhrURUdzJ8GGBUmVA1Dae
 QsEG02gUX1eHvqbm8wCRK/s2QtTGszs69iMNKkFJ3CPGTk1WYcCLbw9hrbNosn0r8vG+
 v+iG2vJ8cKR37GmxhlDxfyfCzX/fUHGVA7pT2e+ezKqsAe1Z6Vzkbr16qiqh7cWMNfqd
 1A5m54OIbwtnQ5GHK7T97R5S2SoygpbIXgReD5fb3z8FXRBIzKRDVdLkAD5MRQD23w+j
 3GfzIubMpHxxmeHEx8YUyzL3j0Uvqm6KF4NRwromZCFyrjnPG1cFlriynQNC/hOz7amA
 O31g==
X-Gm-Message-State: AOAM531hGtNvfkV9C54vTuYV4uUJv18bOwzgxyzhztst+snFlDozCqAT
 FQqKoh0LXGK25yzdX3ryVJvoQw==
X-Google-Smtp-Source: ABdhPJzWGr6/MT4H0R1a9fZAQ0IPCIco2RmhEir+wDHtARFBcgUuP3qijev1jf53TLmQSlaNRNt1vA==
X-Received: by 2002:a17:902:8d8d:: with SMTP id
 v13mr9467117plo.162.1592612586167; 
 Fri, 19 Jun 2020 17:23:06 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id z1sm6157580pjz.10.2020.06.19.17.23.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 17:23:05 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Remove unnecessary gen_io_end() calls
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200619170324.12093-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b1dbcfa7-84fa-b5ca-7603-e8251b693f91@linaro.org>
Date: Fri, 19 Jun 2020 17:23:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619170324.12093-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/20 10:03 AM, Peter Maydell wrote:
> Since commit ba3e7926691ed3 it has been unnecessary for target code
> to call gen_io_end() after an IO instruction in icount mode; it is
> sufficient to call gen_io_start() before it and to force the end of
> the TB.
> 
> Many now-unnecessary calls to gen_io_end() were removed in commit
> 9e9b10c6491153b, but some were missed or accidentally added later.
> Remove unneeded calls from the arm target:
> 
>  * the call in the handling of exception-return-via-LDM is
>    unnecessary, and the code is already forcing end-of-TB
>  * the call in the VFP access check code is more complicated:
>    we weren't ending the TB, so we need to add the code to
>    force that by setting DISAS_UPDATE
>  * the doc comment for ARM_CP_IO doesn't need to mention
>    gen_io_end() any more
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h               | 2 +-
>  target/arm/translate-vfp.inc.c | 7 +++----
>  target/arm/translate.c         | 3 ---
>  3 files changed, 4 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


