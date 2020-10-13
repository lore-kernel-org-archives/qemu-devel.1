Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17BEC43457
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:43:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06EEE20878
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ikyoT2Zh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06EEE20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSR8e-0002OJ-0y
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 16:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kSR4f-00078l-Al
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:39:09 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:43801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kSR4d-0001JZ-0k
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:39:09 -0400
Received: by mail-ed1-x544.google.com with SMTP id dn5so837779edb.10
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 13:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l83+7C5w6SrBLDoIP7sfm4KiVqcNwbJfo79YId+KRcM=;
 b=ikyoT2ZhlT+JzMcAyoVfSTQE3Otcvg+lYn3hQS+C/OeEW9dRi0pEoP/i1OWcryjgBY
 dFTcW3UjKmfujVgWpECsMNE2m6+gzbecOsC+mihsS8D68u42Gnx1m7/IlvOoIfzss9u5
 Sjf4rjqrel75LtbbNFBhU4lajnsWMYeO56LnTSdcBHE5Ulc0Aflv+0FQ94A9JEVW3J+o
 2PoNHZ3LncXVP4xCt4BixID0kQl3qoZEpvRYKxW/L1S7WqW9U/cVdW0UM+EwVShFio3M
 cniWp4oRwtx52f/TpDV5KEmVPCr9PnlBO75CXQ+nhUjgBgFmFFbXBaExjbGDEbEs6QMv
 67gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l83+7C5w6SrBLDoIP7sfm4KiVqcNwbJfo79YId+KRcM=;
 b=MBTg2vT8Zz9xzxncUXf/nJLm15LC3TGDu90NnUkKDWQ+3knuPhYouvsbLX7OygsLGv
 6Iw23/MiYSE1j/iis6UQMRBvMTEkbDoHn0DIP4aITd9PVCS8rwGw2znZq87XKFYh9vYL
 LXzt5SvFAfI6EdmiNHiBOPfQmJQjmKSU+gqCkQgOwITntG+xKtVqUG3l+n+PNFWHMPvG
 UuoJOGO66rhF8iMl3uPUIYJYVnSBqy+JvbJQgjR3NtZUr2Nv24FvFupZsySPv+F3NCbH
 Tm8FobpaMjgo+n+vytkvqzFHbKYG3l0PPCicU3qR8JGbO/LHPoG+SkJZ2e2sBdTRB0dO
 2yvQ==
X-Gm-Message-State: AOAM533OCNhG2o4FuxYUKK8FRIpkTPaQjP3G2g0dgzTxvoSRb+G5Sf6a
 62NzpOii4skKXZv37PgmCbDAkUM8jd3Ci5iS42jh5g==
X-Google-Smtp-Source: ABdhPJx41XYYfDhXmY7wzRTFXLns99/nfRSF7Wadj/4GkXKKJfAtvGoZNKKWHUX1kRGKnNIQMWujkqtF80pell2Nfy8=
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr1608685edf.52.1602621544584; 
 Tue, 13 Oct 2020 13:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201012153746.9996-1-peter.maydell@linaro.org>
 <20201012153746.9996-10-peter.maydell@linaro.org>
 <dbba485a-b69e-9138-5db4-d146ceec3c3a@linaro.org>
In-Reply-To: <dbba485a-b69e-9138-5db4-d146ceec3c3a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2020 21:38:53 +0100
Message-ID: <CAFEAcA_v3f4meMrENphpXSHNz=dNBQDE0LA=_3DMjxvSKL6wnQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] target/arm: Implement FPSCR.LTPSIZE for M-profile
 LOB extension
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

On Tue, 13 Oct 2020 at 21:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
> I think these two sets of masking are confusing.
> Perhaps usefully rearranged as
>
>     if (!fp16) {
>         val &= ~fz16;
>     }
>     vfp_set_fpscr_to_host(env, val);
>
>     if (!m-profile) {
>         vec_len = extract32(val, 16, 3);
>         vec_stride = extract32(val, 20, 2);
>     }
>     val &= 0xf7c80000;
>     if (lob) {
>         val |= 4 << 16;
>     }
>     fpscr = val;

Yeah, probably cleaner.

The other thing I wondered about is whether we should
be setting vec_len/vec_stride for an A-profile CPU which
doesn't implement the short-vector extension (ie where
MVFR0.FPShVec is zero). But that gets a bit awkward: v8A
allows an implementation to make Stride and Len be RAZ,
but v7A didn't permit that and so I think we would need
to distinguish:
 * has short-vector support (eg Cortex-A9)
 * v8A, can implement FPSCR.{Stride,Len} as RAZ/WI
 * no short-vector support, Stride/Len can be written
   but the only effect is that some insns must UNDEF
   (eg Cortex-A7)

I think at the moment we currently provide short-vector
support for everything, which is wrong but wrong in
the direction that means more guest code runs...

thanks
-- PMM

