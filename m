Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A907C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025F9206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BNnl7G5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025F9206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUp1-0008A6-9j
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joUln-0003tL-Rw
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:30:35 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joUlm-0002mz-A9
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:30:35 -0400
Received: by mail-oi1-x241.google.com with SMTP id w17so4784344oie.6
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 09:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SH5uWQM18zzBJk03lB86wlRTLsFrMGNi4yUPo/BbQA0=;
 b=BNnl7G5p3VN8GrbIktkbS8TYXolmXv+QuvsQVkoy0mjC7qT1t1NLgCJWBnE1J+3GMl
 5WSbBylbuF+i+pGYHQLigdU1zWSri2f4qXb2MHv2yHifFg2BuHm5gfjXkZnO0uXauy3W
 Wxt3zFCNh3c32RZtTytpqqbnOeR7uq5nSYnvBf2ZOhAF92CiCy59i8Do6OxhS8nesvi0
 j8EMZFeMnYUqrAlpJPWz1mWcaGhM4hBJ/ZSfyPDArgvmGCWKm3w2EVs20LM7rsT+ofKB
 epqrTaJR9HqF4j64eVlbiDox5Ia5WHFtr5vcwhhvgihHvIcI3xqMz1I6XF42AjvJ6K+Q
 puvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SH5uWQM18zzBJk03lB86wlRTLsFrMGNi4yUPo/BbQA0=;
 b=gmraG+7R9EC152FZcdF2Y5mQjnKt6bTd1zD/flZlqSdz47q070Gj35ybas5BY7l1VC
 c/NCBq24L/Ig+O7c/je3jz+XeFS6xuRIMRxqTvhxGK7Mih51l9HptERAhX/PrvcOedTK
 RXGIfAn7ysicWt2VOjfrgW+888+pMd4ZJMlvASQthaA/uz8jxCohnKgWLEN5pII3Px4h
 Ok7XiFJmQWmk2AECN+90WuxzgekINrtMwN5k4ojS7GGXKC3XYfUoLQRWAHIQu/GG5s9L
 7p76ehCvRHRhg/5o45GxVomsOvO5SJNV/vnM3kAZ7knPSWAC7XX0n4a2ec1x9hkZFreD
 o3cw==
X-Gm-Message-State: AOAM5302qnpoo6hBzcR4XH3BlA635CjkLR5kHBEkeiM1lx58IDOWcxxA
 jV3MLbdEQP8Qlh3Xx0r8kuD8rdx+/rkBejma8TCr9yKwXQQ=
X-Google-Smtp-Source: ABdhPJy9Y/DYVxxut5fz3bi/1+pNP3N5iOIV987D67n8MhhVTc+7pdmdToZebI72GM0Gd1oOjrDmAwJFeJvr9BO1wTc=
X-Received: by 2002:a54:4694:: with SMTP id k20mr2865797oic.146.1593102633270; 
 Thu, 25 Jun 2020 09:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200605041733.415188-1-richard.henderson@linaro.org>
 <20200605041733.415188-6-richard.henderson@linaro.org>
In-Reply-To: <20200605041733.415188-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 17:30:22 +0100
Message-ID: <CAFEAcA-T+Vg-3Ruz_8avQrL0KULavP+UoM+RrAF_Y6=t-sZKwg@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] bsd-user: Tidy VERIFY_READ/VERIFY_WRITE
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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

On Fri, 5 Jun 2020 at 05:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These constants are only ever used with access_ok, and friends.
> Rather than translating them to PAGE_* bits, let them equal
> the PAGE_* bits to begin.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/qemu.h | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(We really should either get bsd-user up to speed and
maintained or just delete it...)

thanks
-- PMM

