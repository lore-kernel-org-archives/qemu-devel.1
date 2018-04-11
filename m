Received: from eggs.gnu.org ([2001:4830:134:3::10]:36092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6Hra-0001OG-DD
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6HrZ-0003eG-M7
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:40:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43316 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f6HrZ-0003e3-Hw
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:40:45 -0400
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-18-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <da2a3e61-7ccc-b81b-7a99-4ab7478d193c@redhat.com>
Date: Wed, 11 Apr 2018 17:40:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 17/24] tests/tcg: move ARM specific
 tests into subdir
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
> These only need to be built for ARM guests.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/README                      |  9 ---------
>  tests/tcg/arm/README                  | 11 +++++++++++
>  tests/tcg/{ =3D> arm}/hello-arm.c       |  0
>  tests/tcg/{ =3D> arm}/test-arm-iwmmxt.s |  0
>  4 files changed, 11 insertions(+), 9 deletions(-)
>  create mode 100644 tests/tcg/arm/README
>  rename tests/tcg/{ =3D> arm}/hello-arm.c (100%)
>  rename tests/tcg/{ =3D> arm}/test-arm-iwmmxt.s (100%)

Reviewed-by: Thomas Huth <thuth@redhat.com>
