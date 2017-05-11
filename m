Received: from eggs.gnu.org ([2001:4830:134:3::10]:49655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8uH2-0005qK-OM
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8uGz-0008Cp-N7
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:01:20 -0400
Date: Thu, 11 May 2017 16:01:13 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511200113.GK24584@stefanha-x1.localdomain>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-9-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Tv3+oRj6D9L8lW+H"
Content-Disposition: inline
In-Reply-To: <20170419094356.19826-9-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 08/16] mirror: Request aio
 context change permission on target
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


--Tv3+oRj6D9L8lW+H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 05:43:48PM +0800, Fam Zheng wrote:
> What's done in the source's context change notifier is moving the
> target's context to follow the new one, so we request this permission
> here.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/mirror.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Tv3+oRj6D9L8lW+H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFMMJAAoJEJykq7OBq3PI3QAH/inFxl//kLx3jf249KKN8zvA
U6wxGXZGtrVfwxdEyQXpYG+CY2EpXHdn+x5W9ybIRd4kEr7c+RqGFZ3AFPnnG7cu
LxCiSs/5aHuusO6CXi1/OBN8Iw526OisOPS/qqaJnVWbizY4UvST02HjPqtN2bxU
2JxbmH3ZioNdkOgzz2qeSFrmYJv1xqlFUgBvusT5vLGxibEE2trHZs4bAvme5OuX
yEaWm+O8BE5gxLj3TrKl1W6lQyiVJv5dBOv/UOqGJjrspJqAsmwiG63/EPVujk2a
KSI7t2aRDxe/fIOaYUK7xcBG+pxvhy6L2LAxH/A0eHyY77sS+6yYJsHBgpktnVs=
=cb50
-----END PGP SIGNATURE-----

--Tv3+oRj6D9L8lW+H--
