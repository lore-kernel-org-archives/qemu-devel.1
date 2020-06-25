Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6F6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2951D206EB
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDUPaD8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2951D206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joQuU-00005M-GO
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 08:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joQtn-0007w8-6k
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:22:35 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joQtl-000302-2y
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:22:34 -0400
Received: by mail-oi1-x241.google.com with SMTP id h17so4772646oie.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 05:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=J5E8Yz7WdHtNNchaXGGg1yzfOWfV4cXol1nPpRLd3zE=;
 b=XDUPaD8t+3OXTVfderIp3Ai/g9/Pe2rkHE5dKnFmDi4wXfKFvSHfmaLZxZ37NRZ2Gy
 WrU+b4N2G4ZXKq34QV/HEYBYxYPeqH/R6J3Nv/3lHlF9Y1yOaXtVT8P7vofbpWOs1vIJ
 uGgGjC5JWWtQfjDjVzbrppVCwZV0lGu3q8FfHlgThajtgzamaIt0IBer8Y93cGRKiuad
 8PwMqKOAy0Jw8Po5BhsWRcrMiThRN14wJYCZ+F0XSbvWIAzgIYYefu1MQhE+C/69Z3Ai
 YXJ6+hlePm7JOF7QaTjrdb3As6O0qKQgRvyjsbVwueBW/nviO5cDCBFd9faYgwcCD/ur
 ASCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=J5E8Yz7WdHtNNchaXGGg1yzfOWfV4cXol1nPpRLd3zE=;
 b=UoGBP8suIFXdN+Q9YDkhFNW/SFc3DXJI9DkLdnSbikW5WThTuwl9ivXSMlVFehU5lQ
 L43pnWIX3ma+YY1Lde9LodFVyi/YChju1QFk8IrkHJ9/70+hdTR5XgWxOzU0mL+vC1J6
 wIrw3YqDp5l551tIhNB3+eCvT6YrqpBurme4dzG2aYWCrkbHXk1icd7kSLwfiOtI3ATp
 wyyuPG6+yt40MSRzjWqghFHrDr3F1Fj75DUkKZa6cJ7aLpQuSttZDO5ADhVn1Ma3hbLt
 ABylIJkMVIWHBBc1Azm/eTpBMYAtaiL0rgc6qglfHT2RE4172KqJ1+1iE5fQVjnAlItR
 RH8A==
X-Gm-Message-State: AOAM533NM7BZJyTBQsfK2Mc4ki3XqLkNirW9kotSkFHM313GHybguXE4
 BOJrscjVxOViNPiSyoItyt4bF3aVEg2lWe3R/NM2jQ==
X-Google-Smtp-Source: ABdhPJw94FUb1M0+PXVFNFsxuGgl7/L6vqmYexS54QsOxBqv0prCOYSWgFhgOyV9fsKLJeNqo9VWv2MTaFup6Bf7+Ro=
X-Received: by 2002:a54:4694:: with SMTP id k20mr1857507oic.146.1593087751777; 
 Thu, 25 Jun 2020 05:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-8-ppandit@redhat.com>
 <7ffe6cd9-fc23-3fdf-6c57-7bb0af0dd030@redhat.com>
 <nycvar.YSQ.7.77.849.2006251427210.92950@xnncv>
In-Reply-To: <nycvar.YSQ.7.77.849.2006251427210.92950@xnncv>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 13:22:20 +0100
Message-ID: <CAFEAcA9yP=y9nzvqs_GZF=n9EXz7SPY4kiR6ZqHF+T+f7mnV5g@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] tz-ppc: add dummy read/write methods
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jun 2020 at 10:18, P J P <ppandit@redhat.com> wrote:
>
> +-- On Thu, 25 Jun 2020, Philippe Mathieu-Daud=C3=A9 wrote --+
> | > @@ -196,7 +196,22 @@ static bool tz_ppc_dummy_accepts(void *opaque, h=
waddr addr,
> | >      g_assert_not_reached();
> |
> | This is a shame we now have to fill the read/write handlers for
> | unreachable code :(
> |
> | > +static uint64_t tz_ppc_dummy_read(void *opaque, hwaddr addr, unsigne=
d size)
> |
> | I'd instead use a clearer:
> |        g_assert_not_reached();
> |
> | > +static void tz_ppc_dummy_write(void *opaque, hwaddr addr,
> |
> | Ditto:
> |        g_assert_not_reached();
>
> This will likely be called in tz_ppc_dummy_accepts() above. Do we still w=
ant
> to revise this patch? considering read/write callbacks are unreachable.

The point of g_assert_not_reached() is that it documents and
asserts that the code is not reachable. If the read and write
callbacks are unreachable (which they are) then having their
bodies just be a call to g_assert_not_reached() is the best
way to document that.

thanks
-- PMM

