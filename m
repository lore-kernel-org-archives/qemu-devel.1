Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF0FC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 17:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A16BC20640
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 17:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8ItNsW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16BC20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibplR-0004Qe-Q5
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 12:45:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibpkI-0003dc-Kf
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 12:44:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibpkH-0002ix-9n
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 12:44:26 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:33934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibpkH-0002iU-45
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 12:44:25 -0500
Received: by mail-oi1-x22c.google.com with SMTP id l136so471556oig.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 09:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L/OQceRW1bkzHkgGcsWhik4ob1xjBqqDcVG046qg/6Y=;
 b=Z8ItNsW7bscMSGPQWc0JXU04nSp7yhKKk1vE9CVN5X13FXakoGlaj2ELC9AlD2L6mI
 m5UF1I8rOvw+bIzBQ1ZXBOpM54OdCR2OdNhG3w9nMv2XDC4YKCO+/z1aruQQ1nwam5q8
 Yp7nkttYvC6O1A891u5Tnf8StXHq+MiJ5Gtq490seNTbJvmJvIUkdZ/LbSKZts3L15EF
 jGGnj7Ei32iZnQe9q/y3t5V1OQGUOAiU46TUNQcOuYiJoDEJX+Yrv3cHF59LSeJu8O4b
 Z3p9BvYwYlUCs6PPM6Wmq4bsknUJwdiHyPG9hFKBLJ2fdnp7aNPBnygnjcVw6s4+AfnY
 /qvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L/OQceRW1bkzHkgGcsWhik4ob1xjBqqDcVG046qg/6Y=;
 b=Aw15cerb5+ddSs3l9nfCQdtNycYPTphdBV/vAgcAe76uM8Y8HjLJ/du9Wa/v1Y8oQG
 Hw7nb1+GLoycPRvJiz9W67CmIvpjuAZcMqV/F9i1jFGgzsAYmHCAe9hSmx1exBdoJiqO
 edkm303Pu4QAVkIqIv1K9dZ1sToa0nPBBhC1wi8N5/qekAE7nSgR5V6lhl0LL6RYQndr
 0rnyAtqTJQSu7b8Pjjr0iDE3RUdqhed1skq0Q/NOiyhSLAm9iLi95XTaI0neR10imlpj
 soanP00zW/wt+6PH7U+Qdegm3Mll+ccJSAVGVNSnPokWaGGLRXW/HtlvI2fvdcA/nM+k
 oQEw==
X-Gm-Message-State: APjAAAUgPsbrTY7iFcKR9FkOEMbkB2qLtnKrgtd54cyNdigXZkSCWrpO
 jpQHA2Ts1eorXFZbvTcj5AkkghYo4qK6lIzu0w12fg==
X-Google-Smtp-Source: APXvYqxQ/dnujMFsiApz3wCLmMfLWddpoFyB5tuTNsBb1qsDBycKeOaHMUec4fk3yJrm3+pXM6kaeovgTdmjjFWwZRY=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr198823oih.98.1575308662864; 
 Mon, 02 Dec 2019 09:44:22 -0800 (PST)
MIME-Version: 1.0
References: <20191202060806.77968-1-david@gibson.dropbear.id.au>
 <8b490fbe-2b09-2a2c-16a8-6739ce6a847d@linaro.org>
In-Reply-To: <8b490fbe-2b09-2a2c-16a8-6739ce6a847d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 17:44:11 +0000
Message-ID: <CAFEAcA-W74ZGVEat3A1cmgCGrGY9gF_7T-w9DK0TSPEXc4Cm_g@mail.gmail.com>
Subject: Re: [PATCHv3] exynos4210_gic: Suppress gcc9 format-truncation warnings
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Dec 2019 at 16:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/1/19 6:08 AM, David Gibson wrote:
> >
> > -    for (i = 0; i < s->num_cpu; i++) {
> > +    /*
> > +     * This clues in gcc that our on-stack buffers do, in fact have
> > +     * enough room for the cpu numbers.  gcc 9.2.1 on 32-bit x86
> > +     * doesn't figure this out, otherwise and gives spurious warnings.
> > +     */
> > +    assert(n <= EXYNOS4210_NCPUS);
> > +    for (i = 0; i < n; i++) {
> > +
> >          /* Map CPU interface per SMP Core */
>
> Watch out for the extra line added at the start of the block.  Otherwise,
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I thought about putting this in rc4 but eventually decided
against it. Queued for 5.0 (with the stray extra blank line removed).

thanks
-- PMM

