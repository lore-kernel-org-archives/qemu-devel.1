Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3357CC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 04:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA66A2166E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 04:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Anz+Mu5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA66A2166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvwc4-0003kY-2L
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 00:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56567)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hvwbg-0003Ks-1x
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hvwbe-0002D5-Ts
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:34:23 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:59205)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hvwbd-000267-Mo
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:34:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 464XSm0C9Zz9sN4; Fri,  9 Aug 2019 14:34:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565325256;
 bh=pnffnth02fHDLb+kjDfO9OIFpdAisu9HTECgN03roN4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Anz+Mu5eQGP34Ym+GGUwWZjtkHaFy4l2foMs7ky6oaz3k5MiXTv65HTlge3wscrAW
 wmslxp3e6iL9iboNxMl6EdnV4bdvXpoXnleNZJlEjaeARG9/TdoWLpDnBrKqaURZyr
 mSXp2YMXoHEekZautrgyG+KDvQCjm75YKvTGC6wM=
Date: Fri, 9 Aug 2019 13:06:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190809030647.GI5465@umbus.fritz.box>
References: <877e7nelf3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Content-Disposition: inline
In-Reply-To: <877e7nelf3.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] configure and submodules capstone, slirp, dtc
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
Cc: Samuel@pond.sub.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 David Gibson <dgibson@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 05:17:36PM +0200, Markus Armbruster wrote:
> configure --help documents capstone like any other generic optional
> feature.  This leaves --enable-capstone=3Dgit and =3Dsystem undocumented
> there.  Anyone care to improve this?
>=20
> It documents slirp unlike other generic optional features, and shows
> only --disable-slirp.  Anyone care to improve this?
>=20
> There's also --enable-dtc, which appears to select the system's dtc if
> it deems it usable, else the git submodule.  Should it support explicit
> --enable=3Ddtc=3Dgit and =3Dsystem, too?

I have no strong opinion on the matter, so I'm happy for it to be
consistent with whatever else we have.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1M40cACgkQbDjKyiDZ
s5KrqhAAqEtcD7zXZrWFbDk8GSVR9iUxJejBKtDDrwANix2jwTN/7huc6Eirf8lj
xdozMpP1IBUnQMST7/fFIqsOmo97gg1+C6hF/TedNQz5VvBEQbA/9AR18UNuV7pd
YzhQZSxsreVZG5JTqxP3M04RPnPYZCK3xhlCum3QYugXWJIhYBRq9QGA+LnVgH6T
NU7tVVxHbrDkD0YUPEWn+3SASJfxLHXMJ1cdk91BCIbK5sCEMMsza0FmRnsipqud
70wI6Kfq5IgKlWkkJOXoWiAlNrF3OXazLekMyCZ2iWpoGqisFqkOEoR1W1XXcL7M
iuDgk8k2aJfqTX2C5z5jMkSEhxSJPZARWifqQdwg8qBsM5imcIH8/eVzUXo/Rh/c
+w6vXpUt+J6lESFTvy4vzLVlqxfHrSVr2xSUEdd+2hN0AGqIz9OVcbiH2P4yfPCp
dKuS4uaPPQgqhC2/QSK13B21vq9cIXP9AmIktHa+phfJYlrnNfzWA7irEgeTjcGp
xaPkOIy/8oRz4/RlOtZuXfatftkmZ8twPDeM84GAhsOCi/z0GuW/tV0NdLAbDxZH
Bt1kdoPRE1GdDYQhNPzjLCE75ygIkX/KyInkugb0LrJWFZFmTzbgTX6e4l2t9aqw
A7imsfOBAwMMWVfu9K0XZHqykp8KDBGQvdVCHHUXWFDbK9OvhX8=
=xeIh
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--

