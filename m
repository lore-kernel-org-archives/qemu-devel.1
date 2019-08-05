Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A57C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C65E2070D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="phlELFLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C65E2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hunCB-0004jS-S7
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 20:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35039)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hunBM-0003TF-6m
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hunBL-00030s-4C
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:18:28 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:57449)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hunBJ-0002vK-25; Mon, 05 Aug 2019 20:18:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 462Zwp4pDlz9sDB; Tue,  6 Aug 2019 10:18:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565050698;
 bh=pL/BDGLbOEc3LhHUpAJJC0Xwn8WVetw38M94LO72pOs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=phlELFLrOmCZSfT2NiSngUUAQl5SrRpvwx6NcWuGu2HCalGlx3eXtaXXTWuay0D6R
 EsfHAqoGTcffwlHywctIpHRPMgV8nZXRKDZNLiV1Ito17GWh1BqyY+Ml6xrvWpcWjH
 +c8A8W2241+Ef+0Hszqhv35nnS4GyBWy4fEBJBjo=
Date: Mon, 5 Aug 2019 22:30:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190805123037.GB14494@umbus.fritz.box>
References: <20190731141233.1340-1-clg@kaod.org>
 <20190731141233.1340-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <20190731141233.1340-3-clg@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v3 02/18] tests/boot-serial-test: add
 support for all the PowerNV machines
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2019 at 04:12:17PM +0200, C=E9dric Le Goater wrote:
> Use the machine names specifiying the CPU type, POWER8 and POWER9.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-4.2, thanks.

> ---
>  tests/boot-serial-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 24852d4c7d0b..a54d007298f7 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -103,7 +103,8 @@ static testdef_t tests[] =3D {
>      { "ppc64", "pseries",
>        "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken",
>        "Open Firmware" },
> -    { "ppc64", "powernv", "-cpu POWER8", "OPAL" },
> +    { "ppc64", "powernv8", "", "OPAL" },
> +    { "ppc64", "powernv9", "", "OPAL" },
>      { "ppc64", "sam460ex", "-device e1000", "8086  100e" },
>      { "i386", "isapc", "-cpu qemu32 -device sga", "SGABIOS" },
>      { "i386", "pc", "-device sga", "SGABIOS" },

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1IIWsACgkQbDjKyiDZ
s5IvHA/8Cj8nAKIqytBbdoy50e9IcpTZXEzYrTKPEpjktxrIXDlcIhl0PrzREXlS
dv2yony0BwAm2bZbc7XBfrt5Mp9L7fAngnjcd+bvEJpgITJiVsJRlUiz5IsOZuEa
Nq51RFVESYFdLepI5/Kx3Y28amWB2S2IJqmElrZEoYRYKZY9baAsBS0XEuT8suoI
KBRLq64FCMlO3NETw+4hiAi5fbGcBbkzlsKIUI9NcvUaR4SIO3rFv8YOR+I1O240
3Bn/zZqsOl0JHQ8KrzM4yLPZtBzsFs9jlykLvsRTA2JOsm6zzvVuNiU04KOcb33N
4+CkHfniAlTWdnxKUDgAacmfLe5xa+weHwf00/liREEV8Fk5cNjNq4B8NJvi0vtu
RcjEc0IM5sbRnSvHWRgred5TbvWdrJB4fZYQYNAA3c5kmbIzN2Z4kJAagTRt2N0V
JbYu+Vxpn/sTme96eofoR9xaCcw7i/JW/6mpl0SD1lpCXdbSTcjJWe3spkTTJ1Ns
57QWVMPsXKCfsvGjjtW9ivDGEiRpKD3o9wNVPLO7Mfo5VWNpmPO/7+o4KKPbKOzM
gKdHnMHfS1CkhHIPWNEMtv6l4yrZBCAkbYuQzSu6jjDnKCOxMTmkNqdNrnA57lfO
L+9+KspJUtqZM8fstcf75GzysYDo8G3vQUkTYknp44h2fw3zCv0=
=ikRq
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--

