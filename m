Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E61C28CC3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 02:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF31D20717
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 02:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aomuRGWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF31D20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34498 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYM6Z-0002Cr-Vc
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 22:56:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYM5h-0001nT-EC
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 22:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYM5b-0001du-Md
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 22:55:49 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:56137)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hYM5W-0000P0-U6; Tue, 04 Jun 2019 22:55:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45JYLR4pbVz9s7h; Wed,  5 Jun 2019 12:55:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559703311;
	bh=g3q2pSqEs+eQBRZMHeCFr25zLI4FxPNwvfDFA/fLRto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aomuRGWAxg/4uDM+oN1WlPq73GaCSW5oELCCF9h3iTzgDY8DbLf2FAi8GgFyZL2BC
	tbWsjaDG6OyWHXdSdNN6sMw09tbUZW7+XNhy48R6gUHLBTE0rT0PLzUYJFCYrILRPs
	tnoMvx0yK3xyPKltsnx69K5TNj7cYb02lF/Ome+g=
Date: Wed, 5 Jun 2019 10:10:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20190605001057.GA26598@umbus.fritz.box>
References: <20190604190115.8053-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20190604190115.8053-1-mark.cave-ayland@ilande.co.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH for-stable 0/5] target/ppc: VSX/xvxsigdp
 fixes for 4.0 stable
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2019 at 08:01:10PM +0100, Mark Cave-Ayland wrote:
> Nothing to see here - just Anton's patches fixing several issues with the
> VSX native endian conversion patches from 4.0, plus a related bug in xvxs=
igdp
> queued for 4.0 stable.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

>=20
>=20
> Anton Blanchard (5):
>   target/ppc: Fix xvabs[sd]p, xvnabs[sd]p, xvneg[sd]p, xvcpsgn[sd]p
>   target/ppc: Fix xvxsigdp
>   target/ppc: Fix xxbrq, xxbrw
>   target/ppc: Fix vsum2sws
>   target/ppc: Fix lxvw4x, lxvh8x and lxvb16x
>=20
>  target/ppc/int_helper.c             |  2 +-
>  target/ppc/translate/vsx-impl.inc.c | 23 ++++++++++++-----------
>  2 files changed, 13 insertions(+), 12 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz3CI8ACgkQbDjKyiDZ
s5IQfRAAqtysuRhYhX48J2ISCeQ//6BACSU8/dTR9kFt2g3stSZibdnKbuO2F5e9
kwLIDgqO3KZGiftXKYWOlI5cb/PPFV/RlyQHMVeOd9nLng42p952lBeJ+18WH/Z4
yK6zT3Zt8Rx/rHlq/vyj1tE/DSWpeddGqkhhUZSQoK6dmJ61h8JqXcjERprmMuzf
pnumTF4cNinHEAPdgZJbdjC9P7jcuCYNJTVKTlkj5dcfWJT9aotR5i5FXCbv0dFC
AmATGdf3GzrenjSwBxZT90LGEh6eVZ7hmth1lVQ1j9IFqQsXlSi2yUHtrzU6ccdD
sZCaZQ1oe9ZapzDSOfRIt+yM8wHEHC+HBJPIDVO6HvFc9NlOM8yoTFqakHlI50Ra
6RChgk2rgNPXDS7F1QuN2V3YwhKnnmgv7D76WCMXTlVyqnlUBfFL6QbB1J4InnTv
4Kl/4nkJFCYCuTI9pO+MNN7t+001c283/5DOlSYuDYQUw+KFHWUWjOacMWUEUlT2
5OEsQetpXBV+7MfvVtFpsowxBJi+7pSU0Wj2b+Cdg1f62pOOZHankTIWC7XyWJkn
7Ct03k5zCADLUqaXfDBbzcRCFWPOujioRSu/51+LRVmC0RsDxiHvl1Q8TsV+L4c+
Ahif677NGg6rgpP1RBiXSPEakKXgLP+Gk+8jx7jfYgh/t17ZoKQ=
=IVL0
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

