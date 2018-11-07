Received: from eggs.gnu.org ([2001:4830:134:3::10]:59383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKFkG-0002Ky-Mi
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 23:47:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKFk8-0007BU-Bi
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 23:47:08 -0500
Date: Wed, 7 Nov 2018 15:46:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181107044635.GE5575@umbus.fritz.box>
References: <153933509870.3834759.13291133122604475240.stgit@bahia.lan>
	<153933511983.3834759.10815543413375425072.stgit@bahia.lan>
	<e77c6869-d89e-c5df-c43f-a2b5df3fbf59@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sfyO1m2EN8ZOtJL6"
Content-Disposition: inline
In-Reply-To: <e77c6869-d89e-c5df-c43f-a2b5df3fbf59@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] spapr_pci: rename some structured
 types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--sfyO1m2EN8ZOtJL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 12:49:53PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 12/10/2018 20:05, Greg Kurz wrote:
> > According to CODING_STYLE, structured types names are expected to be
> > in CamelCase but we have:
> >=20
> > typedef struct spapr_pci_msi {
> >     uint32_t first_irq;
> >     uint32_t num;
> > } spapr_pci_msi;
> >=20
> > typedef struct spapr_pci_msi_mig {
> >     uint32_t key;
> >     spapr_pci_msi value;
> > } spapr_pci_msi_mig;
> >=20
> > Acronyms are often written in upper-case, but here we would en up with
> > a lot of upper-case letters in a row (ie, sPAPRPCIMSI) which defeats the
> > purpose of CamelCase. It even displays "RPC" which looks awkward.
>=20
> Yet more common than this. I vote for sPAPRPCIMSI as PCI is an acronym.
> "pci" is small letters hurts my eyes :)

Hrm.  So, yes, I know I kind of started it, but these various
compromises about how to captialize things means this patch is now
"change from non-camelcase to.. something that's also not really
camelcase".

At which point I'm not particularly convinced it's worth the bother.

If we really want to go ahead with CamelCasing this, I think we'd need
to start by fixing up the existing sorta-camelcase-but-not-really
stuff to actual camelcase.  Which would mean the slightly odd reading
"Spapr" and "Pci" and "Msi" and so forth, but it might be worth it for
consistency.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sfyO1m2EN8ZOtJL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvibioACgkQbDjKyiDZ
s5KY/BAAktrzJIRvnQRTKKq9J0tT3rMQ0Slb8FRvBEXQ4AmGhcCn4Mz1WG7e8sgk
PC/GMPdem9iJf4AIUiJ+2J/MCpZ18JIf2rgiSudB3ItMnIppBUZG4mmCIPSsrKcL
e5A3Ps0DSV84vncywRp8KYP7eBKv4Jb3j7PTLej2CigdxSCTpfs7YK1g15XzE42B
+njgWo7EWPF4ij6dmK5TkDscFPhJtqkx5i6p16RjQJWkU1tK8wItTd3r0Q2CC7DH
Zidgp8M1kUDJ/AxaCQffR2f7A5eZhskqirh0VjD+0pcf3xeyZ7c/hx/bcCMxV63a
7LatJkZb8Dv9kuBNTHsTJGzCk87feVkgTVTWWF1Z5207y8Xm9f0ratsJTeuHd4MU
iyrmx4GLQ5rp1JTWcqhgPjWt31PE16suQiSsa5q0kApRXOepS6q/YrTqoTixSBMq
brS4eoknUPEhNgrVRrJ9YhIPI1nRUFA4LsYNfxPe/Ko7ED/QqX2EGZoYEOB6WcqB
PLq/PYMoZYVIqbujx91XSvBKVHnchkF/9AWt6N6ZHyvrskR6VLdUFRh2aWnvI9ox
z9uFPbpr+5TIl/s8cf/4mWR996Tgs72U/0yrDLSX+xCVI38FAD0iNw0z2E89gbhh
jwa3ZTJmEs9RJmqPL8VYMfnv05wo1llHNk07IJ1zeJqDREcY4Ko=
=O9Rf
-----END PGP SIGNATURE-----

--sfyO1m2EN8ZOtJL6--
