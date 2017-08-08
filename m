Received: from eggs.gnu.org ([2001:4830:134:3::10]:59155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1df5YQ-0007qN-Vt
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1df5YN-00089N-1c
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:32:18 -0400
Date: Tue, 8 Aug 2017 22:44:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170808124411.GE25081@umbus.fritz.box>
References: <20170808060817.2832-1-david@gibson.dropbear.id.au>
	<20170808060817.2832-3-david@gibson.dropbear.id.au>
	<96975486-48cd-1ccc-209c-3f06f73f5d0e@kaod.org>
	<20170808125451.3281c2ce@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
Content-Disposition: inline
In-Reply-To: <20170808125451.3281c2ce@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/2] target/ppc: Add stub
 implementation of the PSSCR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, agraf@suse.de


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 12:54:51PM +0200, Greg Kurz wrote:
> On Tue, 8 Aug 2017 11:19:58 +0200
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > On 08/08/2017 08:08 AM, David Gibson wrote:
> > > The PSSCR register added in POWER9 controls certain power saving mode
> > > behaviours.  Mostly, it's not relevant to TCG, however because qemu
> > > doesn't know about it yet, it doesn't synchronize the state with KVM,
> > > and thus it doesn't get migrated.
> > >=20
> > > To fix that, this adds a minimal stub implementation of the register.
> > > This isn't complete, even to the extent that an implementation is
> > > possible in TCG, just enough to get migration working.  We need to
> > > come back later and at least properly filter the various fields in the
> > > register based on privilege level. =20
> >=20
> > yes a lot of the fields are only accessible to the hypervisor, and the=
=20
> > hypervisor also uses a different SPR number to access the PSSCR bits.
> >=20
>=20
> This patch uses 0x357 (855) which is the SPR number for hypervisor state
> access. But, yes, part of the register is also accessible in privileged
> non-hypervisor state with SPR number 0x337 (823). This will have to be
> covered later, but for now:

Yeah, I know.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmJshkACgkQbDjKyiDZ
s5LxeRAA3v5Xah9619NStpmaaTRctBf92lYLQGtPikvIL6d3Bbd3kq4eKReMUltT
WBk6KYUI4qsm+Rz7oxF1MDso+kxSgSvl+mwiljEZ/W87H3MF2bAEEEY1XD4KjOuM
tdlxyAATEO+LJGmATD8Af68Bpp9eLmlG2QVZ36PrEZkQq6yQGFHLqmZ0spaLd8Q8
JV8uu0QejGD9kD996rqh7YN4XOFbUQFcsEoi/mDXhG8/0ioA/gYgzuzjkuZMpIey
TI5Tewj/QOORGv5LriqXclk+fBPrORs28lp2zYsibtYE+Sx0fkWYK1YD7OpWi11o
g/4UBk4Fm/rlZu+LETN+V5VWTEAOVyzotdZ1H/vgXjccEAH3GN+6GXK4DNoiBTOM
CScNthmH8kDbwK03BEWz4x7Bo3Ut1+0KvXFd+fGI5f9jsnz21KAbKLZITz2vQ6Hc
mzKcCxeHVaivu0QU8VMTAx2UB6+Cp41nbXq1cW3Dfs6jPTDL9Et1RF7QX57KXsTx
5wDaCR2CmKA9CJTJrMntcPDSMRRJRorKtRSYKHsj+dyA8RRA2UjDD53z459p2Ype
eRaPfupVfM91gp9Z7S3F5lTWW7pypgNuWgO3O3ehhUmL/cexY1ycWALcVP9sy3gP
JB0hHSo5yGvPxdZVau99QmEJmHddhVxOfA/ePHqi90KbXDcHvzg=
=Dgjh
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--
