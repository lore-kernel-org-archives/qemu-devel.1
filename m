Received: from eggs.gnu.org ([2001:4830:134:3::10]:59473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAJV6-0006rt-OP
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAJV3-0007wy-07
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:41:56 -0400
References: <cover.1509550787.git.berto@igalia.com>
	<33492fad2f21dff38a33a96decb38983aee7e405.1509550787.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6e9b5351-b1b4-4df4-c267-a8b4e8061864@redhat.com>
Date: Thu, 2 Nov 2017 18:41:44 +0100
MIME-Version: 1.0
In-Reply-To: <33492fad2f21dff38a33a96decb38983aee7e405.1509550787.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jbjPWLlibj0bPQx5t5PtwJE6vvjhhSVQg"
Subject: Re: [Qemu-devel] [PATCH 3/4] qcow2: Don't open images with
 header.refcount_table_clusters == 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jbjPWLlibj0bPQx5t5PtwJE6vvjhhSVQg
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>
Message-ID: <6e9b5351-b1b4-4df4-c267-a8b4e8061864@redhat.com>
Subject: Re: [PATCH 3/4] qcow2: Don't open images with
 header.refcount_table_clusters == 0
References: <cover.1509550787.git.berto@igalia.com>
 <33492fad2f21dff38a33a96decb38983aee7e405.1509550787.git.berto@igalia.com>
In-Reply-To: <33492fad2f21dff38a33a96decb38983aee7e405.1509550787.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-01 16:42, Alberto Garcia wrote:
> qcow2_do_open() is checking that header.refcount_table_clusters is not
> too large, but it doesn't check that it's greater than zero. Apart
> from the fact that an image like that is obviously corrupted, trying
> to use it crashes QEMU since we end up with a null s->refcount_table
> after qcow2_refcount_init().
>=20
> These images can however be repaired, so allow opening them if the
> BDRV_O_CHECK flag is set.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c              | 6 ++++++
>  tests/qemu-iotests/060     | 7 +++++++
>  tests/qemu-iotests/060.out | 5 +++++
>  3 files changed, 18 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--jbjPWLlibj0bPQx5t5PtwJE6vvjhhSVQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAln7WNkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ad3QH/Rh5tYYUe4XT7HB0zvznS/qv+k3t9M9Z
T+/RLYfKXU4CcF0kPDp0npSpb+gs1MqvbfkYSrS4XheowGlWesCY+kj9fM/M/w2C
aqSeoH3toDuzXzbFJaWS04isiPZW5tRceoVxQKUUwniGO4HKNOaNch3Q5DkFSxNb
rV+Y641cLyBwYoqNUCurTPgyDnjbj0zMhLSeTR9uVXE55dfGGDQaTEwA+2OaQ/kH
gQ8BPylz7jlTZUMrXEMdmN1JIipwPNtf93SBMcqEgvSCnR9n9cqeaPtq3peuWII/
zvzXdGhC23oR0tmc71Ih2DeFjYWWLH0KZwcEumJ+TS09gxHo7M3ogFs=
=R8FS
-----END PGP SIGNATURE-----

--jbjPWLlibj0bPQx5t5PtwJE6vvjhhSVQg--
