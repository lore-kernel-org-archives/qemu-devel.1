Received: from eggs.gnu.org ([2001:4830:134:3::10]:41799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKCp-0006nm-5b
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:07:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKCo-0002M4-DQ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:07:31 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<395d808b99997ca8718bba951c5a2eebe6794650.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <376f5dc1-6d47-5f47-713f-487712482cb0@redhat.com>
Date: Thu, 1 Feb 2018 20:07:15 +0100
MIME-Version: 1.0
In-Reply-To: <395d808b99997ca8718bba951c5a2eebe6794650.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vk53xgDlypjIHEneZVxqZ5hAIFqblQPb2"
Subject: Re: [Qemu-devel] [PATCH v3 24/39] qcow2: Update discard_single_l2()
 to support L2 slices
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
--vk53xgDlypjIHEneZVxqZ5hAIFqblQPb2
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <376f5dc1-6d47-5f47-713f-487712482cb0@redhat.com>
Subject: Re: [PATCH v3 24/39] qcow2: Update discard_single_l2() to support L2
 slices
References: <cover.1516978645.git.berto@igalia.com>
 <395d808b99997ca8718bba951c5a2eebe6794650.1516978645.git.berto@igalia.com>
In-Reply-To: <395d808b99997ca8718bba951c5a2eebe6794650.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> discard_single_l2() limits the number of clusters to be discarded to
> the amount that fits inside an L2 table. Since we'll be loading L2
> slices instead of full tables we need to update that limit.

Hmmmm, maybe rename the function to discard_l2_slice() or
discard_in_l2_slice() or discard_all_in_l2_slice() or
discard_single_l2_slice()?

> Apart from that, this function doesn't need any additional changes, so
> this patch simply updates the variable name from l2_table to l2_slice.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cluster.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Anyway:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--vk53xgDlypjIHEneZVxqZ5hAIFqblQPb2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzZWMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AgtIH/0v0FBu9oP/kBouMuEQRrVyh/wcl2q+/
OvEkeoCTTAbUw07sKsChs0kEnB5bJkcrpqiCmELgm1kWR/RRx6JVwnaGoE6kegCX
+xluzE3AOrJS4jPJtUEALqgvHifYxkJXtgEBVfvEvUto7da33U67mkRPYZMK4rqs
79OLAEgNBotmKmJDK4MyFuGJdiQEnSKhSAVOhYGu6kSaiUQPZRdrSTXeGrcTwq5j
VczdwwyvlFOO2OgMZVKoxfqD9bpfZAUmRh6zh4WiP2DIxd7wLmRREatwKpD9hcan
ozQxPpnbj0NTNAss6099VFr3yZMmubV9V7wlr47rrvkYzDHgqVLlyX4=
=qu7N
-----END PGP SIGNATURE-----

--vk53xgDlypjIHEneZVxqZ5hAIFqblQPb2--
