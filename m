Received: from eggs.gnu.org ([2001:4830:134:3::10]:47610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epDxO-00062k-SJ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epDxL-0000Xv-NO
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:04:14 -0500
References: <20180215131008.5153-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7fa13bbd-7c4b-3c1b-891a-68b251a7f617@redhat.com>
Date: Fri, 23 Feb 2018 15:03:54 +0100
MIME-Version: 1.0
In-Reply-To: <20180215131008.5153-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zJ6qsJyNIRfcH9hsJCV6nROkACpxSvEZK"
Subject: Re: [Qemu-devel] [PATCH v3] qcow2: Replace align_offset() with
 ROUND_UP()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zJ6qsJyNIRfcH9hsJCV6nROkACpxSvEZK
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <7fa13bbd-7c4b-3c1b-891a-68b251a7f617@redhat.com>
Subject: Re: [PATCH v3] qcow2: Replace align_offset() with ROUND_UP()
References: <20180215131008.5153-1-berto@igalia.com>
In-Reply-To: <20180215131008.5153-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-15 14:10, Alberto Garcia wrote:
> The align_offset() function is equivalent to the ROUND_UP() macro so
> there's no need to use the former. The ROUND_UP() name is also a bit
> more explicit.
>=20
> This patch uses ROUND_UP() instead of the slower QEMU_ALIGN_UP()
> because align_offset() already requires that the second parameter is a
> power of two.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v3 is the same as v2, but rebased on top of the current master fixing
> a merge conflict.
> ---
>  block/qcow2-bitmap.c   |  4 ++--
>  block/qcow2-cluster.c  |  4 ++--
>  block/qcow2-refcount.c |  4 ++--
>  block/qcow2-snapshot.c | 10 +++++-----
>  block/qcow2.c          | 14 +++++++-------
>  block/qcow2.h          |  6 ------
>  6 files changed, 18 insertions(+), 24 deletions(-)

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--zJ6qsJyNIRfcH9hsJCV6nROkACpxSvEZK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqQH0oSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AmgIH/iIn54S0tV5qXb4n7q0qhTr8QcBLUedz
5aRzATXdtdyAEKb8ahlP3cvBvr2HLXe2FX6gwEjkh0/zoGbYrp61D0sYCU6u8A+C
KNtBYcYNPAfsgO9AUZBPo7VKqut7Og7YWYn6R1sEikHE6zd9UnzUUKq67P+sncan
xbpkkNR81QcDykdYwrzf2FNA4+BN20qWovgohV2VFKhsv27JeFsU64d+6eGB+i9+
uQLamUy2DHgQPFS1QbZbVo2aExvxGY7sgJnkrm0M6PI2isaSm0v/E4J3vzzr5wI7
Mx7rKbhZG+9quXt1n1wBLutWUggxEfbNRGYxzVmflPC+2JaTlcTU/qc=
=DZJu
-----END PGP SIGNATURE-----

--zJ6qsJyNIRfcH9hsJCV6nROkACpxSvEZK--
