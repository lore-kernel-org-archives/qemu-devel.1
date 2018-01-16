Received: from eggs.gnu.org ([2001:4830:134:3::10]:56861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebYq9-0007gS-TR
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebYq8-0005sg-VZ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:32:17 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<dd49ca34767c46886ef775739c3a3611b7d5a65b.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <03840926-d189-f617-aeae-58de6c0fcd3c@redhat.com>
Date: Tue, 16 Jan 2018 15:32:02 -0600
MIME-Version: 1.0
In-Reply-To: <dd49ca34767c46886ef775739c3a3611b7d5a65b.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ANi90WktkFvP7u1mePm44d4zA0KzeltLR"
Subject: Re: [Qemu-devel] [PATCH v2 05/32] qcow2: Remove BDS parameter from
 qcow2_cache_table_release()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ANi90WktkFvP7u1mePm44d4zA0KzeltLR
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <03840926-d189-f617-aeae-58de6c0fcd3c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/32] qcow2: Remove BDS parameter from
 qcow2_cache_table_release()
References: <cover.1513342045.git.berto@igalia.com>
 <dd49ca34767c46886ef775739c3a3611b7d5a65b.1513342045.git.berto@igalia.com>
In-Reply-To: <dd49ca34767c46886ef775739c3a3611b7d5a65b.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> This function was only using the BlockDriverState parameter to get the
> cache table size (since it was equal to the cluster size). This is no
> longer necessary so this parameter can be removed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cache.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ANi90WktkFvP7u1mePm44d4zA0KzeltLR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeb1IACgkQp6FrSiUn
Q2qAwgf/Qem7bXKYfUBzpluh/rB2wwW7TeozXZdVlxlYyK1Q6XXmquEWizkjmmCX
O9gwQ7ISRsU3J9SuGOJjAKEK8e5brTOgNxVytRlEgpRSx9q+0h4xTRoYgjCg+Dtf
7xB0jJz971Ngm2d9C7xHZyNkmmwuQWZE0MNnrsn1kxU7yJi3tjJ4RdnktZzqIUIH
D321MufX6Q7jEvA+Bkvh9ICWA+gxO8CwzRfvEOmVkCbBRUOcCE9bmPtdd1ICXxIL
56spbDb84+Nui2mumJczuXgEoOAt8tTYpD/zug3h4meQ+UHKlR8wH5xKpX0jiCUI
fvmaXgz7UfrgS0Y1XahTYEZ4khxIbg==
=VJXH
-----END PGP SIGNATURE-----

--ANi90WktkFvP7u1mePm44d4zA0KzeltLR--
