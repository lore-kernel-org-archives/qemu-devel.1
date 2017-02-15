Received: from eggs.gnu.org ([2001:4830:134:3::10]:41718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ce2hR-0000lV-Oh
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ce2hQ-00047K-UL
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:45:01 -0500
Date: Wed, 15 Feb 2017 17:44:51 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170215164451.GH4935@noname.redhat.com>
References: <20170212014724.10618-1-mreitz@redhat.com>
	<w51lgtazdqs.fsf@maestria.local.igalia.com>
	<8d536684-8a07-7c34-16ca-be234685ab2a@redhat.com>
	<w51k28tumiv.fsf@maestria.local.igalia.com>
	<7fcba84d-4cd8-b34d-ef3e-4fbfa46d59a9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <7fcba84d-4cd8-b34d-ef3e-4fbfa46d59a9@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Swap request limit
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.02.2017 um 14:42 hat Max Reitz geschrieben:
> On 14.02.2017 10:52, Alberto Garcia wrote:
> > On Mon 13 Feb 2017 06:13:38 PM CET, Max Reitz wrote:
> >=20
> >>>> -#define BDRV_REQUEST_MAX_SECTORS MIN(SIZE_MAX >> BDRV_SECTOR_BITS, \
> >>>> -                                     INT_MAX >> BDRV_SECTOR_BITS)
> >>>> -#define BDRV_REQUEST_MAX_BYTES (BDRV_REQUEST_MAX_SECTORS << BDRV_SE=
CTOR_BITS)
> >>>> +#define BDRV_REQUEST_MAX_BYTES      MIN(SIZE_MAX, INT_MAX)
> >>>> +#define BDRV_REQUEST_MAX_SECTORS    (BDRV_REQUEST_MAX_BYTES >> BDRV=
_SECTOR_BITS)
> >>>
> >>> I'm just pointing it out because I don't know if this can cause
> >>> problems, but this patch would make BDRV_REQUEST_MAX_BYTES not a
> >>> multiple of the sector size (INT_MAX is actually a prime number).
> >>
> >> Very good point. I don't think this could be an issue, though. For one
> >> thing, the use of BDRV_REQUEST_MAX_BYTES is very limited.
> >=20
> > Ok, but then I wonder what's the benefit of increasing
> > BDRV_REQUEST_MAX_BYTES.
>=20
> The benefit is that the definition looks cleaner.

Whatever way we want to write it, I think MAX_BYTES =3D MAX_SECTORS * 512
should be a given. Everything else is bound to confuse people and
introduce bugs sooner or later.

Kevin

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYpIWDAAoJEH8JsnLIjy/WpakQAIZuQZANvs1iok/K2dT1b829
XQG+oRLSkcSEPc9E283KhpweRLqMVHxO3l2htTwyHTW5jyT5TNYVNOwEWYp4VnOg
HTh2j2vjih7iiKCDAmIZ73o5wl+yVmXrqjg8tZfG5uaYr6u9Lq74muHxQkLSGjbj
VayzIDijjtYiB0zkpjUwrD6L57gUbVL3DiV8ayKnXejTw9rbjPh6frI2krrjISfX
/zFtsstNa45Rq/aKddjavCRwlJJ0FeuZoQnH8AFc1LSdtbNVZLFUNYD5/+LuIOZn
JXDslo4m8GWI502HXKLQDWF/53ujyH3/+TcDN+R6Pp8ko+4+BquswBrghVLNtAri
bcc6gIaEQWTE39c/Wp6/aI7HNEvkz/n7oFZqFrBHWZfw/D4PZuGhvaYZQ18sk1El
sJ2/P09y1GHKD8nhHvhQ3Ecu3Yazx/nGyCictOKHhfF831SPkXFLay4y4j5jSLr3
6oVsUUWI6hS4HGQuoENN+vx7KbmEWW3HzJTs1UZaeInTlnjLWPUau+doOuuQNghQ
ibaZAQDg69vw/lDtv83mysR5B46shTPJpIZ2vAvNy0G0kQSsaE9FShplJDGoFn9o
+SrIdPrqM+9DHZaivb353S0XaUyOswEdKt/EW3m4C7lGDpD+vVqCoxnfoOnQhTwh
I5X00YoDrYod6cr9rq8D
=xATh
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
