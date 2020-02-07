Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97D4C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA6CF21741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u8btnUOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6CF21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j07ml-0005cr-Sw
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 12:51:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j07lZ-0004EI-U6
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j07lY-0004Wn-Dl
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:50:09 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41633)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j07lY-0004Ub-8i
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:50:08 -0500
Received: by mail-oi1-x243.google.com with SMTP id i1so2776593oie.8
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 09:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oG7cjaxvE6O9JEseTahxhg2dD3nv7KpE1DmTnT6lWIs=;
 b=u8btnUOoo3WVFYZ5lz7IzNUG8Wu4C+h2LDpajkp8WjW0vT+fSRB0kH2DLqi7cOrRdW
 uVKn3NvWmgbzg7rQqMBPgSvo3Tp8aNb6tX7LTzUiKXeJQ/w0lrZCOC8o1+qKbF8d5Cev
 +sRJw1h0p1GnZjwmAMDDUqcUDENfY7C9pPrNcEcXlfPJw03LIiu6IgKAjF3hJHaTGkuw
 srPeCvw2pWAA1pbyHZyc6dmR0mYiWOcxU6VS1AVAuTGCw/oVUWh4X5baJlJUfMMxKucp
 jxcLisYIJbqeIbAscF49DHvEx2WlbokpjJg6AObPz4lKWqRLXOyWq3VMWxSsM5EVsmMj
 FZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oG7cjaxvE6O9JEseTahxhg2dD3nv7KpE1DmTnT6lWIs=;
 b=E1UOhs1TMOPqFbD6+I9OgyQnjU6JNarj109Lz/hvja/w5WSxiE2Ee5NVrSWxn9rocj
 5q4CwJfSC+47QDOsveKESJexg5KstRgvPtB8vfmhbEd0P7GAzYTl1Ruo2L+9SIq+ZsXc
 wVAuQkIlz8QLpX5ziaEBgFIUbF4GPuhKIKQyuKK6CyRFGpUXi2YcNFqKBKCMniJne/B/
 9iDj4gXcTL1SGeisP6CE0IdwsgPHEsXy9zxVHg5f9WKn5FaOAh9X2l0jy8nOtXTQfBGb
 Nb1JkzEIUbdPX7DVpTdTq7bmwp6gAbGYIkvVJoI8OuLbzbRHaikvagOkhCF//kw9DdyU
 Kebw==
X-Gm-Message-State: APjAAAVSheEzLddNf9PBX8dtDxi9MC6MsX6cmIFzM4Y3E319A10QX+pW
 EMA/4q9e+L2AWwuaqNBMf2aqFKBUEpDy3V2XF4swMA==
X-Google-Smtp-Source: APXvYqyJmVigK1wvrTZWcLcDMvZRgLO5c9GgdmdwmN3J5UE3CKDQrqXrOsAlD8stshI1FcBYX7AmCF64gSG1/deeoh8=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr2756701oie.146.1581097807064; 
 Fri, 07 Feb 2020 09:50:07 -0800 (PST)
MIME-Version: 1.0
References: <20200203144716.32204-1-richard.henderson@linaro.org>
 <20200203144716.32204-12-richard.henderson@linaro.org>
In-Reply-To: <20200203144716.32204-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 17:49:55 +0000
Message-ID: <CAFEAcA_SyqsXCoGkZ0Z=iXtk-nbxe5=78HpvjJdwaO=c4tkrpw@mail.gmail.com>
Subject: Re: [PATCH v3 11/20] target/arm: Update MSR access for PAN
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 14:47, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For aarch64, there's a dedicated msr (imm, reg) insn.
> For aarch32, this is done via msr to cpsr; and writes
> from el0 are ignored.
>
> Since v8.0, the CPSR_RESERVED bits have been allocated.
> We are not yet implementing ARMv8.0-SSBS or ARMv8.4-DIT,
> so retain CPSR_RESERVED for now, so that the bits remain RES0.

...we removed CPSR_RESERVED in patch 8...

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Move regdef to file scope; merge patch for CPSR_RESERVED:
>     do not remove CPSR_SSBS from CPSR_RESERVED yet, mask PAN
>     from CPSR if feature not enabled (pmm).
> v3: Update for cpsr_valid_mask etc.
> ---
>  target/arm/cpu.h           |  2 ++
>  target/arm/internals.h     |  6 ++++++
>  target/arm/helper.c        | 21 +++++++++++++++++++++
>  target/arm/translate-a64.c | 14 ++++++++++++++
>  4 files changed, 43 insertions(+)

Other than fixing up the commit message

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

