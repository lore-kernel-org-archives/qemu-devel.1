Received: from eggs.gnu.org ([2001:4830:134:3::10]:36862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehJzw-0004AD-64
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehJzv-0001FB-D0
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:54:12 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<2d458349144f49c68b903e77d383c18071e4cdae.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <404747be-25a7-7937-1f6b-f3597200832d@redhat.com>
Date: Thu, 1 Feb 2018 19:54:00 +0100
MIME-Version: 1.0
In-Reply-To: <2d458349144f49c68b903e77d383c18071e4cdae.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jW1qBZb4LNxAbzwbeOHbV4qHr8E4TE3fz"
Subject: Re: [Qemu-devel] [PATCH v3 22/39] qcow2: Update handle_copied() to
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
--jW1qBZb4LNxAbzwbeOHbV4qHr8E4TE3fz
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <404747be-25a7-7937-1f6b-f3597200832d@redhat.com>
Subject: Re: [PATCH v3 22/39] qcow2: Update handle_copied() to support L2
 slices
References: <cover.1516978645.git.berto@igalia.com>
 <2d458349144f49c68b903e77d383c18071e4cdae.1516978645.git.berto@igalia.com>
In-Reply-To: <2d458349144f49c68b903e77d383c18071e4cdae.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> handle_copied() loads an L2 table and limits the number of checked
> clusters to the amount that fits inside that table. Since we'll be
> loading L2 slices instead of full tables we need to update that limit.
>=20
> Apart from that, this function doesn't need any additional changes, so
> this patch simply updates the variable name from l2_table to l2_slice.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cluster.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--jW1qBZb4LNxAbzwbeOHbV4qHr8E4TE3fz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzYkgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AzYoH/iozZg/GJOGT+G7szp/6M+bBh6CyebRR
gTbXpM1iPwLwOSbm0cbgsyLoUbwvAWk7pqkRDY4RhNRisurngb6EK840hqtOhcbc
46/cJZLnHNLflv+Ro7u/MVxcc0YgAbgtNFE2E08gJ6hnZq4hzplG15lyiBnHLPNv
l8H3DwLQPGpxSvMqgnkcJSkACqsxtlcwGM466c3sI6hu4HhtQZTDrSBfJ8A14FpN
gHWybgZHBFArjMLXpyD0C+R6fiyYklm+10F4bUR56YOvRgFW0IeM2wAGOFzMPNu/
h+eROl/aW+ZVx6RaRP5BkNkv6oLoK2yPnGw8FWD0Bz6RCdr9AVil+sQ=
=mUJc
-----END PGP SIGNATURE-----

--jW1qBZb4LNxAbzwbeOHbV4qHr8E4TE3fz--
