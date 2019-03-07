Received: from eggs.gnu.org ([209.51.188.92]:43922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1lh4-0005pM-BE
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 00:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1lh3-0007eU-FQ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 00:35:46 -0500
Date: Thu, 7 Mar 2019 16:21:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307052149.GP7722@umbus.fritz.box>
References: <20190306043801.8852-1-david@gibson.dropbear.id.au>
	<c1c9ba97-f80d-d61d-d5c8-9d909951da01@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6iXXu7NwgEt9u5a7"
Content-Disposition: inline
In-Reply-To: <c1c9ba97-f80d-d61d-d5c8-9d909951da01@kaod.org>
Subject: Re: [Qemu-devel] [RFC] spapr: Use CamelCase properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: groug@kaod.org, aik@ozlabs.ru, agraf@suse.de, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--6iXXu7NwgEt9u5a7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 08:22:51AM +0100, C=E9dric Le Goater wrote:
> Hello,
>=20
> On 3/6/19 5:38 AM, David Gibson wrote:
> > The qemu coding standard is to use CamelCase for type and structure nam=
es,
> > and the pseries code follows that... sort of.  There are quite a lot of
> > places where we bend the rules in order to preserve the capitalization =
of
> > internal acronyms like "PHB", "TCE", "DIMM" and most commonly "sPAPR".
> >=20
> > That was a bad idea - it frequently leads to names ending up with
> > unreadable clusters of capital letters, and means they don't appear to =
the
> > eye as type identifiers, which is kind of the point of the CamelCase
> > convention in the first place.
> >=20
> > In short, keeping type identifiers look like CamelCase is more important
> > than preserving standard capitalization of internal "words".  So, this
> > patch renames a heap of spapr internal type names to a more standard
> > CamelCase.
>=20
> +1
> =20
> > We also rename VIOsPAPR* to SpaprVio*, the less natural reverse ordering
> > was only there in the first place to mitigate the capital-letter cluster
> > of "sPAPRVIO".
>=20
> Could we remove the Device prefix ? I don't find it very useful.

[Aside: ITYM "suffix"]

>=20
> 	SpaprVioVtyDevice
> 	SpaprVioVlanDevice

Done.

> 	SpaprVioDevice

I'll leave this one.  "SpaprVio" doesn't really make grammatical
sense, and "SpaprVioDevice" works in analogy with, say, PCIDevice.

>=20
> > This is 100% a mechanical search-and-replace patch.  It will, however,
> > conflict with essentially any and all outstanding patches touching the
> > spapr code.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> I have spotted dromedaries :
>=20
> 	typedef struct SpaprDRConnector

I've changed this to SpaprDrc.  Shorter and makes it clearer that
these are the same things as the "DRC"s we reference elsewhere.

> 	typedef struct SpaprDRCPhysical

Changed to SpaprDrcPhysical

>=20
> Could we get rid of the 'State' prefix ? It does not add much to the name
> and usually the associated macros remove it.

True, but it is a common qemu pattern, so I think I'll leave these for now.

> 	SpaprRngState
> 	SpaprPhbState
> 	SpaprRtcState
> 	SpaprDimmState
> 	SpaprMachineState
> 	SpaprCpuState
>=20
> It would be good to reverse the xics filenames also.

I'm not really sure what you mean by that, and in any case I don't
think it's really in scope for this patch.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6iXXu7NwgEt9u5a7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyAqmoACgkQbDjKyiDZ
s5KQnRAAz3ddRM0f4AoxkpXrQ1UUrtp9RebnOMGREJIz7ChxlDbqQmDeDJ/8L0Ow
L5wJ/Z8wP8wpEArwJW/vUU8/auoblJZDXFMd2vbqHAwRZa+njmCU/BVEDzMp7M+h
1gIOC6PUJ2lR5K0hIoVAF0aEkOTw5VvD3i/0oz4Hq3BpLIvNpZSVdbA8txwOuYeE
5JmM4TtBu3Np8H/P3YgK5K6oLOxAerzkh2ukbYeEIL3s0lr5hC5mTk616Bnonu0v
NsyFO1Ev25NjPyDGOOYue9AN2oZvt0eJgTKMgO1xZZp+q8W29l7kGTpsv1Bxmp3o
BOKpM6vhfWKG/UeOAi4UBrmt1rvvFsbKpdL+Ix+mhhxJkw3c9sBkjn5QM++tT7HU
0jQYvNaJSfgnNhfLoTgEhyIVNKavekQA/CHpSwyXg7BSyRqFbiokzQJbeM9cXexP
oaen/Hm7t5XPN7xZw5jz1WbZXbPcy3cfyfpEQY0/dY1/6KYdUs4WeE1CE5fpRgyK
dklA7xN0gBrOJr+v8HTl+atXXr9oKgKB7ezNbiGsU6CqWHGBPclXgtz7K07fqu3c
eztR7ibfKPbaxDycVCpzL2lG/NkcQclXqjeS/OxrmXlvYUg3Go6+ri+LxTYrVCsS
lLEIQV0RlbIuBuD3JgroZgyHNbS22dadF8NUCyvHXaqBgQtbslE=
=pa8E
-----END PGP SIGNATURE-----

--6iXXu7NwgEt9u5a7--
