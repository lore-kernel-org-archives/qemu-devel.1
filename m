Received: from eggs.gnu.org ([2001:4830:134:3::10]:42459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjAWc-00010y-T4
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 15:07:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjAWZ-0003i0-HR
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 15:07:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjAWZ-0003hY-85
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 15:06:59 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28AEAC00DE18
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 20:06:59 +0000 (UTC)
References: <20170227134202.2991-1-marcandre.lureau@redhat.com>
	<20170227134202.2991-4-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1e5ebe24-8e7a-68b9-7a59-1950724268c0@redhat.com>
Date: Wed, 1 Mar 2017 14:06:56 -0600
MIME-Version: 1.0
In-Reply-To: <20170227134202.2991-4-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nafrW5pWtsvCFqwRAHguPvcQa9tdq66rX"
Subject: Re: [Qemu-devel] [PATCH v2 03/21] xen: use a better chardev type
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nafrW5pWtsvCFqwRAHguPvcQa9tdq66rX
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <1e5ebe24-8e7a-68b9-7a59-1950724268c0@redhat.com>
Subject: Re: [PATCH v2 03/21] xen: use a better chardev type check
References: <20170227134202.2991-1-marcandre.lureau@redhat.com>
 <20170227134202.2991-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170227134202.2991-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 07:41 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  xen-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/xen-common.c b/xen-common.c
> index fd2c92847e..d46685ef4e 100644
> --- a/xen-common.c
> +++ b/xen-common.c
> @@ -34,7 +34,7 @@ static int store_dev_info(int domid, Chardev *cs, con=
st char *string)
>      int ret =3D -1;
> =20
>      /* Only continue if we're talking to a pty. */
> -    if (strncmp(cs->filename, "pty:", 4)) {
> +    if (!CHARDEV_IS_PTY(cs)) {
>          return 0;
>      }
>      pts =3D cs->filename + 4;
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--nafrW5pWtsvCFqwRAHguPvcQa9tdq66rX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtyngAAoJEKeha0olJ0NqpgAH+gKIew2rUgWIB71UuEXxCDp7
HhS6TjDZlEh6c66qp6mwjuzXvBaoBXVavxj8OwnHjF8tU8KsxYs0exmoGxLqkx5P
goUlxCTj/9o50ytlrRsy4uPcWOR28yIMGezx0S2faSqKphpg3Cmk44SJzstvqdAH
DTQ5HGrNI30itMSuL5fz4umcwPPRDykuSaSOzqvpFlTapDsIyxAptwKUS0uN1MD8
2Vr7d41MnrH1EJNXpVMwkL/Cd0Fr2P4sO1BpbbxoEYGKHKu1OX8rbmn03cNZYsAN
nkf4eC8S9F/RCWEFuEWaHsn/7N4QNh13jsp5DoyQmZWHMIj+8mXO/NPgttc+rwg=
=Z27o
-----END PGP SIGNATURE-----

--nafrW5pWtsvCFqwRAHguPvcQa9tdq66rX--
