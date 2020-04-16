Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A94BC2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:16:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62DF22063A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RyI4UX0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DF22063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP5JF-0003UD-Jv
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 10:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jP5IU-0002tH-FU
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jP5IT-0004mc-42
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:15:18 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jP5IS-0004mK-VW
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:15:17 -0400
Received: by mail-oi1-x244.google.com with SMTP id k133so15948913oih.12
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1KdzUyR24JGyuSdT3X2ybdEiBULSA7QQZx8pJoHprqU=;
 b=RyI4UX0fuYfWjR4CkrmrA0aq3YkfM77uaZHUFeisnAIoaTGLhyUp4o1taUH+QgFd+v
 kdlhxMGhxBrXWdS5otHqAwcUdXMRErN68vcA5HstyFBfw0zwnQ7u3z158XJP2V/vcfPY
 c04/4whWpJsQKBRztILNGRMxOcMTuDIPkdhEa+w5to20BqEfKOV24umqdRZ0cpGZeAZB
 dH91jKoJOnWx9IZD/Ir3nmagYxXjP0y1lYkNgL7JcP3Psy2/ERzcappmxSXuwq4OzM5O
 2Z04uxtDm7dFugh+iv6WTCVaY4KOcB4yIl7aEx2LepEbzDVRHSVYrJBgn3scBBqq2CIE
 MI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1KdzUyR24JGyuSdT3X2ybdEiBULSA7QQZx8pJoHprqU=;
 b=adSk+AKXkBuXyqnVxpPkkrvZr0yeJkaEc8kNO2vwzr0WIN0bqrIx+lyjPY04cdzyVY
 +iE0AQuVhUlk6S76EA0OP1S6hexPqhv/4+S4lLXdSHip3yUbws9icI0/2nncjknIgE53
 r2gxykxN4uUFBnnEJXIGeLk/fK4V9XxHCGNeuVejDIo+h0MvqYF9DSaAa/OjOjYPS8gI
 ihaizLKzOXW0Jltaa0rwasXOshgyXLmfXkRNN0A5UL8/n7kJFZ9VUq+SwgrOENSlW0Yr
 rlcYMt/f0/vqF/bpW0WmnI21YY1DyBx/u/7tUO8ZwanxDOPfi4+9NXpfnnmFoYfpA8Mt
 j5+Q==
X-Gm-Message-State: AGi0Pubm6FHvv+tQrfe7o4tLdtDIkKe8+R10uGyVP9A+OgidFu7hPhE/
 Lo1Ah+l0jbaDbtCC4ocz+LSR2nrudz9yF2RO0WOktQ==
X-Google-Smtp-Source: APiQypJ7eL055cve5g42t8iSA7rBoE0lKrH04uVWahTBGoB2CxIxx0YEECkrtOKHR9/I8g3C02R5u7Eg0Ur4MoKeqGU=
X-Received: by 2002:aca:dc56:: with SMTP id t83mr2870836oig.48.1587046515773; 
 Thu, 16 Apr 2020 07:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200311064420.30606-1-richard.henderson@linaro.org>
 <20200311064420.30606-12-richard.henderson@linaro.org>
In-Reply-To: <20200311064420.30606-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2020 15:15:04 +0100
Message-ID: <CAFEAcA_V09rpr4X_TTZgo+v5Dj1yZR4zA9-94q+C5xikkhM=BQ@mail.gmail.com>
Subject: Re: [PATCH 11/16] target/arm: Update contiguous first-fault and
 no-fault loads
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 at 06:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> With sve_cont_ldst_pages, the differences between first-fault and no-fault
> are minimal, so unify the routines.  With cpu_probe_watchpoint, we are able
> to make progress through pages with TLB_WATCHPOINT set when the watchpoint
> does not actually fire.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

>      /*
> -     * Perform one normal read, which will fault or not.
> -     * But it is likely to bring the page into the tlb.
> +     * From this point on, all memory operations are MemSingleNF.
> +     *
> +     * Per the MemSingleNF pseudocode, a no-fault load from Device memory
> +     * must not actually hit the bus -- it returns (UNKNOWN, FAULT) instead.
> +     * If you map non-RAM with Normal memory attributes and do a NF
> +     * load then it should access the bus -- but doing so is illegal.
> +     *
> +     * While we do not have access to the memory attributes from the PTE
> +     * to tell Device memory from Normal memory, we can validly assume that
> +     * non-RAM has been mapped as Device memory.  Thus we indicate fault
> +     * on all MMIO.

I don't think you can assume this; for instance a QEMU 'romd'
device might reasonably be mapped as Normal memory but currently
be in "send all accesses to my read/write functions" mode.

> +     *
> +     * Similarly, CPU_BP breakpoints would raise exceptions, and so
> +     * return (UNKNOWN, FAULT).  For simplicity, we consider gdb and
> +     * architectural breakpoints the same.
>       */

thanks
-- PMM

