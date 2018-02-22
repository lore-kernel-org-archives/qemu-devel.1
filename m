Received: from eggs.gnu.org ([2001:4830:134:3::10]:56201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ep0QW-0005ds-DG
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ep0Pd-000301-9g
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:37:24 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-24-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4c07e530-616a-6fb6-473c-6fce26210590@redhat.com>
Date: Fri, 23 Feb 2018 00:34:28 +0100
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-24-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aBiLUBEVr6YtgKpesm6bznlh4FuhOwlCO"
Subject: Re: [Qemu-devel] [PATCH v2 23/36] rbd: ***ing s->snap/image_name in
 qemu_rbd_open()
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
--aBiLUBEVr6YtgKpesm6bznlh4FuhOwlCO
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <4c07e530-616a-6fb6-473c-6fce26210590@redhat.com>
Subject: Re: [PATCH v2 23/36] rbd: ***ing s->snap/image_name in
 qemu_rbd_open()
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-24-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-24-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I suppose the first word after the colon in your subject is supposed to
be "assign" and not what it currently is (which is something I am not
going to repeat!). :-)

On 2018-02-21 14:53, Kevin Wolf wrote:
> Now that the options are already available in qemu_rbd_open() and not
> only parsed in qemu_rbd_connect(), we can assign s->snap and
> s->image_name there instead of passing the fields by reference to
> qemu_rbd_connect().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/rbd.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/block/rbd.c b/block/rbd.c
> index 82f03505a9..a34bf0be46 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c

[...]

> @@ -716,13 +710,15 @@ static int qemu_rbd_open(BlockDriverState *bs, QD=
ict *options, int flags,
>          goto out;
>      }
> =20
> -    r =3D qemu_rbd_connect(&s->cluster, &s->io_ctx, &s->snap, &s->imag=
e_name,
> -                         opts, !(flags & BDRV_O_NOCACHE), keypairs, se=
cretid,
> -                         errp);
> +    r =3D qemu_rbd_connect(&s->cluster, &s->io_ctx, opts,
> +                         !(flags & BDRV_O_NOCACHE), keypairs, secretid=
, errp);
>      if (r < 0) {
>          goto out;
>      }
> =20
> +    s->snap =3D g_strdup(opts->snapshot);
> +    s->image_name =3D g_strdup(opts->image);
> +

Same question as in patch 21: Should we guard these by checking
opts->has_* first?

Max

>      /* rbd_open is always r/w */
>      r =3D rbd_open(s->io_ctx, s->image_name, &s->image, s->snap);
>      if (r < 0) {
>=20



--aBiLUBEVr6YtgKpesm6bznlh4FuhOwlCO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqPU4QSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AhaQIAKM1czY4UkdKmJtg37I+Kf/oL/RJBBRP
uQMPGjdmLjJZvUe/o4mW2iI/l4jQxC6+qL1uMl49lZFh0vzWEuTeL89+luNPgSI3
XCvxRb89ginI/2cO7qLvX49WClJZSKMntHtrYNnGHaChkzDjhLf2edQUk+EepDQ5
xwbyrVRMNtzEtxRlA1u1LHUFwc9pzPhPGoEHoF7hboRlsiQHZer0/jlsf9uncub8
hEPzL8zgRAVP0mRJBth7gMQM7A7Fv8j9FIEZEuG2TRL6A3LHhQIPfXcJrZmgFfX2
9jg8kIFVn15nnELUwBCSoJJCT+kioI+ts477qma0JlEU5mg7mrtGZEg=
=OOEY
-----END PGP SIGNATURE-----

--aBiLUBEVr6YtgKpesm6bznlh4FuhOwlCO--
