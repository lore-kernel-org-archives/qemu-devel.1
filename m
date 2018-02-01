Received: from eggs.gnu.org ([2001:4830:134:3::10]:33885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehJrf-00008x-JW
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:45:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehJre-0000dv-OJ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:45:39 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<6799e51bdf50179b3632adf20c768cf22c260e8c.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <df7822e9-025c-75b0-6139-e958dab0e745@redhat.com>
Date: Thu, 1 Feb 2018 19:44:56 +0100
MIME-Version: 1.0
In-Reply-To: <6799e51bdf50179b3632adf20c768cf22c260e8c.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mmPp4wKRfkvZ51ob23bbX4xzmkmAS8dkl"
Subject: Re: [Qemu-devel] [PATCH v3 21/39] qcow2: Update
 qcow2_alloc_cluster_link_l2() to support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mmPp4wKRfkvZ51ob23bbX4xzmkmAS8dkl
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <df7822e9-025c-75b0-6139-e958dab0e745@redhat.com>
Subject: Re: [PATCH v3 21/39] qcow2: Update qcow2_alloc_cluster_link_l2() to
 support L2 slices
References: <cover.1516978645.git.berto@igalia.com>
 <6799e51bdf50179b3632adf20c768cf22c260e8c.1516978645.git.berto@igalia.com>
In-Reply-To: <6799e51bdf50179b3632adf20c768cf22c260e8c.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> There's a loop in this function that iterates over the L2 entries in a
> table, so now we need to assert that it remains within the limits of
> an L2 slice.
>=20
> Apart from that, this function doesn't need any additional changes, so
> this patch simply updates the variable name from l2_table to l2_slice.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cluster.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Hm, well, strictly speaking this patch should not be at this point in
this series -- e.g. handle_alloc() so far only limits its nb_clusters to
the L2 size, not the L2 slice size.

But that's nit picking because the slice size equals the L2 size anyway
(for now), so

Reviewed-by: Max Reitz <mreitz@redhat.com>


--mmPp4wKRfkvZ51ob23bbX4xzmkmAS8dkl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzYCgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AP4MH+wWMsNTjOKZj2EeAKxV8vhK3f+E404mQ
tU/I0hBogiC7VNnsSEqD3XY/bBkEjbMMQGA/D8j8AGn1QWBQ2mv6TETndThiZ1GJ
+ywQrUlAbPo+SrSJfR4OVa7LogWyaZ0dnCvVf8y5vHHhnFQTamQGMO05EOJCBUmP
dq5hBG7nJ1mcgSplJMidJUJc9mrBgPxBasH2gnI02N1mN/WO4dUSBTR34vi/9rB5
QdRRnjaBXLRbwn60bc5CSj+z3mbikKW3+swCU7pQDWq6HsGyVzY7APcjj/NAcvN9
rPipASTe/IP7He2bksHqpLOwqyvG+7ehEGxMfYVDsMRj31i/ti5PO78=
=yJe8
-----END PGP SIGNATURE-----

--mmPp4wKRfkvZ51ob23bbX4xzmkmAS8dkl--
