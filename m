Received: from eggs.gnu.org ([2001:4830:134:3::10]:56676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZliJ-0001o5-Cu
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 17:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZliG-00056H-BZ
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 17:52:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eZliG-00054M-3N
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 17:52:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BCADC00F1D8
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 22:52:42 +0000 (UTC)
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
	<20180111213250.16511-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a70d433c-669a-6664-a37c-124b58b85820@redhat.com>
Date: Thu, 11 Jan 2018 16:52:38 -0600
MIME-Version: 1.0
In-Reply-To: <20180111213250.16511-2-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="89bgeoABRGtqgRwCJOiEbxViNnBcUkSNI"
Subject: Re: [Qemu-devel] [PATCH v4 01/51] qlit: use QType instead of int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--89bgeoABRGtqgRwCJOiEbxViNnBcUkSNI
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com
Message-ID: <a70d433c-669a-6664-a37c-124b58b85820@redhat.com>
Subject: Re: [PATCH v4 01/51] qlit: use QType instead of int
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
 <20180111213250.16511-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2018 03:32 PM, Marc-Andr=C3=A9 Lureau wrote:
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qmp/qlit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
> index b18406bce9..0c6809ef3c 100644
> --- a/include/qapi/qmp/qlit.h
> +++ b/include/qapi/qmp/qlit.h
> @@ -21,7 +21,7 @@ typedef struct QLitDictEntry QLitDictEntry;
>  typedef struct QLitObject QLitObject;
> =20
>  struct QLitObject {
> -    int type;
> +    QType type;
>      union {
>          bool qbool;
>          int64_t qnum;
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--89bgeoABRGtqgRwCJOiEbxViNnBcUkSNI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpX6rYACgkQp6FrSiUn
Q2r7ggf/Y3tSaFWbTbqFmUgTbGnuVnhWH+bvKccwY5WtobVPVqz8PlvFa4eOTl/C
7kGtHE1H+lL6b/c+H71zdFw0vUSkCI30Nekfn9FMv4HEh6tIaq+kj6LZ/GykWkjx
SlbhRXqS9LPFmrN273mec4zOrpTHSPqRlK67klh3sYNicQzmBBxIJWeuLNAzd44I
HpQJTJRUTsHONtfva22uVxYdAuHKZH+cD8EttMR0WbmXm0AuZy+18gjISxZiSlF8
5nbQsl3lf/ZEQqG+z/gURY+EFxY5VyjeCNBV4Zhemhk+jMCrmYG0BrvhDYuF1fb3
TAzqB91BZ9qou8U5SDzuspjo5OGIrw==
=wRY/
-----END PGP SIGNATURE-----

--89bgeoABRGtqgRwCJOiEbxViNnBcUkSNI--
