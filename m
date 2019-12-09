Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AD7C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 11:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3362C2077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 11:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KxLt3fcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3362C2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieHef-0002tj-CI
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 06:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ieHe0-0002Sc-Uf
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ieHdz-00071j-KJ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:56:04 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ieHdz-00071a-Ee
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:56:03 -0500
Received: by mail-ot1-x342.google.com with SMTP id 77so11917037oty.6
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 03:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9gloapw0kyjezAxEQ00KyaSuLjlFyKDrbSj/v7FrhQ0=;
 b=KxLt3fcTrUTSeBlsF54U317/nrlaoAOqK9tvQXAXh+ajVelwLPIT/y5LiiNJgLHXi9
 RPYT1gdrt6hGnc6ZFm103AdsIezHFaikUMDjsSJerThCKniPB7LXODk5UOOi4wYVeIVV
 JAbIxFDiE26JP21Z9isQ5Asx25sEWn9RZvY75hIZ49vKvHYC0ywG9CE9xS3HQOJ5VkY6
 E5WDYtuU+Mj4GhHu+xIaTUdwg+Dhn0yowKsRGDM+EaS37SvCtIuunv5YG2MCCBa9ALnM
 Ozoylk63VFTs6iA72CfQXI1nhL009MF1pR+kLKDf/Lk9bU9V1npgIHMn+jgI9KNCRdLA
 f9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9gloapw0kyjezAxEQ00KyaSuLjlFyKDrbSj/v7FrhQ0=;
 b=UiGeOlZcgaNqByibSaOciklEzTPmf5ZfZwU8tAQHCcBLjM81iODePZSshn6R/iebd4
 g+gbOgpFIWtkrDczZ8hQNFBXGY44bqwrwGSjpu/7FvQb0WCCJfrKwseuFk7H1v3aLy+N
 y/sn4j1BRFc8dOa6OBohTPSbpnB/pQYlWf67ETja/am38EdDjSfneRExRiisnz1AbPhr
 C5gC2yyGtEYnIU2xu/zBdE59PmSMPu0VoSRVKaUJ5EaD31reR1vSZCLgUCle1Zp2np6R
 mexC3dqhazJ3HzzPqIGoWuGmdxT1v6ekGi7Pr+VTYvtlPO/R7dybOYqbYYvApH8teZyr
 NLlw==
X-Gm-Message-State: APjAAAW87xOPuE7qWEUkW96M7JY3FdAJ4LL0rgno2E12vwAp+PsbDveN
 5EzvKu4iEyl+U7zmhqTMRLU26MoTRUD7W+SdU2K3OA==
X-Google-Smtp-Source: APXvYqxrgORXbuIyiXPfP+zU74a5aSgJVZWvgV7wW2atNzSyIgKw1KXOG4abBxnc3oWzobU8mZpG83lRPuFYuWIp9S8=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr21510383otq.135.1575892562538; 
 Mon, 09 Dec 2019 03:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20191203225333.17055-1-richard.henderson@linaro.org>
 <20191203225333.17055-10-richard.henderson@linaro.org>
In-Reply-To: <20191203225333.17055-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Dec 2019 11:55:51 +0000
Message-ID: <CAFEAcA_zCfPZMoi6oMyoXRYaCpaGC28FK7MxgbaCe3i078WGtw@mail.gmail.com>
Subject: Re: [PATCH 09/11] target/arm: Set PAN bit as required on exception
 entry
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

On Tue, 3 Dec 2019 at 22:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The PAN bit is preserved, or set as per SCTLR_ELx.SPAN,
> plus several other conditions listed in the ARM ARM.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 42 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index a1dbafb9b2..043e44d73d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8634,8 +8634,12 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
>                                     uint32_t mask, uint32_t offset,
>                                     uint32_t newpc)
>  {
> +    int new_el;
> +
>      /* Change the CPU state so as to actually take the exception. */
>      switch_mode(env, new_mode);
> +    new_el = arm_current_el(env);
> +
>      /*
>       * For exceptions taken to AArch32 we must clear the SS bit in both
>       * PSTATE and in the old-state value we save to SPSR_<mode>, so zero it now.
> @@ -8648,7 +8652,7 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
>      env->uncached_cpsr = (env->uncached_cpsr & ~CPSR_M) | new_mode;
>      /* Set new mode endianness */
>      env->uncached_cpsr &= ~CPSR_E;
> -    if (env->cp15.sctlr_el[arm_current_el(env)] & SCTLR_EE) {
> +    if (env->cp15.sctlr_el[new_el] & SCTLR_EE) {
>          env->uncached_cpsr |= CPSR_E;
>      }
>      /* J and IL must always be cleared for exception entry */
> @@ -8659,6 +8663,14 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
>          env->thumb = (env->cp15.sctlr_el[2] & SCTLR_TE) != 0;
>          env->elr_el[2] = env->regs[15];
>      } else {
> +        /* CPSR.PAN is preserved unless target is EL1 and SCTLR.SPAN == 0. */
> +        if (cpu_isar_feature(aa64_pan, env_archcpu(env))) {
> +            env->uncached_cpsr |=
> +                (new_el == 1 &&
> +                 (env->cp15.sctlr_el[1] & SCTLR_SPAN) == 0
> +                 ? CPSR_PAN
> +                 : env->spsr & CPSR_PAN);

env->uncached_cpsr isn't wiped by this function, so the default
behaviour is "same as it was previously" without needing to fish
the bit out of env->spsr again, I think.

> +        }
>          /*
>           * this is a lie, as there was no c1_sys on V4T/V5, but who cares
>           * and we should just guard the thumb mode on V4

thanks
-- PMM

