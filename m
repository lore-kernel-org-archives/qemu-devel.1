Received: from eggs.gnu.org ([2001:4830:134:3::10]:36572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fRCBU-0006vr-31
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fRCBR-000516-0C
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:51:44 -0400
Date: Fri, 8 Jun 2018 08:51:37 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180608075137.GD29183@stefanha-x1.localdomain>
References: <1487347224-8667-1-git-send-email-pl@kamp.de>
	<20170220145011.GJ21255@stefanha-x1.localdomain>
	<73412b92-353d-7109-cfbe-9c61bf91e7eb@kamp.de>
	<a9939647-5c4e-9336-1121-eb821fe8eecc@virtuozzo.com>
	<20180607101046.GC19032@stefanha-x1.localdomain>
	<2ddb8b13-650a-5bd7-8c77-3f2eca34efdf@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline
In-Reply-To: <2ddb8b13-650a-5bd7-8c77-3f2eca34efdf@virtuozzo.com>
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


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2018 at 01:19:29PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> 07.06.2018 13:10, Stefan Hajnoczi wrote:
> > On Fri, Jun 01, 2018 at 07:16:14PM +0300, Vladimir Sementsov-Ogievskiy =
wrote:
> > > 20.02.2017 17:59, Peter Lieven wrote:
> > > > Am 20.02.2017 um 15:50 schrieb Stefan Hajnoczi:
> > > > > On Fri, Feb 17, 2017 at 05:00:24PM +0100, Peter Lieven wrote:
> > > > > > this is something I have been thinking about for almost 2 years=
 now.
> > > > > > we heavily have the following two use cases when using qemu-img
> > > > > > convert.
> > > > > >=20
> > > > > >=20
> > > [...]
> > >=20
> > > > > Does this patch work with compressed images?=A0 Especially the
> > > > > out-of-order write mode may be problematic with a compressed qcow2
> > > > > image.
> > > > It does, but you are right, out-of-order writes and compression sho=
uld
> > > > be mutually exclusive.
> > >=20
> > > Sorry for being late, but can you please explain to me, why?
> > There are image format-specific limitations on compressed writes.  For
> > some reason I thought they were append-only in qcow2, but I was wrong.
> >=20
> > Stefan
>=20
> And what are limitations for compressed writes in qcow2?

Writes must be cluster-aligned and the size must be 1 cluster (except
for the last cluster in an image).

qemu-img convert honors this, so it's not a problem.

> We can't write asynchronously? Why?

Async compressed writes are supported nowadays.

I think my original comment was wrong.  It should be fine to use
out-of-order compressed writes.

Stefan

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGjWJAAoJEJykq7OBq3PIWZgIALncLtu+SvGG+seICTN9v0Id
PAZvatH2bn0dIuLiOsZ75iXbPiiOT617icuL0jz5oYi8pNTB5k/KqGghmlQNYpQh
tA5fvwGMyUBPn2yjY9bHniVi+ZB0xFLNg38oNi+XNifizl+g4h1WOR/qTcwGIkb1
f+CtYU4P8sXfrzIARd/DsdaFYa13qgbqmtV6qiGTFaIhd9I+5fshAtFG4pQOMgm5
L0akQEDA1uCQqMBIpgbUSblCNU9EsNWRh483+SH959YLe3gFQAF/rqYhfypbTQWS
1b4bxJWSqHoVxwB9SrCT3sZXZPLXuLkvPuf/pMNeyoTjPV9nLf+hWxZ2ZX9lx6A=
=pMHj
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
