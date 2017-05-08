Received: from eggs.gnu.org ([2001:4830:134:3::10]:37051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7lUI-0002H0-E9
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7lUH-00004z-A4
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:26:18 -0400
References: <20170507000552.20847-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <35278c2f-b8c9-2258-c30a-73e64c2e3fc9@redhat.com>
Date: Mon, 8 May 2017 18:26:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170507000552.20847-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cKUQxWv1D7BTq3lLMHwPckN3JmW9rPCJw"
Subject: Re: [Qemu-devel] [PATCH v13 00/12] qcow2 zero-cluster tweaks [was
 add blkdebug tests]
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
--cKUQxWv1D7BTq3lLMHwPckN3JmW9rPCJw
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <35278c2f-b8c9-2258-c30a-73e64c2e3fc9@redhat.com>
Subject: Re: [PATCH v13 00/12] qcow2 zero-cluster tweaks [was add blkdebug
 tests]
References: <20170507000552.20847-1-eblake@redhat.com>
In-Reply-To: <20170507000552.20847-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.05.2017 02:05, Eric Blake wrote:
> I've collected several improvements for qcow2 zero-cluster handling.
>=20
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-v13
>=20
> Marked as v13 for "hysterical raisins", since it it the half of
> v10 [1] that was not resubmitted as v11 [2].
>=20
> Depends on Max's block tree:
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00641.html
> and on Max's qcow2 cleanups:
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00689.html
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05227.html=

> [2] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05896.html=

> [3] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00722.html=

>=20
> Changes since last posting (v12 [3]):
> - 2 more new patches: split indentation from other changes (patch 1),
> and add a typedef (patch 5)
> - address Max's findings
>=20
> 001/12:[down] 'qcow2: Nicer variable names in qcow2_update_snapshot_ref=
count()'
> 002/12:[0040] [FC] 'qcow2: Use consistent switch indentation'
> 003/12:[----] [--] 'block: Update comments on BDRV_BLOCK_* meanings'
> 004/12:[----] [--] 'qcow2: Correctly report status of preallocated zero=
 clusters'
> 005/12:[down] 'qcow2: Name typedef for cluster type'
> 006/12:[0032] [FC] 'qcow2: Make distinction between zero cluster types =
obvious'
> 007/12:[0002] [FC] 'qcow2: Optimize zero_single_l2() to minimize L2 chu=
rn'
> 008/12:[0002] [FC] 'iotests: Improve _filter_qemu_img_map'
> 009/12:[0010] [FC] 'iotests: Add test 179 to cover write zeroes with un=
map'
> 010/12:[0003] [FC] 'qcow2: Optimize write zero of unaligned tail cluste=
r'
> 011/12:[----] [--] 'qcow2: Assert that cluster operations are aligned'
> 012/12:[----] [--] 'qcow2: Discard/zero clusters by byte count'
>=20
> Eric Blake (12):
>   qcow2: Nicer variable names in qcow2_update_snapshot_refcount()
>   qcow2: Use consistent switch indentation
>   block: Update comments on BDRV_BLOCK_* meanings
>   qcow2: Correctly report status of preallocated zero clusters
>   qcow2: Name typedef for cluster type
>   qcow2: Make distinction between zero cluster types obvious
>   qcow2: Optimize zero_single_l2() to minimize L2 churn
>   iotests: Improve _filter_qemu_img_map
>   iotests: Add test 179 to cover write zeroes with unmap
>   qcow2: Optimize write zero of unaligned tail cluster
>   qcow2: Assert that cluster operations are aligned
>   qcow2: Discard/zero clusters by byte count
>=20
>  block/qcow2.h                    |  23 +++--
>  include/block/block.h            |  35 ++++----
>  include/block/block_int.h        |   7 ++
>  block/qcow2-cluster.c            | 181 ++++++++++++++++++++++---------=
--------
>  block/qcow2-refcount.c           | 144 +++++++++++++++----------------=

>  block/qcow2-snapshot.c           |   7 +-
>  block/qcow2.c                    |  38 ++++----
>  tests/qemu-iotests/common.filter |   4 +-
>  tests/qemu-iotests/060.out       |   6 +-
>  tests/qemu-iotests/122.out       |  16 ++--
>  tests/qemu-iotests/154           | 160 +++++++++++++++++++++++++++++++=
++-
>  tests/qemu-iotests/154.out       | 158 ++++++++++++++++++++++++++++++-=
---
>  tests/qemu-iotests/179           | 130 ++++++++++++++++++++++++++++
>  tests/qemu-iotests/179.out       | 156 +++++++++++++++++++++++++++++++=
++
>  tests/qemu-iotests/group         |   1 +
>  15 files changed, 840 insertions(+), 226 deletions(-)
>  create mode 100755 tests/qemu-iotests/179
>  create mode 100644 tests/qemu-iotests/179.out

Thanks, applied to my block branch with patch 5 extended as proposed
(and git fixed patch 6 automagically):

https://github.com/XanClic/qemu/commits/block

Max


--cKUQxWv1D7BTq3lLMHwPckN3JmW9rPCJw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkQnCISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ATwAH/2QVk5NhGHT1lbZ97kdPaHrwJo16KfJ6
RLJdMl3roMUz6xwJ8+QOWILHBDPuuV2Y0cK3Is9GnOAFh3ZlqPK1e9UKGMklu/MY
8SySYrDGnrpRMZpJdyHvwJs6kga3Qt3DbY1W9ZV9n1FcHgflz0DKDn1VBeoTMa5R
7VdgAskxqsF41qOkpLcOSjV/2AsmHGEELzM3TVHp8mKoJUCYqhTrhDHgHfogF0n/
2T4bK5/aVrNI0bCswwGDrBZa82zJxVfO51uR2JiauviPWpi6DCswKPWPAcqyY5Ss
D2eRybMlFgC0sa4H/dlGsSH6Mv9cL532zoXPMxv/qBr4ohKCNLzqslQ=
=O+GG
-----END PGP SIGNATURE-----

--cKUQxWv1D7BTq3lLMHwPckN3JmW9rPCJw--
