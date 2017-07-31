Received: from eggs.gnu.org ([2001:4830:134:3::10]:38493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dc7F2-00068H-JJ
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dc7Ez-0006V2-BY
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:44:00 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dc7Ez-0006Um-56
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:43:57 -0400
Received: by mail-wm0-x243.google.com with SMTP id d40so5832358wma.3
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 02:43:56 -0700 (PDT)
Date: Mon, 31 Jul 2017 10:43:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170731094353.GF11830@stefanha-x1.localdomain>
References: <20170728133631.5449-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Ow488MNN9B9o/ov"
Content-Disposition: inline
In-Reply-To: <20170728133631.5449-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10] trace: ensure .stp files are
 rebuilt if trace tool source changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--1Ow488MNN9B9o/ov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 02:36:31PM +0100, Daniel P. Berrange wrote:
> The make rules for generating the .stp files forgot to add a dep
> on $(tracetool-y) to trigger a rebuild if the trace tool source
> changes.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  Makefile.target | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--1Ow488MNN9B9o/ov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZfvvZAAoJEJykq7OBq3PIPy0H/ja1Y2OkBLMqY1si1MgLncra
1LaSEk0AuDY1lTAmyjWHK/uz2h0eqEucWyC1aqMbh794OGGTkhPsy1iexUKr36q7
kapRZUxTN/AZszZAUjSHftGKcTJELv3VbWfM3KMw0sVrH/1XY1QKIMG/iJ9cj3M3
vmNBUkt26SPzdlZiwhnOTL/RpwxBBD7IctI0859C7YArg8ftTVtxJ89Cs5PSv3PI
JgF6m5SlDFR+4CXJ7JFvSuD0sOzQ8kmp6z5Dx+mGL5ozt93k8q8+LFmz7OAH7uWI
wmh15gWerKs5HRoL75/lJs4xci/IhDn2MrJxM6flRaekJqEi/9MbuSto9nfTmnc=
=l++s
-----END PGP SIGNATURE-----

--1Ow488MNN9B9o/ov--
