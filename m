Received: from eggs.gnu.org ([2001:4830:134:3::10]:42447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6kiA-0003dz-OE
	for qemu-devel@nongnu.org; Fri, 05 May 2017 17:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6ki9-0007uD-Uy
	for qemu-devel@nongnu.org; Fri, 05 May 2017 17:24:26 -0400
References: <20170504030755.1001-1-eblake@redhat.com>
	<20170504030755.1001-8-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6510e826-c39f-8910-ab67-a45b031efd20@redhat.com>
Date: Fri, 5 May 2017 23:24:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170504030755.1001-8-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DKM162gD71kBrEpcN6k4RpNUQugCIJSi9"
Subject: Re: [Qemu-devel] [PATCH v12 07/10] iotests: Add test 179 to cover
 write zeroes with unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DKM162gD71kBrEpcN6k4RpNUQugCIJSi9
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <6510e826-c39f-8910-ab67-a45b031efd20@redhat.com>
Subject: Re: [PATCH v12 07/10] iotests: Add test 179 to cover write zeroes
 with unmap
References: <20170504030755.1001-1-eblake@redhat.com>
 <20170504030755.1001-8-eblake@redhat.com>
In-Reply-To: <20170504030755.1001-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.05.2017 05:07, Eric Blake wrote:
> No tests were covering write zeroes with unmap.  Additionally,
> I needed to prove that my previous patches for correct status
> reporting and write zeroes optimizations actually had an impact.
>=20
> The test works for cluster_size between 8k and 2M (for smaller
> sizes, it fails because our allocation patterns are not contiguous
> with small clusters - in part, the largest consecutive allocation
> we tend to get is often bounded by the size covered by one L2
> table).
>=20
> Note that testing for zero clusters is tricky: 'qemu-io map'
> reports whether data comes from the current layer of the image
> (useful for sniffing out which regions of the file have
> QCOW_OFLAG_ZERO) - but doesn't show which clusters have mappings;
> while 'qemu-img map' sees "zero":true for both unallocated and
> zero clusters for any qcow2 with no backing layer (so less useful
> at detecting true zero clusters), but reliably shows mappings.
> So we have to rely on both queries side-by-side at each point of
> the test.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v12: probe the map in more places, to make test easier to follow
> v11: reserved for blkdebug half of v10
> v10: drop any changes to v2 files, rewrite test to work with updates
> earlier in the series, add a blkdebug probe
> v9: new patch
> ---
>  tests/qemu-iotests/179     | 132 +++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/179.out | 160 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 293 insertions(+)
>  create mode 100755 tests/qemu-iotests/179
>  create mode 100644 tests/qemu-iotests/179.out

Reviewed-by: Max Reitz <mreitz@redhat.com>

TIL qemu-io -c w.


--DKM162gD71kBrEpcN6k4RpNUQugCIJSi9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkM7X8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ALlMIAIX9o5JxGwI6U9PGGJb6QS+GKT1zpR6R
j1/qaVIQBrNcAULsk75EMTnD+nc3+npN0syr3oqlgdCqTK/VLhMcM9fdeBEG6Usk
TeLAM6iB7e8tMKb9YnsUZz2FOSkCwpCcD7vxualea7Kj8NlHwpGNBztrdVc7a7ad
suHBD/rcLvkFB0bIiCksvAFQ4uNHd8ujDM0lom3hTcAUjSpbSoVkR9WrThC6+L6c
PWvcIJbjawFEgdqYu9+XrL1QBUbDdIogkwHGEuu+ZWHz7vfvMT53KYBpQlqDwSs6
HIIalfD7uIRgUR9vkVuuE0cc8s9AE9//1eRgjnWqVRu02AEqIxR7w7o=
=A4QY
-----END PGP SIGNATURE-----

--DKM162gD71kBrEpcN6k4RpNUQugCIJSi9--
