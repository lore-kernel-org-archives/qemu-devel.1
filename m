Received: from eggs.gnu.org ([2001:4830:134:3::10]:36547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fhoDE-0001DP-Jg
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 23:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fhoDA-0000Ov-L7
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 23:42:12 -0400
Date: Tue, 24 Jul 2018 12:14:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180724021456.GF6830@umbus.fritz.box>
References: <20180628083633.12413-1-clg@kaod.org>
	<20180628083633.12413-2-clg@kaod.org>
	<20180718061230.GE2102@umbus.fritz.box>
	<bc6c5befa0a24b35f439419d6dea493dc19035b9.camel@kernel.crashing.org>
	<20180723041614.GD6830@umbus.fritz.box>
	<3692f644f72a1af49b7d5988d6b8482ea2f1e271.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TeJTyD9hb8KJN2Jy"
Content-Disposition: inline
In-Reply-To: <3692f644f72a1af49b7d5988d6b8482ea2f1e271.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--TeJTyD9hb8KJN2Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2018 at 09:55:53AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2018-07-23 at 14:16 +1000, David Gibson wrote:
> > >=20
> > > Now, this is an ICS subclass, so why shouldn't it directly poke at the
> > > target ICP ?
> >=20
> > That's ok in theory, but causing it to expose the icp interface to a
> > new module isn't great.
> >=20
> > > It's an alternate to the normal ICS since it behaves a bit
> > > differently (PQ bits & all).
> >=20
> > AFAICT the PQ bits are effectively another filtering layer on top of
> > the same ICS logic as elsewhere.  I think it's better if we can share
> > that shared logic, rather than replicating it.
>=20
> I don't know, is there much shared logic ? And the shared bits are the
> subclassing, that's handled that way...
>=20
> This is really a different piece of HW, a separate ICS implementation,
> that has its own quirks, is configured via different registers, does
> EOI differently etc...
>=20
> Even the resend stuff is done differently, the resend bitmap is
> actually SW visible via an IODA table.
>=20
> I mean, we could (maybe we do these days not sure) have an ICS
> superclass wrapper on the actual icp_irq() but that's really all there
> is to it I think.

Hm, yeah, fair enough.  I realized what I was suggesting would
actually need another layer of qirqs than we have, so it's not a good
idea after all.  Ok, I'm happy proceeding with exposing icp_irq().

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TeJTyD9hb8KJN2Jy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltWi50ACgkQbDjKyiDZ
s5Ld8g//ZegA0/oB9hdcQeUlLF0LyVdr97tvWZ1tI0mEX1C5yRb+6Kn+6SiS8EXR
TWSRwkSVrNqHxCWzqFifz9ak1yEo6hl/fXnSbLo7V1lHghIOlzsX1fIe6+HShPj/
u4RQ0oo52+7TZ9ToskWM+rbdsQ+T1xyRaANcgrp73CkrkBumQxlctWx28EQKpcGB
5mkAgek6PysMhM0uPr6QkJHsrXK7+mNEHyhtqkHvKj/Dhk5humvgeif/6UARzYJU
K99kR/GW2vEUwIA02YADUyz3QFI9gWF2WYPI5DarVD07M0MFvZNsZ2EkRgzQJDCd
nJNZwlnfZ6PjHZVUBgTbGiVxNQCF4HIH37KcS76YicXo/a00PgKLyDQhnjmuQg2k
aOJBtSJQ1Wp1XdIYDatNDOhbO34P08zFyapYU/EVq061HlLvbH3iU9k83ibbtLKb
jxrhyx+nwYhKKdwISfgtRBYrJcXPC7sBfx+6omZXuwbtFeD8yDZPELXDa+3B4WhG
r8ptDByvaHmF7FchMs3DBIoNPIojp3yLu7I71HECRc/TkdEjYCPqkPj90+JExHpG
5sdkDNY6TaJzWTVPSCv4J5hl5M31Bse5Cd4pczqD3ZM87Kbk5LWob7qUrBLKzRgV
Y3FGoJD7cJJv5r7Zh7kr7MCLHoMcuDxpIEFlA55jlKUBPcxolHQ=
=RHjw
-----END PGP SIGNATURE-----

--TeJTyD9hb8KJN2Jy--
