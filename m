Received: from eggs.gnu.org ([2001:4830:134:3::10]:59339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce3Ld-0001if-6R
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:26:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce3Lb-0006hR-OT
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:26:33 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-11-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <609721d7-0361-6a1b-8eb9-fc1bbd14c1f7@redhat.com>
Date: Wed, 15 Feb 2017 18:26:20 +0100
MIME-Version: 1.0
In-Reply-To: <1487006583-24350-11-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SpR0wr6ULlWcONJLWevGmjTs39ktV55Ss"
Subject: Re: [Qemu-devel] [RFC PATCH 10/41] block: Request child permissions
 in format drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SpR0wr6ULlWcONJLWevGmjTs39ktV55Ss
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <609721d7-0361-6a1b-8eb9-fc1bbd14c1f7@redhat.com>
Subject: Re: [RFC PATCH 10/41] block: Request child permissions in format
 drivers
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-11-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-11-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 18:22, Kevin Wolf wrote:
> This makes use of the .bdrv_child_perm() implementation for formats tha=
t
> we just added. All format drivers expose the permissions they actually
> need nows, so that they can be set accordingly and updated when parents=

> are attached or detached.
>=20
> The only format not included here is raw, which was already converted
> with the other filter drivers.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/bochs.c     | 1 +

In theory it might make sense to have another category "read-only format
drivers". In practice those are the drivers we don't care much about,
soooo...

>  block/cloop.c     | 1 +
>  block/crypto.c    | 1 +

I'm not sure whether the crypto driver qualifies more as a format driver
than as a filter driver. I guess saying it's a format driver is a bit
more strict and it's better to be strict when it doubt.

Max

>  block/dmg.c       | 1 +
>  block/parallels.c | 1 +
>  block/qcow.c      | 1 +
>  block/qcow2.c     | 1 +
>  block/qed.c       | 1 +
>  block/vdi.c       | 1 +
>  block/vhdx.c      | 1 +
>  block/vmdk.c      | 1 +
>  block/vpc.c       | 1 +
>  12 files changed, 12 insertions(+)
>=20
> diff --git a/block/bochs.c b/block/bochs.c
> index 7dd2ac4..516da56 100644
> --- a/block/bochs.c
> +++ b/block/bochs.c
> @@ -293,6 +293,7 @@ static BlockDriver bdrv_bochs =3D {
>      .instance_size	=3D sizeof(BDRVBochsState),
>      .bdrv_probe		=3D bochs_probe,
>      .bdrv_open		=3D bochs_open,
> +    .bdrv_child_perm     =3D bdrv_format_default_perms,
>      .bdrv_refresh_limits =3D bochs_refresh_limits,
>      .bdrv_co_preadv =3D bochs_co_preadv,
>      .bdrv_close		=3D bochs_close,
> diff --git a/block/cloop.c b/block/cloop.c
> index 877c9b0..a6c7b9d 100644
> --- a/block/cloop.c
> +++ b/block/cloop.c
> @@ -290,6 +290,7 @@ static BlockDriver bdrv_cloop =3D {
>      .instance_size  =3D sizeof(BDRVCloopState),
>      .bdrv_probe     =3D cloop_probe,
>      .bdrv_open      =3D cloop_open,
> +    .bdrv_child_perm     =3D bdrv_format_default_perms,
>      .bdrv_refresh_limits =3D cloop_refresh_limits,
>      .bdrv_co_preadv =3D cloop_co_preadv,
>      .bdrv_close     =3D cloop_close,
> diff --git a/block/crypto.c b/block/crypto.c
> index 200fd0b..ca46883 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -628,6 +628,7 @@ BlockDriver bdrv_crypto_luks =3D {
>      .bdrv_probe         =3D block_crypto_probe_luks,
>      .bdrv_open          =3D block_crypto_open_luks,
>      .bdrv_close         =3D block_crypto_close,
> +    .bdrv_child_perm    =3D bdrv_format_default_perms,
>      .bdrv_create        =3D block_crypto_create_luks,
>      .bdrv_truncate      =3D block_crypto_truncate,
>      .create_opts        =3D &block_crypto_create_opts_luks,
> diff --git a/block/dmg.c b/block/dmg.c
> index 8e387cd..a7d25fc 100644
> --- a/block/dmg.c
> +++ b/block/dmg.c
> @@ -697,6 +697,7 @@ static BlockDriver bdrv_dmg =3D {
>      .bdrv_probe     =3D dmg_probe,
>      .bdrv_open      =3D dmg_open,
>      .bdrv_refresh_limits =3D dmg_refresh_limits,
> +    .bdrv_child_perm     =3D bdrv_format_default_perms,
>      .bdrv_co_preadv =3D dmg_co_preadv,
>      .bdrv_close     =3D dmg_close,
>  };
> diff --git a/block/parallels.c b/block/parallels.c
> index d3970e1..b79e7df 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -762,6 +762,7 @@ static BlockDriver bdrv_parallels =3D {
>      .bdrv_probe		=3D parallels_probe,
>      .bdrv_open		=3D parallels_open,
>      .bdrv_close		=3D parallels_close,
> +    .bdrv_child_perm          =3D bdrv_format_default_perms,
>      .bdrv_co_get_block_status =3D parallels_co_get_block_status,
>      .bdrv_has_zero_init       =3D bdrv_has_zero_init_1,
>      .bdrv_co_flush_to_os      =3D parallels_co_flush_to_os,
> diff --git a/block/qcow.c b/block/qcow.c
> index a6dfe1a..3a95d4f 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -1052,6 +1052,7 @@ static BlockDriver bdrv_qcow =3D {
>      .bdrv_probe		=3D qcow_probe,
>      .bdrv_open		=3D qcow_open,
>      .bdrv_close		=3D qcow_close,
> +    .bdrv_child_perm        =3D bdrv_format_default_perms,
>      .bdrv_reopen_prepare    =3D qcow_reopen_prepare,
>      .bdrv_create            =3D qcow_create,
>      .bdrv_has_zero_init     =3D bdrv_has_zero_init_1,
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 4684554..dac3fb8 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3399,6 +3399,7 @@ BlockDriver bdrv_qcow2 =3D {
>      .bdrv_reopen_commit   =3D qcow2_reopen_commit,
>      .bdrv_reopen_abort    =3D qcow2_reopen_abort,
>      .bdrv_join_options    =3D qcow2_join_options,
> +    .bdrv_child_perm      =3D bdrv_format_default_perms,
>      .bdrv_create        =3D qcow2_create,
>      .bdrv_has_zero_init =3D bdrv_has_zero_init_1,
>      .bdrv_co_get_block_status =3D qcow2_co_get_block_status,
> diff --git a/block/qed.c b/block/qed.c
> index 1ea5114..eda9402 100644
> --- a/block/qed.c
> +++ b/block/qed.c
> @@ -1678,6 +1678,7 @@ static BlockDriver bdrv_qed =3D {
>      .bdrv_open                =3D bdrv_qed_open,
>      .bdrv_close               =3D bdrv_qed_close,
>      .bdrv_reopen_prepare      =3D bdrv_qed_reopen_prepare,
> +    .bdrv_child_perm          =3D bdrv_format_default_perms,
>      .bdrv_create              =3D bdrv_qed_create,
>      .bdrv_has_zero_init       =3D bdrv_has_zero_init_1,
>      .bdrv_co_get_block_status =3D bdrv_qed_co_get_block_status,
> diff --git a/block/vdi.c b/block/vdi.c
> index 18b4773..fd6e26d 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -891,6 +891,7 @@ static BlockDriver bdrv_vdi =3D {
>      .bdrv_open =3D vdi_open,
>      .bdrv_close =3D vdi_close,
>      .bdrv_reopen_prepare =3D vdi_reopen_prepare,
> +    .bdrv_child_perm          =3D bdrv_format_default_perms,
>      .bdrv_create =3D vdi_create,
>      .bdrv_has_zero_init =3D bdrv_has_zero_init_1,
>      .bdrv_co_get_block_status =3D vdi_co_get_block_status,
> diff --git a/block/vhdx.c b/block/vhdx.c
> index 4dc2743..8c5ade2 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -1983,6 +1983,7 @@ static BlockDriver bdrv_vhdx =3D {
>      .bdrv_open              =3D vhdx_open,
>      .bdrv_close             =3D vhdx_close,
>      .bdrv_reopen_prepare    =3D vhdx_reopen_prepare,
> +    .bdrv_child_perm        =3D bdrv_format_default_perms,
>      .bdrv_co_readv          =3D vhdx_co_readv,
>      .bdrv_co_writev         =3D vhdx_co_writev,
>      .bdrv_create            =3D vhdx_create,
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 9d68ec5..f5e2fb5 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -2359,6 +2359,7 @@ static BlockDriver bdrv_vmdk =3D {
>      .bdrv_open                    =3D vmdk_open,
>      .bdrv_check                   =3D vmdk_check,
>      .bdrv_reopen_prepare          =3D vmdk_reopen_prepare,
> +    .bdrv_child_perm              =3D bdrv_format_default_perms,
>      .bdrv_co_preadv               =3D vmdk_co_preadv,
>      .bdrv_co_pwritev              =3D vmdk_co_pwritev,
>      .bdrv_co_pwritev_compressed   =3D vmdk_co_pwritev_compressed,
> diff --git a/block/vpc.c b/block/vpc.c
> index d0df2a1..b9c9832 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -1067,6 +1067,7 @@ static BlockDriver bdrv_vpc =3D {
>      .bdrv_open              =3D vpc_open,
>      .bdrv_close             =3D vpc_close,
>      .bdrv_reopen_prepare    =3D vpc_reopen_prepare,
> +    .bdrv_child_perm        =3D bdrv_format_default_perms,
>      .bdrv_create            =3D vpc_create,
> =20
>      .bdrv_co_preadv             =3D vpc_co_preadv,
>=20



--SpR0wr6ULlWcONJLWevGmjTs39ktV55Ss
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlikjzwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Af08IAJhm98aU5GgTFhHJqvz09Rg7AmzalbJ/
LjIihQcy8hqARnIY6MeOulA2ngKhkpOoJQI4WtwQZQ0bYzqatjxWUSSMS92IKyVQ
wgoG38EU04DsdUONmtCTjXN1zgTtWqshYaOBTPHTh7Zbde0zU2I45L41aU/ph5f9
M7qlkn5rQlPJ7e0xF3hyudSM9F+vRKngsAJ9Nh11XRbpLaRzhOQdgZhgIfgKBUDz
gwU1oESQwsqjB2i0u4+0xXBHARtTH40HXAN8q+QzpbiBGY7xhmFkui8b1kMv7TGS
9pni8gWcju/9pw6oWYi/f+pZ60zmCGhnPvhllYaHoElO2prXbwD+MVY=
=qB4I
-----END PGP SIGNATURE-----

--SpR0wr6ULlWcONJLWevGmjTs39ktV55Ss--
