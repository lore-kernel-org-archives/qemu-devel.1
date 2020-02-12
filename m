Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A66C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 23:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8309021569
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 23:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LoJ63jrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8309021569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j21nc-00020j-O9
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 18:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j21mc-0000ia-0l
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 18:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j21ma-0004p6-B1
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 18:51:05 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:54577 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j21mZ-0004nT-Ju; Wed, 12 Feb 2020 18:51:04 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48HxH74YFNz9s3x; Thu, 13 Feb 2020 10:50:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581551459;
 bh=5FhWVspFSoju4kUNIEAQTlU9FL+Urm5G1BLoaaFjsh4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LoJ63jrKzGa0/VthtEHVUmx43JEvtwWaDB+xpZnt8Uy+mCtOpo/GXujLEEbtKgIM2
 pfCS6+EPLWuCdexywD4zhTxTCqr9kSXF2f6EhDBKLX+kILG+lJKwF7Qc4qJOPa2hHC
 mDIIzxuLiTGBX6n6G0r04HZhC9g1O/68T1KnUt+8=
Date: Thu, 13 Feb 2020 10:49:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 0/3] pnv: Fix a couple of issues reported by Coverity
Message-ID: <20200212234917.GB124369@umbus.fritz.box>
References: <158153363409.3229002.13469293798150754920.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <158153363409.3229002.13469293798150754920.stgit@bahia.lan>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2020 at 07:53:54PM +0100, Greg Kurz wrote:
> This fixes some issues in the PHB3 and PHB4 code that was merged
> recently.

Applied to ppc-for-5.0, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5Ejv0ACgkQbDjKyiDZ
s5Ijrw//bh9UXJvesObelmwDjarsDWXTux3JWI9oDfsM2onx7HlNSCQy8v0Uq/xj
d7NDhH9abBOlO8pzBdiIEKsn7InfD1ESqv3uHP59/AQdrDDPju2ofvJEP6J1TWo/
tD6TcvDwO6Q4MmeNqlO2UWtEOVBIwNBWGsjwvMd6PgEhzzRE0noPH/ZbJ98dCZ3r
zDQiw9Kkp9LxR6J6/fZ9JoY/Ohrg2AEIWlNOBX2VXPiJO+Tbw2ODIJelqsuqEgPN
CGEOsw+JP9ORJ9g6NU/rVwL5iEApRNXdQfg4kRYgjdSamowXdDBLYFz+m4uTWOjC
b+1QULEuhX9PzEYQEpXFuc63O3g72JEDe5pcXhj87mK4Ozumge8c/LbV/LAV7aA1
EylYcmg/n5MaW0AXZKkjtgi27v4+R5+HdYjtsgDeCBzc4slMgrfZZj/oD3DT7aeZ
xHCDW+DwKLbPMczsKYWewF5iRl9Rou7FEmWlvZG9NUCTYK9yPvKSLeZWi61dNX6d
PtqAm79Pf8Q+l6esaz56uKVSVJVrNbiwP0c2E7mG/Q3mcWKKXUDXD/4Sconr7qm8
DBAem2c7PWR2NvlrNoJKAZ1b5WUbC0ifm9hd/xYZRa6X01/DvFWaw8GRT6uPbFLx
FU5tIZcn77RGSZCXagN7SzUKS56JcCSsJ156CNfkQbrYcwTW8LI=
=9Jum
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--

