Received: from eggs.gnu.org ([2001:4830:134:3::10]:47982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fXRqR-0002Iu-O4
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fXRqQ-0004dr-Gf
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:47:51 -0400
References: <20180319080705.10310-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <78deba5f-05a8-0737-23f3-f50c2bf8bf8e@redhat.com>
Date: Mon, 25 Jun 2018 15:47:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180319080705.10310-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uuPJTfl8Pd20DDMCUyzHKSQPnDCQRCg7k"
Subject: Re: [Qemu-devel] [PATCH v2] qcow2: add overlap check for bitmap
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
Cc: kwolf@redhat.com, jsnow@redhat.com, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uuPJTfl8Pd20DDMCUyzHKSQPnDCQRCg7k
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, eblake@redhat.com
Message-ID: <78deba5f-05a8-0737-23f3-f50c2bf8bf8e@redhat.com>
Subject: Re: [PATCH v2] qcow2: add overlap check for bitmap directory
References: <20180319080705.10310-1-vsementsov@virtuozzo.com>
In-Reply-To: <20180319080705.10310-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-19 09:07, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> If it appropriate for 2.12, let's push it. If not - then for 2.13.
>=20
>=20
> v2: - squash 02 (indentation fix) to 01
>     - drop comment from qcow2_check_metadata_overlap()
>     - set @ign to QCOW2_OL_BITMAP_DIRECTORY for in-place case in
>       bitmap_list_store. I don't think non-inplace case should be chang=
ed,
>       as it don't touch active bitmap directory.
>=20
>  block/qcow2.h          | 45 ++++++++++++++++++++++++------------------=
---
>  block/qcow2-bitmap.c   |  7 ++++++-
>  block/qcow2-refcount.c | 10 ++++++++++
>  block/qcow2.c          | 22 ++++++++++++++--------
>  4 files changed, 54 insertions(+), 30 deletions(-)
>=20
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 6f0ff15dd0..896ad08e5b 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -98,6 +98,7 @@
>  #define QCOW2_OPT_OVERLAP_SNAPSHOT_TABLE "overlap-check.snapshot-table=
"
>  #define QCOW2_OPT_OVERLAP_INACTIVE_L1 "overlap-check.inactive-l1"
>  #define QCOW2_OPT_OVERLAP_INACTIVE_L2 "overlap-check.inactive-l2"
> +#define QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY "overlap-check.bitmap-direc=
tory"

In addition to this, Qcow2OverlapCheckFlags in qapi/block-core.json
needs to be adjusted.

Apart from that, the patch looks good to me.

Max

>  #define QCOW2_OPT_CACHE_SIZE "cache-size"
>  #define QCOW2_OPT_L2_CACHE_SIZE "l2-cache-size"
>  #define QCOW2_OPT_REFCOUNT_CACHE_SIZE "refcount-cache-size"



--uuPJTfl8Pd20DDMCUyzHKSQPnDCQRCg7k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsw8noACgkQ9AfbAGHV
z0BVlwgAiPgohioTFyCHxqh2hAHiW+ALzk8x09aI6aZ6PJxpYgAxmoksq2UxEd3v
P7I/Ixvva4OFlJf9Db5uPCRhcZNxpZsKZWcLlvSHUfa5FnNMVugUXCKs7jqnFJP0
oPM9ptejVAVSxmr5BwZvD5gOCCVXsMHIbHnSmLnsEG6iO213gOsumlsXTLS+Cafp
Ji/uG7WM0UnCeGw5PzbD479UYZH4EpMarP18T6AInPXP7EkBxo4cy848/kAHdyES
LsVwtixdPDyiqjzqW2S5Q3Dfv0QGO0ru9LFAEU1sfjjd3T8I68rGeva6+Gg/YChq
zE3eFBJrLPeOM+9v6zvBeN1rpJR3Gw==
=97wW
-----END PGP SIGNATURE-----

--uuPJTfl8Pd20DDMCUyzHKSQPnDCQRCg7k--
