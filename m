Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC65AC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C262084A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuStnqFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C262084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60502 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOpYw-0002Gz-H7
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 16:22:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOpVN-0007Zk-85
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOpVM-0008An-5L
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:19:01 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:44845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOpVL-0008A5-Uc
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:19:00 -0400
Received: by mail-lf1-x144.google.com with SMTP id n134so2482182lfn.11
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 13:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=M8wSvfK5ieqsUFuTDi1yZY06NbIx7MLgRwmil9egUtw=;
	b=QuStnqFwXjDLz1naO/kTp0fEvt+fucTg/FgccNlTKuzvcQB/zlZnaeeItsSxdHU6y9
	jSvV9PwvpdtOJQQc46JgLulQQ9lSOa05mXSzmDVVlx3rGq4VcPQjTbXgfGnHPHtEbFMb
	SrO8q1WwFgYjTzMj6oVEU02Kh8eRYLcyjG5psYdX1NC5VjKMwCj9whKPoVCF+yVylIlp
	nwS2AZAq+CIojXO/G+LQ69E2B5cZNImxTIuFEnoAVQ8UkZ7G1MUw42e4snoLemmHVQro
	rf35esOVgMel/bUC/GgSkGecidpTGvFFFVmeuIF0eDB6poqpxNinNtOau/oDebad8/K7
	Es4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=M8wSvfK5ieqsUFuTDi1yZY06NbIx7MLgRwmil9egUtw=;
	b=CLQyHudcAm2T3YU/5TTdRddQvTb3boLD9xRPtbXSl0SQqbPOQo1OZLZXwcXw+Mh7a5
	PHroTOdDOcGicwadbDE42wArY8sum9Cox4/iCFFGJNSoiFUkvvHHm6xDFu7Ao+6i8xlP
	E98QjbdQz/P8aE5W3B0VEeORu8Iuz1Yjvo/9CwOH2cWiBNhmKuBgsfDQ2W39OMXqBzLN
	ljhxPAUdk2cfG7R7OyaoRhcKaD625uBi7wgyP+eAwGPBPnHBjlIOc+vA7R4CPMX/OPYU
	BAGLtdyrzofupuJ0b8c8iLWAROkx63ix2HeMvAyQqAzFBZZxhv88e9cn2CP5dCrEkqwL
	Bb2w==
X-Gm-Message-State: APjAAAVKI+yazwnt/ZfN085YmcnBzRobMzrh7svnLUyA6Tf2pTq5W+Zc
	SQ4TRUC+wtMLHI8iZol3sEMWApjDFFRP4xSGVXA=
X-Google-Smtp-Source: APXvYqw8picwwDl2LgqjpWr0BDA8bkbcsb+EUMHqqk9jqpZbwzZuqEQaYzjkbj5tg8SCkIgKf8kAJ1pNkxHyH0rJo94=
X-Received: by 2002:ac2:523a:: with SMTP id i26mr3549585lfl.118.1557433138651; 
	Thu, 09 May 2019 13:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-29-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-29-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 13:16:52 -0700
Message-ID: <CAKmqyKPdwPrtr+nJiyPHYaBdOpUzQ6Ww8zGGSfn4NPQO4HWb6g@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH v3 28/39] target/tricore: Use env_cpu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 7, 2019 at 5:31 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/tricore/cpu.h       | 5 -----
>  target/tricore/op_helper.c | 4 ++--
>  2 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
> index 4c997b6d30..fc3328fdf5 100644
> --- a/target/tricore/cpu.h
> +++ b/target/tricore/cpu.h
> @@ -208,11 +208,6 @@ struct TriCoreCPU {
>      CPUTriCoreState env;
>  };
>
> -static inline TriCoreCPU *tricore_env_get_cpu(CPUTriCoreState *env)
> -{
> -    return TRICORE_CPU(container_of(env, TriCoreCPU, env));
> -}
> -
>  #define ENV_OFFSET offsetof(TriCoreCPU, env)
>
>  hwaddr tricore_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
> index ed9dc0c83e..ba2f21a6c3 100644
> --- a/target/tricore/op_helper.c
> +++ b/target/tricore/op_helper.c
> @@ -29,7 +29,7 @@ static void QEMU_NORETURN
>  raise_exception_sync_internal(CPUTriCoreState *env, uint32_t class, int tin,
>                                uintptr_t pc, uint32_t fcd_pc)
>  {
> -    CPUState *cs = CPU(tricore_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      /* in case we come from a helper-call we need to restore the PC */
>      cpu_restore_state(cs, pc, true);
>
> @@ -2800,7 +2800,7 @@ static inline void QEMU_NORETURN do_raise_exception_err(CPUTriCoreState *env,
>                                                          int error_code,
>                                                          uintptr_t pc)
>  {
> -    CPUState *cs = CPU(tricore_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      cs->exception_index = exception;
>      env->error_code = error_code;
>      /* now we have a real cpu fault */
> --
> 2.17.1
>
>

