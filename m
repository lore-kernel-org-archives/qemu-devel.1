Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD16C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 23:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9EFE20881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 23:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ChlRIZZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EFE20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54236 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTaau-0000m0-UL
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 19:24:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTaZf-0008Vu-72
	for qemu-devel@nongnu.org; Wed, 22 May 2019 19:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTaZd-0008Bx-KY
	for qemu-devel@nongnu.org; Wed, 22 May 2019 19:23:06 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:40343 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hTaZb-00088Y-U5; Wed, 22 May 2019 19:23:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 458TFS0g97z9s5c; Thu, 23 May 2019 09:22:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558567372;
	bh=GnFPdmqdnm2Q2gFrl2ZIzRwQY2NZMM3Mm6NWc5yxZSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ChlRIZZMyvtOQxBaNnU8K825yu6hvIyOeUkVWYsXopfBTCxeTRjJ50umV3hS5QSZ8
	WSwW7mUK44fMxsgM17Ac6LPCO4bbZVHv5YfxaippFbKzWN6hHCa827Zr16wmusijHO
	SUrtfTMz8IPm7YSAeOzWZEXkMT/KC5eNxnybEkMQ=
Date: Thu, 23 May 2019 09:22:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190522232217.GK30423@umbus.fritz.box>
References: <20190522074016.10521-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u3W6riq+uV6J42Ub"
Content-Disposition: inline
In-Reply-To: <20190522074016.10521-1-clg@kaod.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 0/2] spapr/xive: change default interrupt
 mode to 'dual'
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--u3W6riq+uV6J42Ub
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2019 at 09:40:14AM +0200, C=E9dric Le Goater wrote:
> Hello,
>=20
> Here is a little series fixing multiple resets when in 'dual'
> interrupt mode and changing the default mode to 'dual'.

Applied, thanks.

>=20
> Thanks,
>=20
> C.
>=20
> C=E9dric Le Goater (2):
>   spapr/xive: fix multiple resets when using the 'dual' interrupt mode
>   spapr: change default interrupt mode to 'dual'
>=20
>  hw/intc/spapr_xive.c     | 11 +++++------
>  hw/intc/spapr_xive_kvm.c |  4 ----
>  hw/ppc/spapr.c           |  3 ++-
>  3 files changed, 7 insertions(+), 11 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--u3W6riq+uV6J42Ub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzl2acACgkQbDjKyiDZ
s5KoRw//ZyUg1WY+KLZwdqUrpFt2JF2LAAQNgegqbV6kw+7vOmoUnJbu35fmJ9DU
7nB0/u7STTmFJA4N4kAY0YqJD0tFEMlqSxt9xrCGgrFO6D/gJDzP/Wad9xgtQfe3
WrVcDIGDBo4/BSM/+fipzEMsG7sNnh4bj4OGjbKWxtC0Rapj/Z5FEi5SchZzBDFg
fxZ37zaJ1DE2ULsgyNo3D20QQkUP76foR130ynmgP1nO7TnV67F81hpRF5UKnfYv
2JPpQ5z/6uh729T3OnbBO74hNXYGuwjgpQCiXFrTWWmia1ROqhAKZPcv4VoRLXmm
BdwVe5GsuYyTGJLfb/ww2rPIPAsgv/8MACqEUzW4SokY+iw94Zr18VOdpwVEsFpw
77st0TcAK+qRm1VYS5iDUQBSdP5BP/6kwNvveR9thH+VTXhWN93ifmNXiQ+jpG0D
qIbctVrSmmVe0Cce0sS1vP6MeO1HVGP1paFjJVC11Jd6g1GbgvbLavPZvNG7agAp
T1n+jI7pe6tPbfmJKB2prGCgsIkxuQ5N9fcgiekU5R6zX2WdwhwX+hTq6W5rlvSW
8ZlnA5mEvb453RILDFkkChreGEYB6T3zR+ESqAhvJVFVVM4BxhhxQfJTEDa6iqXa
EwOev19AP/H3Hc7Jcq84m32lYwWWRFzazo+P8t23bi6tWFhcvo0=
=g8dI
-----END PGP SIGNATURE-----

--u3W6riq+uV6J42Ub--

