Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B719C04AA6
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1404A2084B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZ+l3HRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1404A2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58175 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL700-0005Z1-DP
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:11:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6z1-0004yU-Ac
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6yw-0006id-JS
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:10:15 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL6yw-0006hR-Cy
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:10:10 -0400
Received: by mail-oi1-x244.google.com with SMTP id k9so5349983oig.9
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=B94E7NZj0SFgoC2ulErXn1smjIswt7NK/HMwDHHoyJU=;
	b=DZ+l3HRxA0YftKkUK9FKeOHQNRN78VznE56GqUqIjy7Z9JZeMclKl88yImSs6fnKcr
	oGNiMUqAevvtMoNSVTFZlTNgEJu5Mx7RckIR0cREUwxDm9skE//JOpdhexrg/Fgl2rAs
	8ZKJJqm5ngLzngogCfTWWNX/SJ2zrqU+ZVZEfcg86WNtp/oVXWFWpbGOyC+lW2zJc3Es
	naOvLQ2lrSdEd010QrHbJ4FOkrPypSHvY+y2k59QGtCWZ85IJ3c8pz7sVetpgV6Ff0dr
	WT5sKWYpEnaYaLw+nI8xTBEbqZT24e/pB+77cUSZ9gAFs5aaVO2xrmSc/2ZbfeCe9ysU
	mbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=B94E7NZj0SFgoC2ulErXn1smjIswt7NK/HMwDHHoyJU=;
	b=nZ/suEuEZrOoZMYK0HtDGTcTdNg20n42qe48elpRNRgiQNXXikyWFb48E9D65vfJ7t
	96P8iLJH953qXNOi47191arPVS49qWhoEJj713AkINH/c0fCqZSWwW95S6XpgD6VSqvA
	ZBas/MMIdC+nOCqjmqoGXabbVNe3wKTK9exi/UIlyXVcbaV7X9angrxg2OlQkn3ASCNp
	t7iFqzBk6HLYXeIKz/KRgnSNwKnkmau2W8XhCfN6rkJ9xHHmbNs96EyqGwsvQVHy5uBq
	CCw1DmrLKD/h5psCmGt54jqCI3wElcwC8xh1onSfHmDRlGfOaEY9wq4e3C4jX7tFNkbp
	bdUw==
X-Gm-Message-State: APjAAAXktp0+htDHye0qzh99l8f5U2v0+MWFlC8kdWBg3sqnbeI+ThLC
	q4q88bIxRGw0NrUHi9p8XtrkF1JOK+eMPLFtD6IaQUiF+qI=
X-Google-Smtp-Source: APXvYqyJag/FiCbvO02t/7RC+PuWPllOisEuApUFBhCWbu4lt/0CE6RJQY08sh3dj3yY6EkstgioH/AHO5o3zcF9veo=
X-Received: by 2002:aca:4c88:: with SMTP id
	z130mr16315467oia.170.1556547009371; 
	Mon, 29 Apr 2019 07:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-11-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:09:58 +0100
Message-ID:
 <CAFEAcA8y47RpfpuwqagRDMTJpZLyVkhNV_NF0y6_qVhopoeAGA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 10/36] target/cris: Use env_cpu,
 env_archcpu
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429140958.JOl0qDKCH8SuYkMBHpB73yMQ5meraQIrNg-NVC0brpE@z>

On Thu, 28 Mar 2019 at 23:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/cris/cpu.h          |  5 -----
>  linux-user/cris/cpu_loop.c |  2 +-
>  target/cris/mmu.c          |  3 +--
>  target/cris/op_helper.c    | 10 +++-------
>  target/cris/translate.c    |  2 +-
>  5 files changed, 6 insertions(+), 16 deletions(-)

> --- a/target/cris/mmu.c
> +++ b/target/cris/mmu.c
> @@ -290,7 +290,6 @@ static int cris_mmu_translate_page(struct cris_mmu_result *res,
>
>  void cris_mmu_flush_pid(CPUCRISState *env, uint32_t pid)
>  {
> -    CRISCPU *cpu = cris_env_get_cpu(env);
>         target_ulong vaddr;
>         unsigned int idx;
>         uint32_t lo, hi;
> @@ -316,7 +315,7 @@ void cris_mmu_flush_pid(CPUCRISState *env, uint32_t pid)
>                                         vaddr = tlb_vpn << TARGET_PAGE_BITS;
>                                         D_LOG("flush pid=%x vaddr=%x\n",
>                                                   pid, vaddr);
> -                    tlb_flush_page(CPU(cpu), vaddr);
> +                    tlb_flush_page(env_cpu(env), vaddr);
>                                 }
>                         }
>                 }

> @@ -143,7 +139,7 @@ void helper_movl_sreg_reg(CPUCRISState *env, uint32_t sreg, uint32_t reg)
>                         D_LOG("tlb flush vaddr=%x v=%d pc=%x\n",
>                                   vaddr, tlb_v, env->pc);
>                         if (tlb_v) {
> -                tlb_flush_page(CPU(cpu), vaddr);
> +                tlb_flush_page(env_cpu(env), vaddr);
>                         }
>                 }
>         }

This file is a mess because it's old-school hard-tabs, but maybe
fix the indent on these lines while you're changing them?

Either way
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

