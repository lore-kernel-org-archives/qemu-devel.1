Received: from eggs.gnu.org ([2001:4830:134:3::10]:38037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1eHPSO-0002by-8d
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 02:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1eHPSN-0007rk-HQ
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 02:28:28 -0500
References: <20171122001656.12996-1-jsnow@redhat.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <8fd37504-3d8f-a057-d57d-d098ea713d09@redhat.com>
Date: Wed, 22 Nov 2017 08:28:15 +0100
MIME-Version: 1.0
In-Reply-To: <20171122001656.12996-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q3IwQd1QhM2lq2wLetRhUimViCUhlgrT7"
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 075 and 078
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q3IwQd1QhM2lq2wLetRhUimViCUhlgrT7
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <8fd37504-3d8f-a057-d57d-d098ea713d09@redhat.com>
Subject: Re: [PATCH] iotests: fix 075 and 078
References: <20171122001656.12996-1-jsnow@redhat.com>
In-Reply-To: <20171122001656.12996-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 22.11.2017 v 01:16 John Snow napsal(a):
> Both of these tests are for formats which now stipulate that they are
> read-only. Adjust the tests to match.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/075 | 18 +++++++++---------
>  tests/qemu-iotests/078 | 14 +++++++-------
>  2 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>=20

Yep, fixes the issue with "Opening cloop images without an explicit read-=
only=3Don option is deprecated. Future versions will refuse to open the i=
mage instead of automatically marking the image read-only.".

Luk=C3=A1=C5=A1


--Q3IwQd1QhM2lq2wLetRhUimViCUhlgrT7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJaFScPExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsFc
OwgAw7n/Z2DKwxEytzGKzssA4qsqrar+PGjMlaPySQXo4ZIphbuFf7Lny8B0DKKU
0K71W2HL/i75OtSgiCC35tMUP2rjXT0TEIeaQw9wPw6g2t5jEOpL0N7bFZdYqysY
+6y1VUXGZlMlW1SS15m2U4T3JJH1VaJ/75SfTahXdp295buuimpjRfDFGzZQAwu4
uWBqgeubqghu/Lv6xZmoxhwbnR+/F11X6qRd+X5pswnkWkbieV+98IqCYKjyOo3/
WXo15MisKTrl8Jx0+un/28QWSK1YDzMyulOoEokPUn0G5peJyOHZQfxXWs+JywWC
SHqwXF+GjYbB24lKUzTpSuI8LQ==
=OYIn
-----END PGP SIGNATURE-----

--Q3IwQd1QhM2lq2wLetRhUimViCUhlgrT7--
