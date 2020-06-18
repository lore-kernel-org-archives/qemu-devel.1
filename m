Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9ACC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4071A20720
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjxqTUDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4071A20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlsAh-0006dB-Fg
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 06:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlsA2-00064N-A5
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:52:46 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jls9y-0002Iv-O7
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:52:46 -0400
Received: by mail-ot1-x342.google.com with SMTP id d4so4181629otk.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 03:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iVZxlubKdO45F+wI2LxuA9yidpgPj1lhxOvNIiLJ0t0=;
 b=CjxqTUDcf2py6QIIe63ETfCfiIMeSPODgUlaYu/VCq0PZsWNONP1qLp1H/4Ris6XQF
 5py7vMpjjkQd4dnyMRwDzHYholioMMBsmTxRgTHng/Au6PodOf0otHJCDEQeP3Z3Vydi
 fPngIQS4gB5se/6WlrPqvWfegtXxDr9ItFuGu0KLWKXLT1BlDAbAS7W0R8q3G5EihMIy
 ru+bVAuC4yJ09wIPzrMqI1sVgUOih2GlDe7+KYQDEZ+b/nAzuJUNSuE2KZJFrWNsmIvT
 wqJ7BbgRia0rRki89GD73GrEPn+roojZKdmemp1WDklTZLsQhWvn6vXbgXJflrDJmfrC
 aYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iVZxlubKdO45F+wI2LxuA9yidpgPj1lhxOvNIiLJ0t0=;
 b=sZvxbuVUmUN5PlBSYee7rC6CHPKj8mYwBu0afsW/5uz6dgKTdlCTISKC/rL4Q6EEdO
 5M1VWQskHc99jmTy7xWGQeWBFgShm1kIkeyovWwj14MGk1idAvSqJ6O+sFbUtpiBm6f/
 T98btthBWHrxXGlgmOmJLs9brQicRNlFJ0mdqa0Ka5aZ39ciV4OOQ78cv7irp0TmzkOl
 McBtsXAtpjn9yfKCSd3lhj8f/Lugzy5NYLmZTJhlrmw3yENuKkp8vl3AW8VeYnn7aMAQ
 bP/xi/0q6xhFrULN6MU5NkExAPr9VHY2j7sWyJLuHglC+g6a/IgA40h9Ot6HJvQsaPCh
 r4dQ==
X-Gm-Message-State: AOAM531E2cB+zhdeQwvBvHwmLcMyydjs6C8NNUhawSDWpOCaUicNmyrr
 x+RwqxKqlygzE3dXP2YvNwzFjHACcQTzfXwH+KobmQ==
X-Google-Smtp-Source: ABdhPJzslIoHMUD3OOP49bY8nmWz7eGW5l62SmYCwTAx1Eis/zXAnxS8XSOv3hqNnuTzf544Rnj7IS0sKHyEpPE4Z78=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr2736190otn.221.1592477561358; 
 Thu, 18 Jun 2020 03:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-4-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 11:52:30 +0100
Message-ID: <CAFEAcA9bAt=cG9nSWP6JaVyx4jf2UGmYLKzvaJ7rVCdLVpw2ig@mail.gmail.com>
Subject: Re: [PATCH v7 03/42] target/arm: Add support for MTE to SCTLR_ELx
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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

On Wed, 3 Jun 2020 at 02:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This does not attempt to rectify all of the res0 bits, but does
> clear the mte bits when not enabled.  Since there is no high-part
> mapping of SCTLR, aa32 mode cannot write to these bits.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 2ec49c1a55..7862bf502d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4698,6 +4698,22 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  {
>      ARMCPU *cpu = env_archcpu(env);
>
> +    if (arm_feature(env, ARM_FEATURE_PMSA) && !cpu->has_mpu) {
> +        /* M bit is RAZ/WI for PMSA with no MPU implemented */
> +        value &= ~SCTLR_M;
> +    }
> +
> +    /* ??? Lots of these bits are not implemented.  */
> +
> +    if (ri->state == ARM_CP_STATE_AA64 && !cpu_isar_feature(aa64_mte, cpu)) {
> +        if (ri->opc1 == 6) { /* SCTLR_EL3 */
> +            value &= ~(SCTLR_ITFSB | SCTLR_TCF | SCTLR_ATA);
> +        } else {
> +            value &= ~(SCTLR_ITFSB | SCTLR_TCF0 | SCTLR_TCF |
> +                       SCTLR_ATA0 | SCTLR_ATA);
> +        }

Doesn't SCTLR_EL2 have the same "no ATA0 and no TCF0" that
SCTLR_EL3 does?

thanks
-- PMM

