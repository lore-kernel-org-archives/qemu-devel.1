Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7F2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5900320727
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eGImXlU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5900320727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZfAZ-0000iv-JF
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 14:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZf9x-0000BU-M9
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:34:13 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZf9w-0002TD-MF
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:34:13 -0400
Received: by mail-ot1-x343.google.com with SMTP id q11so2674212oti.6
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 11:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7+R0wGR0TzyHt4PaQaWcOlFGkbI1G+AYd/eUIw65yUM=;
 b=eGImXlU2A26C+bPwa98eyGtniLme8ZjnRn0kZ1W8usP7u9w8IUKv4DIovclz+FHhZP
 QoYlUGD+FEXeEfdsI6EcSIIkyp5biiEZ+NZ2Gi2ee6DTTxa5x8lplzf4VYHp15P+V8vL
 z6pSlZgvx+DBloTsbjLRGGEZFlG+fJzCN/+p+JTIklb3PZlzS+NVOND2vKafvgg5Axsp
 Dl1x0OJkvAaa2tu6dwtiTLeYpBhIpTCnOZm2EQdIePkNsOaal9UeazBx6dSQK0EBGqzq
 gBAijNFMjKhWpZog1ZTaWzFlo0X+Sr+p3nlW8Sy21rWsGKqc9iaSZ6p05kqGHRlacRsR
 uoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7+R0wGR0TzyHt4PaQaWcOlFGkbI1G+AYd/eUIw65yUM=;
 b=JtFNGLKr6QSzNoAVZkbfe/UcKPQolCATnP3tOATj4DopJL9lsKmhSWFMK21AqmNKY6
 POKbNa/Wk+iMZJ5xAugQyUJgoeTw2NROaCpY5m1ONF64hsnwPsMDbNmyDGAJo+Og1LQ9
 2mnpBsSq82EtSE0rKIbddkTvNpMiYHmiML7uezxiznhkpjr8oyO25bOzwlhNIEnnjWPf
 cECVRVSP8e2ahONBmJgoND+DMswJgieJAqOjX3+0GmkQ0vk9w528SILCRdJ/72qX8dvg
 +qQePxAv6w4t9MoGjQD1upRN10GaQTnUYcJvmcLWUZVpqvON1t5/bvsN4fO0PGCf0BRJ
 QIDw==
X-Gm-Message-State: AOAM532QQDRPf+FI8jgVXmEzGwDq6kIswq7H7/tqasqT5qYidlmJ0yM8
 nxTAeJaXUl7rOd86Hwg2zeQH8pVGp6Ao/cO5OsuNiw==
X-Google-Smtp-Source: ABdhPJz5HMgqQ/UGSuyXUgTqK1b39kqvAFhoEZSEt6qBkj3yfamrU18qGnfpEdPqKUOUjHd61kTlrOwKS7t1mLbP0/c=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr3114800oth.221.1589567651259;
 Fri, 15 May 2020 11:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200507202429.1643202-1-amanieu@gmail.com>
In-Reply-To: <20200507202429.1643202-1-amanieu@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2020 19:33:59 +0100
Message-ID: <CAFEAcA-n8-pOcwovsS1Z3T4AMa1Nueo2yik9zX5H16QAHeE05A@mail.gmail.com>
Subject: Re: [PATCH] linux-user/arm: Reset CPSR_E when entering a signal
 handler
To: "Amanieu d'Antras" <amanieu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 May 2020 at 21:25, Amanieu d'Antras <amanieu@gmail.com> wrote:
>
> This fixes signal handlers running with the wrong endianness if the
> interrupted code used SETEND to dynamically switch endianness.
>
> Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
> ---
>  linux-user/arm/signal.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
> index d96fc27ce1..8aca5f61b7 100644
> --- a/linux-user/arm/signal.c
> +++ b/linux-user/arm/signal.c
> @@ -244,6 +244,12 @@ setup_return(CPUARMState *env, struct target_sigaction *ka,
>      } else {
>          cpsr &= ~CPSR_T;
>      }
> +    cpsr &= ~CPSR_E;
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    if (env->cp15.sctlr_el[1] & SCTLR_E0E) {
> +        cpsr |= CPSR_E;
> +    }
> +#endif
>
>      if (ka->sa_flags & TARGET_SA_RESTORER) {
>          if (is_fdpic) {
> @@ -287,7 +293,8 @@ setup_return(CPUARMState *env, struct target_sigaction *ka,
>      env->regs[13] = frame_addr;
>      env->regs[14] = retcode;
>      env->regs[15] = handler & (thumb ? ~1 : ~3);
> -    cpsr_write(env, cpsr, CPSR_IT | CPSR_T, CPSRWriteByInstr);
> +    cpsr_write(env, cpsr, CPSR_IT | CPSR_T | CPSR_E, CPSRWriteByInstr);
> +    arm_rebuild_hflags(env);

I was just looking at the signal code's handling of CPSR for a different
reason, and I noticed that at the moment we don't allow CPSR.E to be
updated from the signal frame when the signal handler returns
(because CPSR_USER doesn't contain CPSR_E and that's what we
use in restore_sigcontext() to define what bits from the frame we
allow updating). Don't you find that when the interrupted code
returns from the signal handler that it ends up running with the
wrong endianness (ie the endianness the handler used) ?

I'm going to fix this by putting CPSR_E in CPSR_USER, anyway.

thanks
-- PMM

