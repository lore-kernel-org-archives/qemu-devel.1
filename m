Received: from eggs.gnu.org ([2001:4830:134:3::10]:46648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIxeO-0001TV-AR
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIxeN-0005DQ-B6
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:39:00 -0400
References: <cover.1496844254.git.berto@igalia.com>
	<2ddc2703be89a250994478c92ca7695b4b88791b.1496844254.git.berto@igalia.com>
	<5be69f00-7630-bdb1-70a8-02a078798f15@redhat.com>
	<w51efuuochp.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f8f971f7-aecf-a5d4-9550-742bc5e5d055@redhat.com>
Date: Thu, 8 Jun 2017 08:38:48 -0500
MIME-Version: 1.0
In-Reply-To: <w51efuuochp.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QP1G2M9M1kgqFS4iXqKw6n9IBaIs7l3o8"
Subject: Re: [Qemu-devel] [PATCH v2 2/7] qcow2: Use unsigned int for both
 members of Qcow2COWRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QP1G2M9M1kgqFS4iXqKw6n9IBaIs7l3o8
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <f8f971f7-aecf-a5d4-9550-742bc5e5d055@redhat.com>
Subject: Re: [PATCH v2 2/7] qcow2: Use unsigned int for both members of
 Qcow2COWRegion
References: <cover.1496844254.git.berto@igalia.com>
 <2ddc2703be89a250994478c92ca7695b4b88791b.1496844254.git.berto@igalia.com>
 <5be69f00-7630-bdb1-70a8-02a078798f15@redhat.com>
 <w51efuuochp.fsf@maestria.local.igalia.com>
In-Reply-To: <w51efuuochp.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/08/2017 08:06 AM, Alberto Garcia wrote:
> On Wed 07 Jun 2017 06:02:06 PM CEST, Eric Blake wrote:
>=20
>>> - The offset of the COW region from the start of the first cluster
>>>   touched by the I/O request. Since it's always going to be positive
>>>   and the maximum request size is at most INT_MAX, we can use a
>>>   regular unsigned int to store this offset.
>>
>> I don't know if we will ever get to the point that we allow a 64-bit
>> request at the block layer (and then the block layer guarantees it is
>> split down to the driver's limits, which works when a driver is still
>> bound by 32-bit limits).  But we ALSO know that a cluster is at most
>> 2M (in our current implementation of qcow2), so the offset of where
>> the COW region starts in relation to the start of a cluster is < 2M.
>=20
> That's correct for the offset of the first region (m->cow_start),
> however m->cow_end is also relative to the offset of the first allocate=
d
> cluster, so it can be > 2M if the requests spans several clusters.
>=20
> So I guess the maximum theoretical offset would be something like
> INT_MAX + 2*cluster_size (a bit below that actually).

At which point, your earlier claim that we bound requests at INT_MAX
takes over.  But thanks for correcting me that the end cow region can
indeed be more than a cluster away from the beginning region.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QP1G2M9M1kgqFS4iXqKw6n9IBaIs7l3o8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOVNpAAoJEKeha0olJ0Nq0IEH/0e3dj0cNAZugII3tfe4ZoIe
xyXGf4RgcQEq83CQX9sGsgahR9BHF80fRaXU9p/eOH4L5xlbDe7lOS1kx3qf2Unt
zagoTx+r5+6bIiqVZ+80qp6ztg3pVddpQ+aWutsk8Dllf2lWWUVHtxlUcZBKcs3r
zJizqMGi4h6q6QWGoW4/Kt+JNx/4ak3ehEKci5U1SicKZV48AJ7AAFCiHDunQMFt
r5px7d2gpbqL8JHseBNUr0QBQdScQLYCKF/xucN4homLEBidUvSm2MPsNyCr7TB4
zRyAirlLEMSjLMK9BSWbUruC9QTqkIVlDM6Eug5ujEWulx1fV4ykxwKW2a6CPOo=
=ak2X
-----END PGP SIGNATURE-----

--QP1G2M9M1kgqFS4iXqKw6n9IBaIs7l3o8--
