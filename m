Received: from eggs.gnu.org ([2001:4830:134:3::10]:34401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAqQG-0003VZ-6J
	for qemu-devel@nongnu.org; Wed, 17 May 2017 00:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAqQF-0002tF-4F
	for qemu-devel@nongnu.org; Wed, 17 May 2017 00:18:52 -0400
Date: Wed, 17 May 2017 14:16:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170517041603.GE15596@umbus.fritz.box>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484840466.20089.893964776019028654.stgit@bahia.lan>
	<a94cf0ed-3318-fb2d-f16c-4d2b12fff3bb@kaod.org>
	<20170515151602.61dc381d@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <20170515151602.61dc381d@bahia>
Subject: Re: [Qemu-devel] [PATCH 6/6] spapr: fix migration of ICP objects
 from/to older QEMU
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


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 03:16:02PM +0200, Greg Kurz wrote:
> On Mon, 15 May 2017 14:22:32 +0200
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > On 05/15/2017 01:40 PM, Greg Kurz wrote:
[snip]
> > > +
> > > +            object_initialize(obj, sizeof(ICPState), spapr->icp_type=
);
> > > +            object_property_add_child(OBJECT(spapr), "icp[*]", obj,
> > > +                                      &error_abort); =20
> >=20
> > David does not like the "icp[*]" syntax.
> >=20
>=20
> Ah... I wasn't aware of that. But I agree that I should probably create
> the object names based on 'i', rather than relying on the more complex
> logic in object_property_add().

Right, the non-obviousness of what the indicies will end up being is
exactly why I dislike the "[*]" syntax.  Especially here, where it's
clearly important that the QOM paths end up exactly like in older qemu
versions, I think it's better to be explicit.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZG86DAAoJEGw4ysog2bOSAegP/R55yk5P2V7HwAXyfMpphczm
srxBvUAu/UP+3JgoXA7wfSsI/L8dhnLbCiRhsaaStRqCSRFE0qbz8StPJc133vVl
HQPlt9h/Rv2BonwJ1bWFwZT7B1cXYcC6CC+uYFUBnGPDgmN9gpF2suonQll7JfPm
YzjXqni2Zh00/M05KXsoEWJ5aWnheOjuOmHHP8jaiCAUjtBHAHA3ELMuwwaAEfOO
qZwIN8t4DpdN7wWTMskXXDOCZDtBvgcp4g8i3FVAB6DpAP3dE6kyr1ASzHyePdRB
Schi7Fiv5MvC4v9XIqUyi/1YuoF9arT4KCEpUoNJqPw7IiYMSNWbH++N1WGzngtA
H2ACR2wv288fXeH0HOcU0bsASAwl9gOsuePjE/8G8Skk0hv0/y5D5gQ9McmZJcvm
L+aPwx+XILz7/UHaZ5P2VkB0akCES3mBOBMTOmNdFUSUR8INtBBatyAMzoyvsWBK
or6RgSxHKd3+x0cwCJN23G17Ri9O86OkxcgtBIPAg4JCcClEp5DMa24U0V2TIwZd
bB9G4htaHXkTdNM1DGFkhelyC+mxpqjHYoZRnr0ZPnGVaNSSzXiNxSZTK2MvvgJH
t8o6ORIhW3FmV1Yu/e/WiduTNVbun84gGV2vwvg010+eaQTjDZPVaogHeH1Yv0bj
z2QVeZjSgwxMvqMAX6Up
=gYrZ
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
