Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AABC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 11:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA9B20726
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 11:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5pQcQ60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA9B20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieHPv-0008GB-FX
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 06:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ieHPB-0007qD-Bw
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ieHP9-0000Cq-Rx
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:40:44 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37535)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ieHP6-0000C4-PG
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:40:43 -0500
Received: by mail-oi1-x244.google.com with SMTP id x195so6027661oix.4
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 03:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uklKMZzISOoJyufLSLUTrhbnWXigIY3UMs+4Jn0DM1E=;
 b=n5pQcQ60Gj7PE6UUN/BB428JpdIho+hYjVm8tlj6ASDg8ZU7IS5o8tHgtlnqGD2eeH
 PdkxUxwO0IllbTYrTh7GGsHbnhRFsGHG9hDgyleEQ39isxGfZZTsW5KKNpvVM4t7sqNI
 Sm8grpNmrw/4OXI6NqbKP8FetzmtNeks6/GANfOgrwfsTk6iHx8Pso27sFXnwMteD5RA
 qS0aPNtMIlxwwOlDhlew+EzHuo/7RBXhJ0fsENPav+y3tvGtXe2n+q+J687l/9W/WqI9
 ObGdIwYxFcv8idEUpsEOqJ0RqDwLxoklt6I40hqJYKTTo3nIoF7pCWVsrYS6vnN8ty8z
 TwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uklKMZzISOoJyufLSLUTrhbnWXigIY3UMs+4Jn0DM1E=;
 b=RjrTrfk4NVUCwbE8zrbZnq4FLB542uErb5xCJgwI0izckvWfgrCQO2yow+/RZ95U+N
 ELY92/Zp2WweHSkoygsu1jNIALmo/tMUlsDXpOzIoHqkrNSSa+EzJyDMU8Rp4415Gw0i
 feLrnvJbnQRfPlUtXAoaMUgp0FCUkiPFZOJZTziQL2vuq6pflnyKW6gE65s2VBKE108b
 upscWB/JdpSPHz3sfPkF20AVCLKdGuSQINgBDHJ19CE1T05HzuqPbN5pKirh6EEOO2Ts
 XBFdVsnAaej73t9KUFxRUCHrMgV57gNPWK/3pmRaE51EswuickCT6kuqS5QULPvkUniT
 1RjA==
X-Gm-Message-State: APjAAAV/lsNfPTvF6RyOX9Ci/IstS57LXv+dDIzyTTE+Fy8AHLjTShVK
 l9wXurZHaLE/2uEICvrjAOjMRZK4xqDaQJMzKHplWA==
X-Google-Smtp-Source: APXvYqwNlfHTtoQ/KAr+gzwTYnlPz/fmjsIwF1Rjc1h7bWA6Ye4YxqIemmyFJpKevAmdhv6c32gA+XZ8k1VQl06ixjo=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr24267683oih.98.1575891639638; 
 Mon, 09 Dec 2019 03:40:39 -0800 (PST)
MIME-Version: 1.0
References: <20191203225333.17055-1-richard.henderson@linaro.org>
 <20191203225333.17055-4-richard.henderson@linaro.org>
In-Reply-To: <20191203225333.17055-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Dec 2019 11:40:28 +0000
Message-ID: <CAFEAcA8Cb+wXbbSppEV86eJO0D9TpkwKRbMdqfnu71ag5zhmnw@mail.gmail.com>
Subject: Re: [PATCH 03/11] target/arm: Add mmu_idx for EL1 and EL2 w/ PAN
 enabled
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
> To implement PAN, we will want to swap, for short periods
> of time, to a different privileged mmu_idx.  In addition,
> we cannot do this with flushing alone, because the AT*
> instructions have both PAN and PAN-less versions.
>
> Add the ARMMMUIdx*_PAN constants where necessary next to
> the corresponding ARMMMUIdx* constant.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 22935e4433..22c5706835 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2715,20 +2715,22 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
>   *  5. we want to be able to use the TLB for accesses done as part of a
>   *     stage1 page table walk, rather than having to walk the stage2 page
>   *     table over and over.
> + *  6. we need separate EL1/EL2 mmu_idx for handling the Priviledged Access

"Privileged" (no 'd')

> + *     Never (PAN) bit within PSTATE.
>   *
>   * This gives us the following list of cases:
>   *
>   * NS EL0 (aka NS PL0) EL1&0 stage 1+2
> - * NS EL1 (aka NS PL1) EL1&0 stage 1+2
> + * NS EL1 (aka NS PL1) EL1&0 stage 1+2 (+PAN)
>   * NS EL0 EL2&0
> - * NS EL2 EL2&0
> + * NS EL2 EL2&0 (+PAN)
>   * NS EL2 (aka NS PL2)
>   * S EL0 (aka S PL0)
> - * S EL1 (not used if EL3 is 32 bit)
> + * S EL1 (not used if EL3 is 32 bit) (+PAN)
>   * S EL3 (aka S PL1)
>   * NS EL0&1 stage 2
>   *
> - * for a total of 9 different mmu_idx.
> + * for a total of 12 different mmu_idx.
>   *
> @@ -11886,11 +11924,14 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
>      /* TODO: ARMv8.2-UAO */
>      switch (mmu_idx) {
>      case ARMMMUIdx_EL10_1:
> +    case ARMMMUIdx_EL10_1_PAN:
>      case ARMMMUIdx_SE1:
> +    case ARMMMUIdx_SE1_PAN:
>          /* TODO: ARMv8.3-NV */
>          flags = FIELD_DP32(flags, TBFLAG_A64, UNPRIV, 1);
>          break;
>      case ARMMMUIdx_EL20_2:
> +    case ARMMMUIdx_EL20_2_PAN:
>          /* TODO: ARMv8.4-SecEL2 */
>          /*
>           * Note that EL20_2 is gated by HCR_EL2.E2H == 1, but EL20_0 is
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index fe492bea90..b5c7bc2d76 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -124,9 +124,11 @@ static int get_a64_user_mem_index(DisasContext *s)
>           */
>          switch (useridx) {
>          case ARMMMUIdx_EL10_1:
> +        case ARMMMUIdx_EL10_1_PAN:
>              useridx = ARMMMUIdx_EL10_0;
>              break;
>          case ARMMMUIdx_EL20_2:
> +        case ARMMMUIdx_EL20_2_PAN:
>              useridx = ARMMMUIdx_EL20_0;
>              break;
>          case ARMMMUIdx_SE1:

Why doesn't this switch need also a case for ARMMMUIdx_SE1_PAN ?

otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

