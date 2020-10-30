Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607F3C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D1120731
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lKJSVKy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D1120731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVg8-0002Ia-LP
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYVdw-0000S2-MR
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:44:41 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYVdr-00037o-8Q
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:44:40 -0400
Received: by mail-pg1-x542.google.com with SMTP id t14so5408762pgg.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ivI4Ncp5Qg6ZNoGJ1oMnyqt4jaqTVo68mwPVvnV0TSk=;
 b=lKJSVKy/xse1T3X28X1pj4zxjrFvSwpBEb7/o4lXErGCLg793xFmAEwKtR65O7vK5A
 8qM3+NLpqt6iN9vjc457nEMwrB4F7du6IbyEn54fnyeZYJKONcYp3wESHoF8AM95EiQm
 G1sxZy5FuqlC/rBGyToS+NRgMOR2bBXGG3ep6XAQ6YeICtWiwv4ngftdkilBqHjcKNoc
 PLAslERG042V2tv6yEJX05qF/tf6NYsJbwN1UYkOSTTg4SCfIXYPPM3bUNU3KQYGNX9x
 IG/BgquYa2u4Z1YKB7xvBKDMKSnLgTeVbahZtcxvX/iwi711pQFaNUWRBHkqlBkTI6jp
 n4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ivI4Ncp5Qg6ZNoGJ1oMnyqt4jaqTVo68mwPVvnV0TSk=;
 b=mJiQrOGY1bRzaty5R4LssDcp7hFnZ3UhfsOKwlMlLdlvjPmlcsVL1yQhSjN/z34SQ6
 VEeVvMf0NG2xmOIRxMpORgMYHPuBUpx9r5PIy/oGwnUMZlyZ9PKtMxH6RnMTQ+RsEROs
 OI0ZBk62X9ECuYOaWYKx7B+WwOiksgpkie+NN0ULr4+jJuhHs5ufi12uEZZpia+yBHN1
 Ex03k8iUPpV4rqThqdSG9j2JEf/ltQntIiv7B10tioomY1WZC9sv88tfe9HwM+75GjrX
 2fNT7VJLTG7nHEu0CZIzuo3uD5T1X9G7hWxpgegKu/GR0C6qBju365jBT+wP0QBIJ0Ax
 W+1A==
X-Gm-Message-State: AOAM533Be222WdjY8tXNBVPotRhDUuyu4DW3R/QJV/Ej1Qx//AM8p//L
 RHTpJMZ0ONdahDmH3VMnXPk1hlqWCNegVHhoO40vqg==
X-Google-Smtp-Source: ABdhPJxl5GG5HxZRva54cNzKVXl2LEBcNoZeUSovB9NWgKRW9eACmPM2xHmtQQi3Yg4akjB6C1/VD5bCLYUeMSO/2+A=
X-Received: by 2002:a63:e453:: with SMTP id i19mr2306203pgk.397.1604069072140; 
 Fri, 30 Oct 2020 07:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201009153904.28529-1-peter.maydell@linaro.org>
In-Reply-To: <20201009153904.28529-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 14:44:20 +0000
Message-ID: <CAFEAcA_LBy7kx2uP_uRzyv8jbob3uR5RVDMTtPAYwwdAKuDx7Q@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3_cpuif: Make GIC maintenance interrupts
 work
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Jose Martins <josemartins90@gmail.com>, Marc Zyngier <maz@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for code review, please?

thanks
-- PMM

On Fri, 9 Oct 2020 at 16:39, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In gicv3_init_cpuif() we copy the ARMCPU gicv3_maintenance_interrupt
> into the GICv3CPUState struct's maintenance_irq field.  This will
> only work if the board happens to have already wired up the CPU
> maintenance IRQ before the GIC was realized.  Unfortunately this is
> not the case for the 'virt' board, and so the value that gets copied
> is NULL (since a qemu_irq is really a pointer to an IRQState struct
> under the hood).  The effect is that the CPU interface code never
> actually raises the maintenance interrupt line.
>
> Instead, since the GICv3CPUState has a pointer to the CPUState, make
> the dereference at the point where we want to raise the interrupt, to
> avoid an implicit requirement on board code to wire things up in a
> particular order.
>
> Reported-by: Jose Martins <josemartins90@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>
> QEMU's implementation here is a bit odd because we've put all the
> logic into the "GIC" device where in real hardware it's split between
> a GIC device and the CPU interface part in the CPU.  If we had
> arranged it in that way then we wouldn't have this odd bit of code
> where the GIC device needs to raise an IRQ line that belongs to the
> CPU.
>
> Not sure why we've never noticed this bug previously with KVM as a
> guest, you'd think we'd have spotted "maintenance interrupts just
> don't work"...
> ---
>  include/hw/intc/arm_gicv3_common.h | 1 -
>  hw/intc/arm_gicv3_cpuif.c          | 5 ++---
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index 0331b0ffdb8..91491a2f664 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -153,7 +153,6 @@ struct GICv3CPUState {
>      qemu_irq parent_fiq;
>      qemu_irq parent_virq;
>      qemu_irq parent_vfiq;
> -    qemu_irq maintenance_irq;
>
>      /* Redistributor */
>      uint32_t level;                  /* Current IRQ level */
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index 08e000e33c6..43ef1d7a840 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -399,6 +399,7 @@ static void gicv3_cpuif_virt_update(GICv3CPUState *cs)
>      int irqlevel = 0;
>      int fiqlevel = 0;
>      int maintlevel = 0;
> +    ARMCPU *cpu = ARM_CPU(cs->cpu);
>
>      idx = hppvi_index(cs);
>      trace_gicv3_cpuif_virt_update(gicv3_redist_affid(cs), idx);
> @@ -424,7 +425,7 @@ static void gicv3_cpuif_virt_update(GICv3CPUState *cs)
>
>      qemu_set_irq(cs->parent_vfiq, fiqlevel);
>      qemu_set_irq(cs->parent_virq, irqlevel);
> -    qemu_set_irq(cs->maintenance_irq, maintlevel);
> +    qemu_set_irq(cpu->gicv3_maintenance_interrupt, maintlevel);
>  }
>
>  static uint64_t icv_ap_read(CPUARMState *env, const ARMCPRegInfo *ri)
> @@ -2624,8 +2625,6 @@ void gicv3_init_cpuif(GICv3State *s)
>              && cpu->gic_num_lrs) {
>              int j;
>
> -            cs->maintenance_irq = cpu->gicv3_maintenance_interrupt;
> -
>              cs->num_list_regs = cpu->gic_num_lrs;
>              cs->vpribits = cpu->gic_vpribits;
>              cs->vprebits = cpu->gic_vprebits;
> --
> 2.20.1
>

