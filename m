Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49BEC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 12:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7910221773
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 12:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AVLrEiWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7910221773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40828 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJGtT-0007k5-EE
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 08:20:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hJGnx-0003kg-7o
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hJGnv-0006gA-As
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:15:13 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hJGnu-0006aQ-W8
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:15:11 -0400
Received: by mail-ot1-x343.google.com with SMTP id g8so1938039otk.8
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=WHJE5grGHhy6iPngu3sas69rL2nh47u2iEIu/g1MAdA=;
	b=AVLrEiWHQ0cMuU5I29RoM4aXY8TwQsQHTuWToBVEnZEWz5sc8A0/mHnLdW/eLna7He
	A3AhCili037IamqqsLUt5rnKrKKq3Yzz4NbKO8g0h82TxvDM0uSFdGnEUYJnwPtFzKCf
	RyOvkiX+SSiFtJhaKxGQLU1RSZw+kZYc3DbZ7+W21HpZpbCJReSpC8+KQCSqY7Wp9Fdq
	y9IM7PlEbL11yR49vwLOsyXMxVdLiBi0JmYItvOY2nqhakSHSmQHK+ENq7hOEeZNXoHj
	XnXH1m2Nq7a8MRT0F6gcZ87gezcjMS+Og6IQ/8G8cH6RKdFYHLEyUlWkIkJ69VoY2lRX
	+ZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=WHJE5grGHhy6iPngu3sas69rL2nh47u2iEIu/g1MAdA=;
	b=k5EgDU4xiQR+SgCmsC4OQmK8bo4/vTJP35vUmL2JE+tElU18mEyxpFsqhxbujkhG2b
	vZGJmSu4v/TSTMsi43xzNrBDaUkmO9S3ygdn4Sk8kGkeEXueRc3pA7szrVEpUaHD7zRB
	P4gAp4VKdcRz5WK03rak9e9yaEi072g9hjvwzhCasIy2bANL+59arlEBt1hECIlcfQ70
	VBf9AqguRYQS6dXpldUJugz40BhI2D6i2EsriHr5pSKtzAqsF2chJsTgN+KzL/XrOzrN
	k4d8jn45UB+Hhul9ICx+PQJ6tRRZ1Br5Xh9zDUb1hgiIz56W/yjVKNu/xJXMFarSYwaL
	So1g==
X-Gm-Message-State: APjAAAVT8JeX2+ivfwYtNdQWYmWA0NXCN00PgUfNJIIAJg8OoEeR+58S
	IocrkjsAvVm8MH/cTynHAbf6S4THPq6drcxSejFmBA==
X-Google-Smtp-Source: APXvYqxSwXfW2RWuYyRr5L7qMu9g72z83szwYphcg8Fnv1P5tifgLvQfNXEVycfqsFM7UAjAxIektLIRM8OQzXGQtto=
X-Received: by 2002:a05:6830:2094:: with SMTP id
	y20mr18885293otq.316.1556108109139; 
	Wed, 24 Apr 2019 05:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190424110041.8175-1-marcandre.lureau@redhat.com>
	<20190424110041.8175-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190424110041.8175-3-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Apr 2019 13:14:57 +0100
Message-ID:
 <CAFEAcA-_mX4_sJQ1KxSZbdcR1weANO+8430Y+zSYNBKgezPPLA@mail.gmail.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v2 2/2] build-sys: move slirp as git
 submodule project
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jeff Cody <codyprime@gmail.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424121457.RTMJuTogRyqgTNmdxn7V4IHQtlSc_coul3Oop5Y0cDA@z>

On Wed, 24 Apr 2019 at 12:13, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The slirp project is now hosted on freedesktop at:
> https://gitlab.freedesktop.org/slirp.
>
> The libslirp source was extracted from qemu/slirp filtered through
> clang-format (available in project tree). The qemu slirp directory can
> be swapped by a git submodule.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -52,3 +52,6 @@
>  [submodule "roms/edk2"]
>         path =3D roms/edk2
>         url =3D https://github.com/tianocore/edk2.git
> +[submodule "slirp"]
> +       path =3D slirp
> +       url =3D https://gitlab.freedesktop.org/slirp/libslirp.git

We should prefer to set up a mirror of the git repo
on git.qemu.org and use that, rather than a remote repo.

We also need to do that for the berkeley softfloat
and edk2 repos, I notice.

Stefan or Jeff, could one of you set that up, please?

thanks
-- PMM

