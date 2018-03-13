Received: from eggs.gnu.org ([2001:4830:134:3::10]:60605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evlP5-0000TL-0m
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evlP4-0003aB-77
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:59:51 -0400
References: <20180313144730.2184-1-kwolf@redhat.com>
	<20180313144730.2184-7-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f9e6e86b-c29d-bbf6-b979-ac33eb953391@redhat.com>
Date: Tue, 13 Mar 2018 15:59:38 +0100
MIME-Version: 1.0
In-Reply-To: <20180313144730.2184-7-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xb0WvBIApIbx5Na8EPEjtVbH2EZyGNWRs"
Subject: Re: [Qemu-devel] [PATCH v2 6/8] vhdx: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xb0WvBIApIbx5Na8EPEjtVbH2EZyGNWRs
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <f9e6e86b-c29d-bbf6-b979-ac33eb953391@redhat.com>
Subject: Re: [PATCH v2 6/8] vhdx: Support .bdrv_co_create
References: <20180313144730.2184-1-kwolf@redhat.com>
 <20180313144730.2184-7-kwolf@redhat.com>
In-Reply-To: <20180313144730.2184-7-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-13 15:47, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to vhdx, which
> enables image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  40 +++++++++-
>  block/vhdx.c         | 216 ++++++++++++++++++++++++++++++++++++++-----=
--------
>  2 files changed, 203 insertions(+), 53 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

> diff --git a/block/vhdx.c b/block/vhdx.c
> index d82350d07c..f1b97f4b49 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c

[...]

> @@ -1792,59 +1797,71 @@ exit:
>   *    .---- ~ ----------- ~ ------------ ~ ---------------- ~ --------=
---.
>   *   1MB
>   */
> -static int coroutine_fn vhdx_co_create_opts(const char *filename, Qemu=
Opts *opts,
> -                                            Error **errp)
> +static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
> +                                       Error **errp)
>  {

[...]

>      /* These are pretty arbitrary, and mainly designed to keep the BAT=

>       * size reasonable to load into RAM */
> -    if (block_size =3D=3D 0) {
> +    if (vhdx_opts->has_block_size) {
> +        block_size =3D vhdx_opts->block_size;
> +    } else {

Ah, good.  I have to admit I was a bit worried you'd keep the special
meaning of cluster_size =3D=3D 0.

Max

>          if (image_size > 32 * TiB) {
>              block_size =3D 64 * MiB;
>          } else if (image_size > (uint64_t) 100 * GiB) {


--xb0WvBIApIbx5Na8EPEjtVbH2EZyGNWRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqn51oSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AUGEH/38A/0JTWfRSFQL4aXaAG9CCQkXMWgLj
06ml/FSlt4M+q2ylLio7o3884YHcenA7ErU8N9HEo/cEqMwUyyV1yFy8nLy/pTe8
bBlD0hzjmHtX9SxdqpbiYOw7+c0CO4LZi/AXBr0Y98k/26lFu7tIvrIh819XQnbi
8PPGCCicQb4Kv+aQh/rVvzrlUpjTMaDyNe/caqapxp69w8lDC3sVQC42+augXeAV
XNuSlBzP2wqmx1DDr5L9ACvXCBdcVyXJby49D8H/o7f87hP7SqDTqInT+paRD7h3
qiV3mGJ3U5ADA/AE2e2RkO7xPCXJEt0tue53i0ifBhd88JPNCKCwB+o=
=8tto
-----END PGP SIGNATURE-----

--xb0WvBIApIbx5Na8EPEjtVbH2EZyGNWRs--
