Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDFDC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 16:23:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4AAB20835
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 16:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB7tk0G9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4AAB20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35918 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLs0h-0004LV-So
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 12:23:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLryh-00036c-Qj
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLryc-0007Jy-Pe
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:21:03 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:44691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hLryc-0007GV-Hg
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:20:58 -0400
Received: by mail-io1-xd43.google.com with SMTP id r71so15184834iod.11
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 09:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=+Vq/OMIH1ImSxQZvxEgTjZ9MZHTkTkugEtkJQyDacGw=;
	b=XB7tk0G9QIbpYhuNkRT3qG5c61HC3ilgmFkSlqep0KiI2vP2KmpTfdmoK2EhBlgmrF
	kz2sSYOQwO3/6Gx4rQ2JFravaKKoOGR3PJTx23W0/GPsZQvpajx27ypL/vqYf4jc7iy4
	bExxbQaF1fkWclhYDCDJH4xM81Xpz95+S6k+Aiw9oA+SvcQM95BQ7Y05JbzdHPKPA3OM
	4XxTx0ilMXQs88CqHtTufaCPXAoheglHFg23VGpvXMjUt0qA+2MWFhaoRrW5p9zij09C
	OEFvLD1d9+KRrZc6klAOK1zoQEQMdiHiYqspKC52ogK5v89uNhFts8p7uiWnUe5/JsSP
	QSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=+Vq/OMIH1ImSxQZvxEgTjZ9MZHTkTkugEtkJQyDacGw=;
	b=tl7TX1sE2Yw/SEFViazyWhZgsIH2ZNsGsYVvHGio7O7RfGFNyNDHbuj22dIBlfJQDw
	s2BGUM2wWlZ8obRwC7DeM+pI7LdS59uYGdac0Jbs1JqNZP3wklP7jhZmderWUnOHfyRf
	0u+a+GNgkMj4wDNNwPddtM2LD6agKyDyQWCfBMiVMd5tGr/ZsLpHzG5h5+gzZpZ+XRwH
	ZdyDPCBqYnZCd9fDHErwY24oH56EaLG6JK4RkT6jMFOClue9kQ7gKvnlTJr0jFNPFR6p
	sOxf1coQ0XUXftLNjC7yr7hM7irJ9+jaXtW8FOzpylpLD2BKfKDRUh9UMwWfj9Hnu7G3
	KVBw==
X-Gm-Message-State: APjAAAVvJHc2WuIn55IIEOptfT0XhDPesmpq/onPa6B62iuxRELE/Mi5
	ibrf3Oe5eF2oyd4ltANrUls=
X-Google-Smtp-Source: APXvYqxi6IKcUXIc4MX8k+04obQW3GuGUOo4v1iCdOduQRh1kseANaTe3eEi7lgdDBx/QpZvHr4YCw==
X-Received: by 2002:a05:6602:d0:: with SMTP id
	z16mr43432807ioe.109.1556727657767; 
	Wed, 01 May 2019 09:20:57 -0700 (PDT)
Received: from localhost
	(CPE64777d5479c3-CM64777d5479c0.cpe.net.cable.rogers.com.
	[99.228.64.175]) by smtp.gmail.com with ESMTPSA id
	h10sm8707032iob.18.2019.05.01.09.20.56
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 09:20:56 -0700 (PDT)
Date: Wed, 1 May 2019 12:20:55 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190501162055.GB21155@stefanha-x1.localdomain>
References: <20190425145420.8888-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <20190425145420.8888-1-stefanha@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Subject: Re: [Qemu-devel] [PATCH v2] gitmodules: use qemu.org git mirrors
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501162055.gPBNv45Q9dKK7Ncnw4PHfHDOP4Ljt9UTzETBgtMf35s@z>


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2019 at 03:54:20PM +0100, Stefan Hajnoczi wrote:
> qemu.org hosts git repository mirrors of all submodules.  Update
> .gitmodules to use the mirrors and not the upstream repositories.
>=20
> Mirroring upstream repositories ensures that QEMU continues to build
> even when upstream repositories are deleted or temporarily offline.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  .gitmodules | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Ping?

> diff --git a/.gitmodules b/.gitmodules
> index aa77ce6f50..2857eec763 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -39,19 +39,19 @@
>  	url =3D https://git.qemu.org/git/capstone.git
>  [submodule "roms/seabios-hppa"]
>  	path =3D roms/seabios-hppa
> -	url =3D https://github.com/hdeller/seabios-hppa.git
> +	url =3D https://git.qemu.org/git/seabios-hppa.git
>  [submodule "roms/u-boot-sam460ex"]
>  	path =3D roms/u-boot-sam460ex
>  	url =3D https://git.qemu.org/git/u-boot-sam460ex.git
>  [submodule "tests/fp/berkeley-testfloat-3"]
>  	path =3D tests/fp/berkeley-testfloat-3
> -	url =3D https://github.com/cota/berkeley-testfloat-3
> +	url =3D https://git.qemu.org/git/berkeley-testfloat-3.git
>  [submodule "tests/fp/berkeley-softfloat-3"]
>  	path =3D tests/fp/berkeley-softfloat-3
> -	url =3D https://github.com/cota/berkeley-softfloat-3
> +	url =3D https://git.qemu.org/git/berkeley-softfloat-3.git
>  [submodule "roms/edk2"]
>  	path =3D roms/edk2
> -	url =3D https://github.com/tianocore/edk2.git
> +	url =3D https://git.qemu.org/git/edk2.git
>  [submodule "slirp"]
>  	path =3D slirp
> -	url =3D https://gitlab.freedesktop.org/slirp/libslirp.git
> +	url =3D https://git.qemu.org/git/libslirp.git
> --=20
> 2.20.1
>=20
>=20

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzJx2cACgkQnKSrs4Gr
c8gBsgf9ErX/MtiUX4hHocugweplU4E60EozRdVwKO+Uyv3Phy93+Xr7QoPF60Ti
AgdBNmaGalaqvVl3FXOW+kIDYvRPBkTMS0GJFM+jn5cl0pJLBSWVGjzSTK1FMLek
SZMAkaUD/l/wxQQRo/ewNwyyfE3hA1hA1yPU2psStnRMmWQio/criZLYcVQZabRP
rA1WGbCW69JvPFgKlGZUvyw++VQqmdCBtuYQKODVkbEdqO46VW44KLcr4APeC7xC
DjhZ9LSnilaZphY1To0qPHI1vDProyKYhN7iGUvR+4BRVaQdsS3PgvmbYfaYAaA1
AyLgo2CbH68TDjlX0R0rR9EfoJ67Mw==
=hjtO
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--

