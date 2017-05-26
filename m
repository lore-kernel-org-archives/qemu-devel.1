Received: from eggs.gnu.org ([2001:4830:134:3::10]:59442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dE5Zt-0001Bf-2f
	for qemu-devel@nongnu.org; Thu, 25 May 2017 23:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dE5Zp-0004ph-Te
	for qemu-devel@nongnu.org; Thu, 25 May 2017 23:06:13 -0400
Date: Fri, 26 May 2017 12:10:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170526021000.GH12929@umbus.fritz.box>
References: <20170427072843.8089-1-david@gibson.dropbear.id.au>
	<20170427072843.8089-3-david@gibson.dropbear.id.au>
	<1493917751.4214.12.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rCwQ2Y43eQY6RBgR"
Content-Disposition: inline
In-Reply-To: <1493917751.4214.12.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv3 2/4] pseries: Move CPU compatibility
 property to machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: groug@kaod.org, clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--rCwQ2Y43eQY6RBgR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 07:09:11PM +0200, Andrea Bolognani wrote:
> On Thu, 2017-04-27 at 17:28 +1000, David Gibson wrote:
> > @@ -2480,6 +2480,10 @@ static void spapr_machine_initfn(Object *obj)
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" place of standard EPOW events w=
hen possible"
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" (required for memory hot-unplug=
 support)",
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0NULL);
> > +
> > +=A0=A0=A0=A0object_property_add(obj, "max-cpu-compat", "str",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0ppc_compat_prop_get, ppc_compat_prop_set,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0NULL, &spapr->max_compat_pvr, &error_fatal);
>=20
> I'm not familiar with QEMU's object system, but shouldn't
> you be using object_property_add_str() instead? It looks
> like you're doing more than the straightforward wrapper
> would do, so maybe that's just not possible.

Right.  I can't use object_property_add_str() for two reasons.  First,
I need the opaque parameter which it lacks, second it assumes that
you're storing the property=20
opaque parameter (which the _str() variant lacks) to pass in the
destination variable for the compat pvr.

> In any case, all other string properties look like
>=20
> =A0 pseries-2.10.kvm-type=3Dstring
>=20
> whereas this one ends up looking like
>=20
> =A0 pseries-2.10.max-cpu-compat=3Dstr
>=20
> which I think should be fixed - object_property_add_str()
> passes "string" instead of "str" to object_property_add().

Ah, yes, that's a bug, I'll fix.

> You should also add a sensible description for the property,
> preferably spelling out all the accepted values.

I'll add that.

> Speaking of properties...
>=20
> =A0 $ qemu-system-ppc64 -cpu host,compat=3Dwhatever
> =A0 Segmentation fault
>=20
> You might want to look into that ;)

Uh.. yeah.  I think I've fixed that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rCwQ2Y43eQY6RBgR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJ450AAoJEGw4ysog2bOSKn0P/j7BlW00l0OE2lSrsB3w+iev
AztMeU81UhwbbF4BVb6HU0Xs8yXAGasgsABGjObBr+SJtEw7gCZQ1DWkABDqRrd8
o6PQHJNTwcTPMpqcsCXUwHn4qHpR+mL6RYma1cRFBwfkca31n/9tEcmsVHtoxxnc
CKa7C58gwggB+bJ7mkaeKYo2bQkiRbY6pf6+kHYFjPaUWDzQbZt42t8BEfR1QRfz
zapNcw31SGKrT5sk0FKuVJ6YBTiIta2bVFRMTZJcOYjHfQqzNBvJP4q0wm8fiOln
uTtCNArt0cZL7+l9tmdr1XVkywH0hGq7PlRkNaMN30++LY35Ry/z+yAYBNMv+DRY
bOhdR5d/vRRYRuwVunA7rdilpylRkDS2ciYsP4dRX/2lO8hy8dKfLEeeKJD0jdws
PTnI6jnxOignr9xTtD6iXXZJluHFR/NaUNy6RI14AexPZAdhvGvUu7FtEZSv/4km
XxCzeDejsbo7qZx5fd4cKpSgirPFi49yIm+UgGsDMg6gi6p93ORSZKkzeCVHaGbc
t175gdV72SCFKDvOgDwQWWNqLJGoR7DbBI5qwvwc/EB+RncweTw4+E2Ms2t8tX+x
j8jfYZm2T3T/3IcCqPbFyx8cuiNT2g76wMV+9J/29wHdGa16NgmIfB378JfrOqT1
baFI+Is3xZrt3tl7THQ7
=64mx
-----END PGP SIGNATURE-----

--rCwQ2Y43eQY6RBgR--
