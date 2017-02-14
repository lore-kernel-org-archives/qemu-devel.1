Received: from eggs.gnu.org ([2001:4830:134:3::10]:56463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdi40-0002rV-3w
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdi3y-0005sG-Mg
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:42:56 -0500
References: <261ff7cb02d96c98ea068f3ca255a747b88ebc10.1487096041.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <44cf0a51-5dc1-b144-f269-af9bebf7708e@redhat.com>
Date: Tue, 14 Feb 2017 12:42:44 -0600
MIME-Version: 1.0
In-Reply-To: <261ff7cb02d96c98ea068f3ca255a747b88ebc10.1487096041.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="53UqWvh4T1uvHAILcRk4CkMJeNahGpNjX"
Subject: Re: [Qemu-devel] [PATCH 1/1] qemu-iotests: redirect nbd server
 stdout to /dev/null
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--53UqWvh4T1uvHAILcRk4CkMJeNahGpNjX
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <44cf0a51-5dc1-b144-f269-af9bebf7708e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] qemu-iotests: redirect nbd server stdout
 to /dev/null
References: <261ff7cb02d96c98ea068f3ca255a747b88ebc10.1487096041.git.jcody@redhat.com>
In-Reply-To: <261ff7cb02d96c98ea068f3ca255a747b88ebc10.1487096041.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 12:15 PM, Jeff Cody wrote:
> Some iotests (e.g. 174) try to filter the output of _make_test_image by=

> piping the stdout.  Pipe the server stdout to /dev/null, so that filter=

> pipe does not need to wait until process completion.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  tests/qemu-iotests/common.rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.r=
c
> index 6c0fd4c..08065dc 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -172,7 +172,7 @@ _make_test_img()
> =20
>      # Start an NBD server on the image file, which is what we'll be ta=
lking to
>      if [ $IMGPROTO =3D "nbd" ]; then
> -        eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT  $TEST_=
IMG_FILE &"
> +        eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT  $TEST_=
IMG_FILE >/dev/null &"
>          sleep 1 # FIXME: qemu-nbd needs to be listening before we cont=
inue
>      fi
>  }
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--53UqWvh4T1uvHAILcRk4CkMJeNahGpNjX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYo0+kAAoJEKeha0olJ0Nq9WwH/iQZrMAm2ZTBgWoEnpNL2B8I
b2vGEIfNyRSHZTzjuqoBaTwQyh2SCvLRcJPdZZchtGzUICLJDo/pgGjdv1hTja9F
YDYUeBUT/bz/4JoefmJ5c3uSU6OthjBAXZ9nHjToxVM5ogLe+wamkuIrupbKYWNn
BCGylN5qT4KdBKCf8R5LSLhGH9y4rqtDsRjz8uosz+qeYwcGf0egu3AE+8d2e1wG
d8DFHOxNOg7mYTdCzGXRKjgubUmd3iCArMSagKLTz5rEqM0u7PugOvszbxcn0rIZ
xDe/L957iaml8ePkxogRNW9IwXUjM/kc+nu/b12raBlOaHtrKihbcvWhviXAyLA=
=efno
-----END PGP SIGNATURE-----

--53UqWvh4T1uvHAILcRk4CkMJeNahGpNjX--
