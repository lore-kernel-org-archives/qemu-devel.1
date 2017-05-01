Received: from eggs.gnu.org ([2001:4830:134:3::10]:38150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d53Dt-0004Cz-Dq
	for qemu-devel@nongnu.org; Mon, 01 May 2017 00:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d53Dr-0002KP-KC
	for qemu-devel@nongnu.org; Mon, 01 May 2017 00:46:08 -0400
Date: Mon, 1 May 2017 14:44:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170501044421.GF13773@umbus.fritz.box>
References: <149346893378.132.3063923710149667629@c05f1edc8ed1>
	<8874ac16-9e54-7c67-8e56-8ed92942ee58@ozlabs.ru>
	<20170430131104.GA24566@lemon.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
Content-Disposition: inline
In-Reply-To: <20170430131104.GA24566@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH qemu v4] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, f4bug@amsat.org, peterx@redhat.com, borntraeger@de.ibm.com, alex.williamson@redhat.com, qemu-ppc@nongnu.org, cornelia.huck@de.ibm.com, pbonzini@redhat.com


--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 30, 2017 at 09:11:04PM +0800, Fam Zheng wrote:
> On Sat, 04/29 22:36, Alexey Kardashevskiy wrote:
> > > =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> > > Checking PATCH 1/1: memory/iommu: QOM'fy IOMMU MemoryRegion...
> > > ERROR: spaces required around that '*' (ctx:WxO)
> > > #156: FILE: hw/dma/rc4030.c:720:
> > > +DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_=
mr)
> >=20
> >=20
> > What does the script really want here? I am confused.
>=20
> Must be a false positive here.

Yeah.  I think it thinks that's a multiply * rather than a pointer *.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZBr0kAAoJEGw4ysog2bOS+nQQAJtO/mNg/dcwrNUPwhR/bT9Z
D65EfMZdzlVdu1ycJzxsG/kLpcTx90HuquIHuf5XNSvnQJfoFXtUc9z50TlrXnoM
QhxeyiQqFz6qsAOOQeFaTSQ0k6B9aAOm8QeFk1UU2ZaHQxn3+iG7AYd23RrLU5bt
8azx+qgSXeco6tRbTTdrrVL/GvJ1lj6+IATEqSORyGGBPjjcb6QL/qU1UikaUCYs
Erh4TK7tYMFUbrylN/2DoYTfukhuiCaEPCm2xtAte5gH/BSRKW6M3k9mbew5E7LL
ttdV3+iegvxyrsq6XKikEfZhZDQd5RenT1HfoGTHGx9zSYs6uvhQYxg4fFOzYXg5
tRIl9RCBLy1JhtaS9K0NiGpnNNlAO3eahRUosOfNh+mWCOI9ty2tiBXFebG8Ikyw
EYe4fuymPem8T4cOveSc5euFuWEbChImh0j2uAPs4ueGULldO9XqAHr8cW2fCPBZ
CJN8r4o0BMFtbAgO79VDYfJnj/IAOB30P74N9MPjT3FvXDAIyvriFk1mQKgrTckL
fh0k++afx7Drmu+qJhI9Up+5KScNBu0gHZ+sUkWDBRjv7FPActSUZXUHKaU0y8aH
MKIG5wB0UaKp6iFdRkFvanwdVinkZQqq4NbAh8dt3/SZYofwLup73rSKvm09M+Hd
VG6KdOohx1uNgSAhWS+v
=waaP
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--
