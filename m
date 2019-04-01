Received: from eggs.gnu.org ([209.51.188.92]:57761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hB376-0001v9-B4
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 16:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hB375-0003ar-6x
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 16:01:00 -0400
References: <20190227131433.197063-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <451946f4-70c8-4a49-453c-13ec4cc36e63@redhat.com>
Date: Mon, 1 Apr 2019 22:00:50 +0200
MIME-Version: 1.0
In-Reply-To: <20190227131433.197063-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pIQOZXuvXBw3sD7NmvswDzCLXi7t5YIy5"
Subject: Re: [Qemu-devel] [PATCH v5 0/5] qcow2 check improvements part I
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pIQOZXuvXBw3sD7NmvswDzCLXi7t5YIy5
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com
Message-ID: <451946f4-70c8-4a49-453c-13ec4cc36e63@redhat.com>
Subject: Re: [PATCH v5 0/5] qcow2 check improvements part I
References: <20190227131433.197063-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190227131433.197063-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.02.19 14:14, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>=20
> v5:
> 01: - add Max's r-b
> 02: - s/it's/it/ in comment in block/qcow2-refcount.c [Max]
>     - fix comment style accordingly to updated checkpatch
>       ('/*' on separate line)
>     - add Max's r-b
> 04: - add Max's r-b
> 05: - refactor change in check_oflag_copied, to increase
>       res->corruptions separately from l2_dirty variable [Max]
>=20
> v4 was derived from "[PATCH v3 0/8] qcow2 check improvements"
> (https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02284.html)
>=20
> v4:
> Some patches are new, some patches are not included and are postponed t=
o
> part II.
>=20
> 01,03 - unchanged
> 02: handle broken iotest
> 04-05: new
>=20
> Vladimir Sementsov-Ogievskiy (5):
>   qcow2-refcount: fix check_oflag_copied
>   qcow2-refcount: avoid eating RAM
>   qcow2-refcount: check_refcounts_l2: reduce ignored overlaps
>   qcow2-refcount: check_refcounts_l2: don't count fixed cluster as
>     allocated
>   qcow2-refcount: don't mask corruptions under internal errors
>=20
>  block/qcow2-refcount.c     | 80 ++++++++++++++++++++++++--------------=

>  tests/qemu-iotests/138     | 12 +++---
>  tests/qemu-iotests/138.out |  5 ++-
>  3 files changed, 59 insertions(+), 38 deletions(-)

Thanks, resolved the contextual conflicts that this series has with
Kevin=E2=80=99s data-file series, and applied it to my block-next branch:=


https://git.xanclic.moe/XanClic/qemu/commits/branch/block-next

Max


--pIQOZXuvXBw3sD7NmvswDzCLXi7t5YIy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyibfIACgkQ9AfbAGHV
z0DJRggAoodAgCfQL+3o9eNg0JqOki52d4Kklz04e6mSMQqa9JvDHqUvz1YyCQHK
UYfct+ePfPAfQYTYznuqouqzSy+6AgDFoDJXOYPzTJ4IgwAgMrkSwMi730dq+pnQ
vzZ0aqoP9Cb81ULaO7A54pv3cx+zxXoJEsyrM2THDAxkeZnKQAY9DSPqB7Rcn/dl
ufSaqC9eT8Ekzux4K3l5tD5xmYamGMl5QlCaRpUFL1UnvF1KVwH2KUHeORfUyo8U
q73ud2v3TlMVRm3v6zqITxRn5CSOa+3NF0XcYn1IB1PUASTLB1RDzrXfmrpGhqlM
BSoy/bgUkVzZpWwLTVtUoRg+KmfnxQ==
=Do+g
-----END PGP SIGNATURE-----

--pIQOZXuvXBw3sD7NmvswDzCLXi7t5YIy5--
