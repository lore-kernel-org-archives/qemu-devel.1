Received: from eggs.gnu.org ([2001:4830:134:3::10]:54507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1csX0D-000459-04
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1csX0B-0007lQ-W5
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:56:17 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1csX0B-0007kY-Q8
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:56:15 -0400
Received: by mail-wr0-x241.google.com with SMTP id 20so14494975wrx.0
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 08:56:15 -0700 (PDT)
Date: Mon, 27 Mar 2017 16:56:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170327155612.GF28620@stefanha-x1.localdomain>
References: <1490583036-3683-1-git-send-email-Ashish.Mittal@veritas.com>
	<1490583036-3683-2-git-send-email-Ashish.Mittal@veritas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yH1ZJFh+qWm+VodA"
Content-Disposition: inline
In-Reply-To: <1490583036-3683-2-git-send-email-Ashish.Mittal@veritas.com>
Subject: Re: [Qemu-devel] [PATCH v10 2/2] block/vxhs.c: Add qemu-iotests for
 new block device type "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashish Mittal <ashmit602@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com, jcody@redhat.com, famz@redhat.com, ashish.mittal@veritas.com, Ketan.Nilangekar@veritas.com, jferlan@redhat.com, Buddhi.Madhav@veritas.com, Suraj.Singh@veritas.com, Nitin.Jerath@veritas.com, peter.maydell@linaro.org, venkatesha.mg@veritas.com, Abhijit.Dey@veritas.com


--yH1ZJFh+qWm+VodA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 26, 2017 at 07:50:36PM -0700, Ashish Mittal wrote:
> These changes use a vxhs test server that is a part of the following
> repository:
> https://github.com/VeritasHyperScale/libqnio.git
>=20
> Signed-off-by: Ashish Mittal <Ashish.Mittal@veritas.com>
> ---
> v10 changelog:
> (1) Redirect o/p of "$QEMU_VXHS -d  $TEST_DIR" to /dev/null
>=20
> v9 changelog:
> (1) Dropped second argument to set_prog_path(). We will pick up the test
>     server location from the user's PATH env setting.
>=20
> v8/v7 changelog:
> (1) No changes.
>=20
> v6 changelog:
> (1) Added iotests for VxHS block device.
>=20
>  tests/qemu-iotests/common        |  6 ++++++
>  tests/qemu-iotests/common.config | 13 +++++++++++++
>  tests/qemu-iotests/common.filter |  1 +
>  tests/qemu-iotests/common.rc     | 19 +++++++++++++++++++
>  4 files changed, 39 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--yH1ZJFh+qWm+VodA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY2TYcAAoJEJykq7OBq3PIrMgIAKxjtCA1JdnuQyHxAbT61EyA
Z4LcjgnZKGafU8QjRz1HBgQg/by8MfDBd1FntFclNYrVZ0YT4q7OMzB7W68E6xHi
j4Y3Lxrb2WIkQR9f7cB1S6xLxCl9prvsk8/E+QrMgnbE/cqoLrt2o5sWIQvU4Br/
yOUZ5ebojN2+iF7ViH8Y/OGX3AjGyDbOcHXaN+JHLumhHW4IF45Gh7+JGLqQU2EY
ZjCR++hweqrdFzB0FMncCZSGEmi1mDx/g/l/PiXEiAwCV9Zy4roiRbziOqiyHsxN
x/E3a7/4GZpGKA6bUWoM4xZfxIAFe/cqIgmylnTzLf5y6JFu4hG+PXw/fgN4zK4=
=t3Q6
-----END PGP SIGNATURE-----

--yH1ZJFh+qWm+VodA--
