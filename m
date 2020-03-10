Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FCBC10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F442146E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AkVSzmb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F442146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBT7E-0004q3-8o
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 20:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jBT5a-0003RU-7q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 20:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jBT5Z-00089k-4R
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 20:49:42 -0400
Received: from ozlabs.org ([203.11.71.1]:50899)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jBT5Y-00086T-Og; Mon, 09 Mar 2020 20:49:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48bxLQ0rHQz9sRY; Tue, 10 Mar 2020 11:49:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583801358;
 bh=dGpPDXG3uiSDZfEje5nYJSb0zXZXH5PLk2kfEV6YHBM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AkVSzmb2mGbNw7LZ3PGsU9XV5oxgCGbHqdXwFOjeLygUze4kS+nuNqUKHBEH5LVaN
 0xVNYJRdQFu+c/qRMbSmbg382aOrasuK4EV24IKG0TrAqOouu/xjKV1QyTyplFXsJt
 GoVvl5stId66gqPBoECQfRM4ueDx7JBxmizX6qqk=
Date: Tue, 10 Mar 2020 11:46:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] spapr/xive: use SPAPR_IRQ_IPI to define IPI ranges
 exposed to the guest
Message-ID: <20200310004605.GE660117@umbus.fritz.box>
References: <20200306123307.1348-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RpqchZ26BWispMcB"
Content-Disposition: inline
In-Reply-To: <20200306123307.1348-1-clg@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--RpqchZ26BWispMcB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2020 at 01:33:07PM +0100, C=E9dric Le Goater wrote:
> The "ibm,xive-lisn-ranges" defines ranges of interrupt numbers that
> the guest can use to configure IPIs. It starts at 0 today but it could
> change to some other offset. Make clear which IRQ range we are
> exposing by using SPAPR_IRQ_IPI in the property definition.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.0, thanks.,

> ---
>  hw/intc/spapr_xive.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 20c8155557d6..6608d7220a47 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -677,8 +677,8 @@ static void spapr_xive_dt(SpaprInterruptController *i=
ntc, uint32_t nr_servers,
>      uint64_t timas[2 * 2];
>      /* Interrupt number ranges for the IPIs */
>      uint32_t lisn_ranges[] =3D {
> -        cpu_to_be32(0),
> -        cpu_to_be32(nr_servers),
> +        cpu_to_be32(SPAPR_IRQ_IPI),
> +        cpu_to_be32(SPAPR_IRQ_IPI + nr_servers),
>      };
>      /*
>       * EQ size - the sizes of pages supported by the system 4K, 64K,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RpqchZ26BWispMcB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5m400ACgkQbDjKyiDZ
s5LPdxAAlZlcctIuoUJKc2f3MKJ3a1ibUUA7pocQKWdqC3Nkdy4FQJgSyVwH8Rg1
oTWYL3C/HSxQUIBGDfcYF6WPZTEBlJwB72X4MZTf7EYpHeJ2iw2GQ+sPnjb9FaL4
D2NLuwCkMFqwNQG6gdVV9Z4u3fQ/d7yhYbI45aLiP1UMAoF4k570Ohhypevzh306
bQIAjghgSEtBZnsqtYPjtSYTGiVXEbzwa7uQcUVwEvzKlL6qJ3wB74azJuy1DqPZ
RHcWxt3ASzHz3K0TjH9E90yKB2rXfIHTrNrwVA9pqVEz5nrvte5JrK6St5QfBlzc
+NX/y1W4wIFpUDEPw00DlTHfAHFk8NHpYwP8v7zwBsNZ/jZXIotGqbP9bH0EoDIp
saUgt91/PLn3YhU3uY99cHwcW7wQdPELWEn7UpgwIqrlvZzaVW9On05SZG5m2QyR
+7afSHo33ec/opab9qzRq/NHggLfGqrm2ezp2+9HmK8Q9wlMYnytrjNEB1gTaBTB
CcpF5x2I42rYwG2SzqvLjWtCQ1C3b6gEZpG9ZSP2Is9Ef9gxnUYE2T6MYAlsDEA5
59+VHxbA0EQj7QgxLm+6LZh9+1UJiBGpN5n5KVa35YkEWzgVBXT6Vzu9Yt71ewGS
trxmc8PtHty/6qyXZGlQP9xAvtqmAaenjK9GK7SqEC0309CETWo=
=Nhb4
-----END PGP SIGNATURE-----

--RpqchZ26BWispMcB--

