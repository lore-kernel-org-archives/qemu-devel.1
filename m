Received: from eggs.gnu.org ([2001:4830:134:3::10]:44597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCiCD-0005VX-KL
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCiCA-0005EX-FE
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:32:53 -0400
Date: Wed, 17 Oct 2018 10:32:47 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181017093247.GG22755@stefanha-x1.localdomain>
References: <20181016170938.29303-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ulDeV4rPMk/y39in"
Content-Disposition: inline
In-Reply-To: <20181016170938.29303-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/vhdx: Don't take
 address of fields in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, patches@linaro.org


--ulDeV4rPMk/y39in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 06:09:38PM +0100, Peter Maydell wrote:
> Taking the address of a field in a packed struct is a bad idea, because
> it might not be actually aligned enough for that pointer type (and
> thus cause a crash on dereference on some host architectures). Newer
> versions of clang warn about this. Avoid the bug by not using the
> "modify in place" byte swapping functions.
>=20
> There are a few places where the in-place swap function is
> used on something other than a packed struct field; we convert
> those anyway, for consistency.
>=20
> Patch produced with scripts/coccinelle/inplace-byteswaps.cocci.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Usual disclaimer: produced with "make check" only, but purely
> automated conversion should be safe.
>=20
>  block/vhdx.h        |  12 ++---
>  block/vhdx-endian.c | 118 ++++++++++++++++++++++----------------------
>  block/vhdx-log.c    |   4 +-
>  block/vhdx.c        |  18 +++----
>  4 files changed, 76 insertions(+), 76 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ulDeV4rPMk/y39in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbxwG/AAoJEJykq7OBq3PINfgIAMk6s1eTf8jvzUdEI22Xhryd
UYO0Rtef0sBiz3+gkdEiwXFiq6po/I6p6ipbt78DeLy3voQu2gL+skeVeS2PBEW3
Pp0I/ocWURykeb1u1WGvyyrgY/vccSENM374DSO8oebOFJlfLWwr8ntticohP8h6
yo9wXE40OWX2V7RF31joEnosT0OAuag0zjLaBwnXHyi4l089e+eecjzbFLdJaxCG
63q8TDSGJGlWN5jvJ+f+r0FrINsKUwz700spZDxml5+CBkybetye89Zfhar3yJai
UIOqo148f/HsdytqiTtyUEMq/x+twhdSUYnetUVABNeMhZtJd/2xlEYf/y9QfrQ=
=85DZ
-----END PGP SIGNATURE-----

--ulDeV4rPMk/y39in--
