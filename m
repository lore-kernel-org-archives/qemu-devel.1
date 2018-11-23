Received: from eggs.gnu.org ([2001:4830:134:3::10]:52463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gQ4ra-0003Ct-0A
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gQ4rW-0002lJ-H6
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:22:49 -0500
Date: Fri, 23 Nov 2018 12:10:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181123011005.GU10448@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-5-clg@kaod.org>
	<20181122044450.GF10448@umbus.fritz.box>
	<121d4f915a03c2e734feebceda023947aedb78a3.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3pZQ0wszfDg7ZRO+"
Content-Disposition: inline
In-Reply-To: <121d4f915a03c2e734feebceda023947aedb78a3.camel@kernel.crashing.org>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--3pZQ0wszfDg7ZRO+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 05:50:07PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2018-11-22 at 15:44 +1100, David Gibson wrote:
> >=20
> > Sorry, didn't think of this in my first reply.
> >=20
> > 1) Does the hardware ever actually write back to the EAS?  I know it
> > does for the END, but it's not clear why it would need to for the
> > EAS.  If not, we don't need the setter.
>=20
> Nope, though the PAPR model will via hcalls

Right, bit AIUI the set_eas hook is about abstracting PAPR vs bare
metal details.  Since the hcall knows it's PAPR it can just update the
backing information for the EAS directly, and no need for an
abstracted hook.

>=20
> >=20
> > 2) The signatures are a bit odd here.  For the setter, a value would
> > make sense than a (XiveEAS *), since it's just a word.  For the getter
> > you could return the EAS value directly rather than using a pointer -
> > there's already a valid bit in the EAS so you can construct a value
> > with that cleared if the lisn is out of bounds.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3pZQ0wszfDg7ZRO+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv3U20ACgkQbDjKyiDZ
s5JZ7hAAmMzFWMb7lZ+lcf9n+mWzwaoI1ITIy9hAvx+Q8DUDL/9Q18HK4HKW18qe
1et2aBF5Rb1lgD87loiwwFx25eAPABsH9mQz3mylw2G22VMLxjYDIy07Crswcr7b
FI1ihgwOMKOUJML2+oAWG61ggTyYS/EndLPhUfQ2B1/iT7k7WbXFs027srqc1MrN
xOgkI5NzQglWcFjwPrmAQK8/SaSfhXalwv9pwWcHOO6j3Kwb0OGy2diiqe14D6pi
OeDs1o7ugoDLRraAS1nJJVRZQ6fHjhtonQrf7giCAAUwBxYL7fJ+sMcQnrR/Du2q
Rafrb+Qjl2PvQ54nhRHfkm7BpVfhFf9B5vLoa+nSH/U4gm6nhXNCgbxPq1s0rUoV
LRZ/WIDpUaTvRN0JfjP4VdA+VnEqns/9oLCt+/gnq6Mggs5TRvQBFDFbuYTmIBbF
3YPI2Kjss5b3f64lVxGRvGpFkMtRE+6LSm62jxFywA0Nm8hfBT+oLKPWUVHIE5NK
YvYeFiyYIP+1+CceoiPa578yFG3NLi85RUvzn0j+S6cjCW39ano8TQj9Sx64Pfc1
36G9xNozW4t0Xgv/hUIWQfnbJ7xSxyvjMjoiVeuBMVfEXBUYTAFjJAlFjSwyoAmy
7x+ifPQn/MPwcxIGgMmfmor+uOIBolDm0uXKQfDl+XeYDvCUXqs=
=L+AL
-----END PGP SIGNATURE-----

--3pZQ0wszfDg7ZRO+--
