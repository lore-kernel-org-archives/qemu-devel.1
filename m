Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453C2C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114DF21872
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g/LnSktL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114DF21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoVAC-0006bv-6W
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 11:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35955)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hoV9y-00065i-Rs
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hoV9j-0007SE-Dv
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:50:51 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36860)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hoV9P-0006cM-KZ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:50:34 -0400
Received: by mail-oi1-x244.google.com with SMTP id w7so24568926oic.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 08:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eKAneQqh9tb5eznJCVBNbLCzAgEfmTbWdzTld/2OAKU=;
 b=g/LnSktLZXAMVkb3lPbupWuH1cqBRIIN7GacfCAQcnGH2l897/5zg2CVfBAh4iZ96F
 Dp3Wq1mRN65fDZmkblwi4eoQWZCA08Ffvd7c7qyAw77qEiXIP+sxmC5pJ7Zh5AGljNoY
 5dsxsHjkckLsmvFPSAvcYnxSzwM7AULmpWdQq3n3tHpHNtBNy/DxdHlGDMnMFwLWECK8
 Gp39kDxa3H8NrIXLb77Nc46jTeT17ECGvweWvwU6CVNa59EZItOUOt11Gakz+zQ8E56P
 SiEA/HIieWSJe0lo6XGnKHVsgAQ4EHwHHhKR2pRMFkdwApblfeUIPc1Hp0F+BT5IGqnL
 OxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eKAneQqh9tb5eznJCVBNbLCzAgEfmTbWdzTld/2OAKU=;
 b=ZFn9il7KD6qq2bVjJEkiisnxQbp1vUhSrkAjY7RpmCFN6WbIqlAB73NA+LYRi+LZSk
 wHAzNsQQ7hAYPbv86BwiGTZAY2PkyNvs9rTz5JtX2L0Na6xkPl91psQQTPEmb/yDwE38
 mH5WfQEBBzK1wf2sS4Futo30QafUv/QRXvC1NPUJMnv08yuQsgKmwOhBLd4SOE5j7Q0W
 7QPU2u8hOHMCZbD1zs1TvWBy9ATS50pBDc/DLf0fo3fcBOEWhJgx7gHOPblk+M8lXQNL
 PkhHTs12esCtKDMbkdQjhnrZbqzDLT3Xo+pP4GMaQCjAGrRBq3psFp3iFPjlGrESTAgH
 20/g==
X-Gm-Message-State: APjAAAVfY2CuRNVrm9s0y9wm9Rk/lQFeyKkgp4H9nWU0jnN0FYXp2m6z
 oA6nti68U24XhNXlkaZfzc4lA+0uTcGhLfn695zr1g==
X-Google-Smtp-Source: APXvYqxJ8eqUXKnsJ1Uu+hAs4xO0OioQI4d0rJZ799a6TqRHaUaTPEa89BpLblob29nIJY/eWIgeLhCI7ZRdHBRJfgI=
X-Received: by 2002:aca:6185:: with SMTP id
 v127mr27658031oib.163.1563551335547; 
 Fri, 19 Jul 2019 08:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190307170440.3113-1-richard.henderson@linaro.org>
 <20190307170440.3113-21-richard.henderson@linaro.org>
In-Reply-To: <20190307170440.3113-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jul 2019 16:48:44 +0100
Message-ID: <CAFEAcA9R8kDqLxVVFjJFx_tuNFYXJWQDCv2vEyuBdLXtjMETWQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v4 20/22] target/arm: Create a TLB entry
 for tag physical address space
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 Mar 2019 at 17:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    | 45 ++++++++++++++++++++++++++++++++++++++-------
>  target/arm/helper.c | 20 +++++++++++++++++++-
>  2 files changed, 57 insertions(+), 8 deletions(-)
>  /* Return the address space index to use for a memory access */
>  static inline int arm_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
>  {
> -    return attrs.secure ? ARMASIdx_S : ARMASIdx_NS;
> +    if (attrs.target_tlb_bit2) {
> +        return ARMASIdx_TAG;
> +    } else if (attrs.secure) {
> +        return ARMASIdx_S;
> +    } else {
> +        return ARMASIdx_NS;
> +    }
>  }

Playing around with this series, I have discovered that if
the board model doesn't create the tag-memory then target/arm/cpu.c
will not create the 'cpu-tag-memory' AddressSpace. But nothing
disables the usage of the target_tlb_bit2, and then when
arm_cpu_tlb_fill() does a tlb_set_page_with_attrs() using
an attrs with target_tlb_bit2 set then we assert in
cpu_asidx_from_attrs() because cpu->num_ases is 2 and
cc->asidx_from_attrs() returned an out of range number (ie 2).

Is the tag-memory mandatory for MTE? If so we should either
disable MTE if no tag-memory is provided, or else fail
realize of the CPU; not sure which. If it's not mandatory
then we need to avoid asserting :-)

thanks
-- PMM

