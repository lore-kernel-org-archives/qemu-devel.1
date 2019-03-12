Received: from eggs.gnu.org ([209.51.188.92]:50911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3XV5-0005pC-Qk
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3XV4-00025s-Qa
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:50:43 -0400
References: <20190311165017.32247-1-kwolf@redhat.com>
	<20190311165017.32247-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d2d13d9a-2263-dd7b-343b-dc0734ea5591@redhat.com>
Date: Mon, 11 Mar 2019 21:50:34 -0500
MIME-Version: 1.0
In-Reply-To: <20190311165017.32247-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="O7vjoHOG62W3JA1oPwlrn7tSQD4IhERq3"
Subject: Re: [Qemu-devel] [PATCH v2 01/10] tests/virtio-blk-test: Disable
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
Cc: mreitz@redhat.com, pkrempa@redhat.com, berto@igalia.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O7vjoHOG62W3JA1oPwlrn7tSQD4IhERq3
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, berto@igalia.com,
 qemu-devel@nongnu.org
Message-ID: <d2d13d9a-2263-dd7b-343b-dc0734ea5591@redhat.com>
Subject: Re: [PATCH v2 01/10] tests/virtio-blk-test: Disable auto-read-only
References: <20190311165017.32247-1-kwolf@redhat.com>
 <20190311165017.32247-2-kwolf@redhat.com>
In-Reply-To: <20190311165017.32247-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/11/19 11:50 AM, Kevin Wolf wrote:
> tests/virtio-blk-test uses a temporary image file that it deletes while=

> QEMU is still running, so it can't be reopened when writers are
> attached or detached. Disable auto-read-only to keep it always writable=
=2E
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/virtio-blk-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks like I started reviewing v1 even though I see v2 has been posted.
R-b carries forward:

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
> index b02be0274e..b65365934b 100644
> --- a/tests/virtio-blk-test.c
> +++ b/tests/virtio-blk-test.c
> @@ -751,7 +751,7 @@ static void *virtio_blk_test_setup(GString *cmd_lin=
e, void *arg)
>      char *tmp_path =3D drive_create();
> =20
>      g_string_append_printf(cmd_line,
> -                           " -drive if=3Dnone,id=3Ddrive0,file=3D%s,fo=
rmat=3Draw "
> +                           " -drive if=3Dnone,id=3Ddrive0,file=3D%s,fo=
rmat=3Draw,auto-read-only=3Doff "
>                             "-drive if=3Dnone,id=3Ddrive1,file=3Dnull-c=
o://,format=3Draw ",
>                             tmp_path);
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--O7vjoHOG62W3JA1oPwlrn7tSQD4IhERq3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyHHnoACgkQp6FrSiUn
Q2oGwwf8C4XnbQhvodALJPCityFTmwVszs+lZVf2/XGSud6mUbZW/r0Yvfb0wzuC
JaRxY5T3CsV8wjuDToZohiB9vCEG/oEdxiglkq556hzJa7g8w8h7mIyZi7LDbQjc
pMfoKjoyZWYPkjdxOM/VqS/wRpAPCJYAB3myoc7vh95uJgsIqJnSUHohg+SBJRtm
oXqXKjqdiL5YIL9tcNm7Gqh1Wvb8OIZkLyaDwHyGPzQj0esLPz825gPFEF+Kex4O
18me8/6AHDj9HLMl0IpiHuFkwkV2qqLoS86xEqowocNKa8gs7k+7ZRrtPJYomH2X
zMePswOoUpE0WsyQR8rzMujgAuFXOQ==
=YDkn
-----END PGP SIGNATURE-----

--O7vjoHOG62W3JA1oPwlrn7tSQD4IhERq3--
