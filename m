Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F4AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F304F21527
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HijhXZ4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F304F21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlTnm-0006Uo-AZ
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 04:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jlTn2-0005Sz-9f
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:51:24 -0400
Received: from ozlabs.org ([203.11.71.1]:49005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jlTmy-0008Ov-C8
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:51:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49mzLk49PBz9sSS; Wed, 17 Jun 2020 18:51:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1592383870;
 bh=0+FYW3NBWHrTQS0RCZY11LeSU7FhrDKvno8HqAobQ7A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HijhXZ4CKWXOBeB3oHpt+/mGJD7+uvgBx2uQAAA8hoKzRUsCrLsHxImls1u490Sp8
 PIdLuzVzVlTi5gyJ+Fh7Yh4sAIQ8XI2uLw0vp7BvbxfVwIn/ZMbxPEiUHyjw3z9LhW
 1t0rJ7Gxnr3JmwGrNp7Tz2ZQ+xfup3nOYm+gn0Q8=
Date: Wed, 17 Jun 2020 16:39:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH 0/6] Add various undefined MMIO r/w functions
Message-ID: <20200617063956.GA12597@umbus.fritz.box>
References: <20200617053934.122642-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20200617053934.122642-1-ppandit@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 04:51:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2020 at 11:09:27AM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> Hello,
>=20
> This series adds various undefined MMIO read/write functions
> to avoid potential guest crash via a NULL pointer dereference.

Hrm.  If this is such a common problem, maybe we should just add a
NULL check in the common paths.

>=20
> ex. -> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3Dbb15013ef34617eb=
1344f5276292cadd326c21b2
>=20
> Thank you.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7purkACgkQbDjKyiDZ
s5LsRxAAkXYwhL1HBOFLEAKJmIZCW04W9UE9P5S8mfNufR6mhukM8/mkI77WaJT6
3IE8dZrbdmGnY5HVAib4lMF0mEQ/jSv0bjbDedIE4fmr/vPos/5dHme+J1pZ3JqR
/6wcfJwy0k6aeMZpVVp495173D1wt/BO8LOx5IgWzqIVbiYR6KqC0+IjbUNsE/nE
73cryPoP2SEKvAyChYdj9kDKDpun6/MiMt7gYMFrW1FeMqV8otsvR2hlcX3oH95n
xx5MeyVCZv1ESKM6crraHelpkL5xfO8GlQerQjXp4YpxbnYrZKcV3PmqQGvFFs3l
T1ab8dYiygMOtqdizdmMhGGDkDPOlpHj3JiGPGRuGqxNHIySANNU4TTctOIy0Pkn
ITmIDCEKMRMYmm+OoJMUqXKNmLABmyo7NPyF2M/gU8cJoOj0Va96tLu5SCfNf4vE
4pzLT3z6leZbAccISYtAXYFQUDe/w7F/lEH4u2zCtX2uLbgoL5huEAMgvhcKwZXo
nE6LE/XXaAUcNwy2urVlOVieCsd7gsa5Z6f0GIZrjmIZftzxa8bryA4y1zHdHQpr
muRl/4uXCy5OjJLwBNG3+hOReGCtUpgL/9BI7OqaxuM4sZfS/umzEJxkN1b7uQi+
B/ytJFu3HAbI765aaCSs479pDsiTWrgUQhFA4iC1ydglwRAWLUY=
=fA1d
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

