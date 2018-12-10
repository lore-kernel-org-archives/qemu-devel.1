Received: from eggs.gnu.org ([2001:4830:134:3::10]:60443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWDyi-0002O2-0l
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 00:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWDye-0001lJ-Ez
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 00:19:34 -0500
Date: Mon, 10 Dec 2018 15:16:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181210041646.GK4261@umbus.fritz.box>
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ucgz5Oc/kKURWzXs"
Content-Disposition: inline
In-Reply-To: <20181209194610.29727-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v7 01/19] ppc/xive: add support for the END
 Event State Buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--Ucgz5Oc/kKURWzXs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 08:45:52PM +0100, C=E9dric Le Goater wrote:
> The Event Notification Descriptor (END) XIVE structure also contains
> two Event State Buffers providing further coalescing of interrupts,
> one for the notification event (ESn) and one for the escalation events
> (ESe). A MMIO page is assigned for each to control the EOI through
> loads only. Stores are not allowed.
>=20
> The END ESBs are modeled through an object resembling the 'XiveSource'
> It is stateless as the END state bits are backed into the XiveEND
> structure under the XiveRouter and the MMIO accesses follow the same
> rules as for the XiveSource ESBs.
>=20
> END ESBs are not supported by the Linux drivers neither on OPAL nor on
> sPAPR. Nevetherless, it provides a mean to study the question in the
> future and validates a bit more the XIVE model.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>=20
>  Changes since v6:
>=20
>  - removed the 'chip-id' field from XiveRouter
>  - introduced a 'block-id' field in XiveENDSource to lookup the XIVE
>    END structure when doing a load in the MMIO ESB
>  - removed reset XiveENDSource handler
>=20
>  include/hw/ppc/xive.h |  21 ++++++
>  hw/intc/xive.c        | 160 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 179 insertions(+), 2 deletions(-)

Applied to ppc-for-4.0.

I had some thoughts about maybe-nicer arrangements of things here, but
nothing important enough to delay this (the things I'm mulling over
wouldn't break migration, so it's fixable later).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ucgz5Oc/kKURWzXs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwN6KwACgkQbDjKyiDZ
s5K7AxAAxRHQvL8qEdfowUrzxN/HIjxCQkXNCSLxTZuQ4Y8MpOEeYiryo33Vo20u
2nl6HdvwcZFyDHAalXbQQXxBbAwpN9BTin4ADGRqbIZanhvlE5jhHlEqip+tEYKx
7AvU2x2fR7L8HQ6hIYfiT8GN900Gk9oCLPaiXrh3xc3eguO2Wand2jQocgGlSupx
1qjdK8pk/mwkq4Udk7oZ+pY6bTYwNMYEQO4NIZcYDsFj9cFvvZohSMAWi2VDIjbv
eI6bEoPoM7DfNJJWJ9ROTeO97mTUFs3qgMtuvU8zKBH+zP2CfneWnJdVV6N1LIz0
2JIgQKUPdGUSUzO2jW4wXXqkkIm4HtL4+7ZaIkPJMocf87XcJPG304On2Ot0fAMp
QJM4m2FbyZHp3IV/NTOBe2gde6hOe+peYcCoR6WBgbFrQaECn3a5FqUqEQbNhH+H
+BvsQuKbkGG60H7DMJYNSYsI3VNjZgLVRT3SOZXsE1Vji59AoZLT4781gFlO05u6
ZBZ1JLQTj9W1Ax+jR9MOzCt4FpH8pmLlYfYi4X9ad3C+zPnnbpjEpL6XzIDPEvAL
ClC/z+2JAlf6/F44sHwQ/+cy4L1FHvwDIojSBGcNt8WoGeN03DAurXM0hs0ezC8w
SeGlgNwBNcHqiM4U7PUDGLKuPqk1qUSG31rUZVIU498/jH6bUGs=
=QYH+
-----END PGP SIGNATURE-----

--Ucgz5Oc/kKURWzXs--
