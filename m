Received: from eggs.gnu.org ([209.51.188.92]:54274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2Ciw-0003wT-GX
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2Civ-0007Q3-Lt
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:27:30 -0500
Date: Fri, 8 Mar 2019 11:27:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190308102721.GD5339@localhost.localdomain>
References: <20190307165303.15382-1-kwolf@redhat.com>
	<415d75bd-2d62-d19a-8a5f-e463f4f72866@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <415d75bd-2d62-d19a-8a5f-e463f4f72866@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2 spec: Describe string header
 extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 07.03.2019 um 18:40 hat Eric Blake geschrieben:
> On 3/7/19 10:53 AM, Kevin Wolf wrote:
> > Be more specific about the string representation in header extensions.
> >=20
> > Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  docs/interop/qcow2.txt | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >=20
>=20
> Based-on: <20190227172256.30368-1-kwolf@redhat.com>
>=20
> > =20
> > =20
> > +=3D=3D String header extensions =3D=3D
> > +
> > +Some header extensions (such as the backing file format name and the e=
xternal
> > +data file name) are just a single string. In this case, the header ext=
ension
> > +length is the string length and the string is not '\0' terminated. (Th=
e header
> > +extension padding can make it look like a string is '\0' terminated, b=
ut
> > +neither is padding always necessary nor is there a guarantee that zero=
 bytes
> > +are used for padding.)
>=20
> We didn't require 0 padding?  (goes and re-reads) - oops, yes that's
> correct.

Yes. QEMU does use zeroes, but the spec doesn't mandate it and changing
it would be an incompatible change. And the worst that could happen is
that someone leaves a hidden message in the padding, which doesn't
really hurt.

> It makes it harder to extend a struct by making use of that
> padding if you can't guarantee what the padding had to be prior to the
> extension, and means that you have to consider whether there are any
> potential security risks of the padding being used as a side channel to
> leak information while still being a well-formed file.

It doesn't actually make it harder because we have the length field
which tells us the exact length of the valid data, so we shouldn't even
try to use any of the padding.

> But changing the standard to require zero padding is different than
> documenting existing practice, so your patch is correct.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

Kevin

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcgkOJAAoJEH8JsnLIjy/WKDMQAJhVnoTOf7E9ZyF+OTTxhr1c
6vHT+Ja9ZT6IyuM7SelYsqTGQIUhtCLlws9LDuCnnudiCfJ81CC2601r0CbmC9gz
4eKRxXx0CZ59TO8QsxqCJV3ffBM7PCCr2+6q1KRXX1Rs6btRQyRSyvZ5JIrc2G4M
7egBNkTipZ9xKaoilMUohjqkaVun1QEAsw3KHZ0FiAn5cwyBpK42FFA43Ucd1QSr
uvGGnJV1g4Bn2wdmIhG3Mi9ra3YnOgt3Glawj+EWsPLLRe2FyZT5fWiqa+IdKrwn
NQuxvtFBpDg1Y6+y+HNUqZgJ1/tyxIzc7nbmhCDFZtI9WaWcjiBrQ9Y4G3YpySY7
9JqyoMrqbQ0JgAEKlS7CV3mzua6crt4YBI56QcXvtlHxQjBRJzeGN/QhGL4A0Y8b
h6QZEySSE1TVkWL3nWlLE0+aWl7lVfFVWN/TXh4GuuAQGdhFAActOI+XtmShk2aU
Wvwf9MFPgaKDe26OaTsJGVNP+hHz95RjULxGxQqEflYQkkrZfcusHrQp7e42Ij+Z
N2/kk8Myb1argoBwnFUe8CGe89ABU/wbCXpswMv3LxoVlEekL1liUk9mWvr36TaF
1Qi6Fh3nQmPIUUFM38PIwD6aTp119+ggz+u+d1CrxBF84+UJrcf4xWWlPd7dnO1t
QmdzzKQhgbpBCLa8tnzw
=O7vi
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
