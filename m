Received: from eggs.gnu.org ([209.51.188.92]:51130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3XW9-0006Oj-05
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3XW8-000341-04
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:51:48 -0400
References: <20190308153757.25794-1-kwolf@redhat.com>
	<20190308153757.25794-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b471fd00-2701-0ad0-9eb5-93ac1a3d9d7d@redhat.com>
Date: Mon, 11 Mar 2019 21:46:17 -0500
MIME-Version: 1.0
In-Reply-To: <20190308153757.25794-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GS52Osyh4ZnkmNDUt2vVgqqYN0rPKhEf1"
Subject: Re: [Qemu-devel] [PATCH 1/8] tests/virtio-blk-test: Disable
 auto-read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GS52Osyh4ZnkmNDUt2vVgqqYN0rPKhEf1
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <b471fd00-2701-0ad0-9eb5-93ac1a3d9d7d@redhat.com>
Subject: Re: [PATCH 1/8] tests/virtio-blk-test: Disable auto-read-only
References: <20190308153757.25794-1-kwolf@redhat.com>
 <20190308153757.25794-2-kwolf@redhat.com>
In-Reply-To: <20190308153757.25794-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/8/19 9:37 AM, Kevin Wolf wrote:
> tests/virtio-blk-test uses a temporary image file that it deletes while=

> QEMU is still running, so it can't be reopened when writers are
> attached or detached. Disable auto-read-only to keep it always writable=
=2E
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/virtio-blk-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
> index 8d2fc9c710..0e464aeea4 100644
> --- a/tests/virtio-blk-test.c
> +++ b/tests/virtio-blk-test.c
> @@ -72,7 +72,7 @@ static QOSState *pci_test_start(void)
>      QOSState *qs;
>      const char *arch =3D qtest_get_arch();
>      char *tmp_path;
> -    const char *cmd =3D "-drive if=3Dnone,id=3Ddrive0,file=3D%s,format=
=3Draw "
> +    const char *cmd =3D "-drive if=3Dnone,id=3Ddrive0,file=3D%s,format=
=3Draw,auto-read-only=3Doff "
>                        "-drive if=3Dnone,id=3Ddrive1,file=3Dnull-co://,=
format=3Draw "
>                        "-device virtio-blk-pci,id=3Ddrv0,drive=3Ddrive0=
,"
>                        "addr=3D%x.%x";
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--GS52Osyh4ZnkmNDUt2vVgqqYN0rPKhEf1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyHHXkACgkQp6FrSiUn
Q2qpwQgAiHl+VZJVNWJk00SZKUKYCSrlFEkUjf8vQyENcL+W3hRVH13ys+OQTiCQ
yHfdEeRYZ9aYw6bWcJTWp/QfVzgpprM3l6XbI9QGhc6+upFwfRPX9/Zq05PskHFh
hMPa7rvvb1+ef22LV9MbRoUnamx4gxQDHHzRLNbhH3uocDhLY1d7xJqfNb8SOHVB
OE72k0YASJLU4xCxFS9sVx0CF1mjZpa8gbTZ1J5yO1dWw5fw7o5OqiY36iex67ii
Ktx8Ml5SsYqpmsWvyW38BEmbN0X0pSfphHjo85rm0ULq7eSjsaBBQ58wY+aFpmOf
Ckj91ITvdfc5s//nKDJpDKBzlehO4g==
=A1V2
-----END PGP SIGNATURE-----

--GS52Osyh4ZnkmNDUt2vVgqqYN0rPKhEf1--
