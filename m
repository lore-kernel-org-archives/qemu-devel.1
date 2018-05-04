Received: from eggs.gnu.org ([2001:4830:134:3::10]:57013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fEUjA-0006iG-Ko
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:02:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fEUj7-0006YA-Ix
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:02:00 -0400
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:51474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fEUj7-0006Uw-C6
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:01:57 -0400
Received: from player691.ha.ovh.net (unknown [10.109.120.118])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 18638F3439
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 09:01:55 +0200 (CEST)
Date: Fri, 4 May 2018 09:01:45 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180504090145.3859e638@bahia.lan>
In-Reply-To: <20180504063719.GC13229@umbus.fritz.box>
References: <152538217073.223014.17347204768561945420.stgit@bahia.lan>
	<20180504001102.GH13229@umbus.fritz.box>
	<20180504075821.0e0cbdc6@bahia.lan>
	<20180504063719.GC13229@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/M9YIB2TkI9+k+MsXhi2V+La";
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

--Sig_/M9YIB2TkI9+k+MsXhi2V+La
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 4 May 2018 16:37:19 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, May 04, 2018 at 07:58:21AM +0200, Greg Kurz wrote:
> > On Fri, 4 May 2018 10:11:02 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Thu, May 03, 2018 at 11:16:10PM +0200, Greg Kurz wrote: =20
> > > > Hi,
> > > >=20
> > > > It is expected to be able to migrate a guest started with
> > > >=20
> > > >      -machine max-cpu-compat=3Dpower8
> > > >=20
> > > > from a POWER9 host to a POWER8 host. It works with recent QEMU vers=
ions,
> > > > but it is badly broken if the destination runs QEMU 2.7 or older.
> > > >=20
> > > > This can cause problems in cloud environments that still have syste=
ms with
> > > > older QEMU versions, eg, hosts running ubuntu LTS 16.04.4 (QEMU 2.5=
) which
> > > > are likely to stay around until admins could transition to some new=
er OS.
> > > >=20
> > > > This series was lightly tested, but the patches are simple enough, =
so I'm
> > > > confident they shouldn't break anything :)
> > > >=20
> > > > Please review as I'd like these to go to QEMU 2.11.2 as well.   =20
> > >=20
> > > Applied to ppc-for-2.13.  As you say, these should probably go to the
> > > 2.12 and 2.11 stable trees too.
> > >  =20
> >=20
> > Cc'ing qemu-stable then =20
>=20
> Thanks.  I'm about to go on leave, so I won't be around to shepherd
> these into the stable trees any time soon.
>=20

No problem. I'll take care of that with Mike.

Have a good *disconnected as much as possible* holiday ! :)

Cheers,

--
Greg

--Sig_/M9YIB2TkI9+k+MsXhi2V+La
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlrsBVkACgkQcdTV5YIv
c9YDZxAAyGYUqdX9LnId6AA8D8o+xyOfd9KOPbJhng6Z1vL4JIxJ4XNSoAqPND4d
SZZq3w+sBGnWEzmDxRgdayjwGBLy6diCeydTli6/UAHX5xL6TgYByWKd/9dX5TPd
4SnYCDmZ1HAiPEiejjTqpxcUoZIuWmb9FUG3WDQZ5t8FQO61AYv2HtOMUowBgZoB
lOsy7/vYCwxehYkf/sdofVgYJhou/DQp8T2ClepVMaGM8a1TUV/t7pZir5VVEeXy
qy3GCQoPu8eMCB9DKBe2h8W0tDmoO0Hp1MTjgo+VDPscH+Eb9UuYlm/8zHv4+O5u
8yxni9zOFTHmNdvgClraVq5C3fkmjlu6Xgmg/s+RhulJVOLQ1MvkUYoQEgnFWwC9
3+5CK5NRWc1BpsZBk+7jgL1zDnpI3Ck8bX/rmkVd2j3JQi0gP2plVBKMJ49ocsu3
JQPjRO3gy2blzZdvFbfttWSRCsQbcNWfcBezdLC8mgmSQ5ZX3j78ShBBKBHW8TOG
02tUpMGV/2K3AZB92bWpY8aOSA1msxUF7P+mdBS9dq7oos3isSfh4pt5/rkxyk24
yKBIrxtgKWWeCQ0REqFpOlT6Y6ZcngR8rp920dQ8JWHHV6opIZTfFItqkf1/TEeB
K/OW3kkR/Ep45QsONBRK5ZN4N9iRjYeJYfVHa0zEKlZ7P1vlGYQ=
=+XEr
-----END PGP SIGNATURE-----

--Sig_/M9YIB2TkI9+k+MsXhi2V+La--
