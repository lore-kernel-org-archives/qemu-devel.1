Received: from eggs.gnu.org ([2001:4830:134:3::10]:36187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duX1E-0007wJ-Hg
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 00:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duX1B-0001J7-7n
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 00:53:52 -0400
Date: Wed, 20 Sep 2017 14:35:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170920043533.GF5520@umbus.fritz.box>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-6-clg@kaod.org>
	<20170919024544.GK27153@umbus>
	<f4c2ca7a-0757-f847-7a3e-4907d9b6582d@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Wb5NtZlyOqqy58h0"
Content-Disposition: inline
In-Reply-To: <f4c2ca7a-0757-f847-7a3e-4907d9b6582d@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 05/21] ppc/xive: allocate IRQ
 numbers for the IPIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2017 at 04:52:10PM +0200, C=E9dric Le Goater wrote:
> On 09/19/2017 04:45 AM, David Gibson wrote:
> > On Mon, Sep 11, 2017 at 07:12:19PM +0200, C=E9dric Le Goater wrote:
> >> The number of IPIs is deduced from the max number of CPUs the guest
> >> supports and the IRQ numbers for the IPIs are allocated from the top
> >> of the IRQ number space to reduce conflict with other IRQ numbers
> >> allocated by the devices.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > This is more ick associated with implementing XIVE in terms of XICS.
> > We shouldn't need to "allocate" IRQs for the IPIs - they should just
> > be a fixed set. =20
>=20
> They are allocated at the right beginning so we can consider them
> fixed I suppose.=20
>=20
> > And we certainly shouldn't need to set the XICS irq type for XIVE irqs.
>=20
> This is because, in this patchset, XIVE and XICS use the same IRQ=20
> allocator which happens to be the ICSIRQState array of XICS. yes,=20
> this is ugly but we are identifying the different constraints.=20

Yeah, as I said in the other mail, I think trying to support both
immediately is making a mess of the XIVE design.  Let's get it working
as a machine option first, then worry about CAS and migration.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnB8BUACgkQbDjKyiDZ
s5IocxAAhojNUOxxas0HPUQYPCJtMW2TNrG7yov1twZk7VBE9ZR7t9ErAKe1ZH9u
YU74gtAvC9d1LMZ1Y5NSHbPC1nYGcqYhnXieUO2ZC7gj8euvTQyqIFCR+ne4Jonk
HBnCzYaWKqe8coPJiQskmmXwXo/SvwEAWuqzecJ6sXuoDKdPnqV4AWrjGxmUuhm7
KnFv8acwbTqptbEUls0WjaSvgNILjM/2PHRik7hWbWiYmiPEsAt6e9wFS/u9FGRG
ib3SPDKpp0T62g1sD+SQqt1vTjbHp4xrqnwNR/fKyBjfSHTxduQpzndC21jq8MVZ
swzHQzaWSiBgq9nyLEQw12NE7XzexZX13VipTzp0uyNi6/iWjY+Ek85M+gWV7lr7
QGM3TG8t9pk4L0CNYZLKgUCEbU0HKv+zCVuBYkLCTdjEzNP0n+vFI82/GykpaJ+s
9BIjVqVC8ZC9Imb5SZIn+h10ftdhQSKQfxrWKat+c+EiBS3cAmy1l+pY/9sYhS2/
jkpCZjvRCThzC14p4mV+wGNNuG9nAB3W6o+1Cu44AajAZ6vRVLr86n8nDSaKKgNw
vWQdDzCNbvOBdhAgCrLnRgOVxbQG3+qYbcRckCXX6P2UiSWs6A9bOFNTTLzUo+tq
IBtXxj9MnMuXpTuBe61lDqzMwjEn7y/PyooD/qPYw8QUKVlXPxM=
=Nx3u
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--
