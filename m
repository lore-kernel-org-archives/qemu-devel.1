Received: from eggs.gnu.org ([2001:4830:134:3::10]:42870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fETjp-0005LE-B7
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fETjl-0005hD-EN
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:58:37 -0400
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:49642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fETjl-0005fH-6U
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:58:33 -0400
Received: from player750.ha.ovh.net (unknown [10.109.122.70])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 79EEE158D84
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 07:58:31 +0200 (CEST)
Date: Fri, 4 May 2018 07:58:21 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180504075821.0e0cbdc6@bahia.lan>
In-Reply-To: <20180504001102.GH13229@umbus.fritz.box>
References: <152538217073.223014.17347204768561945420.stgit@bahia.lan>
	<20180504001102.GH13229@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/OE0ro/LYX=_ead5hmeY36gp";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 0/3] spapr: fix backward migration from
 POWER9 to POWER8 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-stable@nongnu.org

--Sig_/OE0ro/LYX=_ead5hmeY36gp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 4 May 2018 10:11:02 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, May 03, 2018 at 11:16:10PM +0200, Greg Kurz wrote:
> > Hi,
> >=20
> > It is expected to be able to migrate a guest started with
> >=20
> >      -machine max-cpu-compat=3Dpower8
> >=20
> > from a POWER9 host to a POWER8 host. It works with recent QEMU versions,
> > but it is badly broken if the destination runs QEMU 2.7 or older.
> >=20
> > This can cause problems in cloud environments that still have systems w=
ith
> > older QEMU versions, eg, hosts running ubuntu LTS 16.04.4 (QEMU 2.5) wh=
ich
> > are likely to stay around until admins could transition to some newer O=
S.
> >=20
> > This series was lightly tested, but the patches are simple enough, so I=
'm
> > confident they shouldn't break anything :)
> >=20
> > Please review as I'd like these to go to QEMU 2.11.2 as well. =20
>=20
> Applied to ppc-for-2.13.  As you say, these should probably go to the
> 2.12 and 2.11 stable trees too.
>=20

Cc'ing qemu-stable then

Cheers,

--
Greg

--Sig_/OE0ro/LYX=_ead5hmeY36gp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlrr9n0ACgkQcdTV5YIv
c9bnIw//Ss43H0nKFd7gPYucH8NALKzHQ9R7zDrsx3rnF8T3FfwJWMT4NG9F8UZL
KcGtNVauC3iKt4BbNPLLI2GXiKilZy0iBbOdtyQwRMKgVH436rArp+Z3ozvMroPj
MEqGaSegfp/DESYFZxSinhhrO442IzKojl4SxVoJBq/TGwy0G64xEhOBtGxz9Jb0
K9mqhKodP4csQkgx10f2bETWzmrTCiuKe3Rb8GAy9KmmguDfCmpTfTiGHyO9tRCb
UXD4d0fdHpvovH8y/bwLCLCsbjQ4yLf6OmoaHcMR7oUlwQx409MsJuL+RRi2G1Te
brW44610mUy7FIyWJnxszV0CpLiqjQxC8EPr9zdwCncm7ZDQlXgLCsKTu/jTGd2o
jImRuXpWzXE6v5KUG0pPDw4F5a7LKSDNwB4wQauTFWyr3qVRnLmybrJkQWxoRjmg
SMZeIpRYb4LPs1tAqNAcsGoG293kXqVbKgUeMwvy87oKEqsbuE1Gf3IWlLeoYzVy
hDFJ38js6OwK/Om4mXDKAjKVDrzaaBsyq39VuNwkb6C1opqdhI36V2MQKh/3sBVR
UH+3RFD/yzofFQ8phKdD254M666A47q2+qKp/oGizjS7mIfquYi1nWVLFvbrMHy8
8wKhAMeb2/QTzw6Z0n7+a3Muzcov4cY5F+yxTT+L0bsGzo532HQ=
=9cTt
-----END PGP SIGNATURE-----

--Sig_/OE0ro/LYX=_ead5hmeY36gp--
