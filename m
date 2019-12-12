Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5FBC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 05:14:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C94C4214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 05:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nJ6VFh9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94C4214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifGo7-0006ku-W3
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 00:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ifGnN-0006Ac-Fg
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 00:13:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ifGnL-00034E-L5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 00:13:49 -0500
Received: from ozlabs.org ([203.11.71.1]:54319)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ifGnL-0002zt-73; Thu, 12 Dec 2019 00:13:47 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47YMQc6Zrmz9sPL; Thu, 12 Dec 2019 16:13:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576127624;
 bh=pd1KMKYV9yAbe9ZtVg5Qf293MhkyNm4QHUg9ptTXDmw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nJ6VFh9WhAqPVUxjnY2rejV5aNw2b/ZSNgwqhZTDnX5AskPTkfk2Ew3FCvrUzu4Xt
 bxRxfq9mYxPYEWgEj4LPEUkwCHGn/gEz2fAqOpoEJeaJKuT4Yawbg3doPZvYUVgi3N
 LLlGxliPZtYPEbxKwtfbkfyb8P70C/9YpAcWH90g=
Date: Thu, 12 Dec 2019 16:11:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 0/2] ppc/pnv: HOMER fixes and improvements
Message-ID: <20191212051136.GW207300@umbus.fritz.box>
References: <20191211082912.2625-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TcuvTDpCAASXpu1W"
Content-Disposition: inline
In-Reply-To: <20191211082912.2625-1-clg@kaod.org>
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 bala24@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TcuvTDpCAASXpu1W
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2019 at 09:29:10AM +0100, C=E9dric Le Goater wrote:
> Hello,
>=20
> The first patch introduces a new XSCOM region for the PBA bridge unit
> (Power Bus Access) which connects the OCC (On Chip Controller) to the
> Power bus and System Memory. The PBA is used to gather sensor data,
> for power management, for sleep states, for initial boot, among other
> things. This first patch also fixes :
>=20
>  - BAR sizes and BAR masks
>  - The mapping of the OCC common area, which is common to all chips
>    and should be mapped once. =20
>  - OCC common area is in BAR 3 on P8
>=20
> and more globally, it fixes multichip support which is currently
> broken because of wrong mappings.
>=20
> The OCC common area is mapped at a unique address on the system and
> each OCC is assigned a segment to expose its sensor data. This is
> fixed in the second patch.
>=20
> Thanks,

Applied to ppc-for-5.0.


>=20
> C.=20
>=20
> C=E9dric Le Goater (2):
>   ppc/pnv: Introduce PBA registers
>   ppc/pnv: Fix OCC common area region mapping
>=20
>  include/hw/ppc/pnv.h       |  20 +++----
>  include/hw/ppc/pnv_homer.h |   3 +
>  include/hw/ppc/pnv_occ.h   |   8 ++-
>  include/hw/ppc/pnv_xscom.h |   6 ++
>  hw/ppc/pnv.c               |  12 +++-
>  hw/ppc/pnv_homer.c         | 109 +++++++++++++++++++++++++++++++++++++
>  hw/ppc/pnv_occ.c           |  11 ++--
>  hw/ppc/pnv_xscom.c         |  32 -----------
>  8 files changed, 148 insertions(+), 53 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TcuvTDpCAASXpu1W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3xzAcACgkQbDjKyiDZ
s5J5bRAAyDqHxbmwPfaAFB2xdmx3mLzBlLBd9tBl7gMCzpGFk1tNQHtCnaH510Ny
5qNtCyHaz5FwV1Wli4GsArZCTuQuszzuTtmb6nhX2lFmF8QlJk4Re+bfjx5/IFZZ
qmr5d84B2ua7cNKUdR5kw7BAx2Gjcxgc/Us+ELUcods8gMhuDzBhGBIHS82ZRyPg
EA2F9nsmAl8u0LFbFjhe2yc+CaGhYdR2Esu6eunUjJzBvKx2E1w6LO6+D4mkHoEd
9nsQi1tBFiT15NX3tEgmLwv0QIjfx+ZGdRNa8Sh3hkvI9+ntjxqGLz4BnHoCt51q
eelHVr3nkbzxIDgCZ1CD9KYIEXo8nJZqNy9d2O9vAglvHe6ulL52wti9ogeMB/wl
WNhTnwWkrGbvm4YhzXO7hkXPZqGqrt2+5iQ6nzPkk9d+JCE++yVuEI0gVQTzI5DG
rv0b3Gfvzpaw4BOCbw/2FXKv3hLktfbVyPY640xBlFp0sy0Sw3G9qhx1HL4tDmb2
FakXE3umHDOvSJPHYkRhOaoqzOjR3tr3zwDl2tnV9b+5UN9YNii9popFp/Hn4dld
50633A3acqg8jnVhlKWArZEpq8iClsHLjGqDIEpQZ6o2xW1lhi6qJ+iybyP3JY/i
ZeZCqCE0qvOnmWIvSm8gDbFxFAVcO61E8gm8O8SOWbH6IQBnP7A=
=rXKk
-----END PGP SIGNATURE-----

--TcuvTDpCAASXpu1W--

