Received: from eggs.gnu.org ([2001:4830:134:3::10]:49255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTGP4-0001ZH-2b
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:09:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTGP3-0003F1-4C
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:09:30 -0500
References: <20170111181432.18868-1-mreitz@redhat.com>
	<20170116204921.31578-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cde665c6-4ad7-81b8-3d9e-a38145862bd3@redhat.com>
Date: Mon, 16 Jan 2017 17:09:22 -0600
MIME-Version: 1.0
In-Reply-To: <20170116204921.31578-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5akNrQbJPULGqKTgxsi2fuNkj53pU3MqN"
Subject: Re: [Qemu-devel] [PATCH v4 11/25] blkverify: Make bdrv_dirname()
 return NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5akNrQbJPULGqKTgxsi2fuNkj53pU3MqN
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <cde665c6-4ad7-81b8-3d9e-a38145862bd3@redhat.com>
Subject: Re: [PATCH v4 11/25] blkverify: Make bdrv_dirname() return NULL
References: <20170111181432.18868-1-mreitz@redhat.com>
 <20170116204921.31578-4-mreitz@redhat.com>
In-Reply-To: <20170116204921.31578-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2017 02:49 PM, Max Reitz wrote:
> blkverify's BDSs have a file BDS, but we do not want this to be
> preferred over the raw node. There is no way to decide between the two
> (and not really a reason to, either), so just return NULL in blkverify'=
s
> implementation of bdrv_dirname().
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/blkverify.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--5akNrQbJPULGqKTgxsi2fuNkj53pU3MqN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYfVKiAAoJEKeha0olJ0NqkxwH/2lOP6+l1h6Imb8Ihw3xXB7z
D+rBQHscDEaVpGNS23fYIMb+qAaFlPc2YwRtOjfmzhl7QzqJSpFt0FPQuG5c4k6U
oDYwSZHDFrpKt8/PMcNUgvHM9iaKN6le9TEXdsQpOYQqE6p+U5jFpvnipf6jX5yu
5xtEeExINDdzhsrvaFxsCgyq8XIhsot/iceCYxz64MgsmLPTw6pfWVrUgoLE+j7W
UDfcfXdkkUWZI3QLbOAJA3rHkYKafQBsoK61f5kwJfXesJMaUShkARz6MSLhHb/r
lrwzzSb1/0THFWHvIVmokg3MBnBawj9FwYQ0c6Siz+nbogRbmwCD30ZJmzN8SCU=
=ijqG
-----END PGP SIGNATURE-----

--5akNrQbJPULGqKTgxsi2fuNkj53pU3MqN--
