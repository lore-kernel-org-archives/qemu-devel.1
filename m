Received: from eggs.gnu.org ([2001:4830:134:3::10]:58173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fRDZo-0007Dp-QI
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fRDZl-0006LG-HB
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:20:56 -0400
Date: Fri, 8 Jun 2018 19:20:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180608092023.GU3344@umbus.fritz.box>
References: <20180507180835.4b7b9222@bahia.lan>
	<20180507165242.46502-1-leandro.lupori@gmail.com>
	<20180604005322.GE4251@umbus> <20180605184612.42099707@bahia.lan>
	<20180606005317.GD17757@umbus.fritz.box>
	<20180606111922.66882650@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GMArzDD+OGn24EFp"
Content-Disposition: inline
In-Reply-To: <20180606111922.66882650@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3] target/ppc: Allow PIR read
 in privileged mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: luporl <leandro.lupori@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--GMArzDD+OGn24EFp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 11:19:22AM +0200, Greg Kurz wrote:
> On Wed, 6 Jun 2018 10:53:17 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Jun 05, 2018 at 06:46:12PM +0200, Greg Kurz wrote:
> > > On Mon, 4 Jun 2018 10:53:22 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Mon, May 07, 2018 at 01:52:42PM -0300, luporl wrote: =20
> > > > > According to PowerISA, the PIR register should be readable in pri=
vileged
> > > > > mode also, not only in hypervisor privileged mode.
> > > > >=20
> > > > > PowerISA 3.0 - 4.3.3 Processor Identification Register
> > > > >=20
> > > > > "Read access to the PIR is privileged; write access is not
> > > > > provided."   =20
> > > >=20
> > > > Yes... but a little further down it says "The PIR is a hypervisor
> > > > resource".  Looking at the older 2.07 ISA, it says that
> > > > guest-supervisor mode reads to the PIR should be redirected to the
> > > > GPIR register, which this change won't accomplish.
> > > >  =20
> > >=20
> > > Hmmm, there are two definitions for the PIR, one in Book III-S (4.3.3)
> > > and one in Book III-E (5.3.3). It looks like you're referring to the
> > > latter...
> > >=20
> > > [Category:Embedded.Hypervisor]
> > > Read accesses to the PIR in guest supervisor state are
> > > mapped to the GPIR.
> > >=20
> > > The Book III-S definition doesn't mention the GPIR. =20
> >=20
> > Oops, sorry.  Yes the GPIR stuff is only for BookE.  The statement
> > about the PIR being a hypervisor resource is definitely in the BookS
> > section, however (both 2.07 and 3.0).
> >=20
>=20
> Yes it is, but IIUC, this means that the guest cannot modify it, eg,
> do mtspr. Section 4.4.4 in Book III-S has a list of SPRs that seem to
> indicate that mfspr doesn't require hypervisor state with the PIR.

Ah, yes, I was looking for a summary that covered that, but hadn't
found it yet.

The patch doesn't actually apply clean to the current tree any more,
due to a rename.  So can you repost, and I'll apply.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GMArzDD+OGn24EFp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsaSlUACgkQbDjKyiDZ
s5IOmRAA3KsZdwEcYc6FgR1Ub5ifuwI4GdYYAWbB7e8OBtBfGdZyJccsCBU2/Ssm
3T5XrmNexntb8M/Jzoz+XbY8YQ3FOOxaSUUmKb4n4nTGO4OSPZQCVSpPNko1E3T0
5rtyM4xtDof+G9AwjwjowTQw3DKrxgq/G4wylTPEO7P0eVlz2j8rYWKZOWYg7Adj
/Vw13AAAQQHCZATCR/GNRu8lPfXiwyGlnlxdLzLj7v9kCACnNORj05i2C+fQKYR2
f0FKStZ2t+B1v/WQDwRKzKlHr7p+8xopr1xk+B+1Z9gKj2iFmcCBCQaruorRQUUH
jlryivGLdukZo/0tO+Yr8bgjpnP3PiRtJBIaQCek06yLHRPDzNQkoYotRSjXHTmC
T10BZB/7AhBiduwySfXG3sEwBzA26Z2lS1+QAQhrAYHMstzn+KTza0t+yGiuYnG9
0PAQQyaI1CfBrD5zFA0cJ9AQ9zCJOXPnwoU19+YenqHbZh7etJon0IU3iQruTWqO
iuewERDek/Dct/xlHoScHi09C1u9H54gGnKX0I2gQnidclkgpnrfdSDzX1RVerP7
1c2xqsxepKX477+TLM9m3VpRqD8Ewff+J+wJQ8ZABGVusTra0CDU9WgC1e1MegOg
oW1D+OPMdoh95WeG5abcUrZer5CYlymHl6FXEcz7yNDc4fAGk70=
=WV5I
-----END PGP SIGNATURE-----

--GMArzDD+OGn24EFp--
