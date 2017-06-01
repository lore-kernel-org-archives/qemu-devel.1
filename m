Received: from eggs.gnu.org ([2001:4830:134:3::10]:50992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGWAx-0002Ur-Ag
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGWAu-0005Ll-9x
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:54:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGWAu-0005L6-1Z
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:54:28 -0400
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496330073-51338-3-git-send-email-anton.nefedov@virtuozzo.com>
	<e21f44ea-a5ec-fb51-699a-b6eb06cc11b2@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4a281f99-0a86-e965-3790-2424cf3c277c@redhat.com>
Date: Thu, 1 Jun 2017 14:54:25 -0500
MIME-Version: 1.0
In-Reply-To: <e21f44ea-a5ec-fb51-699a-b6eb06cc11b2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Sdmx6U4SqTjOhFIwMlwk3PVvT9SBg0R9H"
Subject: Re: [Qemu-devel] [PATCH v2 02/15] file-posix: support
 BDRV_REQ_ALLOCATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Sdmx6U4SqTjOhFIwMlwk3PVvT9SBg0R9H
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, mreitz@redhat.com
Message-ID: <4a281f99-0a86-e965-3790-2424cf3c277c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/15] file-posix: support
 BDRV_REQ_ALLOCATE
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1496330073-51338-3-git-send-email-anton.nefedov@virtuozzo.com>
 <e21f44ea-a5ec-fb51-699a-b6eb06cc11b2@redhat.com>
In-Reply-To: <e21f44ea-a5ec-fb51-699a-b6eb06cc11b2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 02:49 PM, Eric Blake wrote:
> On 06/01/2017 10:14 AM, Anton Nefedov wrote:
>> Current write_zeroes implementation is good enough to satisfy this fla=
g too
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>  block/file-posix.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> Are we sure that fallocate() is always fast, or are there some file
> systems where it is no faster than manually writing zeroes?  I'm worrie=
d
> that blindly claiming BDRV_REQ_ALLOCATE may fail if we encounter a libc=


not so much fail as in "break the guest", but fail as in "take far more
time than we were expecting, pessimising our behavior to worse than if
we had not tried the allocation at all"

> or kernel-based fallback that takes a slow patch on our behalf.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Sdmx6U4SqTjOhFIwMlwk3PVvT9SBg0R9H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMHDxAAoJEKeha0olJ0NqgqEH/Rn++GgxJlNq3hSzr4fY6eAA
dP8J5sjPJgNqfFSEepmiC6W/Tlb/F7Gc3VXOXJzjVk3Tw++ZEWgXbo+6biYH7erP
GHnndsr9uh79iakXc1sMxFkJbltMxOlcZBWRN7mjKEamwzBmD04wVqKPgEerHwAB
b4Yvbq/i6SIQAhK4RvUCXQeiNgTgghqA2e80bVp238JEjHKk9fl0S5eTXmleY6yK
8xDVyfZSAIZXEKsnbnOv3fqTvBAjlkC96HYYyWERz+0kbwfQRVsIPZzPy8bpLzlH
HEEbTgxkScjOu7thzcRAyUUcQJxERLSE9vlCDYh/Xgz1iQ9FAagqM+HbqpOwtY4=
=+l5z
-----END PGP SIGNATURE-----

--Sdmx6U4SqTjOhFIwMlwk3PVvT9SBg0R9H--
