Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240AEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD5F3206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJ/1wvaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5F3206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joV8w-0005Vv-6t
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joV8G-0004yN-Gz
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:53:48 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joV8F-0003zJ-10
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:53:48 -0400
Received: by mail-oi1-x244.google.com with SMTP id t25so5552077oij.7
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 09:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GEFIK9+Y3NSLP4TbrylgqPOAsytgb5X4H5Ke7pVQQy8=;
 b=jJ/1wvaEgNFg81+dUrnrmkNWdY2RSKkf2IbaWh+yiWRu9uArI7bg4KRnAnH/Wdleqi
 FIbTaC2fC7lPCVmBgSdqzYZTBGgzY8leLLR9IxSrINT0g5CxrrbykhDeI6n7LES2bPZ7
 dlpb2vd1PCCFLuEFzCeH24hxKphx/CqfRJ0hAC9aHaJOneKS5+sJC9svnwxhZD3b1b/m
 i/kqDTCDnqGlRvukdYIVZokV85T5/9Du3RlrWScJbCXYwXltpumCXadbMGVZzjJTyWMf
 2mkeVOSEfSQPM48YV7eTbw2G/0DZsiLKFLurYwD4gCwF6NQuL2jZlUpQu9tfl+HShINM
 QFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GEFIK9+Y3NSLP4TbrylgqPOAsytgb5X4H5Ke7pVQQy8=;
 b=ANGV7s44jOtScpQl+sFxnQeQkh2j7QChlUHeHTZ0lSTkLOT0ToNfeiU8ADUVX6888h
 jWRHVBy+uB03Eclr+fT+vWsLG9ox3G8rzYFDyEA33dSsUxiRJg2GEKkykR28S4mVlQaD
 FBQUoJU0X8FyGdrthlr0GZZJWqxjMgxqDvYQWyrp745flwKWT//9tx8nAd6uGLp8t59U
 UBRYiZGY7dCMf0uFgeHGoszuvuvpDoxFgPGi5RlaB5J2Jmt9x38+YIrNh61cxbjRWp0N
 NLsgbgqxXju4pyPrUV6Ca+b1W8dy5P0D4ho+Z3PMFJj+VkWOiPYlz5jUMtAc7fLqgrgK
 pRjA==
X-Gm-Message-State: AOAM532f4lq0SXi1dIiEvGKyImkuU0rxv8gIYqtEJngwGCk56HCEzsYG
 BVC88hMuyjHdE6C3qaVn9hsmXdNzD2lbpR9j6SdW4w==
X-Google-Smtp-Source: ABdhPJxATUBnt71fQxzv8kZ6ZfOEEzQDuVogUeTelZuDLsdAumYiKBIV9kGXhWb+TsilIMChBscE+yLjFX5QCgK+2wU=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr3055310oia.163.1593104025807; 
 Thu, 25 Jun 2020 09:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200605041733.415188-1-richard.henderson@linaro.org>
 <20200605041733.415188-12-richard.henderson@linaro.org>
In-Reply-To: <20200605041733.415188-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 17:53:34 +0100
Message-ID: <CAFEAcA_+f8HFX0ncTk1cgxavG1kbG6RSHrqrxnz3FjNx-N3b4Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/17] linux-user/aarch64: Implement PROT_MTE
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 05:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remember the PROT_MTE bit as PAGE_TARGET_2.
> Otherwise this does not yet have effect.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu-all.h    |  1 +
>  linux-user/syscall_defs.h |  1 +
>  linux-user/mmap.c         | 20 ++++++++++++--------
>  3 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 3cac7750e4..7ff10a8b08 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -286,6 +286,7 @@ extern intptr_t qemu_host_page_mask;
>  #endif
>  /* Target-specific bits that will be used via page_get_flags().  */
>  #define PAGE_TARGET_1  0x0080
> +#define PAGE_TARGET_2  0x0100

This is the same as the bsd-user-only PAGE_RESERVED,
which seems unnecessarily confusing given we're not hurting
for available bits.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

