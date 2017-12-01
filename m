Received: from eggs.gnu.org ([2001:4830:134:3::10]:34133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eKowC-0007hV-7Q
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:17:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eKowB-0006Ae-Ck
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:17:20 -0500
Date: Fri, 1 Dec 2017 09:45:38 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171201094538.GD23501@stefanha-x1.localdomain>
References: <20171129224421.18192-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline
In-Reply-To: <20171129224421.18192-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iotests: fix 197 for vpc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, ldoktor@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 05:44:21PM -0500, John Snow wrote:
> VPC has some difficulty creating geometries of particular size.
> However, we can indeed force it to use a literal one, so let's
> do that for the sake of test 197, which is testing some specific
> offsets.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/197           | 3 +++
>  tests/qemu-iotests/common.filter | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
> index 887eb4f496..e1292689c1 100755
> --- a/tests/qemu-iotests/197
> +++ b/tests/qemu-iotests/197
> @@ -60,6 +60,9 @@ echo '=3D=3D=3D Copy-on-read =3D=3D=3D'
>  echo
> =20
>  # Prep the images
> +if [ "$IMGFMT" =3D "vpc" ]; then
> +    IMGOPTS=3D$(_optstr_add "$IMGOPTS" "force_size")
> +fi

It would be nice to include a comment in the code instead of the commit
description so anyone reading knows why vpc is special-cased here.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaISTCAAoJEJykq7OBq3PIVToH/ArUgOS43uVkUfJ6gSqB1JDN
jVstFRIpEVrQtO7V5WofnNfVy/+btnj1kHwNNaJDHxuTATEFgBc/8HwIpWdrom8B
R7KDzcVfhUm4Zn6RI7tYra0Zf0bP5G9aFco4/z0hjomVLzmHCSuJUp+7+1HpSwH6
EBExJJkMEiu2cTpzQ/89s4UbRhUqGFMgXCOg/+HDt1OuV+kbDtuXkSXTq6mIu8R/
CwabL5fCnj9NHnzaDoQyAqF8eAirk722qkZgERnxvRjP7IxgBQzko7Xd7aesnJG0
cxakC/dx+kr7mBq9MEGzL/WbfqsaTSRRoJecFzp0lfzlLXV/EslULTCOKv0zmQc=
=SVl1
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
