Received: from eggs.gnu.org ([2001:4830:134:3::10]:48440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fcYVC-0008Ld-52
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fcYVB-0001zC-43
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:55:02 -0400
References: <20180705151515.779173-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a32519a5-3f37-184a-cd8d-4979c2f8a6f2@redhat.com>
Date: Mon, 9 Jul 2018 17:54:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180705151515.779173-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1sdgK1y0XVkpJqrNbEBe4EFRQFrzAWSc0"
Subject: Re: [Qemu-devel] [PATCH v4] qcow2: add overlap check for bitmap
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1sdgK1y0XVkpJqrNbEBe4EFRQFrzAWSc0
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <a32519a5-3f37-184a-cd8d-4979c2f8a6f2@redhat.com>
Subject: Re: [PATCH v4] qcow2: add overlap check for bitmap directory
References: <20180705151515.779173-1-vsementsov@virtuozzo.com>
In-Reply-To: <20180705151515.779173-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-07-05 17:15, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> If it appropriate for 3.0, let's push it. If not - then for 3.1
> with fixed "since". Should I cc stable?
>=20
> v4: - fix indentation
>=20
> v3: - update Qcow2OverlapCheckFlags in qapi/block-core.json [Max]
>=20
> v2: - squash 02 (indentation fix) to 01
>     - drop comment from qcow2_check_metadata_overlap()
>     - set @ign to QCOW2_OL_BITMAP_DIRECTORY for in-place case in
>       bitmap_list_store. I don't think non-inplace case should be chang=
ed,
>       as it don't touch active bitmap directory.
>=20
>  qapi/block-core.json   | 21 ++++++++++++---------
>  block/qcow2.h          | 45 ++++++++++++++++++++++++------------------=
---
>  block/qcow2-bitmap.c   |  7 ++++++-
>  block/qcow2-refcount.c | 10 ++++++++++
>  block/qcow2.c          | 22 ++++++++++++++--------
>  5 files changed, 66 insertions(+), 39 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--1sdgK1y0XVkpJqrNbEBe4EFRQFrzAWSc0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltDhU0ACgkQ9AfbAGHV
z0A1pQf+KtIKhc+XNXXIkQz5NBygG7i97rEYU9z6csF++bnvV47Q8ieZr4SPYACH
86QwfYdGJyo3MsxfWwvK4wilFaAbv15/9qpktszCqvQQmZY/8P8UfJ3+6acuqKok
RMN4/axZbHP4NeED2z8aiEy+V6Xng4WcJ5WmUWLqY+4WWRhSPP4KGG9TxN/bw9Np
7Up9tjhyoTAuDLcQPci2gFgFmMQ18HXY6RXxA3l17pzXlX/hAfdjC9ABAE2dCEKk
n856UssFjzcjX5zruKHSdoEDbG7Tx/kSyZnMfzkOX/KudfaP1tnAuV/um2L0zYa2
9zPWS8SI8a1bJZdPWX5L51z4Kb3gTg==
=y7vn
-----END PGP SIGNATURE-----

--1sdgK1y0XVkpJqrNbEBe4EFRQFrzAWSc0--
