Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4D0C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B172078D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S8l92pD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B172078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmI2v-0002pm-9g
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 10:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmI14-0000Qp-2u
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:29:14 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmI12-0007tZ-4v
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:29:13 -0400
Received: by mail-ot1-x344.google.com with SMTP id k15so7412155otp.8
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C/u2JsRLnjfBBA/oPMPI9i9jHqou2+oqY4hgiT980OU=;
 b=S8l92pD/hBGIYstZqH2eCF2swpDSSaSL626ar4Erb8GyMTdrQEffnLqqRgGJUWULtB
 h1N4e6uasgEOFHdzyAb7M9rOLv2EKmHmfcWWC9TnIDecPV3jpIinzX9Kh95sWvGHgGQt
 3SKowalgS9pp+sNo7Cpvpi63gsomb7LQQPHOCuSieHVzVMRkaHcZa9YuC0yoR+Hz8s9Z
 68aqV7jqnpDeW/maHrUlrojDTE15aQp8DzwHlx376YQ3CkQDEPPzFLKV+0inTpDgTj+u
 7Cpt3c3uYe7JPWyJ5eovz7UbVhyQNYZfp4L2WvBO/ljgdlPNvcdd81wAAmNCmq3PJS/a
 pHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C/u2JsRLnjfBBA/oPMPI9i9jHqou2+oqY4hgiT980OU=;
 b=atuiumoMHtzcBzsibySsjTpbB9mRYFvUO0vUAA11R/0aISw+9gO1OqhLjhVjZ/YUR1
 iyZAsHLpr75ZkjfqN3GpDXBLjlSf1xHzil+6phwm/0NQ74jVoR2IEs0HyM/QS/Hd2EQb
 L36vTJqW2LAXJtOrUwRPS7YduMeluOJfGy08Ya28bkcQU4e/j5+Cs7uNFg9QqzKbyl2X
 N/PgvZTR74idOLCuTxro7AbpTnAkjuA/24COERdw3xY2kUfjOHX7eshuu83UOt4p3+7E
 Iw3MyK/EUnux9a0QMZ+mLDnUSGAyUxj1SiPBg9IkoiIKpOKus6d3dmHDylrb+FMCBuMn
 +r+g==
X-Gm-Message-State: AOAM531hVxrNBg+6SGUlokZbXrhLjvb9RDrh/PsTsZfcqNgwv/UrUlFr
 zBdRb7g2KBtvdE779zLedl5XX/p7Pi/tJ8upLWNuNw==
X-Google-Smtp-Source: ABdhPJzd32YLEp+fX6TUFH1zZ07VdPinLv8IbtmzYViRpajUZ+i1NYGSweYy7OMHIwSGHAI1Uh4cb3vgPPsd3CbtQhU=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr3186042oto.91.1592576950778; 
 Fri, 19 Jun 2020 07:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-41-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-41-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 15:29:00 +0100
Message-ID: <CAFEAcA8zBPh8T3J_=LAg2CNWS4nZC+iGsR053yXtd78gSoma1A@mail.gmail.com>
Subject: Re: [PATCH v7 40/42] target/arm: Cache the Tagged bit for a page in
 MemTxAttrs
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

On Wed, 3 Jun 2020 at 02:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This "bit" is a particular value of the page's MemAttr.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v6: Test HCR_EL2.{DC,DCT}; test Stage2 attributes.
> ---
>  target/arm/helper.c | 43 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 8 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 50717afa4a..74925010ea 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -10875,6 +10875,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
>      uint64_t descaddrmask;
>      bool aarch64 = arm_el_is_aa64(env, el);
>      bool guarded = false;
> +    uint8_t memattr;
>
>      /* TODO: This code does not support shareability levels. */
>      if (aarch64) {
> @@ -11099,17 +11100,32 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
>          txattrs->target_tlb_bit0 = true;
>      }
>
> -    if (cacheattrs != NULL) {
> +    if (mmu_idx == ARMMMUIdx_Stage2) {
> +        memattr = convert_stage2_attrs(env, extract32(attrs, 0, 4));
> +    } else {
> +        /* Index into MAIR registers for cache attributes */
> +        uint64_t mair = env->cp15.mair_el[el];
> +        memattr = extract64(mair, extract32(attrs, 0, 3) * 8, 8);
> +    }
> +
> +    /* When MTE is enabled, remember Tagged Memory in IOTLB. */
> +    if (aarch64 && cpu_isar_feature(aa64_mte, cpu)) {
>          if (mmu_idx == ARMMMUIdx_Stage2) {
> -            cacheattrs->attrs = convert_stage2_attrs(env,
> -                                                     extract32(attrs, 0, 4));
> +            /*
> +             * Require Normal, I+O Shareable, WB, NT, RA, WA (0xff).
> +             * If not, squash stage1 tagged normal setting.
> +             */
> +            if (memattr != 0xff) {
> +                txattrs->target_tlb_bit1 = false;
> +            }

Can we implement the effect of stage1+stage2 attrs on whether
the memory location is tagged in the same way it's described in
the Arm ARM, ie by combining the stage1+stage2 attrs and then
looking at the combined result to decide ? In particular, this
code works for the classic attribute-combining logic (where stage2
gets to override only in the more-like-device direction), but
when we get round to implementing ARMv8.4-S2FWB then HCR_EL2.FWB
will allow the stage2 page tables to entirely override stage1
so that we might have memory that is tagged even if stage 1's
attributes said it wasn't.

Currently we do this attribute-combining only for cacheattrs
(the combine_cacheattrs() call) but we could make that deal with
more attributes if we need them for this purpose.

thanks
-- PMM

