Received: from eggs.gnu.org ([2001:4830:134:3::10]:42268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKDx-0007iQ-SZ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKDx-0003hd-0h
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:08:41 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<32d91890c42f980c6d2e494a28bc7c66a84f1469.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f30a38e0-821e-843a-d3ea-2efc3747126b@redhat.com>
Date: Thu, 1 Feb 2018 20:08:29 +0100
MIME-Version: 1.0
In-Reply-To: <32d91890c42f980c6d2e494a28bc7c66a84f1469.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WNyyuJ3E5tLHU3e6dkWJPgFqfxeWSisOj"
Subject: Re: [Qemu-devel] [PATCH v3 25/39] qcow2: Update zero_single_l2() to
 support L2 slices
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
--WNyyuJ3E5tLHU3e6dkWJPgFqfxeWSisOj
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <f30a38e0-821e-843a-d3ea-2efc3747126b@redhat.com>
Subject: Re: [PATCH v3 25/39] qcow2: Update zero_single_l2() to support L2
 slices
References: <cover.1516978645.git.berto@igalia.com>
 <32d91890c42f980c6d2e494a28bc7c66a84f1469.1516978645.git.berto@igalia.com>
In-Reply-To: <32d91890c42f980c6d2e494a28bc7c66a84f1469.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> zero_single_l2() limits the number of clusters to be zeroed to the
> amount that fits inside an L2 table. Since we'll be loading L2 slices
> instead of full tables we need to update that limit.

Same as last patch, maybe we should rename the function now.

> Apart from that, this function doesn't need any additional changes, so
> this patch simply updates the variable name from l2_table to l2_slice.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cluster.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Also again:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--WNyyuJ3E5tLHU3e6dkWJPgFqfxeWSisOj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzZa0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AazoIAIGR2ZfZicBsrLs4TTrmJ2mANiybHpV/
SNCiFq6eZHGxDpZ7QN2NDhOwQwfNA/8YFqrlhJSVFRGQXuzXfXtVUWjp5xOf0z8a
xSPJbhvTww9lkVvmo9xvVomHOv/JQLaHe82VwayYHakbd8zH1+B4Xn5BpZ6xejum
LrNYN7rUnYa3a+Qwq9+xoqTn2/ZfkTI7EWy4mq4x4kKUoPyImK3JayqtBuF5mzGq
HeG3hK3PGLlXZXcUyoHBVuYokdVxtsSU94fHo5PeUNis+zDZyCDswKwwBZ0LJmMC
8AX0A7yWQU2owgbWO4suSyfX3TRvUM1O7HvP7ofKkP0Dhqq1fLWO2Vc=
=Z1VM
-----END PGP SIGNATURE-----

--WNyyuJ3E5tLHU3e6dkWJPgFqfxeWSisOj--
