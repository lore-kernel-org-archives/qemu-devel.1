Received: from eggs.gnu.org ([2001:4830:134:3::10]:39464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxxnn-0001FE-CT
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxxnk-0005EU-8V
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:33:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cxxnk-0005E4-2D
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:33:52 -0400
Date: Tue, 11 Apr 2017 16:33:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170411153345.GB5940@stefanha-x1.localdomain>
References: <20170405151148.16363-1-stefanha@redhat.com>
	<20170405151148.16363-8-stefanha@redhat.com>
	<w51fuhfz10y.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <w51fuhfz10y.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v4 7/9] qemu-img: add measure subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 12:33:49PM +0200, Alberto Garcia wrote:
> On Wed 05 Apr 2017 05:11:46 PM CEST, Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
> > +    QemuOptsList *create_opts =3D NULL;
> > +    bool image_opts =3D false;
> > +    uint64_t img_size =3D ~0ULL;
>=20
> Any reason to use ~0ULL instead of UINT64_MAX ?

Will fix, UINT64_MAX is nicer to read.

> > --- a/qemu-img.texi
> > +++ b/qemu-img.texi
> > @@ -429,6 +429,31 @@ preallocated.
> >  For more information, consult @file{include/block/block.h} in QEMU's
> >  source code.
> > =20
> > +@item measure [--output=3D@var{ofmt}] [-O @var{output_fmt}] [-o @var{o=
ptions}] [--size @var{N} | [--object @var{objectdef}] [--image-opts] [-f @v=
ar{fmt}] [-l @var{snapshot_param}] @var{filename}]
> > +
> > +Calculate the file size required for a new image.  This information ca=
n be used
> > +to size logical volumes or SAN LUNs appropriately for the image that w=
ill be
> > +placed in them.  The values reported are guaranteed to be large enough=
 to fit
> > +the image.
>=20
> It's already explained for other commands, but don't you want to mention
> what ofmt, output_fmt, etc., mean?

Will fix.

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY7PdZAAoJEJykq7OBq3PIfRQH/2SmAjhTmskQJgc3vqDjRB1Q
E1nQDUhCl+bOZZTJpzQZSVac2X0dbBQoplaD9eK9temkTr7XzMcWeuEeNYXePHHG
nKQ3nnh736oTFLaT1+TNANRgH2fm+vsFW4X1Hqy2Af+K0ja3VBsPjzVWDuBuVed5
sD+2e96qFWqbdO2i4mQW4buGTdcRCKhBOAubvWBFMjZjWQAQvdVaEv/Xv+W6Zqn5
JrZtHqEiUMADkww1vYUPNjFNN4TpPLcdFcWBcO1FQEo1cKDUZBAKRHWQrbvdVLGm
gOYRGwEXw8aLCNNv9Veb5YOH78CfEFTV2sjqqph4oB8jzR17frgxMXq7aH9f+WY=
=TTL8
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
