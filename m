Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F24C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B5772082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBg650Bx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5772082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izHvo-0000ln-4r
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 05:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1izHvA-0000Ad-5Y
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1izHv9-0007Aa-4B
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:28:36 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34643)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1izHv8-000723-Th
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:28:35 -0500
Received: by mail-wm1-x341.google.com with SMTP id s144so4155126wme.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 02:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=uWr2kYvQMtQvzdSwYOoC0mRKRVWXdw/SOb7eSE9TilY=;
 b=OBg650BxPGaBufVtrsbmmzOloVPoQnTCEx56GVHyb7N/Ad5TrSZErfv+nsCvxwOD7P
 RCTH6uXiCpP/4WWUX1gbCh3SnhVT7vZ63Y2kTmfo/Asg4oJhuK9wjnuvlVUr8u0/5+wG
 TIzhvEjDlT/mm0wLv291Wnyy3A6X9Tbn0RwBFNNJZRz2iknDuCCUcLPO4foVGnbay9ru
 vzxc4QoTOmzLPeUvjjnH4DBgdeatOH775XabD7/fGkYgnNK6F5aKDUCJ5oAUNx7X0Wn2
 eVT73KsOqhs9N+vMJrVNxCvRynfoLFc7ntRwDPUVH7oCT4BG82Co6wd0T+XjS+Mj2d+J
 cjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uWr2kYvQMtQvzdSwYOoC0mRKRVWXdw/SOb7eSE9TilY=;
 b=cBcSKO5GviXgBURMqOqC/cK58BYitcB/mB29AehEqEjf6RoOPjH65/BFcP0c/brgCR
 158df6NKatF4qcJM7J0eaQ6A/zrX5kGyreffl600eimOKtimOqrt0svk34nTA13+J0c6
 K0XAtsovvfIfzSCyBig7j2ZybHUY0Tx3bNmjfUCZrnzVqA0YrtilwkNkjVtbrZH4rD7T
 V5JKpBjiCyUeEOmquEXTxgrTPkDrGhRjc7q0moG8URo2qg1v1Mrc0//1OyDY5s/uKCSX
 eqBtyFwt9j8YQdStnB0fPIqo+io7lUfQ2hoXlNym1i0U8YtZPC564siTESUCaG76EN1x
 Vrxw==
X-Gm-Message-State: APjAAAWFJEoUa3M3GghjMPt3NNeqVDLZTwBMqhzHXV650ozOOLUM9i0x
 TrDS+iwkgnm5WHPJQTitwgxTl9aziu522Q==
X-Google-Smtp-Source: APXvYqw7x+JR9psVLZRzdkH0wpCLkok9HiBcGqWxXWDPxWjHNcAMNQMhcWmXc15KveEJ+iUPmd0lLQ==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr5183362wmb.155.1580898513345; 
 Wed, 05 Feb 2020 02:28:33 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id y20sm7190720wmi.25.2020.02.05.02.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 02:28:32 -0800 (PST)
Date: Wed, 5 Feb 2020 10:28:28 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [qemu-web PATCH] documentation: update links to readthedocs
Message-ID: <20200205102828.GA58062@stefanha-x1.localdomain>
References: <20200113103550.1133-1-alex.bennee@linaro.org>
 <2331e0b7-cad9-7b53-3d30-7fb88d692c8a@redhat.com>
 <20200115111042.GA163546@stefanha-x1.localdomain>
 <CAFEAcA9Q5nsD5iTPwsVVx73HPUD6aGKd0Sf2FUkAFqjAZhGMGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9Q5nsD5iTPwsVVx73HPUD6aGKd0Sf2FUkAFqjAZhGMGw@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2020 at 11:46:43AM +0000, Peter Maydell wrote:
> On Wed, 15 Jan 2020 at 11:11, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > The qemu.git/master docs are built nightly here (index.html is now
> > visible!):
> > https://www.qemu.org/docs/master/
> >
> > qemu.org's docs are more useful at the moment since they include the
> > user documentation in addition to the developer documentation.
>=20
> Our top-level documentation page https://www.qemu.org/documentation/
> still points to https://qemu.weilnetz.de/qemu-doc.html -- should
> we update that now to link to https://www.qemu.org/docs/master/
> instead ?
>=20
> PS: do you know which version of sphinx-build is being used
> to build the docs for qemu.org ? We should check it's a
> version that's python3-based, because I'm planning to tighten
> up the configure check to reject python2 sphinxes (both for
> consistency with our general Python version requirements, and
> more specifically because the upcoming qapi-doc sphinx
> extension I'm writing will import stuff from scripts/qapi
> which needs Python 3).

Yes, it's python3-sphinx:

  https://github.com/stefanha/qemu-docs/blob/master/Dockerfile#L14

Stefan

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl46mMwACgkQnKSrs4Gr
c8ioKgf/S2Tm5kI3CTZL2MJKCeFGmKqJuR5t1+iqyhk78wvIMmzS7gEOKu+vCHoY
H4MWbrc2zQ6MyksxcU7TCMeHtrrboFnVbfkFEDNukwXJZUpkk0QkwFtXFqsQTM6u
Zfopq1YJmr0N8/I3PtvV3a0OB8It792bYeOf13aONzXJti1KsiGKYI8SIab2H4pl
sYdbwgSkqn4OcPpB/qBS4eMBGXMBb1JT2wfNtqbWRiJxHmc3AbZp+QAWrXS9+Iaa
4a/XphTAvA5BvGsEn9wjR701tXynRFiLFYdNGCjfvG8H5msCZxpR5Q66Av8jMZBQ
FLbRHIofFXJdUyo4drMOgzGAsLegmQ==
=2FVq
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

