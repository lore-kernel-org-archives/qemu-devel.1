Received: from eggs.gnu.org ([209.51.188.92]:44370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1glZOY-0004ye-VE
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:13:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1glZOY-0002gQ-8f
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:13:42 -0500
References: <20190115111007.27159-1-stefanha@redhat.com>
	<20190115111007.27159-3-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8b59c1b6-f28d-2244-dbd0-d0c1af93d4cb@redhat.com>
Date: Mon, 21 Jan 2019 14:13:30 +0100
MIME-Version: 1.0
In-Reply-To: <20190115111007.27159-3-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2FPgC98WU2ts2p8SYUAuOXokvb5g9UcGP"
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: add LUKS payload overhead to
 178 qemu-img measure test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2FPgC98WU2ts2p8SYUAuOXokvb5g9UcGP
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Message-ID: <8b59c1b6-f28d-2244-dbd0-d0c1af93d4cb@redhat.com>
Subject: Re: [PATCH 2/2] iotests: add LUKS payload overhead to 178 qemu-img
 measure test
References: <20190115111007.27159-1-stefanha@redhat.com>
 <20190115111007.27159-3-stefanha@redhat.com>
In-Reply-To: <20190115111007.27159-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.01.19 12:10, Stefan Hajnoczi wrote:
> The previous patch includes the LUKS payload overhead into the qemu-img=

> measure calculation for qcow2.  Update qemu-iotests 178 to exercise thi=
s
> new code path.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/178           |  8 ++++++++
>  tests/qemu-iotests/178.out.qcow2 | 24 ++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--2FPgC98WU2ts2p8SYUAuOXokvb5g9UcGP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxFxXoACgkQ9AfbAGHV
z0AiZwf/f/g1mRgb+UkfE7sxW7CXtq31rbL7SA63m9j8AHRtjysJma5P9z0nv++R
x4jm0UkY4dYsAmeUdyAJ1DoENRbuQkeIrbpaClxJam9iqWF7AkWqK9Ltsa+V/7sz
q1XcxQftPV87svmltoU+YK3jwhsXDp0ekIsE4z1dXSLWivHpzcgoi/EM8NB5yL2y
606h5XxD/dZo6EX17jFwTrm9kdfLqYImTw0wmQb0j4M4Nm+nemvlXmwWWl+UxP8w
9zGxHyjdImf9BwbW3aWENAvrtfhtXEfp4BV94hkOOtuqeO8Ycq3QtjJ/gh2Vcz+Q
KaQrhV3ArW4AgKYNEQ8+ZY5D+FL3Cw==
=Ddzj
-----END PGP SIGNATURE-----

--2FPgC98WU2ts2p8SYUAuOXokvb5g9UcGP--
