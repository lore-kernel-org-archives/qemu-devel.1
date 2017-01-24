Received: from eggs.gnu.org ([2001:4830:134:3::10]:45083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cW8AM-0008WM-3A
	for Qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cW8AJ-0003Gz-2a
	for Qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:58:10 -0500
References: <20161220191523.5779-1-eblake@redhat.com>
	<45d06e45-b8f5-d134-0345-4c493e970bdf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e9184ede-b112-8ab0-2c12-9bbd3b779b8c@redhat.com>
Date: Tue, 24 Jan 2017 14:58:02 -0600
MIME-Version: 1.0
In-Reply-To: <45d06e45-b8f5-d134-0345-4c493e970bdf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QAPRf97U56mKlkKXJfIjbIiK0vVFG3GDa"
Subject: Re: [Qemu-devel] [Qemu-block]  [PATCH v4 0/7] add blkdebug tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QAPRf97U56mKlkKXJfIjbIiK0vVFG3GDa
From: Eric Blake <eblake@redhat.com>
To: qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Qemu-devel@nongnu.org"
 <Qemu-devel@nongnu.org>
Message-ID: <e9184ede-b112-8ab0-2c12-9bbd3b779b8c@redhat.com>
Subject: Re: [Qemu-block] [Qemu-devel] [PATCH v4 0/7] add blkdebug tests
References: <20161220191523.5779-1-eblake@redhat.com>
 <45d06e45-b8f5-d134-0345-4c493e970bdf@redhat.com>
In-Reply-To: <45d06e45-b8f5-d134-0345-4c493e970bdf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ping

On 12/20/2016 01:19 PM, Eric Blake wrote:
> [oops, I forgot cc's on the cover letter, even though the rest of the
> series was properly broadcast]
>=20
> On 12/20/2016 01:15 PM, Eric Blake wrote:
>> Based on Kevin's block-next branch:
>> http://repo.or.cz/qemu/kevin.git/shortlog/refs/heads/block-next
>>
>> Available as a tag at:
>> git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-v4
>>
>> v3 was:
>> https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00278.html
>>
>> Since then:
>> - Address comments from Max and Kevin
>>   - typo cleanups
>>   - no longer force 512-byte alignment
>>   - better naming
>> - Merge two series into one
>>
>> 001/7:[down] 'qcow2: Assert that cluster operations are aligned'
>> 002/7:[down] 'qcow2: Discard/zero clusters by byte count'
>> 003/7:[----] [--] 'blkdebug: Sanity check block layer guarantees'
>> 004/7:[0015] [FC] 'blkdebug: Add pass-through write_zero and discard s=
upport'
>> 005/7:[0002] [FC] 'blkdebug: Simplify override logic'
>> 006/7:[0046] [FC] 'blkdebug: Add ability to override unmap geometries'=

>> 007/7:[0015] [FC] 'tests: Add coverage for recent block geometry fixes=
'
>>
>> Eric Blake (7):
>>   qcow2: Assert that cluster operations are aligned
>>   qcow2: Discard/zero clusters by byte count
>>   blkdebug: Sanity check block layer guarantees
>>   blkdebug: Add pass-through write_zero and discard support
>>   blkdebug: Simplify override logic
>>   blkdebug: Add ability to override unmap geometries
>>   tests: Add coverage for recent block geometry fixes
>>
>>  qapi/block-core.json       |  24 +++++-
>>  block/qcow2.h              |   9 +-
>>  block/blkdebug.c           | 204 ++++++++++++++++++++++++++++++++++++=
+++++++--
>>  block/qcow2-cluster.c      |  29 ++++---
>>  block/qcow2-snapshot.c     |   7 +-
>>  block/qcow2.c              |  21 ++---
>>  tests/qemu-iotests/173     | 114 +++++++++++++++++++++++++
>>  tests/qemu-iotests/173.out |  49 +++++++++++
>>  tests/qemu-iotests/group   |   1 +
>>  9 files changed, 413 insertions(+), 45 deletions(-)
>>  create mode 100755 tests/qemu-iotests/173
>>  create mode 100644 tests/qemu-iotests/173.out
>>
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--QAPRf97U56mKlkKXJfIjbIiK0vVFG3GDa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYh7/aAAoJEKeha0olJ0NqHdgH/RkOXfD205IwW/ItC19gF7jY
tZDnwJmwRunYGzSFu3zinpl8e9W/06oXDYN0lfgDn6/gOlyqoVgA/Jh+5Opei+Yd
rkZyYDe8ZBOYC9bmAE8ySanFGVgAY2nW0Ty15qo8i0bUWjgCvHqghq3RJL8oEXFY
mBl9AacB/jgFuvplnVptfTczID/MrtwVcnjSzAEL1t3Gd6JdUAK3bkBJ5S9SabkE
VywGq7aF2SERExG9Vc8MtsCOdcPpd3b5aPDFbp1KdQ3NI5ndgtr1obbdf1mFLT5s
2hlBD8ZlidV4UadhJcG/Ioy4UrM0aNJnpZ7JdXA1ZbFN88akWTAzd39irCAkTPc=
=amez
-----END PGP SIGNATURE-----

--QAPRf97U56mKlkKXJfIjbIiK0vVFG3GDa--
