Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53488C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD4E20773
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vrM/RykY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD4E20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joVON-0005in-Aw
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 13:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joVNf-0005Cs-K7
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 13:09:43 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joVNd-0003ez-8E
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 13:09:43 -0400
Received: by mail-oi1-x244.google.com with SMTP id a3so5617136oid.4
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VCtLKjHDdYEXKPaRNYd1QCINSZ6kmh4o8EMfO046g/Q=;
 b=vrM/RykYT5oBdHbi6tF+ifhoZv2OxITIgVJueoVhbJ7XsV3/y6rnOfdd85NNwMsY4K
 /h6w1PQOxypOMmPcS2jENmRYnZE/1HGgUUy+oFg2340iMaWOzJh8giZZVObwOeVdzDTc
 TzH4CcuCjHjZJFWlrdVl5VGYB8OcsZtXb0D6abx6FI457Nv8YWwwpZIA09sABH7ga0e6
 PzJFYoPyP2Y0PTTZMg21rj5d8uKXjm7QcFc9kXh04DwRwTXnUYGFVRyez4usWJlkDoxf
 NlXynPD63SuWChx/MhDarwrpC119ALIBvMxRcSYs4fpWGS/4vFsntgS2tci5Cwd4qu28
 Bbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VCtLKjHDdYEXKPaRNYd1QCINSZ6kmh4o8EMfO046g/Q=;
 b=QyrgGMzqq0nc7yC4o52AJBEuobqC1BFyqaJc9tUqxak0pqKkpQZgWctgFQe6YOJL9x
 jXiyPGlM0iGLLjffU43YcWpqqTRoB8yEx9NVLIokMon8Mlw9uf8JGamoycqy8//ZB5uN
 tJvSliBp3YmShlGTYeXpbaj6ou0yH2TJyRq1Cfv37k8k9UArKslDipWsj9bwLj/s2DeJ
 6RWQQCf58m1xAGM3iCgpuJKpdtOzPanazXZzUP1mMlXeWLaMspWf9Y5ZJSye3pP2dfDZ
 PSFfZsRGB39imajEx1DL4zeYdhBMsTXG2wmSSoKMm1g4a7JsqDvS1NkpGm2+3KmQNbfY
 bsog==
X-Gm-Message-State: AOAM530fL3RRu18VZWnVXpglJ+mLSY/q8KjSwR8MIntu4xafsIcnfy6p
 DORyEvpQkyOTUgJqqDeH8qvl8gIZEmaTd5tGubg9Rw==
X-Google-Smtp-Source: ABdhPJzkw7hPJeH8I658vpQSwekdHphR/JxiQCfLWEERqf/4kFt0JtJUn5QEPCdBvslNoVyKoIxbAzIrs31gYtV/Tgo=
X-Received: by 2002:a54:4694:: with SMTP id k20mr3018771oic.146.1593104980015; 
 Thu, 25 Jun 2020 10:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-45-richard.henderson@linaro.org>
 <CAFEAcA_svDHEDP5g3aaEL6_b-8hy0AB8oRBWj=y6G1K_r6E9nQ@mail.gmail.com>
 <f15d6bf6-03ef-70fe-2f40-0665d49b0851@linaro.org>
In-Reply-To: <f15d6bf6-03ef-70fe-2f40-0665d49b0851@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 18:09:28 +0100
Message-ID: <CAFEAcA_qOznfoAWtXGh-85C86fSft5ccSKQKv_uVw6-9bD4Oag@mail.gmail.com>
Subject: Re: [PATCH v8 44/45] target/arm: Add allocation tag storage for
 system mode
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: David Spickett <david.spickett@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jun 2020 at 18:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/25/20 6:03 AM, Peter Maydell wrote:
> > On Tue, 23 Jun 2020 at 20:38, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> Look up the physical address for the given virtual address,
> >> convert that to a tag physical address, and finally return
> >> the host address that backs it.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>  target/arm/mte_helper.c | 126 ++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 126 insertions(+)
> >>
> >
> >> +    /* If not normal memory, there is no tag storage: access unchecked. */
> >> +    if (unlikely(flags & TLB_MMIO)) {
> >
> > Comment says we're checking a memory attribute, but the code
> > is checking for TLB_MMIO, which isn't the same thing.
>
> Comment is not trying to allude to Normal vs Device, but "ram" vs "mmio" in the
> qemu sense.

Oh, I see: maybe "if not backed by host RAM, then" ? I tend to
assume "normal memory" means "Normal memory" :-)

thanks
-- PMM

