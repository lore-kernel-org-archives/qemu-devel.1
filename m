Received: from eggs.gnu.org ([2001:4830:134:3::10]:48111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn8yn-0000pa-7c
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn8ym-0002YW-4r
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:48:49 -0400
References: <cover.1504112061.git.jcody@redhat.com>
	<30210223ca3a13c64b4ba623479b69ae23fa865e.1504112061.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e6c94c07-1724-3db0-2d2e-7cbd94732376@redhat.com>
Date: Wed, 30 Aug 2017 14:48:40 -0500
MIME-Version: 1.0
In-Reply-To: <30210223ca3a13c64b4ba623479b69ae23fa865e.1504112061.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4n1rB7snNq1VVPXI67rIm8H1gQUo8OsUa"
Subject: Re: [Qemu-devel] [PATCH v2 4/7] block/sheepdog: code beautification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, kwolf@redhat.com, rjones@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4n1rB7snNq1VVPXI67rIm8H1gQUo8OsUa
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, kwolf@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org
Message-ID: <e6c94c07-1724-3db0-2d2e-7cbd94732376@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/7] block/sheepdog: code beautification
References: <cover.1504112061.git.jcody@redhat.com>
 <30210223ca3a13c64b4ba623479b69ae23fa865e.1504112061.git.jcody@redhat.com>
In-Reply-To: <30210223ca3a13c64b4ba623479b69ae23fa865e.1504112061.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/30/2017 11:57 AM, Jeff Cody wrote:
> No functional changes, just whitespace manipulation.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/sheepdog.c | 162 +++++++++++++++++++++++++++--------------------=
--------
>  1 file changed, 81 insertions(+), 81 deletions(-)
>=20

>  static BlockDriver bdrv_sheepdog =3D {
> -    .format_name    =3D "sheepdog",
> -    .protocol_name  =3D "sheepdog",
> -    .instance_size  =3D sizeof(BDRVSheepdogState),
> -    .bdrv_parse_filename    =3D sd_parse_filename,
> -    .bdrv_file_open =3D sd_open,
> -    .bdrv_reopen_prepare    =3D sd_reopen_prepare,
> -    .bdrv_reopen_commit     =3D sd_reopen_commit,
> -    .bdrv_reopen_abort      =3D sd_reopen_abort,
> -    .bdrv_close     =3D sd_close,
> -    .bdrv_create    =3D sd_create,
> -    .bdrv_has_zero_init =3D bdrv_has_zero_init_1,
> -    .bdrv_getlength =3D sd_getlength,

The existing style is indeed ugly since it has no consistency,...

> +    .format_name                  =3D "sheepdog",
> +    .protocol_name                =3D "sheepdog",
> +    .instance_size                =3D sizeof(BDRVSheepdogState),
> +    .bdrv_parse_filename          =3D sd_parse_filename,
> +    .bdrv_file_open               =3D sd_open,
> +    .bdrv_reopen_prepare          =3D sd_reopen_prepare,
> +    .bdrv_reopen_commit           =3D sd_reopen_commit,
> +    .bdrv_reopen_abort            =3D sd_reopen_abort,
> +    .bdrv_close                   =3D sd_close,
> +    .bdrv_create                  =3D sd_create,
> +    .bdrv_has_zero_init           =3D bdrv_has_zero_init_1,
> +    .bdrv_getlength               =3D sd_getlength,
>      .bdrv_get_allocated_file_size =3D sd_get_allocated_file_size,

=2E..but aligning '=3D' requires mass reformatting if you get any longer
=2Ebdrv_ function callback added down the road.  If it were me, I'd just
consistently use a single space everywhere, as in:

=2Eformat_name =3D "sheepdog",
=2Eprotocol_name =3D "sheepdog",

but that's my personal opinion, and not a hard rule, so I won't be
bothered if you don't take it.

>  static BlockDriver bdrv_sheepdog_tcp =3D {
> -    .format_name    =3D "sheepdog",
> -    .protocol_name  =3D "sheepdog+tcp",
> -    .instance_size  =3D sizeof(BDRVSheepdogState),
> -    .bdrv_parse_filename    =3D sd_parse_filename,
> +    .format_name                  =3D "sheepdog",
> +    .protocol_name                =3D "sheepdog+tcp",
> +    .instance_size                =3D sizeof(BDRVSheepdogState),
> +    .bdrv_parse_filename          =3D sd_parse_filename,
>      .bdrv_file_open =3D sd_open,

See, with your style, this row now stands out as being missed; with my
style, this line needs no edits.

But your changes are indeed semantic no-ops, so whether you fix the few
unaligned lines per your style, or redo to a consistent style of only a
single space, you can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4n1rB7snNq1VVPXI67rIm8H1gQUo8OsUa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmnFpgACgkQp6FrSiUn
Q2ruxwf/WHkMjvvZqG14axkT0hA6pribbVS4pDOJfIvDMa8sro0mvQo6qGVA27Qh
i5XZGayP8J8zXd3F+aQ9cmjeE3vl7acw6jHj8zByJZYFWE2w5b5S33776C/HT3pD
Cii2P5ROBRPzRwr+7aOZaTHPweqACruwOEWjGL/JC80AeUd2BYP8GyAYs2PZp4zx
GrnJDtGcetrQrx4WXwjxK8IbCN6N+Wm6FHA/EB6giVYlk2b8Ii7KwpZwcPr3U/ys
96FS+4PSNGQLwolcC8s1fBnkmxpU6xXINllHJFK5/o6N4Pzv3Xq/0wuynsgoyXlH
SPVBglMznz+ajDbPs3yAAH+g2H8p9Q==
=CqoF
-----END PGP SIGNATURE-----

--4n1rB7snNq1VVPXI67rIm8H1gQUo8OsUa--
