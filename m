Received: from eggs.gnu.org ([2001:4830:134:3::10]:39386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCuiD-00049T-EX
	for qemu-devel@nongnu.org; Mon, 22 May 2017 17:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCuiC-0002Ks-E8
	for qemu-devel@nongnu.org; Mon, 22 May 2017 17:17:57 -0400
References: <20170522211205.14265-1-hpoussin@reactos.org>
	<20170522211205.14265-2-hpoussin@reactos.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9bb39017-e160-4777-de7d-a0658d3a9fac@redhat.com>
Date: Mon, 22 May 2017 16:17:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170522211205.14265-2-hpoussin@reactos.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gGukIB5rNGrwJLa1gHH2FKhNiWvQ8StJF"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 01/13] vvfat: fix qemu-img
 map and qemu-img convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gGukIB5rNGrwJLa1gHH2FKhNiWvQ8StJF
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Message-ID: <9bb39017-e160-4777-de7d-a0658d3a9fac@redhat.com>
Subject: Re: [Qemu-block] [PATCH v2 01/13] vvfat: fix qemu-img map and
 qemu-img convert
References: <20170522211205.14265-1-hpoussin@reactos.org>
 <20170522211205.14265-2-hpoussin@reactos.org>
In-Reply-To: <20170522211205.14265-2-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/22/2017 04:11 PM, Herv=C3=A9 Poussineau wrote:
> - bs->total_sectors is the number of sectors of the whole disk
> - s->sector_count is the number of sectors of the FAT partition
>=20
> This fixes the following assert in qemu-img map:
> qemu-img.c:2641: get_block_status: Assertion `nb_sectors' failed.
>=20
> This also fixes an infinite loop in qemu-img convert.
>=20
> Fixes: 4480e0f924a42e1db8b8cfcac4d0634dd1bb27a0
> Fixes: https://bugs.launchpad.net/qemu/+bug/1599539
> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> ---
>  block/vvfat.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

I gave Reviewed-by: on version 1, and suggested that this be cc'd to
qemu-stable:
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03622.html

It helps to add that into the commit message for v2, to make it clear
that you haven't changed anything in this commit since that review.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gGukIB5rNGrwJLa1gHH2FKhNiWvQ8StJF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZI1V8AAoJEKeha0olJ0NqW3oH/Rm9OQFJJy/1WpD4CGO9P+G2
fpBgoS3dixTXK737SYxeBq5/E669S7IKfKxMRO0E/0CN9sjVIL5BQF2BHrKnK8ch
UlaXchdfhweOdXYnTUGn7n1RRB5+x//TL7mkKzRV1Z2/wxApFeWMAShLwdqhkc/W
WyTobEm2KASvZsZ+eTF9EbeP9zaxJYDYSDiUHaQWFrI6Fk7EoO1J8CiL5HB1DAUn
KPgudpC8bcaluOvWl9oUZwYt8x7SUXSazf5GJWkCbyT3ls5bINHRpeM7ukLRbG62
MXP/iLZnqEe5ZkQYcY5P4j952Augk771lMAiO6dysynu3ckaIh5ENNck819RPoA=
=/u10
-----END PGP SIGNATURE-----

--gGukIB5rNGrwJLa1gHH2FKhNiWvQ8StJF--
