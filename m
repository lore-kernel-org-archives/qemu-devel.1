Received: from eggs.gnu.org ([2001:4830:134:3::10]:53545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ecTvN-00034B-Cv
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:29:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ecTvM-0000m0-GX
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:29:29 -0500
Date: Fri, 19 Jan 2018 11:29:19 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180119102919.GA3648@localhost.localdomain>
References: <20180118181123.37056-1-vsementsov@virtuozzo.com>
	<55e70fea-ac84-7c95-c195-63796ce4905d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <55e70fea-ac84-7c95-c195-63796ce4905d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] nbd export qmp interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, den@openvz.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 18.01.2018 um 23:45 hat Eric Blake geschrieben:
> On 01/18/2018 12:11 PM, Vladimir Sementsov-Ogievskiy wrote:
> > v2:
> > 01: tweak comment
> >     add Eric's r-b
> > 02: new patch
> > 03: rewritten, to move form 'bool force' flag to 'enum mode' parameter
> > 04: add Eric's r-b
> > 05: improve commit message
> >     tweak comment
> > 06: rebase on 03 changes
> >     make PEP8 happy
> >     some other tweaks
> >     I've left nbd_port variable hard-set to 10900. I think all such thi=
ngs
> >     should be fixed together, and it is simple to change in future
> >     nbd_port =3D '10900'
> >     to
> >     nbd_port =3D iotests.get_free_port()
> >     if needed.
> >=20
> > [Unfortunately, qmp query-nbd-server is not finished yet, coming soon,
> >  but may be after my vocation on the next week]
>=20
> Enjoy your time off. I think the series is nearly ready to go; I had
> some tweaks that I suggested, and will probably replace your 2/6 with my
> counterproposal, but I don't mind doing that cleanup if you don't have
> time to respin.  I'll give it a few more days in case anyone else has
> comments, then add it to my NBD queue.

I haven't reviewed the patches in detail, but the API changes look good
to me.

Kevin

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaYch/AAoJEH8JsnLIjy/W7v0P/1ctKN9KcC8QVFsfpuFehh17
TnfrLUo7/a8ay5+wAitARlLHFHIilvMqK8AZBge1zyfgZLpJAGRNc3kUjG3hbnhy
D+fzmjqgCOUGMlncL88hNzNaqORkTTKM2Mo4UNjo1r/Tt2kQKOXf8DGAzY47+lBP
tCpdi6oEtBZriDT1S2rF68qWssRDR16NurBr4yrH13rwKoLtkG4Mu+w08tcanhoR
Bny8BfbvBc4uP4BenAyCH8vss3vVRpq+w8tdz55x+hLTzAoGrmZSNJ4tcgO7urEo
bQxxLgvg5YGnfPa+Rmp6RF+LKGV6WX5lVqymho1/toWdb4sDXPbc1PSwOEh3Ai0R
cgbA48A2JWpR9V60X6vxgqawiCEzUvOYFDwP5Qru7PFfYPBpGFg/tu4yjBjSRgTt
ZXda86gtYT3UP0Sa8kSnSQ8P5BVW7+OZ6LxdzpJ8xUOANYwzb6Pfq9MqR1EYqN7D
qjqM7NCXYdWztGQrPLfLpuf4IWP9D402ISiXBp1evPjp8iLIoEP9KZHTLmA61VC8
efLYHKNs746LjSFK1uDELFEMYBiKHPMUvFx0lDg77uKBongVdtsnfp1qBi9Ic7dA
VIwzy8OPEOfttfshfioOiNCo4RUqwwq2e5bRSMJENdrzKm1fRIfCBzcWmKUEuvXT
OXdnwOfTwu8pWTQWeDQ2
=ML5j
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
