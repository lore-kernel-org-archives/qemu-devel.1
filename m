Received: from eggs.gnu.org ([2001:4830:134:3::10]:51732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ep06r-0006x0-W4
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ep05f-0003n7-W8
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:17:05 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-21-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e489044a-0cb7-b7f1-3042-26ba1bbc7dfc@redhat.com>
Date: Fri, 23 Feb 2018 00:13:25 +0100
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-21-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C94pcZWrusjkhSABtLmcQiC1aUGIBFFGK"
Subject: Re: [Qemu-devel] [PATCH v2 20/36] rbd: Remove non-schema options
 from runtime_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C94pcZWrusjkhSABtLmcQiC1aUGIBFFGK
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <e489044a-0cb7-b7f1-3042-26ba1bbc7dfc@redhat.com>
Subject: Re: [PATCH v2 20/36] rbd: Remove non-schema options from runtime_opts
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-21-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-21-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-21 14:53, Kevin Wolf wrote:
> Instead of the QemuOpts in qemu_rbd_connect(), we want to use QAPI
> objects. As a preparation, fetch those options directly from the QDict
> that .bdrv_open() supports in the rbd driver and that are not in the
> schema.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/rbd.c | 55 ++++++++++++++++++++++++-----------------------------=
--
>  1 file changed, 24 insertions(+), 31 deletions(-)
>=20
> diff --git a/block/rbd.c b/block/rbd.c
> index 4bbcce4eca..2e79c2d1fd 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -326,28 +326,6 @@ static QemuOptsList runtime_opts =3D {
>          /*
>           * server.* extracted manually, see qemu_rbd_mon_host()
>           */
> -        {
> -            .name =3D "password-secret",
> -            .type =3D QEMU_OPT_STRING,
> -            .help =3D "ID of secret providing the password",
> -        },

Err, did we just forget this in the QAPI schema or is it really not
supposed to be there?

Max


--C94pcZWrusjkhSABtLmcQiC1aUGIBFFGK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqPTpUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AyngH/0BYPLaCh00kw8uQWKfPEzLwrDsOZ284
LBK1hfgYfvZibL3eLjZGgo744orW/jfE7rYKP0DNIwivDgEPaJiFoGUuP8kYoRkP
n9D/ecWvGN9xhtFWXwikVsDgWEsyK3QDw++CIoJt715GymElVRr/IqBy5nP5RHff
Cp+M+cakQkczfY2uYeHNNSt3S5XyFebhIODaROV3boJgvTl2idRLjHCjnKMmsd2D
z4nyF2XkKt6OMRpaKqP1sKHmFoxdk3b/kmSO1Ynioum7xLzP2HZO03sbT88sxtCQ
29U5TnqelkXJOU4Vsg51e66jx4DXTP2VjOIYS50B7J6960cdudToAFM=
=ZbOE
-----END PGP SIGNATURE-----

--C94pcZWrusjkhSABtLmcQiC1aUGIBFFGK--
