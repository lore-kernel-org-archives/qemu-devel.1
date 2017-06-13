Received: from eggs.gnu.org ([2001:4830:134:3::10]:44946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKhp7-0003FE-VV
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKhp2-0005gQ-4y
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:09:17 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dKhp1-0005g9-Ud
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:09:12 -0400
Received: by mail-wr0-x241.google.com with SMTP id v104so27820648wrb.0
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 02:09:11 -0700 (PDT)
Date: Tue, 13 Jun 2017 10:09:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170613090908.GA29273@stefanha-x1.localdomain>
References: <20170508141536.20690-1-stefanha@redhat.com>
	<20170508141536.20690-8-stefanha@redhat.com>
	<w51ziddplu9.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <w51ziddplu9.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v6 7/9] qemu-img: add measure subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, John Snow <jsnow@redhat.com>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2017 at 12:00:14PM +0200, Alberto Garcia wrote:
> On Mon 08 May 2017 04:15:34 PM CEST, Stefan Hajnoczi wrote:
> > The measure subcommand calculates the size required by a new image file.
> > This can be used by users or management tools that need to allocate
> > space on an LVM volume, SAN LUN, etc before creating or converting an
> > image file.
> >
> > Suggested-by: Maor Lipchuk <mlipchuk@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > v5:
> >  * Use UINT64_MAX instead of ~0ULL [Berto]
> >  * Document qemu-img measure ofmt, fmt, output_fmt, and snapshot_param
> >    [Berto]
> > ---
>=20
> I had left some comments to v5 of this patch, I'm not sure if you saw
> that e-mail:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01717.html

Thanks, I hadn't seen it.  Will send another revision.

Stefan

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZP6u0AAoJEJykq7OBq3PIdL8H+gMvTbRC2q1BRiYeJnYxWuhr
SsQZp8XzFSGPV39q75AeM3Fe7rIGuhhFbK0wk/B12pluK6DwNHWvcfIintIiVlwg
bT3CLUl5WV2uYkzxUHrXj5XdiVqw1f8Kjac+dY7t9wSHNltRcCnypYRx9F2CI8Bn
2FznsgEDTNib9uiAqhhGSjfoXVgNmk0c9JzowG/9K5vOpKQhQ9mouRRRz99rVNH6
ECoZzLDqsYx7oQKEznXf8R1ukYJ55hfdYxMnrKi2YjDOD0zpWkDQHh9Ot6k2uArN
HpqJGTzk0MsJN9fNh6ZQBzaM4xZeRfOr7N5LBp58LMS9YX4yQMm7DAvHpccBgyU=
=Pgwa
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
