Received: from eggs.gnu.org ([2001:4830:134:3::10]:42130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8tqp-0008Ii-Si
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8tqk-00061V-VV
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:34:15 -0400
Date: Thu, 11 May 2017 15:34:07 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511193407.GG24584@stefanha-x1.localdomain>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-5-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="doKZ0ri6bHmN2Q5y"
Content-Disposition: inline
In-Reply-To: <20170419094356.19826-5-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/16] blockjob: Allow aio context
 change on intermediate nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--doKZ0ri6bHmN2Q5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 05:43:44PM +0800, Fam Zheng wrote:
> The intermediate nodes do work with aio context change, so allow that
> operations.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/commit.c | 3 ++-
>  block/mirror.c | 3 ++-
>  block/stream.c | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--doKZ0ri6bHmN2Q5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFLyvAAoJEJykq7OBq3PIx7QH/0PO8YNHruco2ig8AW54MNVO
2ZEVgjs2AHpq0y9TFfXX2plAAUpT+AGck0vRp8oTFtQ8Oaj6S1wqAQnMCBj3o5eU
W44UIL7EymjLh6Cun/e/5hc4DoGa1z28iOCX7Q7K/oIvO7eh4XISGm8GQ55oTWx7
HvXKmFQcBxMVBgwPRzOr/Bbga6+h4N+zORnTbYqMpRKV6sPneszxpxol5lEmb56f
3UQ4dMGrfd2lYDLyUrNd/d1uVreB2XZNOOU+udTaDQvBlgUPFXohlDgUAefS+IAI
UdPsvN/HJ1p3qP6DfNaZSpfqMhtzihQsIW7VfSEdk4AtIZgbvC0nrGzVmYSmLPw=
=yayK
-----END PGP SIGNATURE-----

--doKZ0ri6bHmN2Q5y--
