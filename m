Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3B9C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F922082E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lV4Obm0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F922082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j07Pd-0001FN-ME
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 12:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j07Ot-0000ee-2k
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:26:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j07Or-0007xw-NS
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:26:42 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j07Or-0007so-HY
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:26:41 -0500
Received: by mail-oi1-x241.google.com with SMTP id q81so2746076oig.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 09:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m6r+z+NfkEeHREvRA+/bTcVK8wYgYel8uR336DehHPA=;
 b=lV4Obm0DDAM+CDQ8howF5gWunpFpMfmt7FYo4nF84HsifrZoTIplk5G1BhjsD7B+kI
 ZWo1lGxRx9qiWK1ZlBOiHbNnEZrsYS3QrqvbkuQWrfOlPtwClUpB1HwC7cR5yrrvD38p
 Cqk17yMkiVg+DGCnFVJQML8yZS6H0bjha5LhTgw1dwN4ujOT3P6BKrlppOd5WHuqTSa8
 Ma8j2Uz+LshWL6VzSbHPDgtzsZKzzDkPAWshsDLnPK27BROTtEZSf/I8buzJ1067oPQ/
 7HqY2Wn2++EiUsGv9EgheXO19cmkckP+zwItu6kKCh98ILKulbiD77CZFlXul29YYQLw
 bqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m6r+z+NfkEeHREvRA+/bTcVK8wYgYel8uR336DehHPA=;
 b=WvqJ+cbPi1hvE9mlGc5NGkQLAUG+a4SrOZalKs2YA0KP9eJLps8E4Y0waZghq2Ngpx
 dpFrHZjGQL2MxjmgnT0J6AFSZzJEXVsMtBdWLumVhjrDgIltFYUnlP7/BfzEuGmPXAq+
 kvqXszD69EZmfST/4BLP9t04oda6UV2Gwk+3ykNQEC2MvQLbBbyVGBLPmPekCSCQ6/ie
 rdYQtsifIx7rPrA5kufa7kgpRfUQhzMGqjkGZYxIHQUngyrUSckV2RWDFC6PZzL/4HTj
 St3//umZZIaNTETEyDVdhbfqqBb6neniQuvX/P6o07e1Glw47hKK0jMMf/l6OpSVkHaS
 0Vfw==
X-Gm-Message-State: APjAAAVVXKcyZ7wPuWPb+dgpK2hs6yVGtgs6NIumE04T74niw5SK0Cxv
 bxRTk5M4312wDRHKkDyN7zffdTJtnR9O8nMgLDnTpw==
X-Google-Smtp-Source: APXvYqwiEkvCf5yhIaaq08gJZZEYp2oJobp1JtHpP0/kmS/2WUWbq/8qh+Zw6W1Ri24/WjCBq5ezC2PsGOtfV8vjM/E=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr2882883oiy.170.1581096400638; 
 Fri, 07 Feb 2020 09:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20200203144716.32204-1-richard.henderson@linaro.org>
 <20200203144716.32204-6-richard.henderson@linaro.org>
In-Reply-To: <20200203144716.32204-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 17:26:29 +0000
Message-ID: <CAFEAcA87okLv6msSBT6PGYXqTWrLFsfm70LHVtddvb+d6pemwA@mail.gmail.com>
Subject: Re: [PATCH v3 05/20] target/arm: Split out aarch32_cpsr_valid_mask
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 14:47, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Split this helper out of msr_mask in translate.c.  At the same time,
> transform the negative reductive logic to positive accumulative logic.
> It will be usable along the exception paths.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h | 24 ++++++++++++++++++++++++
>  target/arm/translate.c | 17 +++--------------
>  2 files changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 6be8b2d1a9..0569c96fd9 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1061,6 +1061,30 @@ static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx mmu_idx)
>      }
>  }
>
> +static inline uint32_t aarch32_cpsr_valid_mask(uint64_t features,
> +                                               const ARMISARegisters *id)
> +{
> +    uint32_t valid = CPSR_M | CPSR_AIF | CPSR_IL | CPSR_NZCV;
> +
> +    if ((features >> ARM_FEATURE_V4T) & 1) {
> +        valid |= CPSR_T;
> +    }
> +    if ((features >> ARM_FEATURE_V5) & 1) {
> +        valid |= CPSR_Q; /* V5TE in reality*/
> +    }
> +    if ((features >> ARM_FEATURE_V6) & 1) {
> +        valid |= CPSR_E | CPSR_GE;
> +    }
> +    if ((features >> ARM_FEATURE_THUMB2) & 1) {
> +        valid |= CPSR_IT;
> +    }
> +    if (isar_feature_jazelle(id)) {
> +        valid |= CPSR_J;
> +    }

This is a behaviour-change rather than just refactoring:
we used to unconditionally allow the J bit through,
and now we only do so if the isar feature bit is set.

> +    return valid;
> +}
> +
>  /*
>   * Parameters of a given virtual address, as extracted from the
>   * translation control register (TCR) for a given regime.
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index d58c328e08..032f7074cb 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -2747,22 +2747,11 @@ static uint32_t msr_mask(DisasContext *s, int flags, int spsr)
>          mask |= 0xff000000;
>
>      /* Mask out undefined bits.  */
> -    mask &= ~CPSR_RESERVED;
> -    if (!arm_dc_feature(s, ARM_FEATURE_V4T)) {
> -        mask &= ~CPSR_T;
> -    }
> -    if (!arm_dc_feature(s, ARM_FEATURE_V5)) {
> -        mask &= ~CPSR_Q; /* V5TE in reality*/
> -    }
> -    if (!arm_dc_feature(s, ARM_FEATURE_V6)) {
> -        mask &= ~(CPSR_E | CPSR_GE);
> -    }
> -    if (!arm_dc_feature(s, ARM_FEATURE_THUMB2)) {
> -        mask &= ~CPSR_IT;
> -    }
> +    mask &= aarch32_cpsr_valid_mask(s->features, s->isar);
> +
>      /* Mask out execution state and reserved bits.  */

This comment no longer matches the code it's referring to.

>      if (!spsr) {
> -        mask &= ~(CPSR_EXEC | CPSR_RESERVED);
> +        mask &= ~CPSR_EXEC;
>      }
>      /* Mask out privileged bits.  */
>      if (IS_USER(s))
> --

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

