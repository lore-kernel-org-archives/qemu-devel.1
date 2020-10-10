Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EB0C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 12:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22142225F
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 12:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zn9Tn0r7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22142225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kREK1-00057c-PW
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 08:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kREIy-0004TE-O4
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 08:48:56 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:35496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kREIx-00058P-5H
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 08:48:56 -0400
Received: by mail-ed1-x541.google.com with SMTP id cq12so12221895edb.2
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 05:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B76CCZyfub1/rzmJ2i5V3y2lVks3/V4PSnEy43xna2s=;
 b=Zn9Tn0r7mrdW+aSa28GAI30iuGnbNVLsmi1jl8ujHexEcv18WT0xlzzOMyPdB9Nzly
 jA/CqFTRQqYFehd7xv7w2BRJVQFInKY7oaqTHTL2O/2X9XlxUNV9hgaLgrhy7J3i5gh+
 t0l6KJqBCAyo3cHZja0T7+IEfia5pnuRC1JvdF1TA5mXM+PREBoDpDKMXZW0I7R4h2bF
 LbMScc/Bb5NdV/OTHFAwspJd4JPms23brCMsFp4doxKkRxWR49/tMmDD9O5JyxMP6NtK
 y82Fd8MxXWx1fAr9aeMLA5HiEIOQmBikbpZhqBp2BSlmJbi0gopDdLz+MjDx+T0hRUkm
 pwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B76CCZyfub1/rzmJ2i5V3y2lVks3/V4PSnEy43xna2s=;
 b=Eolcz/okJVrlmgXnUFqL847INXbWGwqOAaux1W/rjJEoc3WHiwKXpTIfRnrFHK9yt2
 tfJ6STTD9T8TBcH4oP2/qyzoUoeLpgzIVXx8DqydrfmBePZF9w9smWFqFbqLA9NhqrcB
 EXv/qNpJEuC7JWJfvG0hqJunuKwBniX3X2B2BKZApU1N13TAkKqnp8why5cIdLvigias
 1dzvLbDjpS0I9HYz871iEHi+EDEjoWKikZp9Ohm5BoMS8bQ40mPqQKE7K1871XJllEtC
 EsgQsNxNNHCMq1j2+gfubKbkVRH9/pkKzvjhnR4NLkI/0P4LaVTuzo0KW4PELLVH9epK
 TnLg==
X-Gm-Message-State: AOAM5304w9XWrpxPBOfm7+yE9LRgCiaXSgiv3pbA/k29aA61u+I7Ks8/
 Z6pDYK3WQzPn3YhiZG3ODBDJkkrlQpcxyNrVLv6Rtg==
X-Google-Smtp-Source: ABdhPJxDeyPTGEA9e+7KqRTlR02g89tSybQm/Mhgif0Y6sJ5p9Lku9lIpLbj4EAMn7SXaj3S3afZB4bWk+jZMlz9BZA=
X-Received: by 2002:a05:6402:3133:: with SMTP id
 dd19mr1985123edb.100.1602334132917; 
 Sat, 10 Oct 2020 05:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201009144712.11187-1-peter.maydell@linaro.org>
 <CAFEAcA8BiQcJJr3hkzTqnFLpYtXf1xbDf+GpgvYnPjJr_FAEUA@mail.gmail.com>
 <21d142c5-d651-269a-8fbb-d35a743f1945@linaro.org>
In-Reply-To: <21d142c5-d651-269a-8fbb-d35a743f1945@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 10 Oct 2020 13:48:41 +0100
Message-ID: <CAFEAcA-+9UQ4RNU+rjmc=Mx4MecTVJd_FniS4Mr0Q_QL57e7hw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix SMLAD incorrect setting of Q bit
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Oct 2020 at 23:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/9/20 1:48 PM, Peter Maydell wrote:
> > On Fri, 9 Oct 2020 at 15:47, Peter Maydell <peter.maydell@linaro.org> wrote:
> >> +        tcg_gen_extr_i64_i32(t1, t2, p64);
> >
> > Oh, I forgot to mention, but it looks like extr_i64_i32
> > isn't documented in tcg/README. Is that because it isn't
> > really a TCG IR op, or just an omission?
>
> Because it's not an IR op.  It's the combo of extrl and extrh.

We really should figure out somewhere to document the
interface and operations that frontends can use. (Among
other important things, extr_i64_i32 is usable generically,
but extrl/extrh are 64-bit hosts only according to tcg/README,
so if you trusted the README docs then you'd end up
trying to synthesize this out of shifts and trunc.)

thanks
-- PMM

