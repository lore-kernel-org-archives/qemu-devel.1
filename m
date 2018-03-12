Received: from eggs.gnu.org ([2001:4830:134:3::10]:43592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evQdc-0004dE-9K
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evQdb-0002oO-H6
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:49:28 -0400
References: <20180309214611.19122-1-kwolf@redhat.com>
	<20180309214611.19122-4-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5307278e-55d7-b350-63b5-1ac6301bee71@redhat.com>
Date: Mon, 12 Mar 2018 17:49:10 +0100
MIME-Version: 1.0
In-Reply-To: <20180309214611.19122-4-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DVBtEaOxyL1QqyXcXPaIykSfqdihOl6pN"
Subject: Re: [Qemu-devel] [PATCH 3/7] qcow: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DVBtEaOxyL1QqyXcXPaIykSfqdihOl6pN
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <5307278e-55d7-b350-63b5-1ac6301bee71@redhat.com>
Subject: Re: [PATCH 3/7] qcow: Support .bdrv_co_create
References: <20180309214611.19122-1-kwolf@redhat.com>
 <20180309214611.19122-4-kwolf@redhat.com>
In-Reply-To: <20180309214611.19122-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-09 22:46, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to qcow, which
> enables image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  21 +++++-
>  block/qcow.c         | 196 ++++++++++++++++++++++++++++++++++---------=
--------
>  2 files changed, 150 insertions(+), 67 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

(still not sure about the crumpling)


--DVBtEaOxyL1QqyXcXPaIykSfqdihOl6pN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqmr4YSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AvhgH/28kadj3cvveISN5SeJ9H7jhl5pTfdXH
isuYYD/rl5sib+sLkmLRwHPupy859VujJBdPsY5FgbTKkkcEM13XY6sw5Rz9j9TN
kV+C4s1d0KKOakZOrg55xPJZSzvYFb4ae6NYsWDeBfEJg0MeFmLgbUSsKp2fSqPb
U02GNw7HC/M0p11t2jgYzHzmsz0Pz2KQf8XYFKw3BAK4vtvos3YIliwD45lhp5Bj
hUECtuA0HY9rmlROQ2FGS2u4KuH1iFwmQf+gDMt5ltVBrH6a+DWliz9oa9rKu/WJ
Tu3DcyJzE9icgSgMd/13Zk96Kf0zGz4pAzxpwPKP0C31y1fiooDy+JY=
=nezy
-----END PGP SIGNATURE-----

--DVBtEaOxyL1QqyXcXPaIykSfqdihOl6pN--
