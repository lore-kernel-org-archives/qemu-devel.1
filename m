Received: from eggs.gnu.org ([2001:4830:134:3::10]:55219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAeyN-0007nA-6L
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAeyM-0002ve-4Y
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:37:35 -0400
References: <cover.1509718618.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <434ff63a-95df-0b26-f2a0-390468172ff7@redhat.com>
Date: Fri, 3 Nov 2017 17:37:23 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1509718618.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vefXaFI36RVjKlq3HjgUTdLs90RdrNJON"
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Misc qcow2 corruption checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vefXaFI36RVjKlq3HjgUTdLs90RdrNJON
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>
Message-ID: <434ff63a-95df-0b26-f2a0-390468172ff7@redhat.com>
Subject: Re: [PATCH v2 0/7] Misc qcow2 corruption checks
References: <cover.1509718618.git.berto@igalia.com>
In-Reply-To: <cover.1509718618.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-03 15:18, Alberto Garcia wrote:
> This series contains a few checks that prevent QEMU from crashing
> under some scenarios with corrupted qcow2 images.
>=20
> The first patch solves the crash reported here:
>=20
>   https://bugs.launchpad.net/qemu/+bug/1728615
>=20
> And the others solve similar crashes that I detected in the process of
> fixing this one.
>=20
> Regards,
>=20
> Berto
>=20
> v2:
> - Use goto fail in the l2_allocate() check [Max]
> - Add check and test case for allocation of compressed clusters [Max]
> - Add test case for header.refcount_table_offset =3D=3D 0
> - Add overlap checks to qcow2_crypto_hdr_init_func() [Max]
>=20
> v1: https://lists.gnu.org/archive/html/qemu-block/2017-11/msg00010.html=

> - Initial version
>=20
> Output of backport-diff against v1:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream p=
atch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
>=20
> 001/7:[----] [--] 'qcow2: Prevent allocating refcount blocks at offset =
0'
> 002/7:[0003] [FC] 'qcow2: Prevent allocating L2 tables at offset 0'
> 003/7:[down] 'qcow2: Prevent allocating compressed clusters at offset 0=
'
> 004/7:[----] [-C] 'qcow2: Don't open images with header.refcount_table_=
clusters =3D=3D 0'
> 005/7:[down] 'qcow2: Add iotest for an image with header.refcount_table=
_offset =3D=3D 0'
> 006/7:[----] [--] 'qcow2: Add iotest for an empty refcount table'
> 007/7:[down] 'qcow2: Assert that the crypto header does not overlap oth=
er metadata'
>=20
> Alberto Garcia (7):
>   qcow2: Prevent allocating refcount blocks at offset 0
>   qcow2: Prevent allocating L2 tables at offset 0
>   qcow2: Prevent allocating compressed clusters at offset 0
>   qcow2: Don't open images with header.refcount_table_clusters =3D=3D 0=

>   qcow2: Add iotest for an image with header.refcount_table_offset =3D=3D=
 0
>   qcow2: Add iotest for an empty refcount table
>   qcow2: Assert that the crypto header does not overlap other metadata
>=20
>  block/qcow2-cluster.c      |  8 ++++++++
>  block/qcow2-refcount.c     | 15 +++++++++++++-
>  block/qcow2.c              |  7 +++++++
>  tests/qemu-iotests/060     | 49 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/060.out | 39 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 117 insertions(+), 1 deletion(-)

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--vefXaFI36RVjKlq3HjgUTdLs90RdrNJON
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAln8m0MSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9APYIH/3CtDr84Tom+tUJ+0FRl2ayyfUeEwlKJ
/vFCTBUSEvQcWNq/en3D+n8W80U3B0Jn7Lo1S1lsbTTsS8e9uquqy4Wy9JKHjRWu
GW4rYuPek4wIPkYBCKj1ILMVkM384tlIOtHHuWC6q0Tp2IJu3ocDlrKUV09vvMVp
4dP1Y6hEWpV6Je9cwWr5ShiYiCq6P0RzyFsGorsZ3i0JMOsZek/Uma2oB7LbydOX
KlyGvI7Vactxvh4DhXiQhWCOzBYY4qrZHr3rt9mIe1C8Txmo7V/XXf881uln4GwC
fTul+diEQAIagR7bHdPIp6BQod7f6vIOPjM0KYofP8QfObYIoS061kI=
=L29m
-----END PGP SIGNATURE-----

--vefXaFI36RVjKlq3HjgUTdLs90RdrNJON--
