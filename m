Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB78C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 12:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC653207DE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 12:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8VIieey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC653207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVRe-0002AI-T3
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 08:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQVQo-0001hl-Ci
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:54:02 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:37220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQVQk-0001Pq-Cl
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:54:01 -0400
Received: by mail-ed1-x544.google.com with SMTP id o18so5725927edq.4
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 05:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Yls9ZC0VO5ylKhPi7qnP5iii08Gb+4vluiuZKcCXoIw=;
 b=i8VIieey7xCEwnsQb0gUlPinVo0aiaUmHqp/EeDzidPhjC9Bhz2TUbJauDj79rMv9z
 h77oikGS7xEbsANKkeHN+HcuRKpKst+GgGCTuIuDbO7QeBiKwfUloAMxWAEt3narKfQh
 hwSidfvESaIFPwK2SGpHAmjbOyHCNH5nX4SpbgEejCkeYEltl2nIbsauunRhCfCA+5MK
 hTdbZ84+Ik3gnaq4UmUeq6Ze2J1O0e8xNPBq8kZNg0ZC/Mg5a4kUVDvH/+Ojoq9cxlky
 Aji3du38LNnXIskr+DbeAzljxG9zk+i8vdj8ovKWJERJWJnYRpEIOuIbzeYfIlj+f35q
 zqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Yls9ZC0VO5ylKhPi7qnP5iii08Gb+4vluiuZKcCXoIw=;
 b=jGnq4jmeAWDGnmCk3ZPPtgF80W5ijMHYggUc151Uu+yo91o6DSF9HCxG4071Y64hMj
 oV5N1PRNcS6jJZJ8mBGgK8oyS0HUOXU+sqbv7vV5KTjSPZtEdU9MKM6DZ8+0BS27IGYB
 ncYrZYEQGVHRBEeuknnnRwKPpQpbDGcpeURn9nTT752minUQ9mMNEERyfcOHd3uNQXiG
 gkKSKj1LKM2ucbStbqdAOrH2hIsNfywkpFvuIr2xdmmo6FWhTi9iM0f8v3qUx9DA5C0e
 WFvh+6pqVmOFy+4z+oca2VGqlOM2Tio6n6NFs0tQ6zhhoSKfhWOJTKyQ6PdodjWGkLXb
 kjPg==
X-Gm-Message-State: AOAM531YCdFgkYrbksqRd4trWTQCYmq1QOBwmO3/pcw6oAPIgk6Uh7OX
 I4p+XKmJZp4NH3L8SyPv5DFtnMk/bXQQt5HtD1atCg==
X-Google-Smtp-Source: ABdhPJwGR2xg96/sVIfK1Ybnhz7hU26jsoTcTP8uQPgs3nIob0AlgAJbujOGqr+x0rEztZHRaMYvE4M3RoIP9m0sP9w=
X-Received: by 2002:aa7:c7d7:: with SMTP id o23mr8756577eds.44.1602161636491; 
 Thu, 08 Oct 2020 05:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201001170752.82063-1-richard.henderson@linaro.org>
 <20201001170752.82063-2-richard.henderson@linaro.org>
In-Reply-To: <20201001170752.82063-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 13:53:45 +0100
Message-ID: <CAFEAcA9JbDSVA5rCNbdAXsytLcpAOJP8bnjqbugYL-EicFUXNw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] accel/tcg: Add tlb_flush_page_bits_by_mmuidx*
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jordan Frank <jordanfrank@fb.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 1 Oct 2020 at 18:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On ARM, the Top Byte Ignore feature means that only 56 bits of
> the address are significant in the virtual address.  We are
> required to give the entire 64-bit address to FAR_ELx on fault,
> which means that we do not "clean" the top byte early in TCG.
>
> This new interface allows us to flush all 256 possible aliases
> for a given page, currently missed by tlb_flush_page*.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> +static void tlb_flush_page_bits_by_mmuidx_async_1(CPUState *cpu,
> +                                                  run_on_cpu_data data)
> +{
> +    target_ulong addr_map_bits = (target_ulong) data.target_ptr;
> +    target_ulong addr = addr_map_bits & TARGET_PAGE_MASK;
> +    uint16_t idxmap = (addr_map_bits & ~TARGET_PAGE_MASK) >> 6;
> +    unsigned bits = addr_map_bits & 0x3f;

So this is unpacking...

> +    } else if (idxmap <= MAKE_64BIT_MASK(0, TARGET_PAGE_BITS - 6)) {
> +        run_on_cpu_data data
> +            = RUN_ON_CPU_TARGET_PTR(addr | (idxmap << 6) | bits);

...the value that we packed into an integer here...

> +        run_on_cpu_data data
> +            = RUN_ON_CPU_TARGET_PTR(addr | (idxmap << 6) | bits);

...here...

> +    if (idxmap <= MAKE_64BIT_MASK(0, TARGET_PAGE_BITS - 6)) {
> +        run_on_cpu_data data
> +            = RUN_ON_CPU_TARGET_PTR(addr | (idxmap << 6) | bits);

...and here.

Could we do something to avoid all these hard-coded 6s and
maybe make it a bit clearer that these two operations
are the inverse of each other?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

