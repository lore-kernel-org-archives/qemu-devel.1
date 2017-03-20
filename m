Received: from eggs.gnu.org ([2001:4830:134:3::10]:36962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cpzMz-0006AI-5X
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cpzMu-0007fx-9h
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:37:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cpzMu-0007fa-35
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:37:12 -0400
Date: Mon, 20 Mar 2017 15:37:07 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170320153707.GB7320@stefanha-x1.localdomain>
References: <20170315092940.1367-1-stefanha@redhat.com>
	<20170315092940.1367-2-stefanha@redhat.com>
	<CAMRbyysBvGhV6cqN8qX+dL3f3Y8QOCtn+jhOKunDHFrTZEwyoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <CAMRbyysBvGhV6cqN8qX+dL3f3Y8QOCtn+jhOKunDHFrTZEwyoQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC v2 1/8] block: add bdrv_measure() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 18, 2017 at 12:51:29AM +0000, Nir Soffer wrote:
> On Wed, Mar 15, 2017 at 11:29 AM Stefan Hajnoczi <stefanha@redhat.com>
> wrote:
> > diff --git a/block.c b/block.c
> > index cb57370..532a4d1 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -3260,6 +3260,39 @@ int64_t
> > bdrv_get_allocated_file_size(BlockDriverState *bs)
> >      return -ENOTSUP;
> >  }
> >
> > +/*
> > + * bdrv_measure:
> > + * @drv: Format driver
> > + * @opts: Creation options
> >
>=20
> Isn't this Measure options?

No, these are the block driver .bdrv_create() options.  They are exactly
the same as qemu-img create -o.

qemu-img measure must know the creation options of the new image file
(such as preallocation or the qcow2 image format version) because they
affect the file size.

> Maybe a note about error handling? the only way is to check for non-null
> errp, right?

Yes, errp must be checked.  I'll update the doc comment.

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz/cjAAoJEJykq7OBq3PIz84H/3n4vrwqwgnE7GcdlfZ1aCs3
6QQfdIm8DJzNyMzyAHu2fEt1l8bbftBNK3j/go5NJA4GVzkSVq0amlWf2JYUUxKT
cL77MVzxB3iIaoKLanzfCVraA2F3Ns42v18s5uaBkCGmOREsJL5BT0M9c77qQhwH
A3rn9wbt8K6ua8CXl8pgzPDewecQbZykB2PcqwhoITeODtoFhlXzuA5OcaaXWTrs
Slw1M472VyqBSTcFwYZI2x2sHyhDHeWRCiNinjfNSB576xX6k58utEV49divVfn6
NOfqvpS9Fujxkq9bPtzV3pQq2roXF3hBzPJZ6qJ3PiqcGTstke39mBMWz6tkbBE=
=FFt3
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
