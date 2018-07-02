Received: from eggs.gnu.org ([2001:4830:134:3::10]:59432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fZy3p-0007xa-Pv
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fZy3o-0000a8-ON
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:36:05 -0400
References: <20180702025836.20957-1-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <02d1f79b-c055-bb2a-edd5-3429ff64af90@redhat.com>
Date: Mon, 2 Jul 2018 14:35:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180702025836.20957-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bvmtgL1W5cka6CqNaSyA8VrAI756bKfD4"
Subject: Re: [Qemu-devel] [PATCH 0/4] block: Trivial fixes in offloading code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bvmtgL1W5cka6CqNaSyA8VrAI756bKfD4
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <02d1f79b-c055-bb2a-edd5-3429ff64af90@redhat.com>
Subject: Re: [PATCH 0/4] block: Trivial fixes in offloading code
References: <20180702025836.20957-1-famz@redhat.com>
In-Reply-To: <20180702025836.20957-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-07-02 04:58, Fam Zheng wrote:
> These are the low priority ones spotted by Kevin and Max last week.
>=20
> Fam Zheng (4):
>   qcow2: Drop unused cluster_data
>   file-posix: Fix fd_open check in raw_co_copy_range_to
>   qcow2: Drop unreachable break
>   raw: Drop superfluous semicolon
>=20
>  block/file-posix.c | 2 +-
>  block/qcow2.c      | 3 ---
>  block/raw-format.c | 2 +-
>  3 files changed, 2 insertions(+), 5 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block


Do you want to make qcow2_co_copy_range_to() do something special on
BDRV_REQ_ZERO_WRITE?  To me, it seems natural, but on the other hand
maybe it wouldn't bring anything.  If the protocol layer supports copy
offloading, then it'll probably do that zero write efficiently anyway.
If it doesn't, qemu-img convert will just fall back to the usual
implementation which involves writing zeroes when zeroes are read, so...
 What's your opinion?

Max


--bvmtgL1W5cka6CqNaSyA8VrAI756bKfD4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAls6HCkACgkQ9AfbAGHV
z0A4xgf+MDcvhALFvPD3TqvvlkyvMdnQSd/jBgkRannb7yDEyDPqn8U06/KZkhfh
DWr73T6nCleBNFYgm0lqbS0sF4Im7nU8X7S6lK+q+ZemvdekGezSTXvLhSHqsKpM
PhzS4XCxKZV62qyT4SAiEkjH/PdA9Figd8686qc34mU6O2JN4Qw34HPGEqsuwgX5
3aNHKCaP3JdMPwLQQnQOZYDCSi9+Vd/uWmok32nuihnuivOCKZPCK87mN2tQA+0K
IhNjJWF7YqEqaCDNjUvcyMWLM2/96ehh0jZBxtNlP0ZrOIjCoorE8BOiRpk28m+f
JJvNmu4XAiLKF//ySfoIrgBHVXGorw==
=DjK2
-----END PGP SIGNATURE-----

--bvmtgL1W5cka6CqNaSyA8VrAI756bKfD4--
