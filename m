Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A470C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 542DA207DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VLDvV3ft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542DA207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kArh8-0006qA-Iq
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 05:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kArgQ-0006Lg-ES
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:25:30 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:39664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kArgO-0006d0-Ky
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:25:29 -0400
Received: by mail-ed1-x541.google.com with SMTP id c10so1123387edk.6
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 02:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H5xefrUnBvIyfsTK6oiWBLDD4LgQNL/PySRH96YrVQY=;
 b=VLDvV3ftZ3ac06RP1+OdiSgykaSi5KXZ8/QgTMQeQafALiGH9VEcDkgW+t6NT++edr
 o2dtPuVVA6lxUaJufqPa5i62bf2fA0pzlAPZB8QQxXGxJC0d93hA/ewPXCV9/nTQtGu4
 4ptU+rLbkS24g7BVdPt80Ko4a5DfCVP/QFLpa7HLrj7YL0EglFI8X/npoIqmzP1PUwS7
 5GnWVbQsXilySnjWgSO92ifo0CjJNgIUlZRJMIeUn0Ozn9wJrl0cTuYghCr1Ibvy1fhV
 vmLejSrODDEJg4wfkOGvk2uc+kadPQhtZFZw+bvTt0ftEkod3E+ViEXpMkB018jwtCYE
 VJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H5xefrUnBvIyfsTK6oiWBLDD4LgQNL/PySRH96YrVQY=;
 b=QKWwZyBvbsMETEpAjK86V+e+BEy+2ptbPZx/d6p3e0bgpdi8Lg59cZkWCrqYMiCgdH
 Y+J2UhPOWLFmN8C16icIiQEi/fK95z/IEjSVtvoBwmuHVeM5ECfrPo9nSQJNgDSArNJn
 y7dd1YqYrdBdQT01/moruk0egGqmGS4Z7CLl/ZFTgKS0O46nUGIp1D8Fh0vrh6yLyk8k
 xy+i64kTZw1kNSsk17sWx0inrsa8v4DpW3vOTzdVnANXliRoKgPp2IhN10B6W7ABbnDu
 SkqINA0p/OtZFHfQW3nYy9E+PnU7Jxb1UyOskS1ShF6r9opIgswCqR8nlAx1binOGfZn
 vPIg==
X-Gm-Message-State: AOAM531I2ArFeDK9QO533StyUEj4532qZ8qPqWUFpMtFBBxIRmV3OYdV
 jQqVY5edUb79rSikQrWt2Y2NTCnR/YeEPGhxlEKlIg==
X-Google-Smtp-Source: ABdhPJx86Up6dsNgsootQ+LX21iOS6lQGhmzkdJwP3fJOjqyvytsAUyb0U8u25pwDsXUHMJ1vksTKoK/oNYgBvDflZY=
X-Received: by 2002:aa7:ca14:: with SMTP id y20mr10640706eds.100.1598433927060; 
 Wed, 26 Aug 2020 02:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
 <CAFEAcA8=Mf=EPh__tNhJyGv8+ouD-HH+MuMb+HhtTFes+XqUSQ@mail.gmail.com>
 <CAKmqyKNxURXyNSEePPU1jY7FzcZjRThr2qAvwR393+nqUXBxJQ@mail.gmail.com>
 <CAFEAcA8x=ck1mmJ8Y8o-0NQXWhRgOg5Gp7GvHNkNnLb6rDxygg@mail.gmail.com>
 <CAKmqyKP6OUoaR6iZ6SD6qZPvYF0bKqpB_rRNeQOteg8BtcqKeQ@mail.gmail.com>
 <CAEUhbmWN93n1JoGszsW6WrkGbdFD6VsGyi7Ji6bS6wF+DbMOBw@mail.gmail.com>
In-Reply-To: <CAEUhbmWN93n1JoGszsW6WrkGbdFD6VsGyi7Ji6bS6wF+DbMOBw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Aug 2020 10:25:15 +0100
Message-ID: <CAFEAcA9026WV-t5Q9EbV-nZi+6GZ3WoKCx2tA9QeAXu5iD5ryg@mail.gmail.com>
Subject: Re: [PULL 00/18] riscv-to-apply queue
To: Bin Meng <bmeng.cn@gmail.com>
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
Cc: Alistair Francis <alistair23@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Aug 2020 at 04:21, Bin Meng <bmeng.cn@gmail.com> wrote:
> On Wed, Aug 26, 2020 at 6:41 AM Alistair Francis <alistair23@gmail.com> wrote:
> > Richard and Philippe review patches and some of the RISC-V patches get
> > reviewed by the RISC-V community. The main problem (which is a common
> > problem in open source) is that large technical patch series just get
> > ignored.
>
> Yep, I am only comfortable reviewing patches which I have confidence
> in. Right now I am not working on any H- or V - extension for RISC-V
> so I cannot contribute to any review of these large numbers of H- or
> V- extension related patches. Sorry!

So, everybody has a ton of work they need to do and only a limited
amount of time they might have for code review, so it's important to
prioritise. But I would encourage you, and other people contributing
to RISC-V parts of QEMU, to at least sometimes review changes that are
a little bit out of your "comfort zone" if nobody else seems to be
doing so. Review can find bugs, areas that are confusing or need
comments, etc, even without a thorough knowledge of the relevant spec.
(In fact, not knowing the spec can help in identifying where
explanatory comments can help the reader!) And for the project it means
we have more people who at least have some idea of what that bit of code
is doing. Review that is limited to "this code seems to make sense but
I haven't checked it against the spec" is better than patches getting
no review at all, I think. And it's a good way to build your knowledge
of the codebase and the architecture over time.

thanks
-- PMM

