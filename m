Received: from eggs.gnu.org ([208.118.235.92]:56997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gf4VN-0007lC-3O
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 10:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gf4VH-0007Zp-HG
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 10:01:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gf4VH-0007Us-9s
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 10:01:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so33834228wrt.11
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 07:01:44 -0800 (PST)
MIME-Version: 1.0
References: <20190103142919.30090-1-philmd@redhat.com>
	<20190103142919.30090-3-philmd@redhat.com>
In-Reply-To: <20190103142919.30090-3-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 3 Jan 2019 16:01:31 +0100
Message-ID: <CAP+75-VZhMYFXZczP1-9i11dn-W1e2YPf=tDoN949m9NZSJb6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: Disable qht-bench parallel test
 when using gprof
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G . Cota" <cota@braap.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On Thu, Jan 3, 2019 at 3:29 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
> This test is failing on the Travis CI [*] since some time now,
> disable it until it get fixed.
>
> [*] https://travis-ci.org/qemu/qemu/builds/474821674
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/Makefile.include | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3f5a1d0c30..e764d8d2cb 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -88,7 +88,8 @@ check-unit-y +=3D tests/test-rcu-simpleq$(EXESUF)
>  check-unit-y +=3D tests/test-rcu-tailq$(EXESUF)
>  check-unit-y +=3D tests/test-qdist$(EXESUF)
>  check-unit-y +=3D tests/test-qht$(EXESUF)
> -check-unit-y +=3D tests/test-qht-par$(EXESUF)
> +# FIXME: {test-qht-par + gprof} often break on Travis CI
> +check-unit-$(call lnot,$(TARGET_GPROF)) +=3D tests/test-qht-par$(EXESUF)

Oops this is incorrect because check-unit isn't target but host, so
TARGET_GPROF can't be used.

>  check-unit-y +=3D tests/test-bitops$(EXESUF)
>  check-unit-y +=3D tests/test-bitcnt$(EXESUF)
>  check-unit-y +=3D tests/test-qdev-global-props$(EXESUF)
> --
> 2.17.2
>
