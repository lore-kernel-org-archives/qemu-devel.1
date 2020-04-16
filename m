Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50297C352BE
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 13:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DDF7221F7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 13:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDuEUHU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDF7221F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP4gU-0005ZU-AN
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 09:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jP4fo-00052y-NK
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 09:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jP4fn-0002f4-Kb
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 09:35:20 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jP4fn-0002ec-B4
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 09:35:19 -0400
Received: by mail-ot1-x341.google.com with SMTP id w12so3003840otm.13
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 06:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L+sivtUmB4ke3NE7Mvcacf+YLKZ4pVL+BKFoydhn23Y=;
 b=PDuEUHU/4U4rEatLdiJuprkE4hilHvPnsbZ2IE5A7bo4UzmJ4e4Z3OuGmbVwfKQShA
 lWtITCuMb5BqBgATx1bmSEXP6TFE8DzATb0/Ll1tXjMjEng+QN3NV1DgXzLZfpG7Y44k
 +LvOXLorTP7TExx3fhHWqBQfkY7R2HFhtlpu66i88/z6xkipbxqzrDFog0Gwg7H0bgXm
 AvGSeZcnYoJX4yjyWuR9+tQtoNQsChB/3FLMe94r/aU6uShyVqLi8+fRhpN69QbSvUb8
 +wKP1DiQFeUhucIGXvC3f3jMu0lVGtOzq3zOs4+JSi01D22tkvmAkMmnt61J2jtZWhdJ
 nuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L+sivtUmB4ke3NE7Mvcacf+YLKZ4pVL+BKFoydhn23Y=;
 b=kaiKbGzmvRYhdnEDZa+h2FX7dBM/6viLkdTArCRPMtFquxPEMJjiguFJtGwDqSpGyz
 SoTKzlQ0xo7uaS+dzonJL+BdsAljrBEueo2Xxek5rYotDroUyHuGjrJj3M7M4m9UCNTv
 tdoDdtBEGFyaTMBZjhZ+qkuoSAGJgc372O8nDkGuGsuzkXm/CqunNEFP9tUcQ1uSCCCE
 3g82doDpW56A85h//vCQ/nyB703LgWqUFG6XquhEtz6rLSTDWtx+bZp3c3rK40QL58Yj
 F7xaUlsSgO43DFN5xT1h6JwgSKtOAQoMjO/he8T1Hf2TMgxcKr6xyG4MGy0xWveU7XH0
 Oqmg==
X-Gm-Message-State: AGi0Pua7NrMezqX9ed9CnFoYWxY9JXZHxi2+xIWx/difhW06PqOyCVxp
 adrTqucrTT0oFlICE9pJUGSxQCvjf4Ao4V1k6M8lIg==
X-Google-Smtp-Source: APiQypJP0uREpMCT1Kx0cRaSwSJejYPSE1F8ygRCnWN8vS3tRWGkY6xhGID0gQImErdAnFzCHyob4mxefMLMKzjDj3w=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr5269229otc.221.1587044118130; 
 Thu, 16 Apr 2020 06:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200311064420.30606-1-richard.henderson@linaro.org>
 <20200311064420.30606-11-richard.henderson@linaro.org>
In-Reply-To: <20200311064420.30606-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2020 14:35:06 +0100
Message-ID: <CAFEAcA91-jPRjasTfPiGaNPwiF0Mye-vUU1p8YG8tWyU4yC8fQ@mail.gmail.com>
Subject: Re: [PATCH 10/16] target/arm: Use SVEContLdSt for multi-register
 contiguous loads
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/sve_helper.c | 223 ++++++++++++++--------------------------
>  1 file changed, 79 insertions(+), 144 deletions(-)


>  #define DO_LDN_1(N) \
> -void QEMU_FLATTEN HELPER(sve_ld##N##bb_r) \
> -    (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)  \
> -{                                                                   \
> -    sve_ld##N##_r(env, vg, addr, desc, 1, GETPC(), sve_ld1bb_tlb);  \
> +void HELPER(sve_ld##N##bb_r)(CPUARMState *env, void *vg,        \
> +                             target_ulong addr, uint32_t desc)  \
> +{                                                               \
> +    sve_ldN_r(env, vg, addr, desc, GETPC(), MO_8, MO_8, N,      \
> +              sve_ld1bb_host, sve_ld1bb_tlb);                   \
>  }

Deliberately losing the QEMU_FLATTEN here?

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

