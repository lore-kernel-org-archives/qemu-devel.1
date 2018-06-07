Received: from eggs.gnu.org ([2001:4830:134:3::10]:36745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQrsa-0003J1-PK
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQrsX-0008AQ-Je
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:10:52 -0400
Date: Thu, 7 Jun 2018 11:10:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180607101046.GC19032@stefanha-x1.localdomain>
References: <1487347224-8667-1-git-send-email-pl@kamp.de>
	<20170220145011.GJ21255@stefanha-x1.localdomain>
	<73412b92-353d-7109-cfbe-9c61bf91e7eb@kamp.de>
	<a9939647-5c4e-9336-1121-eb821fe8eecc@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <a9939647-5c4e-9336-1121-eb821fe8eecc@virtuozzo.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH V4] qemu-img: make convert
 async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Peter Lieven <pl@kamp.de>, kwolf@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 07:16:14PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> 20.02.2017 17:59, Peter Lieven wrote:
> > Am 20.02.2017 um 15:50 schrieb Stefan Hajnoczi:
> > > On Fri, Feb 17, 2017 at 05:00:24PM +0100, Peter Lieven wrote:
> > > > this is something I have been thinking about for almost 2 years now.
> > > > we heavily have the following two use cases when using qemu-img
> > > > convert.
> > > >=20
> > > >=20
>=20
> [...]
>=20
> > > Does this patch work with compressed images?=A0 Especially the
> > > out-of-order write mode may be problematic with a compressed qcow2
> > > image.
> >=20
> > It does, but you are right, out-of-order writes and compression should
> > be mutually exclusive.
>=20
>=20
> Sorry for being late, but can you please explain to me, why?

There are image format-specific limitations on compressed writes.  For
some reason I thought they were append-only in qcow2, but I was wrong.

Stefan

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGQSmAAoJEJykq7OBq3PIUcUH/A+PCvtvAdVGkIZ+n5TGd2zu
BxAoTp/q29inNLD5tcoC3a8HIadgen4GvoslKVqGGfS4Ghep+qUxAW5q/QvhMH2o
keHQXAM0A2U2hwZLzmPy5vmOBGTIUL0PoUFOxUFANfSila+kVLTfo5IQ2i/MsiAv
kSfhaGcaJXkukfLHdRLL+3mlGenVXU3Vg1aLgAKXxNEbvnCX1U1KkHhYQyGwIxFL
0G+tk1dcH9uykzWq4BLJLT7acr4CSwQ/TcySeQT/XYPOoQMgou9ertyPEFL80fDZ
1YECBWM+Rp2lUqgdFVrmYSkJSvPMcZQ7l0GVDqAHhO67f4yxh5Yuvqr/N6aSyKI=
=c+Oj
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
