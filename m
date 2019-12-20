Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E57C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:58:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A570B218AC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+JTNyHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A570B218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiInB-00041R-8e
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:58:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiIdk-0004rt-I6
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiIdj-0002PE-6w
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:48:24 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiIdi-0002LG-UA
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:48:23 -0500
Received: by mail-oi1-x241.google.com with SMTP id l9so1759265oii.5
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 05:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LkCvHbS5kGTiB9GuTFKXBUKdxx6n7jSKXqEpRcQfp0A=;
 b=L+JTNyHYp1r4mlY0GR8CB64A+jutF6GSRvtv6KQiNl/ghBgHjtUnl2+YEExPevy3BM
 Q6ZAI1d/w/q40bRpGbKM0+hrZ8d7lTTx0ZLjtvVX76iyeNlKZRCy6RemZas2dxmkBBk1
 a6LsZn3HA3kLus3QsZz4Ob9eBwOpvzi+UX8kLn449Pb7/HZLnBLqPAMkDgaV+PHDw8At
 /xI69EhFQobJU3ezcVHt7oa+gUuZb0gjsEzkbOqeGrFqSG4amGoEd4Y/AlwBFuTrLcCv
 2yYDVkYOOBBRIe/HJKANSqnrvQwnJRymFsfe5F9Mh8gOni/i2Qjuw9u8q7MjM9sNHHCJ
 vT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LkCvHbS5kGTiB9GuTFKXBUKdxx6n7jSKXqEpRcQfp0A=;
 b=eKiLmydTLy6X5LPHnSq8I0NLiyFv0Dfo7LiQC8fEfs4BO1ldKa5GTl/08ZvXwEYCFt
 jNob/97cFmyINDLDxo4KcNDzLapfzY0KWq+TbvUU5c9h+lX3QRTxgXByE5pf1n1KHsLE
 M7kLOYBe5z+G87mXCu0MhRt+2xdEcq/gNyXR5vRKptY/gYdfHwxww1UlioVhPMwOGsMB
 Ier4BNSE/tGCibm7vsDAFXeLCHpcOfy2w2qyFJ8e6tTNd48usAj3wFNWB1vXslCW+Qbh
 IRqVauLq9acsSXuoCTnqwMmT2yKnylZgIXeoIwrwigGRl9RpeS8T9EMsPB1aHZOwLEbM
 cGRA==
X-Gm-Message-State: APjAAAUKufgg9zsKfN3mT841Y5qmnujE9/cRyhqc7ngxuIq0mHVVRJ0U
 pOs1Oau+1Mr5ilM/ZdHHv1c80IAztUu9jMHIMAJlHA==
X-Google-Smtp-Source: APXvYqxyCWQ7In/8LrivDfVo4hX/+20AGWHTVZx/IgPkXG9i6nXr6FccqP8/0jbJ985k3fBmBaWWGKZtZOfJsRNcPNY=
X-Received: by 2002:aca:3182:: with SMTP id x124mr3945658oix.170.1576849701925; 
 Fri, 20 Dec 2019 05:48:21 -0800 (PST)
MIME-Version: 1.0
References: <20191219185609.16748-1-richard.henderson@linaro.org>
 <87bls3dsrk.fsf@linaro.org>
In-Reply-To: <87bls3dsrk.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Dec 2019 13:48:11 +0000
Message-ID: <CAFEAcA8ZyDeFt-PY53Dysf+wiNpUkBk=v+sHG9huUR4awsef7g@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Set ISSIs16Bit in make_issinfo
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Jeff Kubascik <jeff.kubascik@dornerworks.com>,
 qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Dec 2019 at 13:35, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Richard Henderson <richard.henderson@linaro.org> writes:
>
> > During the conversion to decodetree, the setting of
> > ISSIs16Bit got lost.  This causes the guest os to
> > incorrectly adjust trapping memory operations.
> >
> > Fixes: 46beb58efbb8a2a32
>
> It's not really obvious from this commit where we end up now calling...
>
>
> > Cc: qemu-stable@nongnu.org
> > Reported-by: Jeff Kubascik <jeff.kubascik@dornerworks.com>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  target/arm/translate.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/target/arm/translate.c b/target/arm/translate.c
> > index 2b6c1f91bf..9f0afbdb75 100644
> > --- a/target/arm/translate.c
> > +++ b/target/arm/translate.c
> > @@ -8556,6 +8556,9 @@ static ISSInfo make_issinfo(DisasContext *s, int =
rd, bool p, bool w)
> >      /* ISS not valid if writeback */
> >      if (p && !w) {
> >          ret =3D rd;
> > +        if (s->base.pc_next - s->pc_curr =3D=3D 2) {
> > +            ret |=3D ISSIs16Bit;
> > +        }
>
> this function.

Yeah, the combination of decodetree and the C preprocessor
is pretty confusing. There's a macro DO_LDST in translate.c
which creates trans_LDR_rr() functions which call op_load_rr()
which then calls make_issinfo(); and the decodetree generator
is what generates the code that calls trans_LDR_rr() and friends.

thanks
-- PMM

