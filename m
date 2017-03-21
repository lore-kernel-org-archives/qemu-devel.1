Received: from eggs.gnu.org ([2001:4830:134:3::10]:37333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq8CN-0000sD-Uc
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq8CF-0000PR-Br
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:02:51 -0400
References: <1490056074976-474433.post@n7.nabble.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <28d15bd5-1620-b39b-ed92-d8812d1549c8@redhat.com>
Date: Mon, 20 Mar 2017 20:02:42 -0500
MIME-Version: 1.0
In-Reply-To: <1490056074976-474433.post@n7.nabble.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VlKKkl6D1EwWunswkKRfMChNG2dGmjjRG"
Subject: Re: [Qemu-devel] [PATCH v4]COLO:Fix Colo doc,
 secondeary should be secondary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wangguang <wang.guang55@zte.com.cn>, qemu-devel@nongnu.org, qemu-trivial <qemu-trivial@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VlKKkl6D1EwWunswkKRfMChNG2dGmjjRG
From: Eric Blake <eblake@redhat.com>
To: wangguang <wang.guang55@zte.com.cn>, qemu-devel@nongnu.org,
 qemu-trivial <qemu-trivial@nongnu.org>
Message-ID: <28d15bd5-1620-b39b-ed92-d8812d1549c8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4]COLO:Fix Colo doc, secondeary should be
 secondary
References: <1490056074976-474433.post@n7.nabble.com>
In-Reply-To: <1490056074976-474433.post@n7.nabble.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding qemu-trivial]

On 03/20/2017 07:27 PM, wangguang wrote:
> Subject: [PATCH] Fix Colo doc secondeary should be secondary=20

This line feels redundant compared to the overall mail's subject line.
In turn, that subject could use a space after colon.

> This is an error in COLO-FT.txt.=20
> secondeary-disk0 should be secondary-disk0.=20
>=20
> Signed-off-by: Guang Wang <wang.guang55@zte.com.cn>
> ---=20
>  docs/COLO-FT.txt | 2 +-=20
>  1 file changed, 1 insertion(+), 1 deletion(-)=20

Reviewed-by: Eric Blake <eblake@redhat.com>

As it is doc-only, it is safe for hard freeze, but also not the end of
the world if it doesn't go in until 2.10.

>=20
> diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt=20
> index e289be2..bec7547 100644=20
> --- a/docs/COLO-FT.txt=20
> +++ b/docs/COLO-FT.txt=20
> @@ -139,7 +139,7 @@ Secondary:=20
>  { 'execute': 'nbd-server-start',=20
>    'arguments': {'addr': {'type': 'inet', 'data': {'host': 'xx.xx.xx.xx=
',
> 'port': '8889'} } }=20
>  }=20
> -{'execute': 'nbd-server-add', 'arguments': {'device': 'secondeary-disk=
0',
> 'writable': true } }=20
> +{'execute': 'nbd-server-add', 'arguments': {'device': 'secondary-disk0=
',
> 'writable': true } }=20
>  =20
>  Note:=20
>    a. The qmp command nbd-server-start and nbd-server-add must be run=20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--VlKKkl6D1EwWunswkKRfMChNG2dGmjjRG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0HuyAAoJEKeha0olJ0NqWfIIAIabVwRkkr+CqBxHlxr7jpej
8cmBdLAis9SSkotuRaOHqMQVlHEraXhu0Fr/nTQypyxNXB2RQG3YFnjLh46i5+jn
KRgY+ymlfZk0nzDZzzew3GSIYRZoxp31P/v+2qqKzZv3cF7769p7LSGaHiE/PF0K
zNONat5eS9leD0z5f0vKkCCsvV5gVpWZusUtxvQ+ER9/OERimoZ8QxQGHH83+2ol
UZitu2lEyor4OKnFKEqlFPF3bzGT9EtaAuRDpZmjFzlcN2s3ZhJwAIZ2rE8eml3p
r1SZHuf5W7NKmAJZmBcP3LT0hgl2PG3J4FiE4JhqxCpE625k/+8DjQQK0Eu/ROI=
=/ru0
-----END PGP SIGNATURE-----

--VlKKkl6D1EwWunswkKRfMChNG2dGmjjRG--
