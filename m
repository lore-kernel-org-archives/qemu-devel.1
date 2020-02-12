Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8F3C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 15:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A0120661
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 15:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhHYXtbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A0120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1u3a-0001lv-VO
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 10:36:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j1u2a-0000tp-3F
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:35:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j1u2Y-00046r-Vc
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:35:03 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:56151)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j1u2Y-00046G-PS
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:35:02 -0500
Received: by mail-wm1-x342.google.com with SMTP id q9so2795868wmj.5
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 07:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=O848WauDhe+Bbqqwmq9bBV+Xj5Ddi7yKMLvoLWy6/sU=;
 b=mhHYXtbhD1mm075UPuSPLvhwZE3hpJkX1Tl5DnqvcycMcpUPCGJQHEGqbQYusFdjvU
 oWVMhxI3qTqCtO9GdsNpGd74QR97s7wPnSb7oyOm9YwxPHuiN1rUWuGHPOB9UmEPq2/5
 qvbawGapKy2jMK/rU5UfWnS1LJZ0kyslMSoJyBz6Ro7uZDeSD7UwnNheq3qnAFj6EKAd
 P7I2Sr76lYiN8mGbP9/EsR6hrPSVXMc52VTT/yn6+gX44JrGJzo3mu1NnnS21bEU3z6f
 MAmMMRBHUj4venItNec4PDWHF+ueS3LHJTP2fbtTIYzfOYGyvudxtcQXkm0FVxGKZ3Hp
 OtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=O848WauDhe+Bbqqwmq9bBV+Xj5Ddi7yKMLvoLWy6/sU=;
 b=nZ8C9WZPFbHlV+jAqrRnJv1Zn5t8oxGAt3BvWMpTtpx8RhfEGbk1lP7yE7T4PseSam
 wtJpr0YGEWlYdCQTAD02S142DS8CNG5YdewUWWVHZdlAlvbY33vTNbtxmEcxysb+v2gI
 GwSANzWuLOfi2zJ4mx+vI7fSuKJ+nvCCMJCia+ecIo8jCgvvyjtfG9vVp5YrFUdOkM+L
 F6/w6frLqYi9nZXHUMeeA1Pj9QTM4jzovnqfXwZtw/XPErMHply8OpG97Q6l6F0yksHL
 JxXsiMJrX3OySNG5rhyxsndsf+KlZgDFDKKaHoLmso8CFAv64w7QFH1N+lSdbcLXTEvV
 ALxA==
X-Gm-Message-State: APjAAAXNo+qWY1tU3TzJCMbKFhZFXH38x+I5R273V+i/rulZ/epgzM59
 nribYmg2bIBxNwDEZ9rt2Ms=
X-Google-Smtp-Source: APXvYqxHPdbY5LVge4c8H90jCar49O0IE0OZzEnZnYRyxkAnUGg9i2MLOi8PY57RZUouH2Lce4KD/w==
X-Received: by 2002:a1c:9e13:: with SMTP id h19mr13665692wme.21.1581521701464; 
 Wed, 12 Feb 2020 07:35:01 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c141sm1152834wme.41.2020.02.12.07.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 07:35:00 -0800 (PST)
Date: Wed, 12 Feb 2020 15:34:59 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] tracing: only allow -trace to override -D if set
Message-ID: <20200212153459.GE432724@stefanha-x1.localdomain>
References: <20200211111054.27538-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline
In-Reply-To: <20200211111054.27538-1-alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2020 at 11:10:54AM +0000, Alex Benn=E9e wrote:
> Otherwise any -D settings the user may have made get ignored.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  trace/control.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5EGyMACgkQnKSrs4Gr
c8jlpAgAu9TJXKac9LZtBESR0kaQ7m83DRyzJVRoBv1pmLKJPXS7l/N977bWvLT1
0oAMq5o116K6LCQe1Z/gM9ZZF98BdBRbJnAQybNBBBGlo7FY3RY+onXOtpBM6CIW
pIlFRo6pnNW6grIALHubicFcoIi4YG+LLB5Vr+IiViqRZByqOMaFhQE+9nHJtgqs
uQ0wTQNyM9gSvI9Eq9VMKCfMwhErgM3VTJ4VVQQuAfX7p/Wpu828QAn4BHwAvOmm
aA+8t1X4tOI2AJ8/n7ZtdnftCPdayDevWMZOizx2C9DB9ycSvF9kYRvefRcMFyaf
DLxIva+Kn5J7Xjyh07h1N41el0H4Vg==
=sF3b
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--

