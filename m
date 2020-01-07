Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C93EC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:17:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872C0207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NHWU9bXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872C0207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iok3S-0005L1-Fs
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 03:17:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iojPO-0005La-6C
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iojPM-0007j0-OI
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:09 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:48475 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iojPL-0007f0-Ru; Tue, 07 Jan 2020 02:36:08 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47sPLq666Vz9sR1; Tue,  7 Jan 2020 18:36:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578382563;
 bh=JetNSslyu4u5D18ZvFLHkWiAUQyN3ZVxUAL03C7Lg5E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NHWU9bXr3+80UXpfwpYlUXX5C9Ga14dXTeb1afXsn9HfERvpQKlnYFnXXz+EDKgPW
 DAZnFGduEA43MNLjYQ/jMUb09a/s90Pc9/jm3MlAVak8bZJJV8DHW+UN3bVHi4Y5oR
 Kc4WNRNorq/McBvRll6bGSvkfP/psOxTQ7xBEgZI=
Date: Tue, 7 Jan 2020 16:54:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v2] spapr: Kill SLOF
Message-ID: <20200107055436.GI2098@umbus>
References: <20200105234242.78897-1-aik@ozlabs.ru>
 <20200106041940.GV2098@umbus>
 <835b2928-aff9-c2d1-dfdf-60d915706404@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0bvna4DSzZXbdO1R"
Content-Disposition: inline
In-Reply-To: <835b2928-aff9-c2d1-dfdf-60d915706404@ozlabs.ru>
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


--0bvna4DSzZXbdO1R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 03:44:35PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 06/01/2020 15:19, David Gibson wrote:
> >> +
> >> +static uint32_t client_package_to_path(const void *fdt, uint32_t phan=
dle,
> >> +                                       uint32_t buf, uint32_t len)
> >> +{
> >> +    char tmp[256];
> >=20
> > Fixed sized buffers are icky.  You could either dynamically allocate
> > this based on the size the client gives, or you could use
> > memory_region_get_ram_ptr() to read the data from the tree directly
> > into guest memory.
>=20
> @len comes from the guest, I am really not comfortable with allocating
> whatever (broken) guest requested. And if I limit @len by 1024 or
> similar, then a fixed size buffer will do too, no?

I see your point.  Does this call have a way to report failure?  In
that case you could outright fail the call if it requests too long a
length.

> btw how exactly can I use memory_region_get_ram_ptr()?
> get_system_memory() returns a root MR which is not RAM, RAM is a
> "spapr.ram" sub-MR.

Right, but you know that RAM is always at offset 0 within that root
MR.  That said, it doesn't look like it's that easy to bounds check
that pointer, so maybe that's not a good idea after all.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0bvna4DSzZXbdO1R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4UHRoACgkQbDjKyiDZ
s5KelRAA4aK3GP1xfnzXlXfDQ2vAdD0RhPkAng7TjJFi2UmrAKpmGDsAGz+wP4IF
l47J8WDNVgfhAw1IerBKlgZ5q5xKr1fwMj91QzmkzuJqc7cnOl/CKYr66YdQd5x6
WcPnU82HHJRytW2KzWb2WaFe4YZ8Y1zZBdmo5ZuV86smhYXd5hSJ2ek+VuKXMzmi
S8BwK6ZSlv/b5UWQnsBzSC1JwiFtTZrrN+Gxqp+dtdaI6/oSmYJKGgrl7kPVgsUO
2L0dow+sewx4CHny6rlUHN2TtweLFP+wuRQRD/eq2klC1ER193ibIPq610MyN7GK
PzdQYKDfvZ2rTrrwbMiBJR6FBBG7krD+8HRyardDolR/pQ3g6OQA5Pe05xQlZoMj
U0JryPVnVHRO6rCCxYnkV6Nv5TFHA0fK4P1rvMgx3/PQtZHOd7sXw1QqDIlqrTNP
SjwtH3pmKT3hUSd/Vs5bzVdgFSBeSd89SWhnCU1FXydQxUG92oYxwmkKUHodSCC4
1+vdVz3EkLf/7Y71/jBYevBVqLpWZMmrFpP+DCVx8CNcOMqELg6DYUruvxrUxNnb
bqaGn2Ijlu9lF1Qez8hqDN4zSqvyuKH0WDDOJ6pfCvUwoOeFxbpMuvJVNI6EqNhc
JvBFDKyPhl294P0DQwyI8iCWiPm4+ot9Z7aiw6/KDLRT4kj62vk=
=pRz7
-----END PGP SIGNATURE-----

--0bvna4DSzZXbdO1R--

