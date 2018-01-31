Received: from eggs.gnu.org ([2001:4830:134:3::10]:51485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyI2-0004oK-PN
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:43:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyI1-0000Vo-Nt
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:43:26 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<d3c1ce653a6e8ba3bbbf2419109add9254dfe51b.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5866e58c-de7b-b2d2-6deb-6d50490d04f4@redhat.com>
Date: Wed, 31 Jan 2018 20:43:04 +0100
MIME-Version: 1.0
In-Reply-To: <d3c1ce653a6e8ba3bbbf2419109add9254dfe51b.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="M5xNGxUlWHTjCimdIa4b0fpWjCeQmeap4"
Subject: Re: [Qemu-devel] [PATCH v3 12/39] qcow2: Add offset_to_l1_index()
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
--M5xNGxUlWHTjCimdIa4b0fpWjCeQmeap4
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <5866e58c-de7b-b2d2-6deb-6d50490d04f4@redhat.com>
Subject: Re: [PATCH v3 12/39] qcow2: Add offset_to_l1_index()
References: <cover.1516978645.git.berto@igalia.com>
 <d3c1ce653a6e8ba3bbbf2419109add9254dfe51b.1516978645.git.berto@igalia.com>
In-Reply-To: <d3c1ce653a6e8ba3bbbf2419109add9254dfe51b.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> Similar to offset_to_l2_index(), this function returns the index in
> the L1 table for a given guest offset. This is only used in a couple
> of places and it's not a particularly complex calculation, but it
> makes the code a bit more readable.
>=20
> Although in the qcow2_get_cluster_offset() case the old code was
> taking advantage of the l1_bits variable, we're going to get rid of
> the other uses of l1_bits in a later patch anyway, so it doesn't make
> sense to keep it just for this.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cluster.c | 4 ++--
>  block/qcow2.h         | 5 +++++
>  2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--M5xNGxUlWHTjCimdIa4b0fpWjCeQmeap4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyHEgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A7d4H/jtULMobso52P3Xacuqu6gx+xoIReG6y
N9R0+zJy4SXl9H6hrwntcSbiexiYnVD2QrayEz5QJ5n44L1uWe81ENzVIDgWSDYs
bXiR5vX1h7PvXZ0oDtlCOct4/3cELHOQCQ65bds1ZstGq2a+H0M4wC5tj9ARZ1KV
MCCtI95bn46AbYwTZEr3OwvPPVVvdfjKNpmTiAkZjW6LxeOgqsN38zqlJmW1tezz
i8ByYcDXZSSGiXxcbAVpaWFLKyPDayk/V7w4xoPimgW08scGX/1Aga3wSOHX/KRC
bjwUtjNMEhNyMW6iXyk6hi5jbOGZuF7YD5+tC3pJpacUzwyAn3KzbtA=
=RyWP
-----END PGP SIGNATURE-----

--M5xNGxUlWHTjCimdIa4b0fpWjCeQmeap4--
