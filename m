Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807E1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFBF320E65
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5MWQbtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFBF320E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSPgB-00067p-Nl
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 15:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSPeI-0005QM-IV
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 15:07:50 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:51777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSPeH-0005u1-4Z
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 15:07:50 -0400
Received: by mail-pj1-x1043.google.com with SMTP id a17so480192pju.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=TDs51atH4eIgDdH3rjjCtdaHC2R8L6bgkFqfRU3lOI0=;
 b=W5MWQbtNpdyNSKzcpUmnUuAix8eFvnvX0fcBv7UOzxB1rIfdn5TCsn7WoYlPucvgWH
 ak0N2mIpy0oBoi7nSEyp4hw7IMm/JNJelQzX0GT2S0n+oZIJM/O1ugkE4lBh0GtWZ06e
 7YoKTpD25nvZTF5SExiADkmVa5Ox2OLXLAAbyOR7uEWEzKhHAC2eexoOLKxS/31HvuD7
 kaqQhVMg260jpIvy3jyVwqHhgHA6WhLSrjZUBFpzM0PyHheAeSQ7GwyIxSKGIKwxXePh
 Du7A4Mc+stk/VDB4xI/CmvgaLHYEPktYmlfVLfE5oOuqfDBBsC9XFU+X4lx3co0fReHd
 pJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TDs51atH4eIgDdH3rjjCtdaHC2R8L6bgkFqfRU3lOI0=;
 b=R/xL8hm7yQ8lmzX5sIhWhlISt3v5zC+61GCW9C9cE064F0pfYu3s5jOqQnqQKahkyM
 x6vvJIpVbM9qi9oWqgVSkV7EzZuQ1d1sh0OJ0vwWW+rT6vb61kZ//94HyqXcPv+uRYS+
 /x/l8s1djTQBQj6fXrBafQqIvlY2B7Csr4Kn+k5Ai/7UEjinF6u1x9SFW43dB8i+gO+Q
 r9PRvCVUrViyT9Zn/yxGLazzQAThIGyHO4NLFIB1jBq/+j6KgQg6/b/gbtMtVbswHgY7
 C4lGLg0ZdYL5mHkQlPotxkObWGeFgENbr5R+ZUqH3dcPwDN2E90vNV3uFGAM1XfSJ3RZ
 4I6g==
X-Gm-Message-State: AOAM530fUwAxaapWAKcdiG5c1V17evcutRYfA15AtvB/3JV0CocdfOWd
 rlyuB1vfvbCV2xXNlts9Sh4gm0PEj3fQ0Q==
X-Google-Smtp-Source: ABdhPJyxK2FXvumdnL2KqQl+ZrAwwO/6RwGELigrN9z4bZI3DnmyHWQMDnCPxHGPldm4WRUrLJm1Fw==
X-Received: by 2002:a17:902:fe18:b029:d4:d4d7:782 with SMTP id
 g24-20020a170902fe18b02900d4d4d70782mr1140758plj.1.1602616067060; 
 Tue, 13 Oct 2020 12:07:47 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w14sm383155pfu.87.2020.10.13.12.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 12:07:46 -0700 (PDT)
Subject: Re: [PATCH 08/10] target/arm: Fix has_vfp/has_neon ID reg squashing
 for M-profile
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20201012153746.9996-1-peter.maydell@linaro.org>
 <20201012153746.9996-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <614adbe6-c16c-f18d-c444-a474e6b6f559@linaro.org>
Date: Tue, 13 Oct 2020 12:07:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012153746.9996-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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

On 10/12/20 8:37 AM, Peter Maydell wrote:
> In arm_cpu_realizefn(), if the CPU has VFP or Neon disabled then we
> squash the ID register fields so that we don't advertise it to the
> guest.  This code was written for A-profile and needs some tweaks to
> work correctly on M-profile:
> 
>  * A-profile only fields should not be zeroed on M-profile:
>    - MVFR0.FPSHVEC,FPTRAP
>    - MVFR1.SIMDLS,SIMDINT,SIMDSP,SIMDHP
>    - MVFR2.SIMDMISC
>  * M-profile only fields should be zeroed on M-profile:
>    - MVFR1.FP16
> 
> In particular, because MVFR1.SIMDHP on A-profile is the same field as
> MVFR1.FP16 on M-profile this code was incorrectly disabling FP16
> support on an M-profile CPU (where has_neon is always false).  This
> isn't a visible bug yet because we don't have any M-profile CPUs with
> FP16 support, but the change is necessary before we introduce any.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

