Received: from eggs.gnu.org ([209.51.188.92]:54214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1goau1-0001cA-3X
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:26:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1goau0-0000FB-5g
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:26:41 -0500
References: <20190123144610.8842-1-mreitz@redhat.com>
	<20190123144610.8842-4-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <468692a4-a2e2-55f0-eb49-6dee6be6aee7@redhat.com>
Date: Tue, 29 Jan 2019 16:26:21 -0500
MIME-Version: 1.0
In-Reply-To: <20190123144610.8842-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/9] iotests: Fix 232 for LUKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org



On 1/23/19 9:46 AM, Max Reitz wrote:
> With IMGOPTSSYNTAX, $TEST_IMG is useless for this test (it only tests
> the file-posix protocol driver).  Therefore, if $TEST_IMG_FILE is set,
> use that instead.
>=20
> Because this test requires the file protocol, $TEST_IMG_FILE will alway=
s
> be set if $IMGOPTSSYNTAX is true.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>

This keeps biting us. Or at least, it bit me once and then it has bitten
someone else. It's not obvious that you need to accommodate this when
writing a new test.

For now, anyway, this does give us a new bandaid for a while longer.

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  tests/qemu-iotests/232 | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/232 b/tests/qemu-iotests/232
> index 93e5d641a3..e48bc8f5db 100755
> --- a/tests/qemu-iotests/232
> +++ b/tests/qemu-iotests/232
> @@ -69,6 +69,10 @@ size=3D128M
> =20
>  _make_test_img $size
> =20
> +if [ -n "$TEST_IMG_FILE" ]; then
> +    TEST_IMG=3D$TEST_IMG_FILE
> +fi
> +
>  echo
>  echo "=3D=3D=3D -drive with read-write image: read-only/auto-read-only=
 combinations =3D=3D=3D"
>  echo
>=20

--=20
=E2=80=94js
