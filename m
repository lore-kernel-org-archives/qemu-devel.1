Received: from eggs.gnu.org ([209.51.188.92]:32899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwx3X-00022w-9U
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 17:43:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwx3V-0003yq-Hz
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 17:43:03 -0500
Date: Fri, 22 Feb 2019 09:30:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190221223017.GC8609@umbus.fritz.box>
References: <20190218181349.23885-1-ppandit@redhat.com>
	<20190219025500.GN9345@umbus.fritz.box>
	<20190221092546.GB17899@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
In-Reply-To: <20190221092546.GB17899@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] ppc: add host-serial and host-model
 machine attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, Prasad J Pandit <pjp@fedoraproject.org>


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2019 at 09:25:46AM +0000, Daniel P. Berrang=E9 wrote:
> On Tue, Feb 19, 2019 at 01:55:01PM +1100, David Gibson wrote:
> > On Mon, Feb 18, 2019 at 11:43:49PM +0530, P J P wrote:
> > > From: Prasad J Pandit <pjp@fedoraproject.org>
> > >=20
> > > On ppc hosts, hypervisor shares following system attributes
> > >=20
> > >   - /proc/device-tree/system-id
> > >   - /proc/device-tree/model
> > >=20
> > > with a guest. This could lead to information leakage and misuse.[*]
> > > Add machine attributes to control such system information exposure
> > > to a guest.
> > >=20
> > > [*] https://wiki.openstack.org/wiki/OSSN/OSSN-0028
> > >=20
> > > Reported-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > > Fix-suggested-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> >=20
> > Applied to ppc-for-4.0, thanks.
>=20
> Could you add the word  "CVE-2019-8934" to the commit message for this
> patch before sending a pulll request - either end of subject line, or
> just before the Reported-by line.

Done, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxvJnkACgkQbDjKyiDZ
s5La/hAA1TScSh8nAIsD7fRF8VffBRBnKkI1aaZuXVlHOf5sZIC+6+5FNv6nmJtl
26Jb+61M7R/dEGRT3eOTn8Ga5hanBBieucCsokfT3FxcifzCgIUUJKTnDZ7hgggl
TF3JJUD+YKHlA15XHuq8igdizUJ/iLx349wDsOGBIXMGSFMzFysl47c2rDtUeo7/
WGsCgiRr4mBsP5NOci6m7chjSvOq7oErLhztsh84SDlGQSZR3S7d/KfGCMlrQLL+
3Cu1OjcH5nqfkZvIgsUW914YCjQ3gHRmP9RsFmS6Bl7iN6T6M/D9raOE+tECkr9g
aWMxF7vVIGcQ5idtXt8FP/Z0aPUHzmO7q9DQ28vXGaTDin+S3fOXlZ3d8WzYiyBP
Hn5N76ihkJ4J4+V8pUkyJETGLHyraGrY+9Gm5VFG08p3lFQX0eM4V4hGCQYfXGiJ
Rkrl+Peka9dLrdUDklogG25Y+CxC55nXsNovO9ANSWVeZZNFPiEcPo50WpQ3gZaj
BHpg9rBXOY7pDFLcnISMuqgdxRycqxL+q8NHHDMpTluSo2lQLy7NyuFq6N+nT8wd
fW5RWQwHz9qARazvM8iNH0j/RNvRwKDpZUHpawV/qVabVdTEccGSyovoBa6lFYHo
FJEl9ZBc6qksUEFu0anVQKw/gc5J4TX7I2/+xIyZhBBUw9/FsVg=
=pByb
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
