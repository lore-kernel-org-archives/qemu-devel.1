Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8EBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D2520775
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TxUCPC7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D2520775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUqN-0001wK-KP
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joUpV-0000si-Rl
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:34:25 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joUpU-0004Px-0D
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:34:25 -0400
Received: by mail-ot1-x344.google.com with SMTP id n24so3591380otr.13
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 09:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=N17bkuZkabA2O6KzEXbzZaK6naHQPhGk75E/r9X9ghU=;
 b=TxUCPC7SI2zT7j/+q9e8XPx4cp9kwzS5YzXCQr0Hhe2iCD+BP5tfbiAegxYKA4wlUb
 zaimaY+50VtiSGtLWD7R+1yjGl1V98tCBBXiJBfH7J/IqX8MzEt4J/KKJwpn6RBjc/tx
 1H6G2ub6CB/oTW3qP+dFLpgmvliS+r/akgG8ch4m5T2Yznx6cjituFNJlJ2/xyyOo72M
 HQfrbHmY6kU4MMhcpx0E3sx3F0N3CYDjm9EBm7GJgZPjluofNz2jz4svWilPkKAlT11z
 kG8nZaqBoibHYyIMvVfogPxi4vVohh4R/TzHl8PHMbVjcp0L9gJj+XakbugodbCYTn2m
 Uf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N17bkuZkabA2O6KzEXbzZaK6naHQPhGk75E/r9X9ghU=;
 b=NN5j2AJGGP97LXcDMS5RFBoALCnl0Ii0yxN8hS4kkiL5u71Y1U2C8BMPZ1zTJCq+G9
 afi4akwYG8OLeC9/nOg6e2waEUVy7m6Ck+pfPfCQ3JTpI2t+xSU2+kI0PJgwz4AG29wb
 waY4GLmn7ghBrEDC0eSRhWHQ+MWToyH4mNSfFCkycdiGETBm0OMFEOs9XGCd4SbmHYqH
 cpozA/P5AT37Z41DpI1RxgBfjeMQOdLecA2eEOpkovLHcspMrXMzHz4x08EG8aUTVUvb
 DZsC+66HGaXDipzICXFaE7ZgxDILmjmwCUVfqxUpEU4/8RmpQltTwOp9CyrPvv6CaFGA
 J17w==
X-Gm-Message-State: AOAM5317latACoumTKipUgcUuSL8OQqX0ZI64RqksEQVrahRzsn78bbu
 HdtWZlDmq+Kpofqfv8CkYktDHsKkvng42QmAfyolyOy6NmI=
X-Google-Smtp-Source: ABdhPJx3ceiJ1IuP0W20QwiMQuhCgtgviIkxdB6LUL8K+dY+Bwy/XB5jGyD1LIHiDWYewsChZMYb2Y4wWlYLcJ2CRa8=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr26318361otn.221.1593102862427; 
 Thu, 25 Jun 2020 09:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200605041733.415188-1-richard.henderson@linaro.org>
 <20200605041733.415188-7-richard.henderson@linaro.org>
In-Reply-To: <20200605041733.415188-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 17:34:11 +0100
Message-ID: <CAFEAcA_ca4vAxB-2qfsXVUNPUdyFTJQtcBdkegn4ub8SOiR2TA@mail.gmail.com>
Subject: Re: [PATCH v2 06/17] linux-user: Do not use guest_addr_valid for
 h2g_valid
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 05:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is the only use of guest_addr_valid that does not begin
> with a guest address, but a host address being transformed to
> a guest address.
>
> We will shortly adjust guest_addr_valid to handle guest memory
> tags, and the host address should not be subjected to that.
>
> Move h2g_valid adjacent to the other h2g macros.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu_ldst.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index c14a48f65e..3930362e20 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -77,15 +77,16 @@ typedef uint64_t abi_ptr;
>  #else
>  #define guest_addr_valid(x) ((x) <= GUEST_ADDR_MAX)
>  #endif
> -#define h2g_valid(x) guest_addr_valid((unsigned long)(x) - guest_base)
>
>  static inline int guest_range_valid(unsigned long start, unsigned long len)
>  {
>      return len - 1 <= GUEST_ADDR_MAX && start <= GUEST_ADDR_MAX - len + 1;
>  }
>
> +#define h2g_valid(x)  ((uintptr_t)(x) - guest_base <= GUEST_ADDR_MAX)

The old implementation returns true for
HOST_LONG_BITS <= TARGET_VIRT_ADDR_SPACE_BITS
(because there's a different definition of guest_addr_valid() there)
but this one does a range check even in that case.

> +
>  #define h2g_nocheck(x) ({ \
> -    unsigned long __ret = (unsigned long)(x) - guest_base; \
> +    uintptr_t __ret = (uintptr_t)(x) - guest_base; \
>      (abi_ptr)__ret; \
>  })

Why the type change? This seems unrelated.

thanks
-- PMM

