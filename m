Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6937CC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278F920835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XFyqFQeJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278F920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42187 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLPBQ-0005Kw-EN
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 05:36:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPAY-0004bY-J4
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPAX-0000UV-BH
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:35:22 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLPAX-0000Tv-5P
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:35:21 -0400
Received: by mail-oi1-x244.google.com with SMTP id d62so4826935oib.13
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 02:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=0rOz9v90VcHpr35w3E1y3epJ3xn9K0chK/VoN2Q7LTw=;
	b=XFyqFQeJQTN6cTZvXqH2fpmZpQEGhgPXw+tO4y8PdAqOzUPIgjjbAEYeqKvqwiqTyH
	rnPP3E2Xhm8tueF3YpgGHg0lGJywSSbnLsNdnX7P74IT/6nzatgOGO+Y+DE1xAEl+5Fm
	Dp9Dej64MbTLxzZHfG/gbHWXrTLmsPil1BsVQqzvo25pEji39PrMR1+eMIfG4NgG5qMl
	q3h9WjRyZq71CTdx/pEcCcyW/mZGWXtmU+AGQLhktx5H+/bni1B+xL8jiz+7ZNZh/Stm
	ZN9Jmy1gbPTDc5/DlOMbA2JkJsveUQA7vfGQb11HyssQtAde8IwRu+Umy3rSQgiWzmXD
	YSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=0rOz9v90VcHpr35w3E1y3epJ3xn9K0chK/VoN2Q7LTw=;
	b=uLK7oozbP+yqm4d3dlblRYzaUQMmsYf4oY9XBLsH2aUQ1FLvOXtDYPaFMYfc/NkA7m
	QyHB/1OYislYrW3QDFytL8x7mHwDBbeyNvjROq50+CIQKhjvZVWBwsBtDxNT+Z1hHqkV
	MCZf0iBHkFep/tRA8GKc2d/6oLMTpGbEP25DgiTSkYhDdSlOK8pRgkDQOzbuX6WVzqoF
	F/9Qd0bIpI7bVTeShZECKoCCM7qB0ymw4ziRsI+GX4EkaP1DAafeCsyY+r0kmSlvoUZz
	rv2rEEF6sc2MFL61pN74A9DDEOnZSx1/kP2P8dI5x1xesKfWuVL/y4lazybqdGUFK/zu
	Qs5Q==
X-Gm-Message-State: APjAAAUrNa3OtAh8zPb0EXRCvH9Hwb/rUgGBowfU9Arv/ABpX6rdFD3w
	DZLgjP8vEPMjR7+alpzDiCMf/O8AxFed94KAI+ZP9w==
X-Google-Smtp-Source: APXvYqxFjUsW8Ej6B3IHw7PdltaKcVhOBjonUSgWCaywco/cSNa4CqYsQP+dWA8hbPy6SjHca63Keu4+OFUcp+BQgsU=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr2495452oif.98.1556616919945; 
	Tue, 30 Apr 2019 02:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-16-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 10:35:09 +0100
Message-ID:
 <CAFEAcA_tgrZBuwcTZLKro-C4tS+vy5a0Bm7ZvZjr+yL_UnNb_w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH 15/26] target/ppc: Convert to
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430093509.pofXIYx4_9uk-QBBaPldsyYW2AMrk5FCzxLTjBDTjZA@z>

On Wed, 3 Apr 2019 at 04:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: qemu-ppc@nongnu.org
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/ppc/cpu.h                |  7 +++----
>  target/ppc/mmu_helper.c         | 19 +++++++++++++------
>  target/ppc/translate_init.inc.c |  5 ++---
>  target/ppc/user_only_helper.c   | 14 ++++++++------
>  4 files changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 0707177584..da73d3ee5b 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1297,10 +1297,9 @@ void ppc_translate_init(void);
>     is returned if the signal was handled by the virtual CPU.  */
>  int cpu_ppc_signal_handler (int host_signum, void *pinfo,
>                              void *puc);
> -#if defined(CONFIG_USER_ONLY)
> -int ppc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
> -                             int mmu_idx);
> -#endif
> +bool ppc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                      MMUAccessType access_type, int mmu_idx,
> +                      bool probe, uintptr_t retaddr);
>
>  #if !defined(CONFIG_USER_ONLY)
>  void ppc_store_sdr1 (CPUPPCState *env, target_ulong value);
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 4a6be4d63b..6865c0ca37 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -3026,12 +3026,9 @@ void helper_check_tlb_flush_global(CPUPPCState *env)
>
>  /*****************************************************************************/
>
> -/* try to fill the TLB and return an exception if error. If retaddr is
> -   NULL, it means that the function was called in C code (i.e. not
> -   from generated code or from helper.c) */
> -/* XXX: fix it to restore all registers */

Is this XXX comment definitely no longer relevant ?

> -void tlb_fill(CPUState *cs, target_ulong addr, int size,
> -              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
> +bool ppc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
> +                      MMUAccessType access_type, int mmu_idx,
> +                      bool probe, uintptr_t retaddr)
>  {
>      PowerPCCPU *cpu = POWERPC_CPU(cs);
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

