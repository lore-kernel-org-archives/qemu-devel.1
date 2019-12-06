Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AE4C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 04:22:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830102173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 04:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iJTrSZyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830102173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1id58m-0005OP-IS
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 23:22:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1id57h-0004QI-Ue
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 23:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1id57f-0004Vm-JT
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 23:21:45 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:38461 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1id57f-0004OU-4E; Thu, 05 Dec 2019 23:21:43 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47TfYC61VXz9sPn; Fri,  6 Dec 2019 15:21:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575606095;
 bh=7boRys3YcPkpLs69ArwRWS26VDY90VRF8n/5OHu59Vw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iJTrSZyxYwr8nMlxvr7n9HZOfSq4b2YJ+CbMVI3Mm3+iMG6xM/7kuybXMxodO2VP6
 ZfFXE7YHEJWnHGGdqI9AcywDLRfuPETIW7m8d4SrtlgAe+4hwWshpeYtsWztiMBYLB
 775Z94OvGjS7rTeLUUTqTBc/gysS92FRTrvqeAIM=
Date: Fri, 6 Dec 2019 12:38:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [GIT PULL for qemu-pseries] pseries: Update SLOF firmware image
Message-ID: <20191206013825.GK5031@umbus.fritz.box>
References: <20191206012529.81012-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="utPK4TBebyzZxMrE"
Content-Disposition: inline
In-Reply-To: <20191206012529.81012-1-aik@ozlabs.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--utPK4TBebyzZxMrE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 12:25:29PM +1100, Alexey Kardashevskiy wrote:
> The following changes since commit 1bdc319ab5d289ce6b822e06fb2b13666fd927=
8e:
>=20
>   Update version for v4.2.0-rc4 release (2019-12-03 17:56:30 +0000)
>=20
> are available in the Git repository at:
>=20
>   git@github.com:aik/qemu.git tags/qemu-slof-20191206
>=20
> for you to fetch changes up to e53a5569a27066a4f2f36ae368c728ab6c514352:
>=20
>   pseries: Update SLOF firmware image (2019-12-06 12:20:42 +1100)

Thanks, merged into ppc-for-4.2, and I'm preparing a PR for Peter
right now.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--utPK4TBebyzZxMrE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3psREACgkQbDjKyiDZ
s5KJvw/8DI6plNIhbsveOsroeb+Ba3ga1gcI7oGbUyZgGcb4H2FK5CB3k0dEvQ+C
diXsCWvMdFo+FcGtO9Ctml6xo+GFBzhUNLBUYQMObrh4iMkPOK8HlB/z0jupVumv
oxxIJMWyaro7TgSL8Z9cSM415fej7mEDoIXNhb/pGZA1u3/6Vivdvc94SCuwi70R
O4zfRqBPeIDcMK0TNNVTjMXo/yoITxhuRy9HjcDlKZ+1hTSuhIxMu+iboN44HxrS
NtzN7SQ2J3bjhznUcp4gGCdHS4XoZpVjjcwHWAYUNUACAF6QChy8EhfetCH6gv+t
ZSjCHurbIVX9HtHbDhU7gACSXbMLIbZqvYkx7LkGXhWLp7o7uC1oxr+lMTq7NS9D
cvTnQjOTzIE63gV6vUlrL5kBlYzYdETPirBjbTB9quD2Xc48eNXKQ8eJlaJEh25j
LE4nEaQjMFMcOO8XGlEAWyfrDflq3QMKoSCUNsMkbBgYSG7vzNUAbRfd2ameyWeS
V/QIAob7nDzDM+E3II9aHILt7Z5UEuKW7Py3vnNg3olJ/J7JYGGZZcDnTn6l67lP
YIEdXy9E2Eg40pLXJDNzGCoe8BKvEHhZQyj38nbpKQMj2N58oeRQumLQ2rKzjciy
B3l5qHMWN2fLhTIajO7E3AQDKzlrd8do6/m4QmovNhEEEBLRz5w=
=0kLc
-----END PGP SIGNATURE-----

--utPK4TBebyzZxMrE--

