Received: from eggs.gnu.org ([2001:4830:134:3::10]:32780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eoztA-0003eh-Jh
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eozt8-0007Tv-T1
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:02:56 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-19-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f25b3a32-d3b5-e1a4-2aa2-300db9f5d61c@redhat.com>
Date: Fri, 23 Feb 2018 00:02:43 +0100
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-19-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LjgeCVKfUf7n9yMNbcZZhhqj7DgNbEJ9y"
Subject: Re: [Qemu-devel] [PATCH v2 18/36] rbd: Fix use after free in
 qemu_rbd_set_keypairs() error path
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
--LjgeCVKfUf7n9yMNbcZZhhqj7DgNbEJ9y
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <f25b3a32-d3b5-e1a4-2aa2-300db9f5d61c@redhat.com>
Subject: Re: [PATCH v2 18/36] rbd: Fix use after free in
 qemu_rbd_set_keypairs() error path
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-19-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-19-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-21 14:53, Kevin Wolf wrote:
> If we want to include the invalid option name in the error message, we
> can't free the string earlier than that.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/rbd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--LjgeCVKfUf7n9yMNbcZZhhqj7DgNbEJ9y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqPTBQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AEeYH/3ejyqzb5/Xo/rLoD9SbtT5WZkdsqXBr
xWS9+QTOb0Ete641efxoyO6pjnYJdADSGwUxltbEtdhdJ3etc5cTGYYAKbZAVLxD
INeSYWgCdKIMCWumKv+i63Cws0UngSYo/yW5z5LR0AoSiNw1iD+GAUEglH0ePvFN
deYIeVBW6Z9Rcf+MTEWAuBwbn/YhW75V/yVJXuEu5wCSGOK3WUexzWZTpH4uQ19N
0gzBXR8MqaMowsWb4FcdfEtVfcO/FkeDNHahaadX9279o1QmIMmYutju8APNIgRF
aRYlXcwn2Zym6Fx3x0uOghhvHu4CxpWGQSQUU0aUamXjSLhGEgzy5JA=
=Irpe
-----END PGP SIGNATURE-----

--LjgeCVKfUf7n9yMNbcZZhhqj7DgNbEJ9y--
