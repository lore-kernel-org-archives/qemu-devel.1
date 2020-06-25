Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44B0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 781412076E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ruv2rMl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781412076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUzA-0006xU-PV
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joUyb-0006Xw-4m
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:43:49 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36482)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joUyZ-00082M-4v
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:43:48 -0400
Received: by mail-ot1-x344.google.com with SMTP id 72so5882076otc.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 09:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xNlxUJiWHJy0FKH3WbN7avi3uH/JeJUtgbAo9dSBkF0=;
 b=Ruv2rMl0wCLsjUh6OEiherJmSvFh3lqQfzmX1779VqzIv8oXqbRFwoWZ7p1QKSQ6wp
 A0gq0yiuk+lGwuvKRqkBDeQslEkKvNkG/irnE+eC1bj9NUTu08LY8TTLQ18F2hngL2jL
 3lslN9pSft71Tw93reBjmDEi+fQAlamIaKCPbo+dBVDsXThyxUlnPgIP+VfF2LIj1Lpn
 ZimmgtfIvK93SCyBLzIIWaXO57OMsFRdExB/sNLaQNhUChJ+JGh9mf4+feCJYQS+OmVy
 KNi/L2DRra9akntotcZkMLHqXyA5pLenE2WdWm46t7RsCc7OAKJXtTb9WwTZVjm+O99N
 uI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xNlxUJiWHJy0FKH3WbN7avi3uH/JeJUtgbAo9dSBkF0=;
 b=qZC7mIg7NbaMnupOLpW77GmD3T5kGfW687+/+t8UhqX8tHAjHsj1BStgS6/f//XOgn
 1vlEmquHbMOZHAy8zNWyQr5MR+vhNom9IT5mA3vBbkGBEklXiWd2bGiV+dktbgEqx56U
 9D/VR0IRrCJwMA1lI3LMbYqP4damWfyUMogfgxM3L3LDH8Og96KBvlVi/+1/di56kVD8
 OCgBkQ0a2EsGW/HQ/hLFCIGjkEqpjLzzRwCpysHskdwi3C0pBWmWUwxOE3iKYZU2ksWq
 7RJBrtU5nzGjwlwXlT6nLakH0+xW0S0qbc0hc1f+fb3iLhRtlHlb2IXMO1crTj0BZvge
 j34A==
X-Gm-Message-State: AOAM532Yg6A4EZ9WIrCV/DHoPJc/2RZELkeYVLYjJPfLyTX9FTTGuoJS
 ipTfTeECKntk+iCbQYaIaFwURlTcJiAdcZI6QGngJQ==
X-Google-Smtp-Source: ABdhPJxNxQN+qilDtPTsMxQk516jFHRpp8p+djMbb1X3b/DehURBQcI/zJOnldtKPfov4myyuAxQ6kEcIwuHcWOYWAg=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr13773302oth.135.1593103425613; 
 Thu, 25 Jun 2020 09:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200605041733.415188-1-richard.henderson@linaro.org>
 <20200605041733.415188-9-richard.henderson@linaro.org>
In-Reply-To: <20200605041733.415188-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 17:43:34 +0100
Message-ID: <CAFEAcA_Drj7bL6bbDt_Gy1G0SOzvN_P7T6BfmMx+=LcHYWwg0A@mail.gmail.com>
Subject: Re: [PATCH v2 08/17] exec: Add support for TARGET_TAGGED_ADDRESSES
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
> The AArch64 Linux ABI has always enabled TBI, but has historically
> required that pointer tags be removed before a syscall.  This has
> changed in the lead-up to ARMv8.5-MTE, in a way that affects the
> ABI generically and not specifically to MTE.
>
> This patch allows the target to indicate that (1) there are tags
> and (2) whether or not they should be taken into account at the
> syscall level.
>
> Adjust g2h, guest_addr_valid, and guest_range_valid to ignore
> pointer tags, similar to how TIF_TAGGED_ADDR alters __range_ok
> in the arm64 kernel source.
>
> The prctl syscall is not not yet updated, so this change by itself
> has no visible effect.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu_ldst.h | 22 ++++++++++++++++++----
>  target/arm/cpu-param.h  |  3 +++
>  bsd-user/main.c         |  5 +++++
>  linux-user/main.c       |  5 +++++
>  4 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 066cf33f70..d84847dc70 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -69,17 +69,31 @@ typedef uint64_t abi_ptr;
>  #define TARGET_ABI_FMT_ptr "%"PRIx64
>  #endif
>
> +#ifdef TARGET_TAGGED_ADDRESSES
> +extern abi_ptr untagged_addr_mask;
> +static inline abi_ptr untagged_addr(abi_ptr x)
> +{
> +    return x & untagged_addr_mask;
> +}
> +#else
> +static inline abi_ptr untagged_addr(abi_ptr x) { return x; }
> +#endif
> +
>  /* All direct uses of g2h and h2g need to go away for usermode softmmu.  */
> -#define g2h(x) ((void *)((unsigned long)(abi_ptr)(x) + guest_base))
> +static inline void *g2h(abi_ptr x)
> +{
> +    return (void *)(uintptr_t)(untagged_addr(x) + guest_base);
> +}
>
>  static inline bool guest_addr_valid(abi_ptr x)
>  {
> -    return x <= GUEST_ADDR_MAX;
> +    return untagged_addr(x) <= GUEST_ADDR_MAX;
>  }
>
> -static inline int guest_range_valid(unsigned long start, unsigned long len)
> +static inline bool guest_range_valid(abi_ptr start, abi_ulong len)

More type changes...

>  {
> -    return len - 1 <= GUEST_ADDR_MAX && start <= GUEST_ADDR_MAX - len + 1;
> +    return len - 1 <= GUEST_ADDR_MAX &&
> +           untagged_addr(start) <= GUEST_ADDR_MAX - len + 1;
>  }
>
>  #define h2g_valid(x)  ((uintptr_t)(x) - guest_base <= GUEST_ADDR_MAX)

otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

