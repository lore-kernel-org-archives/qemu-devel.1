Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D1BC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27F920801
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wd7KtQBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27F920801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ictnY-00023f-PH
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 11:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ictjt-0006zR-2d
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:12:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ictjr-0006CW-Mj
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:12:24 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ictjq-0006A2-CN
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:12:23 -0500
Received: by mail-oi1-x242.google.com with SMTP id x195so3234768oix.4
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 08:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O7zxnns45g/PqlaLvC0zluFyeYIq9ueCzPawLjJ2Kw0=;
 b=wd7KtQBZUXWCXoFLpeVmPM2yG03Y/cbrTiubxSkOvykVU0kCdjP+vbXSe7T7i302pV
 tJHo9TTZJAxjYblLJ8L4WSBdWaNSP8+pkogVaK6DmtjW5rGn+If2IqWZwnfz/fwy81y7
 7OOqLPYDjdPu0HyvQ3e2ljXGevOGYAFwCLDZs/SYrWihVv2DfoI5rplZkpb4psUOKUAB
 fwmdLZWc9/TahUKfSfR4Py2YafwxFEqC6sW9A5v6SXnOdE7MZDUvf9ejOapZG6C4xElQ
 LuDstYmScARwTOkPCUeAz+4Ut3OH7xv8xghIuLkxVbP8HJAbkCsE00Q0Bb9uAiZQac9U
 U9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O7zxnns45g/PqlaLvC0zluFyeYIq9ueCzPawLjJ2Kw0=;
 b=HYDpxhA5NNtivcpuo30r8ilMeRYALM2BwRpDdlcMFHuxc/7tAx7OEmPTrDpgx9p2YY
 FN8OgetB2cvO4nnwcZD428reLPgnsINGKMME4Ye7PP4u4NqjSBa5eLshPkyr/JoxAGWP
 nuERLJCa1Sm+V4o3bPjKyzXrN46dXa9WCX+4EK0qXxcloWlT+fyuTlBcAQGRHwoT81kt
 06Sx5Dls2gg7K+g01vSjEgAfUfh44/iOd99idNrricxh6lz8DHfnnBNs1jiCtCaM2FGx
 KHL9XKjpUFTmei3Fdc2IOwAr6sxLvt5N0h3wW0uyymfqw90Hax5rbaiyqRnhCY3YBtH8
 GN7A==
X-Gm-Message-State: APjAAAWQBgwD8WdCeU1bswVRmt00LP0l1FtR5xjQi6MviaqbbQSBl5Tv
 ZXh0eWV+tv+6Y253w/f8aaD/A9B7BpOF9PSxF78GTw==
X-Google-Smtp-Source: APXvYqyklXS72nO+9yNMJNrFXgceHwwIs7m+WQQT48Q9iFDMai4r/V650oRZQfHkonlP3JM7yPTQaFhoogmWJ/I9l2c=
X-Received: by 2002:aca:f484:: with SMTP id s126mr7442804oih.48.1575562340754; 
 Thu, 05 Dec 2019 08:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-11-richard.henderson@linaro.org>
In-Reply-To: <20191011134744.2477-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2019 16:12:09 +0000
Message-ID: <CAFEAcA-MKN5vJYTwF5fbQVvgC_QpfezG_S4Z1gF1Qxtc5NSNoA@mail.gmail.com>
Subject: Re: [PATCH v5 10/22] target/arm: Define arm_cpu_do_unaligned_access
 for CONFIG_USER_ONLY
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

On Fri, 11 Oct 2019 at 14:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We will need this to raise unaligned exceptions from user mode.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tlb_helper.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
> index 5feb312941..29b92a1149 100644
> --- a/target/arm/tlb_helper.c
> +++ b/target/arm/tlb_helper.c
> @@ -10,8 +10,6 @@
>  #include "internals.h"
>  #include "exec/exec-all.h"
>
> -#if !defined(CONFIG_USER_ONLY)
> -
>  static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
>                                              unsigned int target_el,
>                                              bool same_el, bool ea,
> @@ -122,6 +120,7 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
>      arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
>  }
>
> +#ifndef CONFIG_USER_ONLY
>  /*
>   * arm_cpu_do_transaction_failed: handle a memory system error response
>   * (eg "no device/memory present at address") by raising an external abort
> --
> 2.17.1

Isn't this just enabling compilation of the softmmu
arm_cpu_do_unaligned_access() on linux-user? That codepath
does a lot of softmmu stuff including calling arm_deliver_fault()
(which implicitly does somewhat more looking at EL1 system
register state than we necessarily have set up correctly
for the user-mode code).

For arm_cpu_tlb_fill() which handles prefetch/data aborts
we just have a separate much simpler codepath for
CONFIG_USER_ONLY which doesn't call arm_deliver_fault().
I think being consistent here about how we handle the
CONFIG_USER_ONLY case would help avoid having a codepath
that isn't very well tested because it's only used in
the odd special case of unaligned-address exceptions.

thanks
-- PMM

