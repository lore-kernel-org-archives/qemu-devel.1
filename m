Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEC9C04AA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634A22075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtlMtLIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634A22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45194 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLRRr-0005Dl-Hr
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 08:01:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLROj-0002aL-Jw
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRB4-0002Qt-Eq
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:44:03 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLRB2-0002P2-P8
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:44:01 -0400
Received: by mail-oi1-x241.google.com with SMTP id l203so10971028oia.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 04:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=XEuUBHvT52CJ2Ip8Lz0wCjs5/i5nmSgDRjM4IWndL6o=;
	b=mtlMtLIKBHbqcVMNiSqSJI6z6uk27nE7x3vGNWI0/spZmMPX3DlMAv28o7UEg7VsBO
	W9XIJmYsvFnSylyegEvC1s0qkEacYdveD3kdbV9x3GRK7uYRd7ExXOozzCSzu6DkHf/t
	KtDP7ylOAbve9S7yaTAUJgeCUMC98HPwNhJ4mOySuGEn4kZ9/7at+I54tVdl4QSzulwg
	VNTn/XiRvsE9CLH3+CPKGt2iFSaULytyPWOfGQj7GHil8ogNtScz9r13MO/pJhluQ1Yr
	5pEhdHjRTrYitimEpbRbRJcr55CHXOQbXxJkIwPpTqfzhWFkeyFnLTgW20ZUBxA/FzNz
	Z0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=XEuUBHvT52CJ2Ip8Lz0wCjs5/i5nmSgDRjM4IWndL6o=;
	b=ETuzeZEEGBeRVr2422uVL7/n4Gd8a2WhueYR8TgfNL+MeAs32qK2Sbt20VbAxqmqXJ
	vGYcsOAnaUu0B6t+j8WnJbK+esEs19L+ZA9NN5zt8DVrfsu+SXcDxU91YIlHY9M6cOCv
	4HPA9zUqkE9oYvVgN9BbM1HVA9NMpnO02t0jLz/s2AvnxJa4wvGqc9bbAYFV0+h4/Hjf
	AkDzCQPKVWslGtDZdXcQATGJxC4uG+Eb35Z0qAgUR2m9GCkVIY3t5eq8EBG0vBS+AACr
	UjU0eWoEwCZM+takUl/NzTilstdcU0rKHSbyyGKATcx5o4I1cRWuAl/VCcEc+xLdXi9D
	iBYA==
X-Gm-Message-State: APjAAAUSTcIossGGLrKvvQaLP6L7CtOKTTMRo1fkl61uiJm2J8TFFsga
	0rjbDqr4WFFtGzCHj1ch5UpLzSY1PiUeAKaHXbSzrA==
X-Google-Smtp-Source: APXvYqyywpnsTyGCaTRSMQjNVsAxbSvygkyxJsVtPd2kox45mhZycQ9wmMuUyBO7hkzUO99Es69elqo2PZDh6udR+Uk=
X-Received: by 2002:aca:e054:: with SMTP id x81mr2640573oig.146.1556624638634; 
	Tue, 30 Apr 2019 04:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-10-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 12:43:47 +0100
Message-ID:
 <CAFEAcA-WRtet-ww==U4F6hxjJ9pRWVbqPAGHFPaMazyaUgTDGw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 09/26] target/m68k: Convert to
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430114347.W30G2zFvG0eZSPIRqYExMT6nFceqL8wwkfgsSrBbays@z>

On Wed, 3 Apr 2019 at 04:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/m68k/cpu.h       |  5 ++-
>  target/m68k/cpu.c       |  2 +-
>  target/m68k/helper.c    | 87 ++++++++++++++++++++++-------------------
>  target/m68k/op_helper.c | 15 -------
>  4 files changed, 50 insertions(+), 59 deletions(-)

> @@ -804,11 +791,36 @@ hwaddr m68k_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>      return phys_addr;
>  }
>
> -int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
> -                              int mmu_idx)
> +/*
> + * Notify CPU of a pending interrupt.  Prioritization and vectoring should
> + * be handled by the interrupt controller.  Real hardware only requests
> + * the vector when the interrupt is acknowledged by the CPU.  For
> + * simplicitly we calculate it when the interrupt is signalled.
> + */

I know this is just code motion, but perhaps we could fix the typo
in passing ("simplicity").

In any case
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

