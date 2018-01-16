Received: from eggs.gnu.org ([2001:4830:134:3::10]:46715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebRua-0002tI-El
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebRuZ-0007w9-6i
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:08:24 -0500
Date: Wed, 17 Jan 2018 00:54:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180116135459.GN30352@umbus.fritz.box>
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<1516110433.10494.5.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PZYVFYZbFYjzBslI"
Content-Disposition: inline
In-Reply-To: <1516110433.10494.5.camel@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V3 0/6] target/ppc:
 Rework spapr_caps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, paulus@ozlabs.org, qemu-devel@nongnu.org


--PZYVFYZbFYjzBslI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 02:47:13PM +0100, Andrea Bolognani wrote:
> On Mon, 2018-01-15 at 17:32 +1100, Suraj Jitindar Singh wrote:
> > The following patch series adds 3 new tristate capabilities and their
> > associated handling.
> >=20
> > A new H-Call is implemented which a guest will use to query the
> > requirement for and availability of workarounds for certain cpu
> > behaviours.
> >=20
> > Applies on top of David's tree: ppc-for-2.12
> >=20
> > The first patch from the previous revision has already been merged:
> > hw/ppc/spapr_caps: Rework spapr_caps to use uint8 internal representati=
on
> >=20
> > The main changes to V3 are:
> > - Split up the addition of the tristate caps into 5 patches
> >   - 1/6 query the caps from the hypervisor and parse the new return for=
mat
> >   - 2/6 add support for the new caps
> >   - 3-5/6 add each of the three new caps
> > - Patch 6/6 Unchanged
>=20
> Correct me if I'm wrong, but it seems to me like there's no way
> to figure out through QMP whether these new machine options can be
> used for a given QEMU binary.

Uh, I don't think so.  These are machine options like any other (just
constructed a bit differently).  So they'll appear in qemu -machine
pseries,? and I believe that info can also be retrieved with QMP.

> If so, that's very unfortunate because it means that libvirt has
> only two options: 1) just use them if the user requests the
> corresponding feature, which will lead to older QEMU binaries
> simply refusing to start; or 2) perform a version number check,
> which will not be accurate if downstream backports are involved.
>=20
> Would this information be added to the MachineInfo struct, so that
> query-machines reports it? Or would a new QMP command be more
> appropriate for the task?
>=20
> Alternatively, if there's any witness we can use instead of an
> explicit capability, let me know. But I still think we should
> think about a better long-term solution, especially because this
> seems to be happening quite frequently lately: see the hpt-resizing
> and max-cpu-compat machine properties, which are just as opaque
> from an introspection point of view.
>=20
> Sorry for not bringing this up earlier.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PZYVFYZbFYjzBslI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpeBDEACgkQbDjKyiDZ
s5JCZRAA0w0Ivx0wFGKH7tIoNkD98+ClrLcvWe/Ip0uAMcKGV538U+eUFGBDGwnc
4cRKcv0Hq+BuasA00Mzi/f/UnmfO4Ql/8kbVEfbKCPF2c0L9/eshgELHG2d5NGo5
Bk0HaGhKsCAMMx3kQLpTdGwrnW7+W+0gcBQ3nPB7latX+GLooOC6B2qH/FJN7CtS
sYPvw4CdTyDfc6AUzXMKeesFXpi0Y0AH/imMSX2glvkkm7i1hX8XwzVyGNHBs+KP
K49uMXpBxzIAQCwAY9tPUM1+LD4NZwRCI3uP6i0kW4cNoh0oNS6Cutwy0FajJ1jP
MywlFSND1sJ/rJsvNqVxy3Dd5y+mFu1xXRX0zNwxc9tcPWiQg67OPyfRQ5HEcrsY
SZBMqHRb+6iCoMc0OIkra30GzJ+7CDzoJg42cjKMwfZ4bB59Y96z++bJqt1a1SCD
DbH/8E2G9VR7XmuX3JdWe1ca4QnkJgM0exrjKtNOEfrZd9Et51y0Pd5M6Sh9gfyI
1kizrsMo/J4GTTN6hyfOni1THl9AifA13E0CJlnXgDdg9pbPELbKvMB8COjZ5MYW
sCxYP7L+uc7YypU2OY7IaHSSbOsDilIGu26P8FQdQpBUupw6Q9n0WnENL4F07pTK
5vJZUaq8rJtxdSl/4dUvip6CLYth6TB3Yd8ST/pgSeJbtucCa44=
=gYcc
-----END PGP SIGNATURE-----

--PZYVFYZbFYjzBslI--
