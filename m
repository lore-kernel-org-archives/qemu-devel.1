Received: from eggs.gnu.org ([209.51.188.92]:36703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzlBF-0004dR-2k
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzlBE-0002dg-CR
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:38:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gzlBE-0002d8-4E
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:38:36 -0500
References: <20190301163518.20702-1-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7f843d10-393c-0a85-38b5-ae93677503b2@redhat.com>
Date: Fri, 1 Mar 2019 17:38:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190301163518.20702-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: add missing support status
 fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 01/03/2019 17.35, Stefan Hajnoczi wrote:
> This patch adds the "S:" line for areas of the codebase that currently
> lack a support status field.
>=20
> Note that there are a few more areas that are more abstract and do not
> correspond to a specific set of files.  They have not been modified.
>=20
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d941cb3862..2464f51879 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -338,6 +338,7 @@ F: include/hw/tricore/
> =20
>  Multiarch Linux User Tests
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> +S: Maintained
>  F: tests/tcg/multiarch/
> =20
>  Guest CPU Cores (KVM):
> @@ -2094,6 +2095,7 @@ F: qemu.sasl
>  Coroutines
>  M: Stefan Hajnoczi <stefanha@redhat.com>
>  M: Kevin Wolf <kwolf@redhat.com>
> +S: Maintained
>  F: util/*coroutine*
>  F: include/qemu/coroutine*
>  F: tests/test-coroutine.c
> @@ -2528,6 +2530,7 @@ F: .gitlab-ci.yml
>  Guest Test Compilation Support
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>  R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> +S: Maintained
>  F: tests/tcg/Makefile
>  F: tests/tcg/Makefile.include
>  L: qemu-devel@nongnu.org
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
