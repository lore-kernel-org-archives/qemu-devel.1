Received: from eggs.gnu.org ([2001:4830:134:3::10]:46699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drfv6-00078A-GA
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drfv1-0001xk-LQ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:47:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drfv1-0001uH-Fx
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:47:39 -0400
References: <20170911210129.5874-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8a100b98-79d2-d209-ee7f-9a46ae74b11e@redhat.com>
Date: Tue, 12 Sep 2017 09:47:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170911210129.5874-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] test-qga: add missing qemu-ga tool
 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 11/09/2017 23:01, Philippe Mathieu-Daud=C3=A9 wrote:
> this fixes running 'make check-unit' without running 'make all' beforeh=
and:
>=20
> $ make check-unit
>   ...
>   GTESTER tests/test-qga
> **
> ERROR:tests/test-qga.c:73:fixture_setup: assertion failed (error =3D=3D=
 NULL): Failed to execute child process "/build/qemu/qemu-ga" (No such fi=
le or directory) (g-exec-error-quark, 8)

Queued, thanks.

Paolo

> make: *** [check-tests/test-qga] Error 1
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> occured trying to split Travis jobs to run more/faster
>=20
>  tests/Makefile.include | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index fae5715e9c..59e027f6ea 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -832,7 +832,8 @@ endif
>  qtest-obj-y =3D tests/libqtest.o $(test-util-obj-y)
>  $(check-qtest-y): $(qtest-obj-y)
> =20
> -tests/test-qga: tests/test-qga.o $(qtest-obj-y)
> +tests/test-qga$(EXESUF): qemu-ga$(EXESUF)
> +tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
> =20
>  SPEED =3D quick
>  GTESTER_OPTIONS =3D -k $(if $(V),--verbose,-q)
>=20
