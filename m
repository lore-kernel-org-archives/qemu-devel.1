Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E61C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 22:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5BE2072A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 22:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bSicxwJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5BE2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVkMC-00046f-R7
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 17:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iVkJm-0002x6-KC
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 17:43:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iVkJk-0005Ff-D5
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 17:43:54 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41473 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iVkJi-0005Dh-MC; Fri, 15 Nov 2019 17:43:51 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47FD0f0CYBz9sPF; Sat, 16 Nov 2019 09:43:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1573857826;
 bh=XzfwguQxTo4cQwb9EYgC2ttZ0hY3v8BVzTnFBRqdZOM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bSicxwJPeNPHnm/X6QRZq1Q5+ILe0wP/xAMScYVdTCt3eSKcm0ZUT3nj099pmWA/S
 hHOTyZr/Gk6NtQLh19cQeeXcVefqzrAd4B8baruJIYryfqSd/hJMQAuWa3ewOedSE3
 +slLOvRL77rQrHVpLvIRAyieJR5TH5nL9YnRD+QU=
Date: Sat, 16 Nov 2019 09:22:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] ppc/pnv: Drop "chip" link from POWER9 PSI object
Message-ID: <20191115222204.GP2134@umbus.fritz.box>
References: <157383383118.166856.2588933416368211047.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7PAM/4G1BR2SfWzg"
Content-Disposition: inline
In-Reply-To: <157383383118.166856.2588933416368211047.stgit@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7PAM/4G1BR2SfWzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 05:03:51PM +0100, Greg Kurz wrote:
> It has no apparent user.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.0, thanks.

> ---
>  hw/ppc/pnv.c |    2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index d7130c3304f0..24bc3d5ab32b 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1091,8 +1091,6 @@ static void pnv_chip_power9_instance_init(Object *o=
bj)
> =20
>      object_initialize_child(obj, "psi",  &chip9->psi, sizeof(chip9->psi),
>                              TYPE_PNV9_PSI, &error_abort, NULL);
> -    object_property_add_const_link(OBJECT(&chip9->psi), "chip", obj,
> -                                   &error_abort);
> =20
>      object_initialize_child(obj, "lpc",  &chip9->lpc, sizeof(chip9->lpc),
>                              TYPE_PNV9_LPC, &error_abort, NULL);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7PAM/4G1BR2SfWzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3PJQwACgkQbDjKyiDZ
s5IJVRAArqWqwrrnCUnKQU2TNiZXwSffvRn9tRkA+APe3fktq0qlbt1rIgk2fvek
/EgoMTBFQeNJj/uZICdSZaf7CX8UWNRZTnyeFprrC3ZAM7SFzGXA40X+oIczZLgt
slNoNTG95wBBsLXw6Fi5auq9pchd+CC1wGN6XQ0FyHzSYxwH+HRIh6Pgrl76f+r0
3t5PvGXmJJ8ycbplgH6Fb3RWopvAc6WtwzYEKkmOSYKULDLfnrfBsi5BfYziq59y
DEiXXJmxJzVKQZymhtuDYJImHh/d62LB7p5BkCIWyKh2J9Lrbucss7vin7Qckl/i
pJZ4AlT5mJLUExwAZZmvTKYHuOS7qZDR9NGAOTktPTiVyVb0KY8rwf0vY5cwMsps
Mj7SRRmFbt8+6qlA23zp9gln0ij5yhihfpx9Gx4qFGDpA5jwW78qa9U+o0Y14kYs
9YpzoqCmJ91vFUjYz67LBUMMHJcoG3Cbmp7+8dSsqNETj8xImMow+ymXCFCinGQI
Ta0oZeFikqw318a6sgkN1qTJiG/dpvJxVAYt/y/lRxccmMWNgTYXAdnZLbERaZSo
3cFRdSWTFJFdthMX5a+m5XbjwKjahwoJyK1v+BY/2hgz+ESUFSSZxTF+EluCBcAB
hcMEeMrQ7fOYs3HobXRXz4VunLjbAY27KXvepTWZIpt0/jFJJUY=
=TDdR
-----END PGP SIGNATURE-----

--7PAM/4G1BR2SfWzg--

