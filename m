Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACC5C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A4424659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hON6p5x+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A4424659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFNX-0002js-Q2
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1idEUE-0007Hs-RQ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:21:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1idEUD-0001zw-JQ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:21:38 -0500
Received: from ozlabs.org ([203.11.71.1]:37159)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1idEUC-0001s1-KM; Fri, 06 Dec 2019 09:21:37 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47Tq1F2GFHz9sPn; Fri,  6 Dec 2019 21:42:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575628977;
 bh=EmVo7Pwx+DtxHbZPtSYRuOir/wR8PGjAnxrrv0MYhSk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hON6p5x+PnDu4M30zAlfbAn0k7s8QF9lfGpFL02WEEXE3mz8NULk2K7cjzkQQVZDy
 i9d+hcb/syvymZ42OehxoreA6KBcCgLLuANytWm/J0b/MypHpdH1YSe1ImjaRlES2q
 cGbd9EqpR47D1S+llf1JZGwN6k/1PIUOA9zpL8Kg=
Date: Fri, 6 Dec 2019 21:29:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/1] ppc-for-4.2 queue 20191206
Message-ID: <20191206102903.GM5031@umbus.fritz.box>
References: <20191206044134.259488-1-david@gibson.dropbear.id.au>
 <CAFEAcA-oGLx+mcgqxC6-QRv9dSdzOqvM8g7q7SzUuAqKSZU-tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qo7zVO9a9OQ5oQtr"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-oGLx+mcgqxC6-QRv9dSdzOqvM8g7q7SzUuAqKSZU-tA@mail.gmail.com>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Laurent Vivier <lvivier@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--qo7zVO9a9OQ5oQtr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 09:52:54AM +0000, Peter Maydell wrote:
> On Fri, 6 Dec 2019 at 04:41, David Gibson <david@gibson.dropbear.id.au> w=
rote:
> >
> > The following changes since commit 1bdc319ab5d289ce6b822e06fb2b13666fd9=
278e:
> >
> >   Update version for v4.2.0-rc4 release (2019-12-03 17:56:30 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-4.2-20191206
> >
> > for you to fetch changes up to d887a8cfc083bcf3856f9f42352989f3624e0cae:
> >
> >   pseries: Update SLOF firmware image (2019-12-06 15:33:23 +1100)
> >
> > ----------------------------------------------------------------
> > ppc patch queue 2019-12-06
> >
> > This is a last minute pull request for ppc-for-4.2.  I know it's very
> > late in freeze, but this does fix a regression: a bad interaction
> > between the new qemu and SLOF device tree construction code means that
> > SLOF will crash if PCI to PCI bridges are included in the system.
>=20
> I really really really don't want to do an rc5. This would
> have to be "everybody using ppc gets crashes" for me to
> really want to put it in at this point...

Yeah, alright.  I'll send it to Mike for a 4.2.1.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qo7zVO9a9OQ5oQtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3qLWsACgkQbDjKyiDZ
s5I9fhAA1tV2qJgRkEMqzowHp2us3la0LpjAb0uMXAFAOKxWqdePeD00lRVpg72J
qJt/tUskyoES3pTWbYpVrf9DDLJFi1CobH+uu0D62ieR4lmw+8Zv57jpq41b0y+Z
/B0MLMa6nbP+daVsbxPcT9RN1poVlOpAtDckQDEaEz5W9aiD7eiTlveclBaYAqqb
LMxrJO2BDi9AFy1b5qRIIpTmAsbDYZQx4dsC1He4LC/PqUZGsLFSzpEqlH+37tWb
LrQcn5Jpq+He9o6deEHyXrOZXtN6dYhlXmxlIjyPc2pf8kGQQRgKnFKID44qaKo7
ZBGY1qL8VZowwCFnMWXpEaLbItlgog727/+xrVrJpX01UovWZD9e8coBF3fU8OCC
tH93X6PMRHScdTEOn/iB9iB65uo/Zf+alNAlvSPBrNLqhBpRgMq8XgJzLiJsauuu
/cnyidCjdC2VHqbSjUvCQNWj99DHxXuWLLgVYCGT7t/S5MON6W/v+woYuroNLDKa
SS1uDDC+BLnm/69fdxAwmYEX69EYy4JnhBBvCIG7+09QNArDtWNUeFP4FVHYY6pU
wHz/Jj47/fnkT9nQ377nexsud0hn7KEP0SzyFheZqM1vswWfg8e2jEF51HgZAdTK
XLAgE8PlwYHgFb2vLIN74K7zVTMk3f4tzu/Lqmb78aOLz9J1ZSU=
=kgXo
-----END PGP SIGNATURE-----

--qo7zVO9a9OQ5oQtr--

