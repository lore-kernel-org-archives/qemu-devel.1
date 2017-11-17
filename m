Received: from eggs.gnu.org ([2001:4830:134:3::10]:59692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFlna-0003FM-Au
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:55:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFlnZ-0000H7-C3
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:55:34 -0500
References: <20171117164747.11525-1-eblake@redhat.com>
	<9279377e-9165-d6b9-930f-7949c2c1fb72@redhat.com>
	<dbb84db4-ead4-e8cf-25c4-fba4dd8701c4@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b9dd49c3-6272-d709-0c1c-e915cbabbf30@redhat.com>
Date: Fri, 17 Nov 2017 12:55:25 -0600
MIME-Version: 1.0
In-Reply-To: <dbb84db4-ead4-e8cf-25c4-fba4dd8701c4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="78edtggCNEcahD8dj4iAKf9tRiHcFJbM3"
Subject: Re: [Qemu-devel] [PATCH for-2.11] qcow2: fix image corruption on
 commit with persistent snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--78edtggCNEcahD8dj4iAKf9tRiHcFJbM3
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org
Message-ID: <b9dd49c3-6272-d709-0c1c-e915cbabbf30@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] qcow2: fix image corruption on
 commit with persistent snapshot
References: <20171117164747.11525-1-eblake@redhat.com>
 <9279377e-9165-d6b9-930f-7949c2c1fb72@redhat.com>
 <dbb84db4-ead4-e8cf-25c4-fba4dd8701c4@redhat.com>
In-Reply-To: <dbb84db4-ead4-e8cf-25c4-fba4dd8701c4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/17/2017 12:46 PM, Eric Blake wrote:

>>
>> The test fails with -m32 and probably also on Big Endian architectures=
,
>> because the bitmap hash differs.
>=20
> Oh my.  Thanks for the rapid testing.
>=20
>> We could "fix" this by replacing the 2100 by a 2102, so for both bit
>> widths rounding is the same.

Actually, thinking about it more, are we sure that a .qcow2 image
created on an -m32 host can be properly loaded on a 64-bit host, despite
their different rounded-up sizes for the bitmaps?  If the difference in
hash is due only to the in-memory representation, but the on-disk layout
is identical, then we are safe; but if the difference in hash is visible
on-disk, then we have a real bug in our qcow2 specification or
implementation of persistent bitmaps.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--78edtggCNEcahD8dj4iAKf9tRiHcFJbM3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloPMJ0ACgkQp6FrSiUn
Q2pgLwgAgaCvuJRYk7Z5F4RV4cgA34U7q/JfckAsR8a+5+NU18V3XWz6Bt3hMJnz
hEOfdTZy4GFVlYZDSr5qvHEtglQIMa71jtMH5MuBkJauSz+QuVq3wegKSOJ0aSHI
9gb277J+kQXZlN0dCMwtCBCESWDixoUyRtT2ygwCfswrVv3gCHzYmAo63TKi5yBH
1VBZC9E4P41s10dvsgZCdtxAdUC2N9pnK8N6tn5N3huIEIYNxOjs79/H8dlQCxsT
6+7+t1Rq1ocqeMzFAu8onuiLEnKH0lHxEKWIpXHrq1CfbbQQm3FukutnUZKWVI4C
N6iYAkrq8TQdesNs217FYVzMRIT6zg==
=6bKx
-----END PGP SIGNATURE-----

--78edtggCNEcahD8dj4iAKf9tRiHcFJbM3--
