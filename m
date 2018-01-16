Received: from eggs.gnu.org ([2001:4830:134:3::10]:54940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebYk7-0004Rc-J7
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:26:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebYk6-0000p7-Lv
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:26:03 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<44e3c682947299e968706e058ac665fbac5bb719.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <24906dd3-8e52-9260-8488-a510feb3be0d@redhat.com>
Date: Tue, 16 Jan 2018 15:25:51 -0600
MIME-Version: 1.0
In-Reply-To: <44e3c682947299e968706e058ac665fbac5bb719.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1IbQozej5bdvyGbl82U9jTTPPpp8cioLf"
Subject: Re: [Qemu-devel] [PATCH v2 03/32] qcow2: Remove BDS parameter from
 qcow2_cache_get_table_addr()
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
--1IbQozej5bdvyGbl82U9jTTPPpp8cioLf
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <24906dd3-8e52-9260-8488-a510feb3be0d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/32] qcow2: Remove BDS parameter from
 qcow2_cache_get_table_addr()
References: <cover.1513342045.git.berto@igalia.com>
 <44e3c682947299e968706e058ac665fbac5bb719.1513342045.git.berto@igalia.com>
In-Reply-To: <44e3c682947299e968706e058ac665fbac5bb719.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> This function was only using the BlockDriverState parameter to get the
> cache table size (since it was equal to the cluster size). This is no
> longer necessary so this parameter can be removed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cache.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1IbQozej5bdvyGbl82U9jTTPPpp8cioLf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpebd8ACgkQp6FrSiUn
Q2qspAf/dfmNuADYRygdddNNxWrkhCEOPzcjYezuFw01GA2h6P3dWe/NNWjEph4d
F8IA+by+sD1RBpnryHtAPgFjzwdFOsZgJY+DvH2w1fnc/Xkm1tITjlPzvIHGC5FH
ti0SlJjP6LvdnexV/FgOtN0B1HjpLLEDoH5uC1lCt0rRD4QpPYBiSkLMHG39cg1W
0XU2nPOJK2LxqbVgSbztG0Dv7ldeOjLtXGCW33kmglZlP3Zq/Ft45G1CXoFdCaKW
Y5PgR7KbXwE4CYuI6N7HrFQtuDtY65vdwLroz+IrOBXUnOnXUyqTas8tKWYFRXlD
0XIwFYgKmxiM//FQzUVoaeJdZysLsg==
=SnVF
-----END PGP SIGNATURE-----

--1IbQozej5bdvyGbl82U9jTTPPpp8cioLf--
