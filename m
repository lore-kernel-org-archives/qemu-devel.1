Received: from eggs.gnu.org ([2001:4830:134:3::10]:47578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cu20j-0003vm-ID
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cu20i-0001wF-Mf
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:15:01 -0400
References: <20170331120431.1767-1-mreitz@redhat.com>
	<20170331120431.1767-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <730e59dc-f46f-41cb-b842-9a91b0dc63bb@redhat.com>
Date: Fri, 31 Mar 2017 14:14:53 -0500
MIME-Version: 1.0
In-Reply-To: <20170331120431.1767-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VC9sCwumSPwdOrC9oVXbGVRjas8n6fHBJ"
Subject: Re: [Qemu-devel] [PATCH for-2.9 2/2] block/curl: Check protocol
 prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VC9sCwumSPwdOrC9oVXbGVRjas8n6fHBJ
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <730e59dc-f46f-41cb-b842-9a91b0dc63bb@redhat.com>
Subject: Re: [PATCH for-2.9 2/2] block/curl: Check protocol prefix
References: <20170331120431.1767-1-mreitz@redhat.com>
 <20170331120431.1767-3-mreitz@redhat.com>
In-Reply-To: <20170331120431.1767-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/31/2017 07:04 AM, Max Reitz wrote:
> If the user has explicitly specified a block driver and thus a protocol=
,
> we have to make sure the URL's protocol prefix matches. Otherwise the
> latter will silently override the former which might catch some users b=
y
> surprise.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/curl.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/block/curl.c b/block/curl.c
> index 34dbd335f4..2708d57c2f 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -659,6 +659,7 @@ static int curl_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
>      const char *cookie;
>      double d;
>      const char *secretid;
> +    const char *protocol_delimiter;
> =20
>      static int inited =3D 0;
> =20
> @@ -700,6 +701,15 @@ static int curl_open(BlockDriverState *bs, QDict *=
options, int flags,
>          goto out_noclean;
>      }
> =20
> +    if (!strstart(file, bs->drv->protocol_name, &protocol_delimiter) |=
|
> +        !strstart(protocol_delimiter, "://", NULL))

Do we care about case-insensitive comparisons here? But I'm fine with
case-sensitive for now, until we have an actual report of someone that
it breaks.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--VC9sCwumSPwdOrC9oVXbGVRjas8n6fHBJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3qqtAAoJEKeha0olJ0NqIi0H/ideRq3CrsLohUWU40lN7YgS
ksrVs8lpVQ19gZHNyt/MTgXytb+aBPrILrmqHl/d9uf7ykI90suK9frMeGwMddUJ
plnMiK7VBWmQfyCMIRxI1S8X4iPlg0ibNkrCdHRu0rjSATQr3i+B1BwCaYc6flyP
tbguFxAsqXd5o9q3wAYeFgIxQHHGVm0ZAENKXop3f9bnJ/WX5F6X2+LbrH8ft9Rj
ZgZh9VsYvcak9mkMi8LIkE5mnHZuE58JITDUsJYBiVeoE411sZ5kFJ7KlPxksYCt
Ge0ci14AWQW+gYgKqYlO/b/neQsRblHLtslfxT5nppGakK2XPwM/3sypUMtsMYg=
=8JQD
-----END PGP SIGNATURE-----

--VC9sCwumSPwdOrC9oVXbGVRjas8n6fHBJ--
