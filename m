Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA611C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D44620835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0mc3jxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D44620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42139 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLP7m-0003nt-O6
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 05:32:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLP6u-0003SP-IP
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLP6t-0006SG-Lp
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:31:36 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLP6t-0006Rb-Bf
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:31:35 -0400
Received: by mail-oi1-x241.google.com with SMTP id v23so10528177oif.8
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ngfCwlYAJnrB4SwxhdmvY3jAzbIU+2IQncHAnt3Ac6E=;
	b=I0mc3jxhRPDAArwJWiyMk5jQQc18sVpeTouhSbkCUe/reyZ4SYUhrScMPSmi7c/MEZ
	LA+mtGCNgrN/SmugKQ+ypGoTykpcfVX9tfksJHzUXccdQqBkTErXsmBcbHZFb2Q78rNu
	9cT9PVqw34Q9uXaj9QPopva1VZpEZQsCBU5BC/rKJaqGTT0mFFJA4I8sUWfLUBIs8p1l
	59UUDVabouzzozLal6GtSyryXEXXboEpw9A6RVGr+657oGqSw7b2EEYi1kFlFqrqtMkv
	AiqCPMjhRYwEMmJ5IPclfF3dJz/SUroYgxT/S/PvUlsLW54VEXdPLT1+SvRwPakNhjdt
	jYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ngfCwlYAJnrB4SwxhdmvY3jAzbIU+2IQncHAnt3Ac6E=;
	b=kjCzxgzQUb9BmIHQOHmOALzdikCB8OfB636hoYiGh4O3e+zVYbSwPuqsyzPd+L3sma
	WlmpbDfq9TRfWwUe43t5OMN3Bid26bPULNy3OIvQwDG+ktSgP5CBvQ/06a9hT4d1avEY
	UdK9863+2/reirkdYuSTvf6SwYLLPJZ7sPeGoTRbY2/Wf4SmlvDFzAU0eEz87TqLHIKM
	0fVA/84KMZk94eZjB89T2X8CICRS5LF4VWG/k7itGkEpgWV46iYHgpDAbrEuAChKP6kR
	BtHQ4KSQ8xEL55hk/X7UfWMezBujzECgMQbk8eoHP7VEOedhP0kJHevGBrE3qHztjft4
	YX3Q==
X-Gm-Message-State: APjAAAWZh4Bmk/YT9gSjffJq0n36Tdjh/WDIgjaSoza3YIFD85fONDO4
	giw/XyykSMRlcgtHND7LwrMqW+q6CgAdLHubecSTfQ==
X-Google-Smtp-Source: APXvYqz3v9y2w3BywpAI994NI11EAZMmrGzOCZTE+YBwkbJxpUc8GTTxezxTVUzUlIedg4PW2Js7fQfh17FZ0P8NjjA=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr2487069oif.98.1556616694338; 
	Tue, 30 Apr 2019 02:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-15-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 10:31:23 +0100
Message-ID:
 <CAFEAcA8PzZV0yDY6gONx+wwN8j52yPi6bEAM5C0NwVCkxd_Hxg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 14/26] target/openrisc: Convert to
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
Cc: Stafford Horne <shorne@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430093123.uDCYMW__WFxmqmyz23r7ISwAqwT3mMoYH02v9QwCOPM@z>

On Wed, 3 Apr 2019 at 04:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> --- a/target/openrisc/mmu.c
> +++ b/target/openrisc/mmu.c
> @@ -107,16 +107,42 @@ static void raise_mmu_exception(OpenRISCCPU *cpu, target_ulong address,
>      cpu->env.lock_addr = -1;
>  }
>
> -int openrisc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
> -                                  int rw, int mmu_idx)
> +bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
> +                           MMUAccessType access_type, int mmu_idx,
> +                           bool probe, uintptr_t retaddr)
>  {
> -#ifdef CONFIG_USER_ONLY
>      OpenRISCCPU *cpu = OPENRISC_CPU(cs);
> -    raise_mmu_exception(cpu, address, EXCP_DPF);
> -    return 1;
> -#else
> -    g_assert_not_reached();
> +    int excp = EXCP_DPF;

Let's hope no compilers complain that this assignment is
never used in the softmmu configuration (where the following
code always sets it to something else)...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

