Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BC6C3A5A3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 02:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D84220674
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 02:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="THNfhBDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D84220674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2o5A-000183-IA
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 22:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i2o1i-0005Cz-5y
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 22:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i2o1g-00073Z-TG
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 22:49:37 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:55925)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i2o1g-000700-66; Tue, 27 Aug 2019 22:49:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46J9F45HLnz9sN6; Wed, 28 Aug 2019 12:49:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566960568;
 bh=rVWe3RaYZcno4etKutHxIkb/uQtL4gwqCtQe4h2S2xU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=THNfhBDGMgrHn8SQJUvJ8WoGauJ3z4WJURRfF3hQEwfhZagC5djgIf9QqvKS8P9DI
 bMv8XnfdMA1wYbzpd69muyrueBPQPwVlidbzd/xr4VndZepLURuhEkos6Uqkmpfp6C
 qpxzbF6BCp3Cwz9WeoPnSykTUGJ0re7UwhmRRzN8=
Date: Wed, 28 Aug 2019 10:46:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190828004634.GB16825@umbus.fritz.box>
References: <20190827065650.107319-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <20190827065650.107319-1-aik@ozlabs.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [GIT PULL for qemu-pseries] spapr: Render full FDT
 on ibm, client-architecture-support
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2019 at 04:56:50PM +1000, Alexey Kardashevskiy wrote:
> The following changes since commit d6bb8b27204eaa58f1da948b65454e3a598ab2=
a4:
>=20
>   pseries: Update SLOF firmware image (2019-08-27 16:47:04 +1000)
>=20
> are available in the Git repository at:
>=20
>   git@github.com:aik/qemu.git tags/qemu-slof-20190827
>=20
> for you to fetch changes up to da9960a5aaa25d27c9798c3d94c7b4c2d8af31ac:
>=20
>   spapr: Render full FDT on ibm,client-architecture-support (2019-08-27 1=
6:47:46 +1000)
>=20
> ----------------------------------------------------------------
> Alexey Kardashevskiy (1):
>       spapr: Render full FDT on ibm,client-architecture-support
>=20
>  hw/ppc/spapr.c | 90 +++++++---------------------------------------------=
------
>  1 file changed, 10 insertions(+), 80 deletions(-)
>=20
>=20
> *** Note: this is not for master, this is for pseries
>=20

Merged, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1lzukACgkQbDjKyiDZ
s5KBFBAA1hlZVSB+SjMBhdz6vtXWUme305CMCDdEqHunI3po7BKzGNM5itL8AbCj
QvoWcvLSGqpfdvvQNG1l3XQ3JpbBHjJj8R6DRGpoLunMrG3lF+JBCuIFTgSI0GiX
l4Jba8kP/UDBrk3hSLxbrY5DUOMciW8c8zGD88FGDsdbOJG8YcSdcMuBdQylbvDW
xNf2q4tGphqKvvhtBzStH0GGkyjAa7EISTYZE+xs3q33EhYOBLPkgw0QNllA417O
Zo01Jki89mKRtttroFvyhG0hiiVNIYLMz4gWD/QlhmMMYtrcGMTi7HYV6tiRToDg
31QEg9uOsh7jed4ynNl+bI9r9/OIHcNKWSzbzeKipmvKCu76WpasrxlWy4h25g4p
kW2GqakB+/e3rSk4qNlQuN/BlGrbMsEr4wxUBw/Ta4A1K+CPkHi2hTbtpN+eBK/f
Hc/F2GlLpVEJJ7o+1Kxm9TLryTIDTTD+aKLEJPOB8QEqcF3A3zD4x0Cex5D/7UHo
URAu2vFJCic/eOc9w51DJDav65vrRCjmQWRC4i1Aj4t/l8B4V1jU+lmzM+x/aDkB
UPqWz0mzChwUGXvRAE/QfLzj7j50DAd3JV1tyeL0P6gt+YglDIiy12E9Wa03RWU5
ytgKgI8rxgyq0TPTSu6a0/Zh1rqWZYFJkBmq4SQzhH0dLo3ILXc=
=SUQY
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--

