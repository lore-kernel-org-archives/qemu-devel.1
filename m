Received: from eggs.gnu.org ([2001:4830:134:3::10]:46226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqHpz-0005DK-QY
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:25:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqHpz-0006DD-0G
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:24:59 -0500
References: <20180223192549.26666-1-kwolf@redhat.com>
	<20180223192549.26666-24-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <20f18014-25e7-c822-9d7d-adc46bdcec81@redhat.com>
Date: Mon, 26 Feb 2018 13:24:53 +0100
MIME-Version: 1.0
In-Reply-To: <20180223192549.26666-24-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="22j1tBfQySGKSugVRiFavqGC2aZeLfBia"
Subject: Re: [Qemu-devel] [PATCH v3 23/36] rbd: Assign s->snap/image_name in
 qemu_rbd_open()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--22j1tBfQySGKSugVRiFavqGC2aZeLfBia
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <20f18014-25e7-c822-9d7d-adc46bdcec81@redhat.com>
Subject: Re: [PATCH v3 23/36] rbd: Assign s->snap/image_name in
 qemu_rbd_open()
References: <20180223192549.26666-1-kwolf@redhat.com>
 <20180223192549.26666-24-kwolf@redhat.com>
In-Reply-To: <20180223192549.26666-24-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-23 20:25, Kevin Wolf wrote:
> Now that the options are already available in qemu_rbd_open() and not
> only parsed in qemu_rbd_connect(), we can assign s->snap and
> s->image_name there instead of passing the fields by reference to
> qemu_rbd_connect().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/rbd.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--22j1tBfQySGKSugVRiFavqGC2aZeLfBia
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqT/JUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A5dwIALqJch/pU9WaztEOt72jh6fb9dhf4v7c
FatkdObGAPGNpn3zp+5hbAwbdnLWtVMpwkvI+ttNrPCyMdlIn8Exguk0RrIx2qqE
xv61Yiu+XJA9yN+2oqHqvcUDnkhM/oZcc0hKc3C9bVmcJq0Im+bAFrQWi1qUMlOV
dXNs+wDuRZQk/OrF8JZ50lJ6qRQMYCcGzBHno5EhNosYhw3+G3qVMqLyzpaQdVxN
tQm377RvxGO7tQP6GiWsKY+owa6MAjshTeJENXQUgLUdm/HAq2uS4SF278BW82gO
Y/f6E6Ar5Vqcc4zxCdI4QSzqvboC1SOAfr/Szi7P+ndvlZFgr2A4Zbw=
=USmP
-----END PGP SIGNATURE-----

--22j1tBfQySGKSugVRiFavqGC2aZeLfBia--
