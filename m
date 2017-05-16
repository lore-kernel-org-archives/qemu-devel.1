Received: from eggs.gnu.org ([2001:4830:134:3::10]:49627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAUTg-0000Jn-W0
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAUTg-0003VF-1Q
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:52:57 -0400
Date: Tue, 16 May 2017 14:39:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170516043910.GG30022@umbus.fritz.box>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484838558.20089.5029926585755792842.stgit@bahia.lan>
	<e962c484-f89f-8623-d66e-8a904e814359@kaod.org>
	<20170515140618.22fad5fe@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Content-Disposition: inline
In-Reply-To: <20170515140618.22fad5fe@bahia>
Subject: Re: [Qemu-devel] [PATCH 4/6] spapr: sanitize error handling in
 spapr_ics_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 02:06:18PM +0200, Greg Kurz wrote:
> On Mon, 15 May 2017 13:59:33 +0200
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > On 05/15/2017 01:39 PM, Greg Kurz wrote:
> > > The spapr_ics_create() function handles errors in a rather convoluted
> > > way, with two local Error * variables. Moreover, failing to parent the
> > > ICS object to the machine should be considered as a bug but it is
> > > currently ignored. =20
> >=20
> > I am not sure what should be done for object_property_add_child()
> > errors but QEMU generally uses NULL for 'Error **'. It might be=20
> > wrong though.
> >=20
> > As for the local error handling, it is following what is described in=
=20
> > qapi/error.h. Isn't it ?
> >=20
>=20
> Yes, it does follow the "Receive and accumulate multiple errors" recomman=
dation,
> but does it make sense to realize the ICS object if we failed to set
> nr-irqs ?

Nor is it necessary to have two different local error variables.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZGoJuAAoJEGw4ysog2bOSiKQP/RIbPsj9dszkZuZmsw9tJeUG
xYE+I4OXz6dkNsSdJ+XtWJh16pOXzjAJa+1mv8f0yFFwk41i/gKq2jCrpkra5xSs
UmjJo34z8ET7jPdOccZ/VxfvOJcTPkmWFd1+GUfjk3LSOUQP434iWWtypdASnXoH
uyKHeszZ+uPNz8PgkjI6OfHrg0mvJFmVj9fig5HhQ/j8tlaiKENPgRCJiK3QUvNg
DeR43yFk8DEa5PnLpDG/27zUeNxk1yMPmvyTfv8PWn68/eESQAWjwsCmiRPeEw+r
eFRHl18EWvxz4Jqm6BkkRzsmZfpgj11zlgV8gXpLB5zzfvMLJ9bU/iAT2zfYfszZ
CAXtiw62TWF4rOBkTtv8LP912cDtnfnYUsH6A9cgTyeLxM/8qNwJJ+CbEe/d0e/E
NwudroBDG7elNgqvD7OIcqmfbwnTO9nnsuVvWsFk0vfFIF5X6V59Nbcnu+1+Suce
gbRdoRLkyRrlFdvQ+X3vrcUuajv7dzOcSVsZwQ02T4SUgGfT5Srmrz9nddNR1qiL
GMeVixHWhnRLtWhyNX8ymDjpVsFtdej7Jti5ofkvhm4Vn0PNUWrZwQPQ5jV0Ecjc
4cWpWm7WJYZCi+73p8AhPUI4z5+1k7gq5GwYPIGXNBLtbyoim5LexGXW2cyq3nJc
tbD27/dvfXKPBGeDrDI4
=lXSD
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--
