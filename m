Received: from eggs.gnu.org ([2001:4830:134:3::10]:38124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehK2f-0006ce-Gv
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:57:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehK2e-0000up-Oa
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:57:01 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<5d8899a6633484768bc66823d9cb30823620fda4.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <568d7c93-e3a4-4eca-ef4b-804463823041@redhat.com>
Date: Thu, 1 Feb 2018 19:56:48 +0100
MIME-Version: 1.0
In-Reply-To: <5d8899a6633484768bc66823d9cb30823620fda4.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6frEqqn0BbaL9aKi9P2fDrJrAhd6aBr3e"
Subject: Re: [Qemu-devel] [PATCH v3 23/39] qcow2: Update handle_alloc() to
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
--6frEqqn0BbaL9aKi9P2fDrJrAhd6aBr3e
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <568d7c93-e3a4-4eca-ef4b-804463823041@redhat.com>
Subject: Re: [PATCH v3 23/39] qcow2: Update handle_alloc() to support L2
 slices
References: <cover.1516978645.git.berto@igalia.com>
 <5d8899a6633484768bc66823d9cb30823620fda4.1516978645.git.berto@igalia.com>
In-Reply-To: <5d8899a6633484768bc66823d9cb30823620fda4.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> handle_alloc() loads an L2 table and limits the number of checked
> clusters to the amount that fits inside that table. Since we'll be
> loading L2 slices instead of full tables we need to update that limit.
>=20
> Apart from that, this function doesn't need any additional changes, so
> this patch simply updates the variable name from l2_table to l2_slice.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cluster.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--6frEqqn0BbaL9aKi9P2fDrJrAhd6aBr3e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzYvESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ApGkIAJVcgpLWaC61sxwHVYKFBsaF/+rYQFng
EY2POhf1QP12fqOvoLNXTZQjD01Orws7ua+ZottB6Z1qbRD9Xun6KOVkpDTfk0YQ
zyMsWzBNtb31H5ka+wPDbZSdiHR4XHBU1DBMKgSK2TvEX///AO94LGZT/Um7S07P
m+r2SMOBq3qg9fVmYLMrIVRQd4uCZ8boF7yY7RHe15ghfYOE+6iBzLHc3/isdFAO
SVkryLlg5RBZLUoQ+PF227Wn00XyUlImwyhJ/Eq9raQ9tWsCS1a2R8SZtuJ3uMsK
Xcp2thATyUgAbZv5O21hpeb3/U9uEay5AC+K7IvwqrtiaQhy6bdUEcE=
=hqn5
-----END PGP SIGNATURE-----

--6frEqqn0BbaL9aKi9P2fDrJrAhd6aBr3e--
