Received: from eggs.gnu.org ([209.51.188.92]:38541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1gtVOs-0002qe-5N
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1gtVOq-0000UL-7D
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:34:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1gtVOp-0000P1-QT
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:34:48 -0500
Date: Tue, 12 Feb 2019 11:26:37 +0100
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20190212102636.GA8193@vader>
References: <1547573562-32754-1-git-send-email-thuth@redhat.com>
	<154825907001.21.1745172489421569133@ebba9967afc0>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <154825907001.21.1745172489421569133@ebba9967afc0>
Subject: Re: [Qemu-devel] [PATCH] seccomp: Work-around GCC 4.x bug in gnu99
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, fam@euphon.net, armbru@redhat.com


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23/01/2019 - 07:57:51, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/1547573562-32754-1-git-send-email-t=
huth@redhat.com/
>=20
>=20
>=20
> Hi,
>=20
> This series failed the docker-mingw@fedora build test. Please find the te=
sting commands and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> time make docker-test-mingw@fedora SHOW_ENV=3D1 J=3D14
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
>   CC      backends/rng-egd.o
>   CC      backends/tpm.o
> /tmp/qemu-test/src/block/sheepdog.c: In function 'find_vdi_name':
> /tmp/qemu-test/src/block/sheepdog.c:1239:5: error: 'strncpy' specified bo=
und 256 equals destination size [-Werror=3Dstringop-truncation]
>      strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
>=20
> The full log is available at
> http://patchew.org/logs/1547573562-32754-1-git-send-email-thuth@redhat.co=
m/testing.docker-mingw@fedora/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

This issue was not introduced by the patch itself.
Will send a pull request anyways.

--=20
Eduardo Otubo

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcYp9cAAoJEN8y58Dw//milSYIAMzg3BPVauwRwe+7l+JBxn+L
xkr1lbvrJBp8WEQi0WXzZBkMYJACcCwKyqyk6CLSjtdl8/MVLWOIErfJZNYOlXjU
iCOnwKFjOg9lcbNYf3bmf0mgo2X6dG3n9b0JSQIA54KZu/ZfoHTvpHSpHP16lXKF
ppPBV8fPbeCV8OuGg+pXbNjD5D4Zd+S36c/d0iaFBjWp4so73HgukPzpruxvtMrR
gsAkEPn32pH3Sogwi8zGLMJhs4U+GmKEWKpjnlzQVgweZK15d+W07RvWiXkOFNmn
MonrgxiTzGmOyf9y1X72gu7p0Bc5PkT5mQFhUa7OsUhuXS8ZswbPd1dV5ilNVc4=
=pGbg
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
