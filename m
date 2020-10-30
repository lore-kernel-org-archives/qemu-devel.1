Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E9FC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149F620724
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gWrTv2bV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149F620724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVl8-0001NY-1D
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYVga-0003vz-8C
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:47:24 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYVgX-0003YA-Q6
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:47:23 -0400
Received: by mail-pg1-x541.google.com with SMTP id h6so5399194pgk.4
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=45FXYFF3j1vdIPopUUAd5Urhixk5oA2LuWDIjFKJxFA=;
 b=gWrTv2bVAHPgjBsPDbMwE1pCiCN+/VNVlwQOPqOLwgpTUb+0Bmd+ayOJUi/cDP/pum
 YSQ994WYvcz+2RHVZkypM4CHbQn02+vI5JJvrp7EjmSkXpVQtxgOSAKjT1hV/P9YxOJq
 igzbv5sm+zFAlc1J7G/gUFUxvTV+53u8Q1CA6ikEbvZM1SlVVLVKIXmDy5vlf/4WhGRd
 XM3JJx6SWItLhEngBPFiasd8psouMQfxz34xjzfu3h6K6gGqDPgz7mUsiK9fZYaeDvls
 cj5TzOgMrwyrQdfLXwoIWVE++b4N6VJK7MvcnxVN9F6qIO/wLx56UJxEgNtbfCwGGIe8
 Ip1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=45FXYFF3j1vdIPopUUAd5Urhixk5oA2LuWDIjFKJxFA=;
 b=Krzw1fU4aZp/TmxQ5Q/LtJoOU/Im496aNUQMPSwGGI9c430Ab6Exavnch5Rn8V2hO9
 gHDgCrMq1ruhG9DLokWGaqJQVaF5pGuQgN9hoJHFJ0KoDJPivFjMPrdxNEbDBBur4STs
 VLlE7iVjFgCq7kTXVH67kTEPnIRqUB290kv1Zft8U+8VYb8w7l0FQfq6yHNz1lkMB4Z2
 j6IAAhOEZp40RvoBIXYD8gvQClcF/z0kgun86x/n31b5F/YOy41wODRrdkL9xHcRCMoe
 /rEHlnvw+CbVmnE3kdxohkdVMbSc9SzVVYgTJ5AD65+Itgu6IHOlO26yOLG5q4upatQp
 VGog==
X-Gm-Message-State: AOAM532RvczEj385gTeMq0SYvur8GyO+eomtu4muvWOxUt2aptYFDNry
 B1byI0fie5E+onaxIlnmVvK1i+kf6/znG5uoY6WJ4oBoVd4=
X-Google-Smtp-Source: ABdhPJzCdz8KX796UaHfJeMeOGFGg7EYfcUlh6ARYfdVJuUuFsLQd35yjHOO8pTjl9epRtgjYZ8Udlce/5x8iXYO7Yw=
X-Received: by 2002:a63:6d4e:: with SMTP id i75mr2539192pgc.305.1604069240523; 
 Fri, 30 Oct 2020 07:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201022164408.13214-1-peter.maydell@linaro.org>
In-Reply-To: <20201022164408.13214-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 14:47:09 +0000
Message-ID: <CAFEAcA9BZ=njKsnErZf9tgAmZXw4=rEiNLkPoPS-phbT2ptxmg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Get correct MMU index for other-security-state
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-pg1-x541.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for code review, please ?

thanks
-- PMM

On Thu, 22 Oct 2020 at 17:44, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In arm_v7m_mmu_idx_for_secstate() we get the 'priv' level to pass to
> armv7m_mmu_idx_for_secstate_and_priv() by calling arm_current_el().
> This is incorrect when the security state being queried is not the
> current one, because arm_current_el() uses the current security state
> to determine which of the banked CONTROL.nPRIV bits to look at.
> The effect was that if (for instance) Secure state was in privileged
> mode but Non-Secure was not then we would return the wrong MMU index.
>
> The only places where we are using this function in a way that could
> trigger this bug are for the stack loads during a v8M function-return
> and for the instruction fetch of a v8M SG insn.
>
> Fix the bug by expanding out the M-profile version of the
> arm_current_el() logic inline so it can use the passed in secstate
> rather than env->v7m.secure.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/m_helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
> index 036454234c7..aad01ea0127 100644
> --- a/target/arm/m_helper.c
> +++ b/target/arm/m_helper.c
> @@ -2719,7 +2719,8 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
>  /* Return the MMU index for a v7M CPU in the specified security state */
>  ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
>  {
> -    bool priv = arm_current_el(env) != 0;
> +    bool priv = arm_v7m_is_handler_mode(env) ||
> +        !(env->v7m.control[secstate] & 1);
>
>      return arm_v7m_mmu_idx_for_secstate_and_priv(env, secstate, priv);
>  }
> --
> 2.20.1
>

