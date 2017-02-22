Received: from eggs.gnu.org ([2001:4830:134:3::10]:38798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cggcc-0001dV-9l
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 18:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cggcb-0002Af-9U
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 18:46:58 -0500
References: <20170221115512.21918-1-berrange@redhat.com>
	<20170221115512.21918-8-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <18af21b2-42ed-e037-ab30-a88302d5e0e8@redhat.com>
Date: Wed, 22 Feb 2017 17:46:48 -0600
MIME-Version: 1.0
In-Reply-To: <20170221115512.21918-8-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lH6qdxlvmSj51coGGgti5xtUSsKFBt6u7"
Subject: Re: [Qemu-devel] [PATCH v5 07/18] iotests: fix 097 when run with
 qcow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lH6qdxlvmSj51coGGgti5xtUSsKFBt6u7
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <18af21b2-42ed-e037-ab30-a88302d5e0e8@redhat.com>
Subject: Re: [PATCH v5 07/18] iotests: fix 097 when run with qcow
References: <20170221115512.21918-1-berrange@redhat.com>
 <20170221115512.21918-8-berrange@redhat.com>
In-Reply-To: <20170221115512.21918-8-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 05:55 AM, Daniel P. Berrange wrote:
> The previous commit:
>=20
>   commit a3e1505daec31ef56f0489f8c8fff1b8e4ca92bd
>   Author: Eric Blake <eblake@redhat.com>
>   Date:   Mon Dec 5 09:49:34 2016 -0600
>=20
>     qcow2: Don't strand clusters near 2G intervals during commit
>=20
> extended the 097 test case so that it did two passes, once
> with an internal snapshot, once without.
>=20
> qcow (v1) does not support internal snapshots, so this change
> broke test 097 when run against qcow.
>=20
> This splits 097 in two, creating a new 173 that tests the
> internal snapshot codepath, effectively putting 097 back
> to its content before the above commit.
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/qemu-iotests/097     |  10 +---
>  tests/qemu-iotests/097.out | 125 ++-----------------------------------=
-------
>  tests/qemu-iotests/175     | 126 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/175.out | 119 +++++++++++++++++++++++++++++++++++++=
+++++
>  tests/qemu-iotests/group   |   1 +
>  5 files changed, 251 insertions(+), 130 deletions(-)
>  create mode 100755 tests/qemu-iotests/175
>  create mode 100644 tests/qemu-iotests/175.out

Reviewed-by: Eric Blake <eblake@redhat.com>

> +++ b/tests/qemu-iotests/group
> @@ -167,3 +167,4 @@
>  172 auto
>  173 rw auto
>  174 auto
> +175 rw auto backing

I used 175 in v5 of my blkdebug series, but Kevin had comments that are
worth me respinning, so I'm rebasing mine to use 176.
https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg03049.html

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--lH6qdxlvmSj51coGGgti5xtUSsKFBt6u7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYriLoAAoJEKeha0olJ0NqTU8H/Atq0Vdj4Jj3pChIh4QBnY+h
VE15QaKCPLrAQncr77zBd02X4AhicNuDmeODLmvn7TczH4ItbbR8aAvLRjlE3mnY
8en+5CxH2ieharNDSmy3kfRYwzso4Yk+RVmfqxS8MONyuxPGOBE0NAzP/PVPxvLl
K2I/JDI+qosqy86kq+BHhBzVIzGGLKiXkDmkpxib2fJ3uw+0XD5Q64U65FZE91pb
HDxbDkYegz4BCh/UerycmuC2myiXDrx3+xqr4P1ghDN9q3n+9tMDSDnDtqFVlaUq
PmyO3yjM6AYC1NRBik2N/lFCm10vUlil5DQZfEY2WLlWpFAz8N9MchL2LjXQJ60=
=9SXX
-----END PGP SIGNATURE-----

--lH6qdxlvmSj51coGGgti5xtUSsKFBt6u7--
