Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE050C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:34:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BD1E22BE8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iM0KPVuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD1E22BE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38183 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqxYd-0002EY-Hs
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 06:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47053)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqxYL-0001jC-Di
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqxYJ-0004Vi-Bd
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:34:21 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqxYJ-00046J-3K
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:34:19 -0400
Received: by mail-ot1-x343.google.com with SMTP id j11so30589204otp.10
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 03:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OoLRuocXcyae0c39AfRGFFWkG6eGTv2vwCCtYPEVV7Y=;
 b=iM0KPVuqOXCUwMVOHQkNDQk0jL1aDjxuz2N3JNymmtzQiM/c0suNjHmhtpfZH9hYHb
 LKXdpfo2vm4jpFEjBSu4TUi915Df6hIfUdowOgrtF//o9LuKSbKnq/cOGcH/FT1ksey0
 5idTtyr35a4sB+pbZqttCzBSZtLT1Pfo/BSwPxAKrdpIZezDl5WwyIBGKxCr2ZyG+5rA
 XCDxojeXbPQDksG3mwZgfoKqNEXCVLMq1lxtA6gU0HwmPO1cLajftGKG6sp3DohgmEEU
 xVy9WpGL3V+B36xbZZY7+20HNN122D1OyTCP+aBsyKGyzeDPsMoRvw5UhNH1Au4smYpl
 A6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OoLRuocXcyae0c39AfRGFFWkG6eGTv2vwCCtYPEVV7Y=;
 b=fpXbc3UrKLu45B1OlGNwcXIxeolgF+wEfjgXkRUdvykhvBDb4Mxuf/7yyxgDHNWyfD
 dw5KKepKHV+Tu++9UfR8ozqJ7H/SHPD8jWp7qE3z2vzjGP3d0P+RzARYXDfBGM/RsJK9
 qou1Kb7Efh7jyvLYBQPsI6gVfBTI3+8xfLOEYDp0GoQz9yTpxKA9luJx5e01FG/RoXol
 uHNTOrkzXzlhF/9uBblIy6lXncF6P4SIcHnitOXAlTaesjazThraXMoCYuFfeXnRhYZX
 0fSTGuS+9+Ft7w437dIze6zcKH5TMbrlvoK9UjK50LFCzbozIFSofpZgMZEisrr/A8cb
 V/Vw==
X-Gm-Message-State: APjAAAWofAnSEeWQrxcOvR+G8S64CGuvYcSoZMZwyahxwQgR2bQ3+X6B
 Dn2MLjQTDGDDmvKXhx6lQFIvfeAPlFBmVQ3NzmNP2g==
X-Google-Smtp-Source: APXvYqw5MARY2qQ8WkEFlLREabgLfbbvcsqXA+W8g4Iy+qm5lQyVqZT0uzwcZvOA7UApbezemJl6zrK10BSvS5exFkA=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr21177301otk.221.1564137253030; 
 Fri, 26 Jul 2019 03:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190726103010.31741-1-alex.bennee@linaro.org>
 <CAFEAcA9ioE_XcSuU_MXZAW=v-7Me6Nq_z9A830i+RswfNxGjcA@mail.gmail.com>
In-Reply-To: <CAFEAcA9ioE_XcSuU_MXZAW=v-7Me6Nq_z9A830i+RswfNxGjcA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jul 2019 11:34:02 +0100
Message-ID: <CAFEAcA9q1=_faoFSJ0QFWuiN6h4WsOCK5LGfeo=OwO65vW6SSA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v4] target/arm: generate a custom MIDR for
 -cpu max
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

On Fri, 26 Jul 2019 at 11:30, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Fri, 26 Jul 2019 at 11:30, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> >
> > While most features are now detected by probing the ID_* registers
> > kernels can (and do) use MIDR_EL1 for working out of they have to
> > apply errata. This can trip up warnings in the kernel as it tries to
> > work out if it should apply workarounds to features that don't
> > actually exist in the reported CPU type.
> >
> > Avoid this problem by synthesising our own MIDR value.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> > +        /*
> > +         * Reset MIDR so the guest doesn't mistake our 'max' CPU type =
for a real
> > +         * one and try to apply errata workarounds or use impdef featu=
res we
> > +         * don't provide.
> > +         * An IMPLEMENTER field of 0 means "reserved for software use"=
;
> > +         * ARCHITECTURE must be 0xf indicating "v7 or later, check ID =
registers
> > +         * to see which features are present";
> > +         * the VARIANT, PARTNUM and REVISION fields are all implementa=
tion
> > +         * defined and we choose to define VARIANT and set the others =
to zero.
> > +         */
> > +        t =3D FIELD_DP64(0, MIDR_EL1, IMPLEMENTER, 0);
> > +        t =3D FIELD_DP64(t, MIDR_EL1, ARCHITECTURE, 0xf);
> > +        t =3D FIELD_DP64(t, MIDR_EL1, PARTNUM, 'Q');
> > +        t =3D FIELD_DP64(t, MIDR_EL1, VARIANT, 0);
> > +        t =3D FIELD_DP64(t, MIDR_EL1, REVISION, 0);
>
> Comment still says we set VARIANT but code says we set PARTNUM...

I guess we might also briefly mention why we set PARTNUM
("just in case guest code needs to distinguish this QEMU CPU from
other software implementations, though this shouldn't be needed",
or some such.)

thanks
-- PMM

