Received: from eggs.gnu.org ([2001:4830:134:3::10]:37592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1etekM-0005nY-O6
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 14:29:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1etekL-0000ve-Tm
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 14:29:06 -0500
References: <20180307185946.29366-1-kwolf@redhat.com>
	<20180307185946.29366-23-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e4c45656-2749-a4d2-9ca1-3fc17796fd0d@redhat.com>
Date: Wed, 7 Mar 2018 20:28:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180307185946.29366-23-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9MgzOeveHrJDyVBPGGdgi43AKBo9BKknf"
Subject: Re: [Qemu-devel] [PATCH v4 22/37] rbd: Pass BlockdevOptionsRbd to
 qemu_rbd_connect()
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
--9MgzOeveHrJDyVBPGGdgi43AKBo9BKknf
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <e4c45656-2749-a4d2-9ca1-3fc17796fd0d@redhat.com>
Subject: Re: [PATCH v4 22/37] rbd: Pass BlockdevOptionsRbd to
 qemu_rbd_connect()
References: <20180307185946.29366-1-kwolf@redhat.com>
 <20180307185946.29366-23-kwolf@redhat.com>
In-Reply-To: <20180307185946.29366-23-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-07 19:59, Kevin Wolf wrote:
> With the conversion to a QAPI options object, the function is now
> prepared to be used in a .bdrv_co_create implementation.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/rbd.c | 115 +++++++++++++++++++++++++++++-----------------------=
--------
>  1 file changed, 55 insertions(+), 60 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--9MgzOeveHrJDyVBPGGdgi43AKBo9BKknf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqgPWkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AfIwH/AlODTll8w3EXYDU/mCjkRU/qspIiRaq
C37k8TzLfzX1qQKkWyOjiGTkvSjOBXeA5beHmR7fKfcVXPgnuukepfJ5DIlFNfHI
tTJiPxb5EXlVZIylyQ03bdAhtAO/xhDKFMcUmus/OdPvtqAxXPrFGcX72SgoNsg9
ihHwqLoErAoUCCoQT/jHrZZYzlBKNbogwA2DgtbvtphrPEJ21FlIomywmU/xXj8h
QURjJcuIFfzM/dAQ3wjPjZuXlMOvA/6S3PG1J0cYXymSBOTuC4He1orHcYNmWMoz
kdndKJGS9QUe9GIGuO2S0lN7qK+hPnssLDB6hu75ZQTFTzm5NurP35A=
=sJpL
-----END PGP SIGNATURE-----

--9MgzOeveHrJDyVBPGGdgi43AKBo9BKknf--
