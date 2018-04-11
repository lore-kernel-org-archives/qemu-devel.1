Received: from eggs.gnu.org ([2001:4830:134:3::10]:52897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6Ctb-0001Xo-Fj
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6CtW-0005mA-ND
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:22:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47476 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f6CtW-0005l0-Hw
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:22:26 -0400
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-10-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <150ad4ec-f324-3054-e6f0-2104eea357c9@redhat.com>
Date: Wed, 11 Apr 2018 12:22:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 09/24] tests/tcg: move architecture
 independent tests into subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: famz@redhat.com, cota@braap.org

On 10.04.2018 21:39, Alex Benn=C3=A9e wrote:
> We will want to build these for all supported guest architectures so
> lets move them all into one place. We also drop test_path at this
> point because it needs qemu utils and glib bits which is hard to
> support for cross compiling.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/README                       |  10 +--
>  tests/tcg/multiarch/README             |   1 +
>  tests/tcg/{ =3D> multiarch}/linux-test.c |   0
>  tests/tcg/{ =3D> multiarch}/sha1.c       |   0
>  tests/tcg/{ =3D> multiarch}/test-mmap.c  |   0
>  tests/tcg/{ =3D> multiarch}/testthread.c |   0
>  tests/tcg/test_path.c                  | 157 -------------------------=
--------
>  7 files changed, 5 insertions(+), 163 deletions(-)
>  create mode 100644 tests/tcg/multiarch/README
>  rename tests/tcg/{ =3D> multiarch}/linux-test.c (100%)
>  rename tests/tcg/{ =3D> multiarch}/sha1.c (100%)
>  rename tests/tcg/{ =3D> multiarch}/test-mmap.c (100%)
>  rename tests/tcg/{ =3D> multiarch}/testthread.c (100%)
>  delete mode 100644 tests/tcg/test_path.c

Reviewed-by: Thomas Huth <thuth@redhat.com>
