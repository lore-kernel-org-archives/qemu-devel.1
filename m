Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580F0C04AAA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 03:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245402082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 03:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YK010Nq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245402082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49689 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNUTk-0001nW-Ct
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 23:39:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNURt-0000hf-Gy
	for qemu-devel@nongnu.org; Sun, 05 May 2019 23:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNURs-0006rI-GN
	for qemu-devel@nongnu.org; Sun, 05 May 2019 23:37:53 -0400
Received: from ozlabs.org ([203.11.71.1]:34117)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNURq-0006oO-4l; Sun, 05 May 2019 23:37:52 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44y7jD1LNKz9s7T; Mon,  6 May 2019 13:37:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557113856;
	bh=yfPh9S7Ei4xiSmk69WUDZ2G1LESu4gvnXYMcvSFnfGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YK010Nq0O3l2xgndyl96M2VYVka/bokE5/lqjavhvFNi3JmdGTzQNwCigv/qL4oyU
	09bcCxVv3n6Ch1NMAc17lnHegzJobZ+OYxCLURVCUpXUW46cW+cEwDk/ckYt1UHj2W
	DruU2so5RcgSEtWNmEUdO/BxGKgWbBVITB3mr2Xo=
Date: Mon, 6 May 2019 13:25:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190506032514.GC6790@umbus.fritz.box>
References: <20190505152839.18650-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
In-Reply-To: <20190505152839.18650-1-philmd@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 0/3] hw/ppc/40p: Move the MC146818 RTC to
 the board where it belongs
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	=?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 05, 2019 at 05:28:36PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi,
>=20
> This series is to properly do the fix sent by Artyom here:
> https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg02264.html
>=20
> There is no RTC on the i82378, move it to the board code,
> set the base year there.

Applied to ppc-for-4.1, although see comment for a possible followup.

>=20
> Regards,
>=20
> Phil.
>=20
> Artyom Tarasenko (1):
>   hw/ppc/40p: use 1900 as a base year
>=20
> Philippe Mathieu-Daud=E9 (2):
>   hw/ppc/prep: use TYPE_MC146818_RTC instead of a hardcoded string
>   hw/ppc/40p: Move the MC146818 RTC to the board where it belongs
>=20
>  hw/isa/i82378.c | 4 ----
>  hw/ppc/prep.c   | 7 ++++++-
>  2 files changed, 6 insertions(+), 5 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzPqRoACgkQbDjKyiDZ
s5Ju1Q/8DTeN/vTWTiDSQAOt04Xdhgi9P/85cNeOUzBsltevH1Niqdds4cumrg8F
spdPcJXxhG+SqX1RSNfJaVqZlicDB/1ESqn6nNR/Ej64CuKj03Veg6cErUtsKZoQ
+EUGAfzLUXvinFLYMTTDw1KLWyq+c9tlmA2pzW3i9bqCoLg+DFu+f7CQRGSYBzmf
hkUDq+Tb9SnVD5jdt9BnRO6NCHkPqiPGB5ww90yQjFCfOqKIiuIGy5Et+4n61BQa
wQDZWipxP2OSnpOzKM73V7YFshYyr7L63I8cAkm0+Qt+w7x9R07kkhlMhhoKTdHq
sqFXRHM99CT/nBATdZd6zpawRd7+EdUQYLtyqFGiS9toYtC8hOPHict+6TBxfENI
9maoPeDdrsasEK8K89vkNXPiFt4IVp508GbpQgfH/vii2mBdMEK8e9P+fzUE1LlL
kozM/Mh6z3Nhq61TNqu2wFb+v6kupYQa6TlAGTSxwtmePineI7b4rEM+KbxhrAin
2YwJqXXv729remyTvAllgxEbkIeWvWOZND1mt45EG2z+Nd2Xif+EdNLfDjPhPAju
Xx/wsWUnGaFgozghp5/lH2yG+eGFAh6bcdoFPTFOtFN81hSGq0L97SHqg9DOZcCA
7Z4zRlDl04Cdgc9as6AyEEl53AlK9IXWxGhaMDz28Y6XWADekhs=
=TIQv
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--

