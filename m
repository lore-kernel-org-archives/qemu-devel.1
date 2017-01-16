Received: from eggs.gnu.org ([2001:4830:134:3::10]:60159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTD6S-0007kT-RB
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTD6R-0004OU-IL
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:38:04 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-4-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3d01b4f0-c641-43ce-2359-9a0ab9c360d5@redhat.com>
Date: Mon, 16 Jan 2017 20:37:57 +0100
MIME-Version: 1.0
In-Reply-To: <20170103182801.9638-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Okg2fVmJR98k4E0kCtE8F9CpvWJiGAXHT"
Subject: Re: [Qemu-devel] [PATCH v1 03/15] qcow: document another weakness
 of qcow AES encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Okg2fVmJR98k4E0kCtE8F9CpvWJiGAXHT
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <3d01b4f0-c641-43ce-2359-9a0ab9c360d5@redhat.com>
Subject: Re: [PATCH v1 03/15] qcow: document another weakness of qcow AES
 encryption
References: <20170103182801.9638-1-berrange@redhat.com>
 <20170103182801.9638-4-berrange@redhat.com>
In-Reply-To: <20170103182801.9638-4-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.01.2017 19:27, Daniel P. Berrange wrote:
> Document that use of guest virtual sector numbers as the basis for
> the initialization vectors is a potential weakness, when combined
> with internal snapshots or multiple images using the same passphrase.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img.texi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/qemu-img.texi b/qemu-img.texi
> index 174aae3..8efcf89 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -554,6 +554,15 @@ change the passphrase to protect data in any qcow =
images. The files must
>  be cloned, using a different encryption passphrase in the new file. Th=
e
>  original file must then be securely erased using a program like shred,=

>  though even this is ineffective with many modern storage technologies.=

> +@item Initialization vectors used to encrypt sectors are based on the
> +guest virtual sector number, instead of the host physical sector. When=

> +a disk image has multiple internal snapshots this means that data in
> +multiple physical sectors is encrypted with the same initialization
> +vector. With the CBC mode, this opens the possibility of watermarking
> +attacks if the attack can collect multiple sectors encrypted with the
> +same IV and some predictable data. Having multiple qcow2 images with
> +the same passphrase also exposes this weakness since the passphrase
> +is directly used as the key.
>  @end itemize

In the output manpage, this itemize looks pretty broken to me:

@item foo
bar baz

is formatted as:

-<foo>
    bar baz

Which may be used intentionally, but it certainly isn't here.

It should probably be written as:

@item
foo bar baz

which becomes

-    foo bar baz

(which is what the other itemize in qemu-img.texi does)

Do you want to fix that in this series?

Max

> =20
>  Use of qcow / qcow2 encryption is thus strongly discouraged. Users are=

>=20



--Okg2fVmJR98k4E0kCtE8F9CpvWJiGAXHT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh9IRUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ABn0IAImQR0PiyaOUsEyEACGOqzVD8IK7xwMl
tPRzwSED8bsG57TZS66+n/lCYMYfUfMteTQePzUwNiskjrmQGjhn0Xxkq28Q/pqT
YoyVqKi3UqT4xm2xEp0ajmt0f9avZbxhvBs+IzqoKYlq9fCaP3kU8Gp1S3mwfEl4
cO2QdSYlOWvikyG4Xaww35VFenFrAl3vUuLSsUYj8eDn9xjO2Pew80dkY1oRURok
SLuvEPyEEXIMDJGdtQSkUETscc18JVkX+ntRhP0uD84GM5pd0hcVVgJ7Po216wq/
x7um0Ex3Al3yR4Zg01/xsw52ngBmoy6YESI6sl9p0EhWU4IisSAEjTA=
=WTwv
-----END PGP SIGNATURE-----

--Okg2fVmJR98k4E0kCtE8F9CpvWJiGAXHT--
