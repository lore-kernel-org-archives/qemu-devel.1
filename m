Received: from eggs.gnu.org ([2001:4830:134:3::10]:47182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqHtq-0007o5-5U
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:28:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqHtp-0008Sr-Af
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:28:58 -0500
References: <20180223192549.26666-1-kwolf@redhat.com>
	<20180223192549.26666-28-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <65fe215a-62b2-f94f-97fe-615ce0d15487@redhat.com>
Date: Mon, 26 Feb 2018 13:28:46 +0100
MIME-Version: 1.0
In-Reply-To: <20180223192549.26666-28-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aaF3fu3s36FBEAdodYQ0Qv0h4NHBOsUDt"
Subject: Re: [Qemu-devel] [PATCH v3 27/36] sheepdog: QAPIfy "redundancy"
 create option
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
--aaF3fu3s36FBEAdodYQ0Qv0h4NHBOsUDt
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <65fe215a-62b2-f94f-97fe-615ce0d15487@redhat.com>
Subject: Re: [PATCH v3 27/36] sheepdog: QAPIfy "redundancy" create option
References: <20180223192549.26666-1-kwolf@redhat.com>
 <20180223192549.26666-28-kwolf@redhat.com>
In-Reply-To: <20180223192549.26666-28-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-23 20:25, Kevin Wolf wrote:
> The "redundancy" option for Sheepdog image creation is currently a
> string that can encode one or two integers depending on its format,
> which at the same time implicitly selects a mode.
>=20
> This patch turns it into a QAPI union and converts the string into such=

> a QAPI object before interpreting the values.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  qapi/block-core.json | 45 +++++++++++++++++++++++++
>  block/sheepdog.c     | 94 +++++++++++++++++++++++++++++++++++++-------=
--------
>  2 files changed, 112 insertions(+), 27 deletions(-)

[...]

> @@ -1907,35 +1950,32 @@ static int parse_redundancy(BDRVSheepdogState *=
s, const char *opt)
>          return -EINVAL;
>      }
> =20
> -    copy =3D strtol(n1, NULL, 10);
> -    /* FIXME fix error checking by switching to qemu_strtol() */
> -    if (copy > SD_MAX_COPIES || copy < 1) {
> -        return -EINVAL;
> -    }
> -    if (!n2) {
> -        inode->copy_policy =3D 0;
> -        inode->nr_copies =3D copy;
> -        return 0;
> +    ret =3D qemu_strtol(n1, NULL, 10, &copy);

(By the way: This was what I was thanking you for in v2 -- I just now
realized I was clever enough not to point to it in my reply...)

> +    if (ret < 0) {
> +        return ret;
>      }


--aaF3fu3s36FBEAdodYQ0Qv0h4NHBOsUDt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqT/X4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ABcwIALIWgU40WGgBeVL9SwgdsaWDqPwB90Lf
yBEB/dXO79Ae6JY0RAdt6lbT0addXx+sgqWFthtE/tT+oggMEkHRDq3X3uNPDK8p
DXq3SsLTAQ8ahvDv45V6hUUjS5u9xImX+xE4WSSv8DQzBVbUTYh63z9d0PYv+4bk
6vI208JcuBriqNs31fBoQuRB+lSvX5iKK0uyJNdCbqijWVjnjbrsy53X8ilVP7Zq
Gkq21MxN9Wyl5o75DdAPALxUaHCSW8k9MVayderJMeIhuSqSfubI0pnnoA2wI2cZ
D4sPjCOAH76a+qMHkvLSxWTSukywYR7ZTHJ+ea0HpsgASYznzv1PcPE=
=kluO
-----END PGP SIGNATURE-----

--aaF3fu3s36FBEAdodYQ0Qv0h4NHBOsUDt--
