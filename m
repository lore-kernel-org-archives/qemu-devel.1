Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB70CC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B933E24670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y+FvN7RT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B933E24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHjc-0000YX-Je
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idFyl-0006P4-Go
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:57:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idFyk-0000ir-Gu
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:57:15 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idFyk-0000ga-82
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:57:14 -0500
Received: by mail-oi1-x242.google.com with SMTP id b8so183414oiy.5
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 07:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g42y1xdNTGbwMgFf8iqh+p4XHfktr+cR3cfNR6JRJdo=;
 b=y+FvN7RT6lUSWta2MvoN/MLXzz8YZrZPW0ChJFsVYtq53oZT2f6I4xxMoSYXlU0smk
 pAyBDzivAOoCACZ6bDCcbGp+Nn4Lf96bGtgZ2wAyej8+6W4xbzrjPUcUeUhqLOR9Auc0
 ZDthYUM9/e8/WgrIzPXLr7u6BbT6+6g5ULGDPkykYC6VAAUTE9x3QfwmUrooAVpyfwaJ
 1qjY0gLDBTdHwaGwh2i9JskdHS1yLay8vtgqn2/000fSgmsL4Qbs3wFnwCNLx8wY7aYC
 b30UqmvX/uUHq8UpF15Py7KRvhATwOxZW+U3K/mHbLVdCfknM2b5XN9Ve3UlyNu+ZaAq
 K2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g42y1xdNTGbwMgFf8iqh+p4XHfktr+cR3cfNR6JRJdo=;
 b=HjHh53oRRdBZoSfQbYx/mL0HmnL2+kyL+xQY+iaVtCV8xYVkGMuBO//T6M3AFEh9Wk
 e1CXd5+LaVCvp0clycb5VrqSJWKE6vaFqDF9B41FnUKQ1QQAY3/dqU3L1/qhBcPumDbZ
 lFMWoHp4CGhLx7jwshWVFy9X7jLYjVtr7oyk2/JcgTd3T50RO3e2iB15ePFDw1AAz7Dz
 TozpDLSn0uRDOaE2p8harPYvbI7DTNl6mK/k/UghmvwAm1FLkQJCNtuyAJTn7TWY2MA+
 A9T2V+E+5yMljo/ATEVO0CVXg/+2emoYn+DOdTYHA3W+jHL9wNZohZIn4LDiapD45maC
 4+3Q==
X-Gm-Message-State: APjAAAVYy8jSYOyjKaK3uKYOjQbLhPXHzDBKprjuak2scpUS/w17iV1T
 12sDvnaLaEVtERYRhOFM45SmRZpQyGvpNGUj3xZXgw==
X-Google-Smtp-Source: APXvYqx4IW/HPd+6r7c52DGFJJlvNXCKOKkeHklkVBJcXffxgHvKqFY1FAc/c/lYOqwos3pka18yH8C5/LBdBIzuDGQ=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr13174595oih.98.1575647833534; 
 Fri, 06 Dec 2019 07:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-41-richard.henderson@linaro.org>
In-Reply-To: <20191203022937.1474-41-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 15:57:02 +0000
Message-ID: <CAFEAcA8iMOrUdNc5onHHR8_mvqcOC1M17QYXBr5bn_g_DF8e+A@mail.gmail.com>
Subject: Re: [PATCH v4 40/40] target/arm: Raise only one interrupt in
 arm_cpu_exec_interrupt
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 at 02:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The fall through organization of this function meant that we
> would raise an interrupt, then might overwrite that with another.
> Since interrupt prioritization is IMPLEMENTATION DEFINED, we
> can recognize these in any order we choose.
>
> Unify the code to raise the interrupt in a block at the end.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

