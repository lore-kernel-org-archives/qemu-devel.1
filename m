Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D36C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924DB24672
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C7qO0nUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924DB24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4phn-00037z-Ow
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 12:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4pgs-0002Pk-VT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:32:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4pgr-0008Nl-MW
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:32:46 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4pgr-0008NW-Gs
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:32:45 -0500
Received: by mail-ot1-x341.google.com with SMTP id 77so4418550oty.6
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 09:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TbEwBYh3QwcPv9pckHv6pdzrFrb5hdHdDAv+ElmXE98=;
 b=C7qO0nUxvIZvMg92M+0iOPOK0ubab+VnylnlCu/XPbMZwNJ51mJi+0neeYHXgzhfcI
 jUYvQYir/HN48hN942Qyimk0BCZQWqncSdbQlMFBI6z9frJCqw7hxwYeB4mtlzSnE2KO
 2ShvppoeBylYWQRI/Gi006LveuUiwAFLrcWGj+S+5pZY25bu5BUmF7VeskGrXTuLSn2h
 h3gortHEj2B3zaK/OI04nM8GzGj4e8gPhvGr/3fBwvJ0I6l5ay72Ext2p6g5aiMKRfHs
 IcRqP/9wimoV0A4PghdWAvHG+QPBz3VxOju6e9S0FFmooEtC2dbUQdF7ip0T/arHZJDr
 uzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TbEwBYh3QwcPv9pckHv6pdzrFrb5hdHdDAv+ElmXE98=;
 b=ls3MPuziL7ocCf9fGwUNkUmv9mrTV2yYpK2be9AkSy1e5aV/dPCF5EBvRnsQdU+uFF
 mq90XPWbFa9+6yDnj7LuUjrFd8YSe2waVVDPTrv+GzqdtOLNrdp80agzS7GxJGLAP4VH
 R690c4Uf1sC2TQCWHP+tHFZUdzE2XW3D2kjRxL0KK8SvrH5UQloI4PqVp+H+IoIP/fme
 pFoil5bQc8KN591AZLqNjFigxdIPZ6ZqAELvWiFuhXCAly4XjG1yDqcvGCHAy8QpsI4t
 wHtFoJMkaBJj1ur0/Yxdxf/slBV7eCIGrCMZ4aiFHZlB0JV9hhBXuH7V0Myrov5dFWEp
 yJLg==
X-Gm-Message-State: APjAAAUUuqektQ+8FDkWuGQ6ohmlQL7mMh0REPWxjHv3FH3wcZAV1mfJ
 KqHldBh2uFzYbolu+1ImRJagZMb8/3k0WdbsEI34qw==
X-Google-Smtp-Source: APXvYqzjDC3AKXq0RV4yEV5+f+fsqDSMKplRWo71FDTa+mI11RiylC+BwaT4Xwnbx+eO3ox+kOZ9nupPxizOzdmN9+w=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr12414559oto.135.1582219964665; 
 Thu, 20 Feb 2020 09:32:44 -0800 (PST)
MIME-Version: 1.0
References: <20200214181547.21408-1-richard.henderson@linaro.org>
 <20200214181547.21408-16-richard.henderson@linaro.org>
In-Reply-To: <20200214181547.21408-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 17:32:33 +0000
Message-ID: <CAFEAcA98CnJ8jhZ1AFWcmK+UE0RwZJHhwQtNnd4z5SG5QqEqjQ@mail.gmail.com>
Subject: Re: [PATCH 15/19] linux-user/arm: Replace ARM_FEATURE_VFP* tests for
 HWCAP
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

On Fri, 14 Feb 2020 at 18:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use isar feature tests instead of feature bit tests.
>
> Although none of QEMUs current cpus have VFPv3 without D32,
> replace the large comment explaining why with one line that
> sets ARM_HWCAP_ARM_VFPv3D16 under the correct conditions.
> Mirror the test sequence used in the linux kernel.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index f3080a1635..c52c814a2e 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -468,22 +468,28 @@ static uint32_t get_elf_hwcap(void)
>
>      /* EDSP is in v5TE and above, but all our v5 CPUs are v5TE */
>      GET_FEATURE(ARM_FEATURE_V5, ARM_HWCAP_ARM_EDSP);
> -    GET_FEATURE(ARM_FEATURE_VFP, ARM_HWCAP_ARM_VFP);
>      GET_FEATURE(ARM_FEATURE_IWMMXT, ARM_HWCAP_ARM_IWMMXT);
>      GET_FEATURE(ARM_FEATURE_THUMB2EE, ARM_HWCAP_ARM_THUMBEE);
>      GET_FEATURE(ARM_FEATURE_NEON, ARM_HWCAP_ARM_NEON);
> -    GET_FEATURE(ARM_FEATURE_VFP3, ARM_HWCAP_ARM_VFPv3);
>      GET_FEATURE(ARM_FEATURE_V6K, ARM_HWCAP_ARM_TLS);
> -    GET_FEATURE(ARM_FEATURE_VFP4, ARM_HWCAP_ARM_VFPv4);
> +    GET_FEATURE(ARM_FEATURE_LPAE, ARM_HWCAP_ARM_LPAE);
> +
>      GET_FEATURE_ID(arm_div, ARM_HWCAP_ARM_IDIVA);
>      GET_FEATURE_ID(thumb_div, ARM_HWCAP_ARM_IDIVT);
> -    /* All QEMU's VFPv3 CPUs have 32 registers, see VFP_DREG in translate.c.
> -     * Note that the ARM_HWCAP_ARM_VFPv3D16 bit is always the inverse of
> -     * ARM_HWCAP_ARM_VFPD32 (and so always clear for QEMU); it is unrelated
> -     * to our VFP_FP16 feature bit.
> +    /*
> +     * Note that none of QEMU's cpus have double precision without single
> +     * precision support in VFP, so only test the single precision field.
>       */

Why not actually mirror the kernel's test sequence, rather
than having a comment about how we deviate from it ?

> -    GET_FEATURE(ARM_FEATURE_VFP3, ARM_HWCAP_ARM_VFPD32);
> -    GET_FEATURE(ARM_FEATURE_LPAE, ARM_HWCAP_ARM_LPAE);
> +    GET_FEATURE_ID(aa32_fpsp_v2, ARM_HWCAP_ARM_VFP);
> +    if (cpu_isar_feature(aa32_fpsp_v3, cpu)) {
> +        hwcaps |= ARM_HWCAP_ARM_VFPv3;
> +        if (cpu_isar_feature(aa32_simd_r32, cpu)) {
> +            hwcaps |= ARM_HWCAP_ARM_VFPD32;
> +        } else {
> +            hwcaps |= ARM_HWCAP_ARM_VFPv3D16;
> +        }
> +    }
> +    GET_FEATURE_ID(aa32_simdfmac, ARM_HWCAP_ARM_VFPv4);
>
>      return hwcaps;
>  }

thanks
-- PMM

