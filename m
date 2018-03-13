Received: from eggs.gnu.org ([2001:4830:134:3::10]:34252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evjX4-0003wQ-K4
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evjX3-0002VX-QG
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:59:58 -0400
References: <20180313115814.23774-1-famz@redhat.com>
	<20180313115814.23774-2-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ce5dcdf3-9b0b-ae88-437f-3ada71530d82@redhat.com>
Date: Tue, 13 Mar 2018 13:59:47 +0100
MIME-Version: 1.0
In-Reply-To: <20180313115814.23774-2-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jtyXI1Tv25wow6LvhbwhYFgMEocvs16yV"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] block: Fix flags in reopen queue
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
--jtyXI1Tv25wow6LvhbwhYFgMEocvs16yV
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <ce5dcdf3-9b0b-ae88-437f-3ada71530d82@redhat.com>
Subject: Re: [PATCH v2 1/2] block: Fix flags in reopen queue
References: <20180313115814.23774-1-famz@redhat.com>
 <20180313115814.23774-2-famz@redhat.com>
In-Reply-To: <20180313115814.23774-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-13 12:58, Fam Zheng wrote:
> Reopen flags are not synchronized according to the
> bdrv_reopen_queue_child precedence until bdrv_reopen_prepare. It is a
> bit too late: we already check the consistency in bdrv_check_perm befor=
e
> that.
>=20
> This fixes the bug that when bdrv_reopen a RO node as RW, the flags for=

> backing child are wrong. Before, we could recurse with flags.rw=3D1; no=
w,
> role->inherit_options + update_flags_from_options will make sure to
> clear the bit when necessary.  Note that this will not clear an
> explicitly set bit, as in the case of parallel block jobs (e.g.
> test_stream_parallel in 030), because the explicit options include
> 'read-only=3Dfalse' (for an intermediate node used by a different job).=

>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--jtyXI1Tv25wow6LvhbwhYFgMEocvs16yV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqny0QSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AVCMIAIWF4q6W/4OnptpT30mRMxhjupaU6P7M
D/W3txMVAmiialQAzcseEE43xugFuuYpdKxUtQp/IVgbuKt3PYHiqFhD2KEAnMwu
eeBEGgzNr6L5ikZDZMpj60IjnjoyzrTrbLRMvFOvOGvomsuZN3zI6tk74uMAnt8Y
E2zDWdy4ig/rDHz+5dZrNEuJ4ynu6/0F3G6IV1NbMhrodJy9sR4Tztjxw7DpITbZ
Xv7Fn3w6ptmCWVTbit2rqEE5k8NyTCeEMft0by3YdlZ3dppGXzjnOPUP/bRAu8SP
eBDKJgE7XBtWB4flI4shyX/Tx3d/jWUjGwJWFiEwjd9Be1XOmGFftLk=
=GD17
-----END PGP SIGNATURE-----

--jtyXI1Tv25wow6LvhbwhYFgMEocvs16yV--
