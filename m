Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0709C54FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 03:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDFFC20724
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 03:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZKb0gly2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDFFC20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGDfQ-0002pZ-Ss
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 23:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jGDeX-0001m1-4o
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jGDeV-0005q4-SQ
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:21:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44375 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jGDeV-0005op-2v; Sun, 22 Mar 2020 23:21:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48m05q0Bbzz9sR4; Mon, 23 Mar 2020 14:21:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584933679;
 bh=k/cpSl3hBGwY9eKjU2UwtGFRBxzWB6/1VLumGcR7Sx8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZKb0gly2s7cFQuRjHOm2RRycmE87p9D1Y037IhX9GIe3jQ7CWV8NB+ZN5I8h2P/Nk
 Ghu3zI9kyzdHNnz0MFB1PC8LyiZi5WDErCaj/zoaf5XccxBv6xi7ghVq5/SZXVct2P
 xeC/+QOYtKh7PIoiLTzPoe1qSGA9ZX6wffuqSEss=
Date: Mon, 23 Mar 2020 13:34:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] ppc/ppc405_boards: Remove unnecessary NULL check
Message-ID: <20200323023424.GB2213@umbus.fritz.box>
References: <20200320155740.5342-1-philmd@redhat.com>
 <20200322084608.GI781112@umbus.fritz.box>
 <CAFEAcA-TPqVN98T=tYAOyQ4JPj8iu+eB3Zi-txgV+GUgcHNjCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-TPqVN98T=tYAOyQ4JPj8iu+eB3Zi-txgV+GUgcHNjCQ@mail.gmail.com>
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2020 at 10:06:13AM +0000, Peter Maydell wrote:
> On Sun, 22 Mar 2020 at 08:50, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >
> > On Fri, Mar 20, 2020 at 04:57:40PM +0100, Philippe Mathieu-Daud=E9 wrot=
e:
> > > This code is inside the "if (dinfo)" condition, so testing
> > > again here whether it is NULL is unnecessary.
> > >
> > > Fixes: dd59bcae7 (Don't size flash memory to match backing image)
> > > Reported-by: Coverity (CID 1421917)
> > > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >
> > Applied to ppc-for-5.1.
>=20
> This would be OK for 5.0 too at this stage.

Understood, I've moved this into the ppc-for-5.0 tree.

>=20
> thanks
> -- PMM
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl54IC8ACgkQbDjKyiDZ
s5KfUhAAkV39fJ+5/pJVof+FcfX2TJXBlY8rT1atyWMaclkjKaKwb4+ZZMwa1ZWV
Qq3adQMfyaq9dHTHu4FrOobqI4UcHnOVM1/T3DLGmXa0Ib3ncwzlywQXunfKGi7k
Pv5Dx9v15TZei9M6RgHRxNDMB5ssip+/zB6orA1gZCRYnx08p3HYg1aQ267Shx+t
FWubQzt+peYS+3lHN+OYAmP9ubIHNjpDpVHefux8S8M/mh7CeHOyvGptOYlSsoql
90dbt+Qf9ymABls2QmOp5USxyKe8VLfgeSSEhWprHn+FFDz4OuKtc/hZ/mx+mBjO
0IjlnBJHwsND7mUvozFpZpUMCkaahVhSVCwMi6sr6QevTrEIpPgyhlmqWwpZVosF
PGU0VCm/C0FBstEUzygEnZMs6mxgAY7Lyt9aShhglJ/qzZP5FpB9QfhNZn87bnVJ
YMG4J50mSMY4a7J0XY1Lqf6cHb9m9oNlS/K9Wh+k+syYtgRAdIe4fxGbHpZ4pdHM
4Cav3tMZENbNJQTs9QKtZ7SC0D09qNmmIhmjWlkIHDaZk6/MOhcgnci8FQ4Wji9w
QBphUXxW/1+s3p/G6cFg0ka9WdkM7YqCiYmFtXJJ5gqbgXt3+F3lZa9mxboekGMO
3H2ie48QiJY4dhlDHQ6A8Zi6u0svs0Hf4LFrID6+y6tYUNtflTg=
=nHHQ
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--

