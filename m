Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D075CC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D7E22525
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AxD8RNjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D7E22525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvpm-0006Ko-ID
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1icvmV-0002pf-0E
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1icvmT-0003KC-Ke
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:23:14 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36796)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1icvmT-0003EL-BN
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:23:13 -0500
Received: by mail-oi1-x242.google.com with SMTP id c16so3658861oic.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 10:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ywEp5s2xOWuK7D7RAlraYeWBuhfECY/Yhnh+tMIgVBs=;
 b=AxD8RNjGmJa+dEMPmKEOO/bjIN97EHefoZbrvr7v+i5ltyu9sYvLYCpXljaSdU/tck
 /GDPHBB3OH+Gyq32SoZGQaudU29cb3pokh9Z/L0czQIcRFpQ1YfQmTotbfV0iHWJ9/yj
 ydVWfCZ2tbT91VEPxsrSEpJ13Wq/PGGiDgaTRa0gS2dftTJePqx1q675giQ37ZFemvfj
 W8C+TPZZgv7T1gs8oiikMTZPiLFenM3QmKd25Dho+ygVNlzdj0nBmOMSzdsHERBshHGR
 dvCO2Irssit8DtR+4mxugpj45lWt9ulpz9ILM38O6diXuDLa6uCje+f30UV86w/+C71P
 VReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ywEp5s2xOWuK7D7RAlraYeWBuhfECY/Yhnh+tMIgVBs=;
 b=pK5Oxyn7LXgpiMvem+uZK0V3JBR1MrhbBSWD6t0ShF9aWbOuUhp66c808XovBS9nDH
 oCmNsowzaxT4tT8KjRUIJQmrowfCyXXNDiUEEELW1QT4Fa43CcD/spuziFBJUdWwlu3N
 AS+F0lrugOhhXjZH49633eSPdrSSjJ9TpLjDvnkmMybiZJAImDI+klBhRKTbVDk4IqWO
 L+NvjXZQiSDeASuP86G7ZkyIOeUT9yEHBVRkbRiZzElBqpRB2QM446zl4anwlDT42ENG
 FDZ1Mx+ONoHan3AtzyoEzqjYWZy1L00+/Gs6FOW6ycRTwZM/FyFi49DcTD/OGNznr2cB
 7KbQ==
X-Gm-Message-State: APjAAAU2wBs4Ki+J/DX1KkV4HkaDC9ABFa6UeajubCXAEUm1mJHqePBm
 MYqAnXtS/f9tQF1eQms/VIoTMxWz2MnLsVDXX6sy5IT/y5E=
X-Google-Smtp-Source: APXvYqynT2e8OWp2aD6Gz2f39kybeFFAOBdo/R8aF7Gru9sOIkSyLgsI5RAIT/v21tPyBMD/44lWoDngEd1qezP9AsI=
X-Received: by 2002:aca:f5cc:: with SMTP id t195mr8633767oih.163.1575570192219; 
 Thu, 05 Dec 2019 10:23:12 -0800 (PST)
MIME-Version: 1.0
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-19-richard.henderson@linaro.org>
In-Reply-To: <20191011134744.2477-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2019 18:23:01 +0000
Message-ID: <CAFEAcA-N++JGRDfOLE7AUsMWVqchSNMvshRu9NJAkCSR1-N=Eg@mail.gmail.com>
Subject: Re: [PATCH v5 18/22] target/arm: Enable MTE
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 at 14:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We now implement all of the components of MTE, without actually
> supporting any tagged memory.  All MTE instructions will work,
> trivially, so we can enable support.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.c   | 10 ++++++++++
>  target/arm/cpu64.c |  1 +
>  2 files changed, 11 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 2399c14471..12fffa3ee4 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -209,6 +209,16 @@ static void arm_cpu_reset(CPUState *s)
>           * make no difference to the user-level emulation.
>           */
>          env->cp15.tcr_el[1].raw_tcr = (3ULL << 37);
> +        /* Enable MTE allocation tags.  */
> +        env->cp15.hcr_el2 |= HCR_ATA;
> +        env->cp15.scr_el3 |= SCR_ATA;
> +        env->cp15.sctlr_el[1] |= SCTLR_ATA0;
> +        /* Enable synchronous tag check failures.  */
> +        env->cp15.sctlr_el[1] |= 1ull << 38;

Isn't this making assumptions about the Linux ABI for
memtag (ie that it actually will expose it to userspace
and that it will make tag check failures synchronous)?

> +#ifdef TARGET_AARCH64
> +        /* Set MTE seed to non-zero value, otherwise RandomTag fails.  */
> +        env->cp15.rgsr_el1 = 0x123400;
> +#endif

Does anything go wrong if we don't bother with the #ifdef?

>  #else
>          /* Reset into the highest available EL */
>          if (arm_feature(env, ARM_FEATURE_EL3)) {
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index d7f5bf610a..ac1e2dc2c4 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -350,6 +350,7 @@ static void aarch64_max_initfn(Object *obj)
>
>          t = cpu->isar.id_aa64pfr1;
>          t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);
> +        t = FIELD_DP64(t, ID_AA64PFR1, MTE, 2);
>          cpu->isar.id_aa64pfr1 = t;
>
>          t = cpu->isar.id_aa64mmfr1;
> --

thanks
-- PMM

