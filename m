Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3012BC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10AF206BF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hrAunhAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10AF206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqufv-0001K2-F3
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 03:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37503)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hqufZ-0000dC-4P
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hqufX-00052H-0P
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:29:36 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:55811 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hqufV-0004Yh-ME; Fri, 26 Jul 2019 03:29:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45w11J357zz9sML; Fri, 26 Jul 2019 17:29:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564126164;
 bh=T/CkzG/oEzmOdi0Gilq1YYB3wbtv+ndFQICGPFn8GGI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hrAunhAUoFuQ7vKiQSRrCkUSnU6WE11k8U6591+OcA1naPk/u1UtO+wrGzCCp890k
 uO4tTxB4qXppziSLcFP9HvG2YN2jDKdYejZYbElmvjeKPR6V4B2FwdNAhFb33+lN3F
 fC8nZDj/PxQizCfG78PrvqGC2UFa+nxbrviyGlGc=
Date: Thu, 25 Jul 2019 13:38:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190725033853.GE28601@umbus>
References: <156398742921.546975.8822387598242513827.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
Content-Disposition: inline
In-Reply-To: <156398742921.546975.8822387598242513827.stgit@bahia.lan>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/2] spapr/xics: Last minute fixes
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2019 at 06:57:09PM +0200, Greg Kurz wrote:
> KVM on POWER9 doesn't use the XIVE VP space optimally. This currently
> limits the number of VMs we can start to 127. Starting with the 128th
> one, KVM fails to create the XIVE or the XICS-on-XIVE device and we
> go through the fallback paths in QEMU.
>=20
> The XICS error path still has an issue that prevents the guest to do
> interrupts, even after QEMU fell back on XICS emulation. This is
> fixed with patch 2.
>=20
> Patch 1 is just a _trivial_ improvement of the warning that gets
> emited when falling back to emulated IC. Feel free to apply it to
> 4.2 or even to drop it if you don't want it in 4.1.

Applied to ppc-for-4.1.  Finding a time to do a PR will be
interesting, but I'll see what I can do

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl05JE0ACgkQbDjKyiDZ
s5KmXRAAtfE1xtHy2tkao89YjMuE3i03ua1Jz9m2y+6pQ0rsqS9tPKhM0WwqQToo
J3srkGkqONL7xg8IZLScHiozAVVGLoS+AIfrq608nV0dn+uPd9MKOH4XAW1gbrJh
GZO7bE82VPRZA0MEJgR0h2Qh8qdTfDBchXfTGBieBzz6KgENx/n42eeWl+NJmKCr
G+ANoaHujxxkbAHA55Cw8rav6PHBawMgRvKkaF273rgq/QrHUbl+qE9n14JWqj7V
pjXx3W5S2x8x+TN55yCuf/lZd7t+58SjcE7B9ouR+0Y7h0fdzJubdA9dq7nMFags
6/R9Gq9UXCV8zTUyGt5HhsCIJAk2W6fpoOzeTlWqWEbHocsEGYYdlZXG9qmgmYBH
xHK46RAZ0k4kR98T/iPV/lkRrPm2GnxrZQoFMAJN233fo25BjpTnrIb8twNR5p6J
Win3judo7no+qVqh3FUfVxg5KBVT21Uow+7Setqya0M41piUgRixNNW3wEkrfv0R
WWn4y3fuWtOnhzaBLhjcLr2rPjhulRvwNSFya4e0xnQZ3aE+cjudvrhsoX3mEsvU
9mFWRqRrXpT1B0tQI7qA877UE1F33PQe9p0tzYZzmS2wh09DK+P4AkN+ZdAMIzR5
lqJ/8mWX2ybD/zmbHz+DNtwTq9jO2hQiQqqfWSN86IqW720nmMI=
=SPaf
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--

