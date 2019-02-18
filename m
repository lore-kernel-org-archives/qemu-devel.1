Received: from eggs.gnu.org ([209.51.188.92]:46444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gvgPf-0008VR-G7
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gvgPe-0005n5-Mv
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:44:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gvgPe-0005ht-ER
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:44:38 -0500
Date: Mon, 18 Feb 2019 10:44:20 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190218104420.GD12256@stefanha-x1.localdomain>
References: <20190123103323.4516-1-stefanha@redhat.com>
	<20190123103323.4516-3-stefanha@redhat.com>
	<7b9da22a-0756-054e-daad-9dba582a7487@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline
In-Reply-To: <7b9da22a-0756-054e-daad-9dba582a7487@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: add LUKS payload overhead
 to 178 qemu-img measure test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Daniel Berrange <berrange@redhat.com>, qemu-block@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 08:14:59PM +0100, Max Reitz wrote:
> On 23.01.19 11:33, Stefan Hajnoczi wrote:
> > diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
> > index 3f4b4a4564..23eb017ea1 100755
> > --- a/tests/qemu-iotests/178
> > +++ b/tests/qemu-iotests/178
> > @@ -142,6 +142,14 @@ for ofmt in human json; do
> >              # The backing file doesn't need to exist :)
> >              $QEMU_IMG measure --output=3D$ofmt -o backing_file=3Dx \
> >                                -f "$fmt" -O "$IMGFMT" "$TEST_IMG"
> > +
> > +            echo
> > +            echo "=3D=3D $fmt input image and LUKS encryption =3D=3D"
> > +            echo
> > +            $QEMU_IMG measure --output=3D$ofmt \
> > +                              --object secret,id=3Dsec0,data=3Dbase \
> > +                              -o encrypt.format=3Dluks,encrypt.key-sec=
ret=3Dsec0 \
> > +                              -f "$fmt" -O "$IMGFMT" "$TEST_IMG"
>=20
> With the change in patch 1, it would be possible to set
> encrypt.iter-time=3D10, for example (default for the LUKS tests).  For me,
> that decreases the test's runtime from 24 to 15 seconds.
>=20
> Pretty please? :-)

Will fix in v3.

Stefan

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcaoyEAAoJEJykq7OBq3PIzBsIAI+qsOrnUh1to1eIi7wJ2xM1
NRlpwFj15bLAQbBejHgltS0rL40uJ5wY5Btww4hUI5fmK0vXy95yRntqsmhoh7D0
r3EHova9jje+pdXl4XTlLv+q7rwlBffp3NaBoRMX/e8D+UH7qhWt3Yv8bKMVGCds
FqgquYlxxsScSiy1qmg15ECV7PZccU8HNv+rumcfn+2jTP3QlMYO5fICN55G7Aw6
5p0ao73hQvTK/fWSqd3a8KEOM9pPS7ospdy14UBv9Kv6Bg5Y9Uvko3RPHsL4/Nd8
0DhX/N/QnzXyG9liJGi9idqlOlPKEm34A8lFakgzFLegGktUc71dmjrabl9HGvo=
=ZmmC
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--
