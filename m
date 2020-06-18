Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B91C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:39:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2248E208C7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vrV00q8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2248E208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlxZ9-0005ZG-BU
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 12:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlxYI-0004qx-BP
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:38:10 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlxYG-0003Vk-TK
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:38:10 -0400
Received: by mail-ot1-x343.google.com with SMTP id e5so5013046ote.11
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 09:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PZonbftaCDc63VNz4v7l9NUr5JjVM0m0avU1O4pKiyg=;
 b=vrV00q8Pb45VJGvX7JMC6N278bdqIq8hGN60sJDGCSBKkQpBBP1T69yAs+c5sgZmBQ
 u2CxBBb1jDRk8WSH2dUCXoJIlsx507EDpthEFGmuK6iWRbxVEpwRpQt2ZUgSukhZGfdh
 AhN0kFClcu8ru1JFJVH+o8C1/jMP2dQ37dBuBxTDnTfkSkAXLRtNKxWbtdgoG9ZPUHb1
 0PpDrqyLKrchgxdU/ccPdB1L5croo3PDjMugPKkLLXjXTG1vudqcBkuqK4PXG/RzyAbw
 S84RkujXj/k5CUpJa5hItYsd4OSQ/N5orLEQCHXhUGZxBvx4XgS4QsvAisQungypls7f
 0GMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PZonbftaCDc63VNz4v7l9NUr5JjVM0m0avU1O4pKiyg=;
 b=AMQFKzEpwtXwF5eofnd5XmT6rare5b+56flrmjp5XbNxjDvTj33XpduAt1+KJUIpz4
 G1xGBl9kXs1y/di1JRgdpQIS8RACamerCJXq6Eu8WjlWn93tC5rGQXxp//xKcbc5uImU
 LpEO6VuyNzCShggwdKd+pADwQLjZRGwASTjFn7FZdDd7Ps6/x3VnS2/sjOMfI2VYg0sS
 NHQptEMoDcoN3z0u92E5x3Y3ThwAlLc14bDqPMX6CjvEylMQG2MK6Bk5bwfBtEG+qSnQ
 CMeZJWYj3pID2F4CHMk0b7pBblyCQUyCicFeyd5t7JZAYi8Q3lvW8J4NKYj8NiMCCO7T
 ISgA==
X-Gm-Message-State: AOAM532RsMPDI1pCdmRXtbxgkxgSjNw0v9EI2JFisj7HjBuCLEHIOfo1
 RcnpMDlOx3UTEaoyo/PK4Op3rJSGdq/jNMOrnC6qOA==
X-Google-Smtp-Source: ABdhPJzna3dtrg2mvfrnF00tjI41qlir9UDCAll6n4a9UpwPftwuwR5KZeWf46wkJ2yZBBBdD+QxcQKQl+DyHu34rxQ=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr4238524oto.91.1592498287591; 
 Thu, 18 Jun 2020 09:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-26-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-26-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 17:37:56 +0100
Message-ID: <CAFEAcA9qwXRG8R+1QCjjx8Cqs3yCaDisWcpECTszZrVjKuJdxg@mail.gmail.com>
Subject: Re: [PATCH v7 25/42] target/arm: Implement helper_mte_check1
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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

On Wed, 3 Jun 2020 at 02:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Fill out the stub that was added earlier.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h  |  47 +++++++++++++++
>  target/arm/mte_helper.c | 126 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 172 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index fb92ef6b84..8ae80f3945 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1318,6 +1318,9 @@ FIELD(MTEDESC, WRITE, 8, 1)
>  FIELD(MTEDESC, ESIZE, 9, 5)
>  FIELD(MTEDESC, TSIZE, 14, 10)  /* mte_checkN only */
>
> +bool mte_probe1(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
> +uint64_t mte_check1(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
> +
>  static inline int allocation_tag_from_addr(uint64_t ptr)
>  {
>      return extract64(ptr, 56, 4);
> @@ -1328,4 +1331,48 @@ static inline uint64_t address_with_allocation_tag(uint64_t ptr, int rtag)
>      return deposit64(ptr, 56, 4, rtag);
>  }
>
> +/* Return true if tbi bits mean that the access is checked.  */
> +static inline bool tbi_check(uint32_t desc, int bit55)
> +{
> +    return (desc >> (R_MTEDESC_TBI_SHIFT + bit55)) & 1;
> +}
> +
> +/* Return true if tcma bits mean that the access is unchecked.  */
> +static inline bool tcma_check(uint32_t desc, int bit55, int ptr_tag)

It's a bit confusing that one of these foo_check()s returns
"true for checked access" and the other one returns "true
for unchecked access"...

thanks
-- PMM

