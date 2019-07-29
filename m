Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA743C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5028206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f3rwDjF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5028206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs622-0006fU-WE
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 09:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46857)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs61X-0006AU-RC
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs61W-0003dU-U1
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:49:11 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs61W-0003cX-JI
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:49:10 -0400
Received: by mail-oi1-x241.google.com with SMTP id m206so45294780oib.12
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 06:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=48qXEGD/D1bvNSdgzHiTnynOO+tKF9PunRPUFt7elKk=;
 b=f3rwDjF2u9ZJ8Jp97/Xzr/2NgNpBQTNUYuEuvmM7vnrtz2LR0e3Yku7QG84o059MhI
 G7ZQV+jxjk013lqWsxyD2WfK97z9ASHwezG7TxDwB59mHnSbI7tS09gC9hH4Tnf5fxZo
 3jIrrniFB9d2Wc9IFsM7VYpSeH9xbKpePIxViDYjOrmdwTjBRsrOfeJ1kUwqO6AQjxsG
 KENB8cGlbVycUYOeFoY+vQuSsGAUKoPlKQFS541oSAQe5oIygtLS2xnMjK4ElAyyOiIZ
 KJJopnI4K7z5NseuS/0iAB2PD7vtMla3T1/3C/eQKc/gDRZjO6Oxh/PER1VB2UEdNNut
 YW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=48qXEGD/D1bvNSdgzHiTnynOO+tKF9PunRPUFt7elKk=;
 b=mIzL+PxDEsL88jsB0vtU5cOG/70lbzxgJV8YkPkDxgtJ3UimbhepKM3HJmJbKIMcQT
 Hv/98V/jIfzDLPmoFzchYzWhPQUNg+8OQkFNGBJcd8n4M8UayWVEW7eM+Oj05Pbbjsot
 t9mNRSXj/i7dNUcOkV0uaR4lVX9a53Sws0pTkIqXHP79YMuU5kifNIGCgAnvxGaD+WrH
 c8U4cQsbrArjsRtg+vdc/yu4Chh1o4s3Vxy2skeiBBbc8YxgJf7rpWcHnigEtbaJU636
 Rj3Ny2m1pNAcsApr1nSUohBLx3iMu9QtXI/iXQ1sH8IezyBXR7sBAVLdbDmQSFddnuqe
 Gg1A==
X-Gm-Message-State: APjAAAWQW+RTw6wccWeplEwM7ZuiSsc5JfSHPCDYCNYaOgQ7AwavAYFE
 Cs4HTHeXMxB3I/6JKAgw/98Ha+q5y/d4A/DXR2ARfg==
X-Google-Smtp-Source: APXvYqzR6J9Ygqve4oYBD1IVBAsF6hds66FM+iw4eFuBPVRAY5MGdzu1LbFdE0tXARXDjIlCYcf/YEED6iPI7RqF/JU=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr34735519oic.170.1564408149544; 
 Mon, 29 Jul 2019 06:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-3-richard.henderson@linaro.org>
In-Reply-To: <20190726175032.6769-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 14:48:58 +0100
Message-ID: <CAFEAcA-1PzQSLE3jtan9_k9690tf9VLjfE+WWoL1xoKhiD9ASw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 02/67] target/arm: Remove offset argument
 to gen_exception_insn
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 at 18:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The address of the current insn is still available in s->base.pc_next.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c |  6 +++---
>  target/arm/translate.c         | 32 ++++++++++++++++----------------
>  2 files changed, 19 insertions(+), 19 deletions(-)

This works because all our uses of gen_exception_insn() are
for generating an exception at the PC of the current insn;
things like SVC/SMC/HVC which want to generate an exception
where the PC is that of the following insn are already handled
via a different function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

