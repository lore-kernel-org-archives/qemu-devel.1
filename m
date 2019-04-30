Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98770C46470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608F621734
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xTZUHgGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608F621734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45334 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLRTP-0006Iu-JA
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 08:02:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLROe-0002Kj-6q
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRGo-0007AK-5V
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:49:59 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLRGn-000791-Ut
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:49:58 -0400
Received: by mail-ot1-x342.google.com with SMTP id s11so7279368otp.0
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 04:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=iBYV1aV35wDLNBsTq2QdV6BNSrkaXzuyhGX7UnK0dFA=;
	b=xTZUHgGhQIG1rY66mD+0yQUqglOvVHJlN6JM8dn7Tn0XZtAgqKfWK0tnqwEPjBJg17
	XLOXbcLXOUVx8Z0NALBd145BODQyXaBj3F2T53LyJN44mMUJGMgJWTUA8x7chf+tMIhc
	ClGKDp6pFsjXqJOgGe/ykxfoouQwCeG6y5Xc4YB2GrpM6m524YrMr0LFk7rmAyDJKMgz
	EnQazwqqzHajdQ36GXV8vvSdycF/rZCXLbqubDyMzvRfJE9Bbq7llM58N7cRkoAeMzZ+
	KnkL+4GMKOgqREEcRWsS5gpVVHf/Ehwifx+Ks7u9hSrbjq6hxUXtaD62s2AESwyNJGFO
	cE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=iBYV1aV35wDLNBsTq2QdV6BNSrkaXzuyhGX7UnK0dFA=;
	b=KSUretVmZ5I6M7DXW5VdDVhIzH9V1oe7lh17bttuglpIcNo8ToQT24zg37jpXcUGHx
	59EKVo9MrllCswO70IfJHKTLepyAInrMeF9UQ4qmyHq0yOETGVC9a6b9L6/5PGhbAAmd
	6dHgG629Etue5TUCUNNhsqkeLMrFG6fUoltnXaW0lCr30Qu8/HbsEaJjO1Hh+rNn5j/8
	8aEWBGUZIlTGKIjpU+ju8onH7SoAlKNnrMw3ykTfOe72LFx9byhQZs+Sez6S2dBRqvCo
	5dX6iZtJO3UZvVU1ADGEYp9c24kOLKf26ujIIPPgWTmNyQLhrReEloHeXuNXdEDtFZr9
	ifYQ==
X-Gm-Message-State: APjAAAV3ijACDrI6MRKZLVkhqvVwtuVuWF8WgRBcWHESf95TugSKsKuv
	dPDPLHVmhB7CH+8eNr4FmCRSNTge/jXrbZeYTKTIqA==
X-Google-Smtp-Source: APXvYqzNA12b3qOFvO1oefDy4DaPl1h88rZN1Vub6coeA+R/OcUuwqLoeeWoyU7r6jUW4Uv1Dqe4JNo9PHdO8QZGdPM=
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr4617761otk.316.1556624996883; 
	Tue, 30 Apr 2019 04:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-8-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 12:49:46 +0100
Message-ID:
 <CAFEAcA-_OG6DKJCVqYahNOo_oMoiWSq0Tb7+dQhOGh3jFg01=g@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 07/26] target/i386: Convert to
 CPUClass::tlb_fill
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430114946.7s21AgBW_UlI6mZ3pqMH0E02iUfLdEGO-oCw4KH_gzU@z>

On Wed, 3 Apr 2019 at 04:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We do not support probing, but we do not need it yet either.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> +    env->retaddr = retaddr;
> +    if (handle_mmu_fault(cs, addr, size, access_type, mmu_idx)) {
> +        /* FIXME: On error in get_hphys we have already jumpped out.  */

"jumped"

> +        g_assert(!probe);

> --- a/target/i386/mem_helper.c
> +++ b/target/i386/mem_helper.c
> @@ -191,24 +191,3 @@ void helper_boundl(CPUX86State *env, target_ulong a0, int v)
>          raise_exception_ra(env, EXCP05_BOUND, GETPC());
>      }
>  }
> -
> -#if !defined(CONFIG_USER_ONLY)
> -/* try to fill the TLB and return an exception if error. If retaddr is
> - * NULL, it means that the function was called in C code (i.e. not
> - * from generated code or from helper.c)
> - */
> -/* XXX: fix it to restore all registers */

Is this XXX comment definitely stale ?

> -void tlb_fill(CPUState *cs, target_ulong addr, int size,
> -              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
> -{
> -    X86CPU *cpu = X86_CPU(cs);
> -    CPUX86State *env = &cpu->env;
> -    int ret;
> -
> -    env->retaddr = retaddr;
> -    ret = x86_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
> -    if (ret) {
> -        raise_exception_err_ra(env, cs->exception_index, env->error_code, retaddr);
> -    }
> -}

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

