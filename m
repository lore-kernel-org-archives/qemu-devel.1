Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5168FC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:00:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D593206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oCbGZSz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D593206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5uD-00075p-66
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD5i7-0001a8-Rn
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:48:27 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:35046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD5i5-0001ir-Tj
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:48:27 -0400
Received: by mail-ej1-x643.google.com with SMTP id a26so1469174ejc.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 05:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3IDprVzykahK+tCmIeyfF2J+Gnyg29LO9RV2SD1EOXs=;
 b=oCbGZSz/JiAdN0Dp+x7MG7Kmhbig7an+nCuIjSCHtLEsDsoCph5jR2JFDnAtyt7Zsm
 AzAs6x+9kfLb5JDIG50ezLmEO+jHAPL95Uj/OkS2XW+VzBu5wEfBz1Jvt9/X09rU+ld+
 tUrY+6Fr677wjyDuUgmnllCX7y5bDbb8WOlD29XtGzzemDOTaeIaPkwUtL0CqdwvQA2f
 OHqNGHrYhO7c2OJ/Ouu+SCK9lKOyGQQlBEiQQhcgsOn3FO2iKfTjQGL04lqDg1Ki9vEp
 XOhYsR6qSVJDzk/zYG6QExiUELuYeUgZ1DG/bk6sBC/y4BA8RMuJTBh4oFyhujLYeUL7
 s8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3IDprVzykahK+tCmIeyfF2J+Gnyg29LO9RV2SD1EOXs=;
 b=aylvAYlVcRQCEqWZceESU7mSWs8LjgfPudKe2YaqvFmPnnIYRWWMwfrsnnpmWCBWtE
 Z6JyPGx7ZYIYovUYxCq55DqCkycuBCNi7dWfDOeimvqS3nvzL4hM2hg65mt4KNZ16rP2
 tyB7oB4m1Lk0yhHUmkOJqyYawMCZiH7yiD/PEXfFSYestzhkDu+/QBLs20CWXHz6xn9Y
 yrCBob450JE5/2I/5c3eEZ45ddfp+v29/1+aotksMbuCkpsgcOnFQ+Q7rmOYi7FxBJbY
 fbSrNKwO3XQiIq8LdxKG887yUQJLS/nSuKSM78lU//a8hu/jPe6s1SDSwSwSQC0gjjgw
 Uljg==
X-Gm-Message-State: AOAM532FFzN8S2aZixTGUa1zpAT9UCKJjNsus76/cQCgoYxCaLZ5iTAN
 Yd7F7FukHM2zpKyPlBmq+CX0MSCenCyxRpwF0IHFHw==
X-Google-Smtp-Source: ABdhPJz0bvXVdTL9Zyd7+OuuAVs7TDyvHFTRC9fuynYbAT4QDVUf3c+Vw3sUdJsnUbHPrQPOps4DsOjI6Mm4uIDozDE=
X-Received: by 2002:a17:907:728e:: with SMTP id
 dt14mr1330828ejc.4.1598964504082; 
 Tue, 01 Sep 2020 05:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <1598874522-5186-1-git-send-email-sai.pavan.boddu@xilinx.com>
In-Reply-To: <1598874522-5186-1-git-send-email-sai.pavan.boddu@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2020 13:48:13 +0100
Message-ID: <CAFEAcA_GvSnK0LSxyT0jsFz2yRufrg+Zjs=h7XJtJSp4dGzquw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Configure number of pmu counters
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Andrew Jones <drjones@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 31 Aug 2020 at 12:44, Sai Pavan Boddu
<sai.pavan.boddu@xilinx.com> wrote:
>
> Default the pmu counters to 4 and configure it a 6 for a53 cores.
>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  target/arm/cpu.c    | 3 +++
>  target/arm/cpu.h    | 3 +++
>  target/arm/cpu64.c  | 1 +
>  target/arm/helper.c | 2 +-
>  4 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 6b382fc..805a692 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1051,6 +1051,9 @@ static void arm_cpu_initfn(Object *obj)
>      cpu->psci_version = 1; /* By default assume PSCI v0.1 */
>      cpu->kvm_target = QEMU_KVM_ARM_TARGET_NONE;
>
> +    /* set number of pmu counters to 4 */
> +    cpu->pmcrn = 4;
> +
>      if (tcg_enabled()) {
>          cpu->psci_version = 2; /* TCG implements PSCI 0.2 */
>      }
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index ac857bd..3b47ba8 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -879,6 +879,9 @@ struct ARMCPU {
>       */
>      int32_t core_count;
>
> +    /* Number of pmu counters */
> +    uint8_t pmcrn;
> +
>      /* The instance init functions for implementation-specific subclasses
>       * set these fields to specify the implementation-dependent values of
>       * various constant registers and reset values of non-constant

Rather than doing this, I think the better approach would be to
switch to treating PMCR_EL0 as an ID register in the same way
we do for other varies-per-CPU ID registers:

 * new field uint64_t pmcr_el0 in the ARMISARegisters sub-struct of ARMCPU
 * each CPU's initfn needs to set this (sorry, this is going to mean
   a fair amount of digging through TRMs to find the right values)
 * define_pmu_regs() just uses the isar.pmcr_el0 field as the resetvalue
   for PMCR_EL0
 * define_pmu_regs() needs to use pmu_num_counters() to get the number
   of counters for its loops

Side note: looking at the code I see we don't implement the effect
that MDCR_EL2.HPMN has on this register... (and probably we don't
in general get the EL2 handling of the PMU right in other places too).

thanks
-- PMM

