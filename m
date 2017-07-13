Received: from eggs.gnu.org ([2001:4830:134:3::10]:55556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVkax-0004vK-2s
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVkaw-0003wD-3s
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:20:19 -0400
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-9-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <36921d14-da67-1b0e-3ae6-a609963794f0@redhat.com>
Date: Thu, 13 Jul 2017 15:20:01 -0500
MIME-Version: 1.0
In-Reply-To: <20170713163219.9024-9-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="c273TNgFDBcAV72uTJRM9oQTsvvTTXnPO"
Subject: Re: [Qemu-devel] [PATCH v2 08/29] qcow2: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org, "open list:qcow2" <qemu-block@nongnu.org>, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c273TNgFDBcAV72uTJRM9oQTsvvTTXnPO
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org,
 "open list:qcow2" <qemu-block@nongnu.org>, qemu-trivial@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <36921d14-da67-1b0e-3ae6-a609963794f0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 08/29] qcow2: use DIV_ROUND_UP
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
 <20170713163219.9024-9-marcandre.lureau@redhat.com>
In-Reply-To: <20170713163219.9024-9-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2017 11:31 AM, Marc-Andr=C3=A9 Lureau wrote:
> I used the clang-tidy qemu-round check to generate the fix:
> https://github.com/elmarco/clang-tools-extra
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block/qcow2-cluster.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index f06c08f64c..30db942dde 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -61,7 +61,7 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_=
t min_size,
>              new_l1_size =3D 1;
>          }
>          while (min_size > new_l1_size) {
> -            new_l1_size =3D (new_l1_size * 3 + 1) / 2;
> +            new_l1_size =3D DIV_ROUND_UP(new_l1_size * 3, 2);
>          }
>      }
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--c273TNgFDBcAV72uTJRM9oQTsvvTTXnPO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ9XxAAoJEKeha0olJ0NqFPAH/3ZpXKgCervqXnn0faW8oBxA
LkI9UCi2JZOm0taGMVKPyi9ow+a3a3SZoYmY2B2Zjvv1K5qCcnVT76B351nQW15x
ZQMeTzG5FopI0C7lIMo6BqemGjjIfBvATi2JZRERnkoNl3uEuKxr4+upQhFri9NM
0jvlMQmMtzv1WuLcYSaiIqB/hMdSS4a9V9MkMp54kpa0e/aF9PGbG0h4fo5VP4Y/
FsOlMcc1Yu/13TOLMqSllwHVUtXuQgv7JPVV1R4gAJIUWnhUUHTEvqk0bBGEkujv
jDmjDSXNV3zr7ctWSVnS9je774/WLbsxSMdthXupyjx6BJBLrb3TzCea3pdvmg4=
=6OIl
-----END PGP SIGNATURE-----

--c273TNgFDBcAV72uTJRM9oQTsvvTTXnPO--
