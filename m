Received: from eggs.gnu.org ([2001:4830:134:3::10]:56946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZl5q-0005i8-MC
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 16:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZl5p-0003Q3-RG
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 16:08:30 -0500
References: <20170203120254.15062-1-berrange@redhat.com>
	<20170203120254.15062-3-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e9bba8a1-31ec-be01-ab42-aacb985be0d8@redhat.com>
Date: Fri, 3 Feb 2017 22:08:20 +0100
MIME-Version: 1.0
In-Reply-To: <20170203120254.15062-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d0LSJiIWTQGS6xeorGqSNSu8xWsKwN9Pt"
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qemu-img: fix --image-opts usage
 with dd command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d0LSJiIWTQGS6xeorGqSNSu8xWsKwN9Pt
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <e9bba8a1-31ec-be01-ab42-aacb985be0d8@redhat.com>
Subject: Re: [PATCH v2 2/6] qemu-img: fix --image-opts usage with dd command
References: <20170203120254.15062-1-berrange@redhat.com>
 <20170203120254.15062-3-berrange@redhat.com>
In-Reply-To: <20170203120254.15062-3-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.02.2017 13:02, Daniel P. Berrange wrote:
> The --image-opts flag can only be used to affect the parsing
> of the source image. The target image has to be specified in
> the traditional style regardless, since it needs to be passed
> to the bdrv_create() API which does not support the new style
> opts.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--d0LSJiIWTQGS6xeorGqSNSu8xWsKwN9Pt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliU8UQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AqgIH/2H1Fg5XAvwnFv+foW55cHKc1Y2DAhDl
FlCJ3dGxwi6Xn5s86lGvYn0Ujyq3/i6dWxssJoME5oYMUQ5zTg6n+RwSuK4qCd/B
EztnyKobuak1/ll0btAh/MQ7L8P/MmpG3ar76lJH1i90TaeOBHzCcC8NJDZxLc/Z
St5iBe6daH08pHGvkwD9Dw9GQ0/1isYZGYlD0XBKGjZriNU+VToXlb7CTmmqtvLn
epBQLpkdCG+gyjMjs/qZrP5CH16i37cbLHF2yyyreUUMaKKBitXuCEr7PGWT1G/K
jSJPJAAGHV5+ZOWGOkI4oWz4T0kbAw/QsZo9/ZxHeQvBfuqn4LAO2Ds=
=EFZL
-----END PGP SIGNATURE-----

--d0LSJiIWTQGS6xeorGqSNSu8xWsKwN9Pt--
