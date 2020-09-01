Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6A3C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:31:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01CF420767
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMZPpvWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CF420767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5RU-00015w-3v
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kD5Qr-0000Vj-VJ; Tue, 01 Sep 2020 08:30:38 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:46057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kD5Qq-000867-AW; Tue, 01 Sep 2020 08:30:37 -0400
Received: by mail-lj1-x242.google.com with SMTP id c2so1248672ljj.12;
 Tue, 01 Sep 2020 05:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=VeCtmxpyBD1wTUB21dJqQwaQwI0C9E+xzkYIKwce00Q=;
 b=hMZPpvWsxablVEvok4y2WH2cHKr5K+bzrh0CPeb5M9iYlesk4J5xtnrM/B38cDpJ0r
 hmadmWkxe9VVtVYVLKUcNux9eZwuhmASJgDCLZswDZrSvLqveDqm5zkfz/ylW9AN+0Tg
 ivqsxDi/UDvVjep5w0AURkmZCIAj87s1uLJJLvBzMBCYjCJ1x3YFG6D/9zB4k+5l0wYG
 PJGg/7iRx5NxsCHS/mvQioU/Cw5M6ODUuf6BjlUV61//t5Hy5374A72EXXFmfqeLx54v
 etux0Pws6TW3Rc1PFhS/4XmQQes/g6fW0HpHcM0uxl1LF4OUW8LX9a2Tv7Pg/ATFFBAQ
 zMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VeCtmxpyBD1wTUB21dJqQwaQwI0C9E+xzkYIKwce00Q=;
 b=siNLtXquCQR27HHV2vGKqVsSes+M05JaMuZvusqXDNiews97mm8DyxQEahguJ6kbJP
 1W85XrURYlqGzfQv9Og462zaWdbdsv/MtCR5Bqfl0Oy8Oz6dCtBzowdfSb3P3VpGukBD
 7olThFqABokyjAzI56U0RgVtoi2F/YckEBk7eySfwl8B1VHuUXckuE4vFPvO4K7FHngh
 TUag1ZfgGRwNezqQx9aJE9/OxM0ZRC4v7YE6WoEilfLvJDMqnm6nsw3wYmkv8CL3hxPp
 7iTV6nEylcrhxNUNDIX3fiJVKzgs3KFJuDM20oqYPY+KpdvS2MYl9SfbHGOyA2uGPVNu
 pHfQ==
X-Gm-Message-State: AOAM533OnUfVYvpyUli8e/WzXdHPbWSfIPyy92HQNIrhyeUIZWwkHbca
 cA3KjFK5XKIoykGiRxA4TeQ=
X-Google-Smtp-Source: ABdhPJylqv1ezUaaqJkC1saUZmUSZjB0OIx1qVbd34Nt57ckzIuZZ6oByAubGci4orkK3hzwhGowmg==
X-Received: by 2002:a2e:9810:: with SMTP id a16mr425270ljj.157.1598963433336; 
 Tue, 01 Sep 2020 05:30:33 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id d17sm245811ljl.133.2020.09.01.05.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 05:30:32 -0700 (PDT)
Date: Tue, 1 Sep 2020 14:30:30 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH] target/arm: Configure number of pmu counters
Message-ID: <20200901123030.GV2954729@toto>
References: <1598874522-5186-1-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598874522-5186-1-git-send-email-sai.pavan.boddu@xilinx.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=2.346, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "'Edgar E . Iglesias'" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 'Philippe =?iso-8859-1?Q?Mathieu-Daud=E9'?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 'Alex =?iso-8859-1?Q?Benn=E9e'?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 31, 2020 at 05:18:42PM +0530, Sai Pavan Boddu wrote:
> Default the pmu counters to 4 and configure it a 6 for a53 cores.

Your commit message looks like it needs a little rewording.

I would probably split this into two patches, one that adds pmcrn
and another that modifies the A53.

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

/* Set default number of PMU counters */

That way if the default changes you don't need to edit both code and comment.

With those changes:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



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
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index dd69618..76c879a 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -190,6 +190,7 @@ static void aarch64_a53_initfn(Object *obj)
>      cpu->gic_vpribits = 5;
>      cpu->gic_vprebits = 5;
>      define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
> +    cpu->pmcrn = 6;
>  }
>  
>  static void aarch64_a72_initfn(Object *obj)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 44d6666..4afbefb 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6534,7 +6534,7 @@ static void define_pmu_regs(ARMCPU *cpu)
>       * field as main ID register, and we implement four counters in
>       * addition to the cycle count register.
>       */
> -    unsigned int i, pmcrn = 4;
> +    unsigned int i, pmcrn = cpu->pmcrn;
>      ARMCPRegInfo pmcr = {
>          .name = "PMCR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 0,
>          .access = PL0_RW,
> -- 
> 2.7.4
> 
> 

