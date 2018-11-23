Received: from eggs.gnu.org ([2001:4830:134:3::10]:52462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gQ4ra-0003Cs-0E
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gQ4rW-0002lC-Gg
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:22:49 -0500
Date: Fri, 23 Nov 2018 12:17:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181123011733.GV10448@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-5-clg@kaod.org>
	<20181122044450.GF10448@umbus.fritz.box>
	<121d4f915a03c2e734feebceda023947aedb78a3.camel@kernel.crashing.org>
	<731ece35-0584-63b5-60dc-e53c7a0c5a93@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EsfvRFssnM00t552"
Content-Disposition: inline
In-Reply-To: <731ece35-0584-63b5-60dc-e53c7a0c5a93@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 04/36] ppc/xive: introduce the
 XiveRouter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--EsfvRFssnM00t552
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 08:59:32AM +0100, C=E9dric Le Goater wrote:
> On 11/22/18 7:50 AM, Benjamin Herrenschmidt wrote:
> > On Thu, 2018-11-22 at 15:44 +1100, David Gibson wrote:
> >>
> >> Sorry, didn't think of this in my first reply.
> >>
> >> 1) Does the hardware ever actually write back to the EAS?  I know it
> >> does for the END, but it's not clear why it would need to for the
> >> EAS.  If not, we don't need the setter.
> >=20
> > Nope, though the PAPR model will via hcalls
>=20
> Indeed. The H_INT_SET_SOURCE_CONFIG hcall updates the EAT.
>=20
> >> 2) The signatures are a bit odd here.  For the setter, a value would
> >> make sense than a (XiveEAS *), since it's just a word.  For the getter
> >> you could return the EAS value directly rather than using a pointer -
> >> there's already a valid bit in the EAS so you can construct a value
> >> with that cleared if the lisn is out of bounds.
>=20
> Yes we could. I think I made it that way to be consistent with the=20
> other XIVE internal structures which are bigger : END, NVT

Yeah, but as noted elsewhere I don't really like the get/set model for
the bigger-than-word-size structures.  It gives the impression that
they're atomic updates when they can't be, as well as unnecessarily
copying a bunch of stuff, sometimes on hot paths

> There might be other reasons in Pnv. One was to use generic accessors=20
> to the guest RAM but I didn't do it finally. Take a look at the Pnv
> model and we might decide to change the prototype then. I don't=20
> think it's a major change.

Hmmm.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EsfvRFssnM00t552
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv3VS0ACgkQbDjKyiDZ
s5JWFw//ZCM2Iw0OTWPRzhz+fb2HtoklzviDVLiNyt8RONKCUfrj69icgjr+g0LR
/JNDTvMEIAMA87uS5EXpiEbEk6RhRXtj+p2kC1F3l27Y/hLhCycGlxBlAa2WLcJv
lWGXqGo1WVTaO9CTbmrGLOm/ht6eUcAMhPnCHhM+bttP7Fjlff/8w8MuDABRYyA6
5mrp4eEAeg6X31EOB+D87mw7y9Dao6C6JDI2s6LgZikjUj41ROzylNZqt6NDRLjE
bVN38uoHHQWjlzaahyhZG4eyj46f+xl7JIe5wC2lvDYoCOBzLbek29T4yKpKdGze
3//ePHIk8PF8hbsTnTM0JgLxQ25NQIAKpJiJ98TzyQEgdfQM2d5agfl/mPgz+4aU
rztDQ8Z2kTDaguIBLaMHrbTFWHIdBqm4kerx5wuVUyb2Wh5TiOf61DKCH1HlZUW0
7jWzgWeO447davRJtTAAT0rwivjsjrUMuHq+abPAoEoizbQubTZnfApmOEq8ytCL
4vXFofupbkTzXD1pUvxn94lXw+S7Nm1dOaqle1fSOGPSbTBxUjgmC402SS6Hluj9
G67tEy5WHN2pP6BgE2czw804Fo9BYUI5u27e2PgDy7UATjVRqcI+4Nct+Q4iU2pC
lK/34T7AQJFFTppJhn1qekSPjTJjVdz8ucWYeXsHdZ8uwmYxxk0=
=fHgo
-----END PGP SIGNATURE-----

--EsfvRFssnM00t552--
