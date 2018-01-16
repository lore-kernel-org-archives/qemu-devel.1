Received: from eggs.gnu.org ([2001:4830:134:3::10]:47971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eba2n-0001rs-OW
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:49:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eba2m-0001Ph-Mq
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:49:25 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<c209a6903edc99329e9f8693851a180e33a80c75.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4e84ef33-8af0-7cf2-2ca9-98015e84a476@redhat.com>
Date: Tue, 16 Jan 2018 16:49:15 -0600
MIME-Version: 1.0
In-Reply-To: <c209a6903edc99329e9f8693851a180e33a80c75.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D1uvOW9yqjyxmpFJJga9WQhi71GzP76Nz"
Subject: Re: [Qemu-devel] [PATCH v2 19/32] qcow2: Update
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D1uvOW9yqjyxmpFJJga9WQhi71GzP76Nz
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <4e84ef33-8af0-7cf2-2ca9-98015e84a476@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 19/32] qcow2: Update
 qcow2_alloc_cluster_link_l2() to support L2 slices
References: <cover.1513342045.git.berto@igalia.com>
 <c209a6903edc99329e9f8693851a180e33a80c75.1513342045.git.berto@igalia.com>
In-Reply-To: <c209a6903edc99329e9f8693851a180e33a80c75.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> There's a loop in this function that iterates over the L2 entries in a
> table, so now we need to assert that it remains within the limits of
> an L2 slice.
>=20
> Apart from that, this function doesn't need any additional changes, so
> this patch simply updates the variable name from l2_table to l2_slice.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--D1uvOW9yqjyxmpFJJga9WQhi71GzP76Nz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpegWsACgkQp6FrSiUn
Q2rm1QgAkSFWhC7asF77u+MR5mhXUUTXj9tnPPKhjvPjLmvqU6xZvxrounaT9ygR
aogfsHvkYQlBACH2ERhS1Y2vuhfb70UQFakbjFucVmOHOe/2Mo0OkXSQEeL1PT0A
Rp52LX9hbusDL9vYW2bJ7orkVoIcSP/LAy2+GqvkUpwQUEiiKDZKxtAe8EOxjjrN
91PgtvrrvPcIVEKf9MJU6uXb7B/XEgoLRm3jraMOgcPeOnd5QSrgAxufW3R1yDRe
NaEmKCchEEYQSLbQWWyMT437Gse7DiTXkUFGU8hW/dd4F6WXKAQzJtRZZc6ZkQVX
oHIp1idUjKVLlkvWkRKmnvaybegQqw==
=A9wn
-----END PGP SIGNATURE-----

--D1uvOW9yqjyxmpFJJga9WQhi71GzP76Nz--
