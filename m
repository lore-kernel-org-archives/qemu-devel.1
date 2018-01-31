Received: from eggs.gnu.org ([2001:4830:134:3::10]:46836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egy15-0001cM-JR
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:25:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egy14-0004FJ-N2
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:25:55 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<344e6913766e24ed55592a84ceb8fad3ee59028b.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f4571263-fb18-1a77-86a7-67eac4e4ed2a@redhat.com>
Date: Wed, 31 Jan 2018 20:25:44 +0100
MIME-Version: 1.0
In-Reply-To: <344e6913766e24ed55592a84ceb8fad3ee59028b.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iFbCjIbHuaV6NvGzQbhZwY9fL05b1onyb"
Subject: Re: [Qemu-devel] [PATCH v3 02/39] qcow2: Add table size field to
 Qcow2Cache
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
--iFbCjIbHuaV6NvGzQbhZwY9fL05b1onyb
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <f4571263-fb18-1a77-86a7-67eac4e4ed2a@redhat.com>
Subject: Re: [PATCH v3 02/39] qcow2: Add table size field to Qcow2Cache
References: <cover.1516978645.git.berto@igalia.com>
 <344e6913766e24ed55592a84ceb8fad3ee59028b.1516978645.git.berto@igalia.com>
In-Reply-To: <344e6913766e24ed55592a84ceb8fad3ee59028b.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> The table size in the qcow2 cache is currently equal to the cluster
> size. This doesn't allow us to use the cache memory efficiently,
> particularly with large cluster sizes, so we need to be able to have
> smaller cache tables that are independent from the cluster size. This
> patch adds a new field to Qcow2Cache that we can use instead of the
> cluster size.
>=20
> The current table size is still being initialized to the cluster size,
> so there are no semantic changes yet, but this patch will allow us to
> prepare the rest of the code and simplify a few function calls.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cache.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--iFbCjIbHuaV6NvGzQbhZwY9fL05b1onyb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyGDkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ASzEH/jPXiTXmBMISIGHiqdZucQ+gnUWu5XXT
7U+CqBay5FvJv3G+fzFMp6qaH1Cr6Ckri6KkEfBmqyynTRbR7h6EUS4qFZePB680
Fqfm9qEszg4YILDvR2gNd/F78Ei38UV19TmdjvzJyC4P2H/g8+Z20CIWUWRJ13P0
8L9KuQPHV3FFePez36GS9dIlh9xfu3h3NoX7NdT/GCqC8RowSDoTILhQxcKwjorG
5Mm3VQlmw9aYnpGScXSTX0qB306XbrQPAWilgp5JS73XsKPdK8zi9zGFk4taWw1w
9KYuynKzekZXjEL7zLgKnaCv72MJ8K2KFy3/l7FLfdrU5cr27gMXHzw=
=drDy
-----END PGP SIGNATURE-----

--iFbCjIbHuaV6NvGzQbhZwY9fL05b1onyb--
