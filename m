Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BCBC352BE
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 12:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B828A20936
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 12:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmBsc544"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B828A20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP3VD-0007It-VD
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 08:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jP3UW-0006kv-Tv
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 08:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jP3UV-0003rB-Ss
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 08:19:36 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jP3UV-0003qn-JO
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 08:19:35 -0400
Received: by mail-ot1-x343.google.com with SMTP id m13so2853979otf.6
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 05:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5ZcsL05B1ot02DO4kYp6bZ4rMjBwIUOtktRMVs6NzEc=;
 b=kmBsc54465o72JnO26cLR08cEMimj71OeMpon2Ib/mDnwsb1E/8oWAr3A7ODnvMY8A
 ahtnSR+ZZegbcXzA/v5czG1JnAxnSUWwVO9bUs8VGKBsso3LBByzltklSpH129i6sTfL
 WrlV1PWJpdbTlU1BBtjSCk7tQIGxoXLwlMemrVZE5VPsrw2FrLqnDtn7tSqOFy9VNHIL
 1p+NAhdNuBtvxakDSBn/hdgWhdIZN1NhIY8hgpKqb7Nc38a2WPLjW3JYvHHcsTHudFcj
 DPrBy/vmtTTiePj66Jo16IMNnaSzNnWNY1cLZ/6TTgk1PWQKfZ5O5NsIRI9B0Ishmfzj
 Q3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5ZcsL05B1ot02DO4kYp6bZ4rMjBwIUOtktRMVs6NzEc=;
 b=W74AH92cfdajMPdKfIjMd8/+Xbn64qil4batV1H731glk/bhzdvaOZkoT7hS3EXBKW
 dU2IyRk0PrQUwC7XrC0f+tMdZOnymGG8zwKziMJQbf0EkMjOCKbDtH+Wbnn6zZR4UEn9
 uF5uz1KVZ5SpnbAnAFeSpza0QkO9a2csHR/SrjO9q/tovQ94sGRunBrutMJl7iMmoqk+
 ctiu77D3m9w1/B20I2PoWwteiYzt4fqLgoU1tmaybSzMn+7+kiRMS/4HwFnjt/jDp3QU
 jZITaCqrfanlwEquRloRd5LF3+31q5ZAW7XL89roH9fGh3oFzDTdqbZzrwZCJ1SutvEr
 74uQ==
X-Gm-Message-State: AGi0PuZfYRtnYM81IFhoahamYpCNaSqswm8FNUV8AgA6e41NsLTclOZw
 lpQ5r9DKmXWWAV4nJOxMTcL2tlDOTXfCtKr238YbOQ==
X-Google-Smtp-Source: APiQypIpI5+hnX9zx84fybrYOco0fqGnqaAC/nef/6TI2KQeeJZAcgtJ/g0CWURah4nkinHkXwb7LHEqI+DwA9rW2+E=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr7925564otj.91.1587039574221; 
 Thu, 16 Apr 2020 05:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200311064420.30606-1-richard.henderson@linaro.org>
 <20200311064420.30606-5-richard.henderson@linaro.org>
In-Reply-To: <20200311064420.30606-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2020 13:19:23 +0100
Message-ID: <CAFEAcA9D9cpx5vxtuaeVonFJ0NNKjMOB6viPuE0+ppGiqZSMFw@mail.gmail.com>
Subject: Re: [PATCH 04/16] target/arm: Use cpu_*_data_ra for sve_ldst_tlb_fn
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
> Use the "normal" memory access functions, rather than the
> softmmu internal helper functions directly.
>
> Since fb901c905dc3, cpu_mem_index is now a simple extract
> from env->hflags and not a large computation.  Which means
> that it's now more work to pass around this value than it
> is to recompute it.
>
> This only adjusts the primitives, and does not clean up
> all of the uses within sve_helper.c.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/sve_helper.c | 241 ++++++++++++++++++----------------------
>  1 file changed, 107 insertions(+), 134 deletions(-)

> +#ifdef TARGET_WORDS_BIGENDIAN
> +# define be_bswap16(x)  ((uint16_t)(x))
> +# define be_bswap32(x)  ((uint32_t)(x))
> +# define be_bswap64(x)  ((uint64_t)(x))
> +# define le_bswap16(x)  bswap16(x)
> +# define le_bswap32(x)  bswap32(x)
> +# define le_bswap64(x)  bswap64(x)
> +#else
> +# define be_bswap16(x)  bswap16(x)
> +# define be_bswap32(x)  bswap32(x)
> +# define be_bswap64(x)  bswap64(x)
> +# define le_bswap16(x)  ((uint16_t)(x))
> +# define le_bswap32(x)  ((uint32_t)(x))
> +# define le_bswap64(x)  ((uint64_t)(x))
> +#endif

Am I confused, or are these just reimplementing
cpu_to_be16()/cpu_to_le16()/le16_to_cpu()/be16_to_cpu() etc from bswap.h ?

(It seems a pity to have to lose the memory subsystem handling
endianness for us.)

thanks
-- PMM

