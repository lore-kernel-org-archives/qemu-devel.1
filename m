Received: from eggs.gnu.org ([2001:4830:134:3::10]:41484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef710-0006nD-Be
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef70z-0002Ox-G4
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:38:10 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<5e98f636670e1741b9bafae624efb0052d9d0b71.1516978645.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eb3ea998-c9c9-d231-0f9e-dfb307c05558@redhat.com>
Date: Fri, 26 Jan 2018 10:37:59 -0600
MIME-Version: 1.0
In-Reply-To: <5e98f636670e1741b9bafae624efb0052d9d0b71.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3QkVc67I6RN0wVzqkg1NoBtN0RvVVaOY6"
Subject: Re: [Qemu-devel] [PATCH v3 18/39] qcow2: Refactor
 get_cluster_table()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3QkVc67I6RN0wVzqkg1NoBtN0RvVVaOY6
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <eb3ea998-c9c9-d231-0f9e-dfb307c05558@redhat.com>
Subject: Re: [PATCH v3 18/39] qcow2: Refactor get_cluster_table()
References: <cover.1516978645.git.berto@igalia.com>
 <5e98f636670e1741b9bafae624efb0052d9d0b71.1516978645.git.berto@igalia.com>
In-Reply-To: <5e98f636670e1741b9bafae624efb0052d9d0b71.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2018 08:59 AM, Alberto Garcia wrote:
> After the previous patch we're now always using l2_load() in
> get_cluster_table() regardless of whether a new L2 table has to be
> allocated or not.
>=20
> This patch refactors that part of the code to use one single l2_load()
> call.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3QkVc67I6RN0wVzqkg1NoBtN0RvVVaOY6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlprWWcACgkQp6FrSiUn
Q2pRFAgAlmkWqxukHdh5ydXIP2nDXpA11+nncMMxc9czyfOAzoOEL8aGJwbSIXLy
gCrb/PlscoFUlTZSmw4DZqEDdQoZ6WPlhb5jECUsjWa1JBSG3j0uAxfRi8l7ODsC
ZHY0rEWzwlKg6SyUcBNuKqUHp1DcICH+VAsrWTxqelgUEq6/X7c8Zrq0oAg5HfZH
iQ3IgFYbh24uSkUgmRnk/3YoQXj09fUVWz1E8dj3xmSGGWDWIZaQ7DF02KTCEAs0
8xNiEPYGfaG1rVEZswhVwCLxOMAKQ8Vis1relO1Lo9jTQmRrmTRruGdmSUm2OljK
Fdks0ZQfw6aNMOlQhHXnP9MKohusdw==
=7ieV
-----END PGP SIGNATURE-----

--3QkVc67I6RN0wVzqkg1NoBtN0RvVVaOY6--
