Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB2AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF5720740
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCzLJ+PI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF5720740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZH8T-0006lI-Na
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 11:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZH7o-0006FW-DJ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:22:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZH7m-0004h1-Ve
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:22:08 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZH7m-0004gn-OC
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:22:06 -0500
Received: by mail-oi1-x243.google.com with SMTP id a69so6417448oib.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 08:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tybePqhSuTf9QS4Iu+fqHWsuU+Zk3KtWDnwVhCKRykw=;
 b=SCzLJ+PI1XyRTcM0Y1O4K5g8aWka2wte94q/YL2xEngC65vh9OqPIfBuGqeRjqaciR
 el4xA0vhac7RigIsZ5WcEld2epHlUskeOLJoH8BuCiPY41ic3+cGFl8gDOP49ZpWgrLb
 JTpmCQcqLmqcw3/WmTsQMiH8mzvynsYqIqkZ3Gs7Ma8JcQXSq48gDxsSLq+kZccZ3/is
 LpJ1XWTUVmg+OiN8B11pFUFcEC8h75PnpScAiMj92pR4cMgD6wa8CYOg5DPLBnFKNXSd
 3DD1o0Zl0cmyxjKesC3fiB/wy6NvAQuUlW2NtWnNVbr11IF3eL7axvSvzkpQipcE1H3Q
 yBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tybePqhSuTf9QS4Iu+fqHWsuU+Zk3KtWDnwVhCKRykw=;
 b=tO1qIoQbO5qSF57SXB7tB0F0JTsJgK94L9Wwh00L54oaJ16yy0+Sul9kA3MVSpWu5A
 Jjt56Sz51wqkIafybcMRk2t+shSNvjQS50L2vgI6HTH77U8l4aYIU2ulYBXQwnY1iElD
 C2E3BV47DsoSVhAvNvxC3kF9y+5Hxou3YiWVRQa3IV3yP3viWZC9lqHYuicIHlijAeR2
 bkfspSEhWdcbI1buC/3pQ3wVzqgDDniH2lukKy+eeSwbaax8e4CClWmr4W9x+dQdVE0D
 QY1oGheD6D9aftlrrg+s1gkPMnTXAo7baPaiQ1+zqD9h9eBcigwYeSjx3n23UwxulqgG
 hT4A==
X-Gm-Message-State: APjAAAWB/aOK0RC3hCI0+Q+Maox2W1QpFuDMxkW8pZN3/bleVDn6zSCF
 eywvzgkjC8mDXKqBbl86vXCyRp2FBgHZAix+ahYi6g==
X-Google-Smtp-Source: APXvYqwEzoGQrHDks+ODGmcAGu4Dy2Ca1feu5KO4QLEtfauG8WwYgG4d+tOoa0j8MnwkclMKKDfI3lXChnXTGL7RW3w=
X-Received: by 2002:aca:a9d4:: with SMTP id
 s203mr22607366oie.146.1574698925675; 
 Mon, 25 Nov 2019 08:22:05 -0800 (PST)
MIME-Version: 1.0
References: <20191123115618.29230-1-maz@kernel.org>
In-Reply-To: <20191123115618.29230-1-maz@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Nov 2019 16:21:54 +0000
Message-ID: <CAFEAcA_MQpJ=8UFnP=Qnt+4GWMUO_AtJBBNz-bM2L2wf5htuaQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Honor HCR_EL2.TID3 trapping requirements
To: Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Will Deacon <will@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 23 Nov 2019 at 11:56, Marc Zyngier <maz@kernel.org> wrote:
>
> HCR_EL2.TID3 mandates that access from EL1 to a long list of id
> registers traps to EL2, and QEMU has so far ignored this requirement.
>
> This breaks (among other things) KVM guests that have PtrAuth enabled,
> while the hypervisor doesn't want to expose the feature to its guest.
> To achieve this, KVM traps the ID registers (ID_AA64ISAR1_EL1 in this
> case), and masks out the unsupported feature.
>
> QEMU not honoring the trap request means that the guest observes
> that the feature is present in the HW, starts using it, and dies
> a horrible death when KVM injects an UNDEF, because the feature
> *really* isn't supported.
>
> Do the right thing by trapping to EL2 if HCR_EL2.TID3 is set.
>
> Reported-by: Will Deacon <will@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
> There is a number of other trap bits missing (TID[0-2], for example),
> but this at least gets a mainline Linux going with cpu=max.

I guess this ought to go into 4.2, given that it gets recent
Linux guest kernels to work.


> @@ -6185,11 +6221,13 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              { .name = "ID_AA64PFR0_EL1", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 0,
>                .access = PL1_R, .type = ARM_CP_NO_RAW,
> +              .accessfn = access_aa64idreg,
>                .readfn = id_aa64pfr0_read,
>                .writefn = arm_cp_write_ignore },
>              { .name = "ID_AA64PFR1_EL1", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
>                .access = PL1_R, .type = ARM_CP_CONST,
> +              .accessfn = access_aa64idreg,
>                .resetvalue = cpu->isar.id_aa64pfr1},
>              { .name = "ID_AA64PFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 2,
> @@ -6198,151 +6236,188 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              { .name = "ID_AA64PFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 3,
>                .access = PL1_R, .type = ARM_CP_CONST,
> +              .accessfn = access_aa64idreg,
>                .resetvalue = 0 },

Missing .accessfn for ID_AA4PFR2_EL1_RESERVED ?

>              { .name = "ID_AA64ZFR0_EL1", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 4,
>                .access = PL1_R, .type = ARM_CP_CONST,
> +              .accessfn = access_aa64idreg,
>                /* At present, only SVEver == 0 is defined anyway.  */
>                .resetvalue = 0 },

>              { .name = "MVFR0_EL1", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 0,
>                .access = PL1_R, .type = ARM_CP_CONST,
> +              .accessfn = access_aa64idreg,
>                .resetvalue = cpu->isar.mvfr0 },

These are the AArch64 accessors for the aarch32 MVFR registers,
but this trap bit is also supposed to trap aarch32 accesses to
the MVFR registers, which are via the vmrs insn. That needs
to be done in trans_VMSR_VMRS(); we can do that with a
followup patch, since the mechanism there is completely different.

thanks
-- PMM

