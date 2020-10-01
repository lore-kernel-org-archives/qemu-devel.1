Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753C0C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 20:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D872F207FB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 20:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FbJa7uWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D872F207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO5Rh-0003Fy-Vi
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 16:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO5QG-0002O3-Lb
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 16:43:29 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:34931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO5QF-0003YY-1J
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 16:43:28 -0400
Received: by mail-ed1-x542.google.com with SMTP id i1so7088408edv.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 13:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/ZDqjKscR2h1brTW66ZxSqMk0uKUmy0MPLBI4j0VFAo=;
 b=FbJa7uWLVPKfL0uUo/HMQY9gevlHIYcD3fnOHEuVmJ5knFwz6ZyaKiz+0U/vVX5lvl
 JbEE0Yt6dXTB6xjUmr3mpV87qGQhjt/R77hNwmD8YyRyNbp8bfux5kJp/PUhOSQaRuAP
 xgRjyoUD5ZSi70AS7Ts9akMRfxAHpkFoTXB38xG69426INsBqQ+nvMtxKCMcrQZuWG4x
 mnikUzL12P/m6LAzjuz+sR75yRI7goeP036QwFQW0/zlDSEli2Dzee7+5zfeiLq1WfUs
 BJH6ZQ05T9VWk1HjO5hsjZwu+lO/lSztvQ7wG3TTJbldCbIyQrpRLGMCBzoljH/MSaer
 jECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/ZDqjKscR2h1brTW66ZxSqMk0uKUmy0MPLBI4j0VFAo=;
 b=rgL2A3ERASSm7ZxtIlRddebQBOl/V2XXf6oHziWwony4uDVD+44UWKwZTTPaLVOhUj
 Syi6wB1niyJMX8VMFTzbTQPFL3Yx+/tdkS76cZ1NHmkkQAJaHiedLOPIe3V971nFIaV6
 4C7F0nHhnstBNR3O2Ygcya2Uo8wkm+fMo/bBGJflcm5nctS19ChxB8XV0KgaTBy20Uiq
 AFQmRLabtxZxtZlNp/pG17P8gBNG7kxxawfUXCBZWOO2Zny4yv+P/8/0/ucoD06l/ksp
 4d/bnBc0mVm7VP9nB9u+LHKhK4cv/QSLN2Gg1GqPTXTvnvvmJVJklgtIGuzSNSEWjES1
 d6kw==
X-Gm-Message-State: AOAM530gvyEIqCva1QznUjKJXcwShX1deFw2np4iBNwlFLk1s/OF3jn+
 xpON/B4DAH+s26IrfYRGbrUNZxymB6WJP9kMoLLJ3A==
X-Google-Smtp-Source: ABdhPJzMBnUFb72erwW5Op7nIjxffs7QgJxlAqhUxFEf+yGn61M4L0jxFS6n++tCAGLTu7QObvnT52ZzvIfSMaOfbck=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr10644272edm.100.1601585001469; 
 Thu, 01 Oct 2020 13:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201001182121.187122-1-thuth@redhat.com>
In-Reply-To: <20201001182121.187122-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Oct 2020 21:43:10 +0100
Message-ID: <CAFEAcA8nQgvgdHE7G8b9sWP4kFeRZvseyFzFvOBFAp8O_A5Xyg@mail.gmail.com>
Subject: Re: [PATCH] hw/rtc/twl92230: Silence warnings about missing
 fallthrough statements
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 1 Oct 2020 at 19:21, Thomas Huth <thuth@redhat.com> wrote:
>
> When compiling with -Werror=implicit-fallthrough, gcc complains about
> missing fallthrough annotations in this file. Looking at the code,
> the fallthrough is indeed wanted here, but instead of adding the
> annotations, it can be done more efficiently by simply calculating
> the offset with a subtraction instead of increasing a local variable
> one by one.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/rtc/twl92230.c | 50 +++++++++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 26 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

