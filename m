Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0318C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:52:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF892053B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LtDbZL0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF892053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHmS-0004g5-6j
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idG54-0004Uh-MW
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:03:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idG4u-0007em-9m
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:03:46 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idG4u-0007bv-22
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:03:36 -0500
Received: by mail-oi1-x241.google.com with SMTP id j22so180484oij.9
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 08:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/3qphMSD38MJXn8egu9CnmdRqqpFh29hxyNYcY2z0yQ=;
 b=LtDbZL0XsDxjqicTeVSzjfOBjpzJgA14CI5n+SFQUEBEHeCwPlRptmzB6HJsGZ/osD
 3uIso6Z7ioseIBUif3ZQMkAKIneWSeriUHIb61zWuoRSD+uTiaBIjBc8aFKT+mqPF/e/
 9HMs71c2Rmi/sTwta7XRiRuE7lxpQcjInN5NlFpFzuoE+2MnbOuuTqeVJqyil3LX/n7V
 M6oTlIKeqV1dJIa8LtxtbcJeHDCjVnGvugB0tMCaAdAGD3MKLp4V1Us53fyeddlw5FeI
 DqATJFGefU2nqW452V4rRGcRnQAXJ6FAEY/IjpeLKgjfizyFcz5LsxPNT4IUUgqiGjh8
 N8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/3qphMSD38MJXn8egu9CnmdRqqpFh29hxyNYcY2z0yQ=;
 b=ub0zlPQE/87fGJYbpnuNKhN43Up4BqYxgOHW1Z8f8DZdqF8yMvCUbIm8yCoxAHL+4U
 ux8M4tAH0KFdInDxut/BSZhEZetQJgP4V2grqSvRzMWDet0HcTJFVor71FIKvvDgIFJq
 gVLGIe+fLNT5MqX2r/UwpkxPMFvni861ao4EAWfkTn6szE1nXLM11FNxmDJ9bqChrodr
 ajjNfHvmTtyJsNu74Lhvmd7KTRuHVyHfGndewu1H5Wph6q3K0H7LMYMmRzjceDdf1tJf
 Uar3uyae3lYPsvr6m2qr27UThoppyZWllXT6H0bjb0QDI4CtylWI/yKwb5hELD3ywvLk
 3XwQ==
X-Gm-Message-State: APjAAAVWWZh/djc9P37KQbAfaDfvkiS3LAAodlHVFiAr5uReyNGV5B73
 kANCgxCwC47sCnMG6ry2dYYOyzgO9BBuvv2+U3kHZg==
X-Google-Smtp-Source: APXvYqyYHJ3BqpWOqLYg7KeJMqh0830TrWV+70OZWemg1PZ8FHy6fzj0qo+h+arEtl62vszCFEcH4snAJv1EZCDroBA=
X-Received: by 2002:a05:6808:996:: with SMTP id
 a22mr12294467oic.146.1575648215104; 
 Fri, 06 Dec 2019 08:03:35 -0800 (PST)
MIME-Version: 1.0
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-36-richard.henderson@linaro.org>
In-Reply-To: <20191203022937.1474-36-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 16:03:24 +0000
Message-ID: <CAFEAcA_DmXG2QJsLCu_gYSCYVCQ4xr1hPkEbfpVXMTZe_wnb6Q@mail.gmail.com>
Subject: Re: [PATCH v4 35/40] target/arm: Update arm_cpu_do_interrupt_aarch64
 for VHE
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

On Tue, 3 Dec 2019 at 02:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> When VHE is enabled, we need to take the aa32-ness of EL0
> from PSTATE not HCR_EL2, which is controlling EL1.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index f2d18bd51a..f3785d5ad6 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8887,14 +8887,19 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
>           * immediately lower than the target level is using AArch32 or AArch64
>           */
>          bool is_aa64;
> +        uint64_t hcr;
>
>          switch (new_el) {
>          case 3:
>              is_aa64 = (env->cp15.scr_el3 & SCR_RW) != 0;
>              break;
>          case 2:
> -            is_aa64 = (env->cp15.hcr_el2 & HCR_RW) != 0;
> -            break;
> +            hcr = arm_hcr_el2_eff(env);
> +            if ((hcr & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
> +                is_aa64 = (hcr & HCR_RW) != 0;
> +                break;
> +            }
> +            /* fall through */
>          case 1:
>              is_aa64 = is_a64(env);
>              break;
> --

The commit message is confusing me. Per the comment
in the code, what we're asking is "is the EL immediately
lower than the target level using AArch64?". We never
took the aa32ness of EL0 from HCR_EL2: that code is
looking at "what's the aa32ness of EL1", because in a non-VHE
setup EL1 is always the EL immediately lower than EL2.

So I *think* what the code is doing is:

 When VHE is enabled, the exception level below EL2 is
 not EL1, but EL0, and so to identify the entry vector
 offset for exceptions targeting EL2 we need to look
 at the width of EL0, not of EL1.

Is that right?

thanks
-- PMM

