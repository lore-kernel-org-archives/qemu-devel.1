Received: from eggs.gnu.org ([2001:4830:134:3::10]:51508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1drWht-00050n-QG
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1drWhs-000381-RT
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:57:29 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:36102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1drWhs-00037m-Lg
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:57:28 -0400
Received: by mail-io0-x244.google.com with SMTP id n69so2882355ioi.3
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 14:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20170911210129.5874-1-f4bug@amsat.org>
In-Reply-To: <20170911210129.5874-1-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 11 Sep 2017 21:57:17 +0000
Message-ID: <CAJ+F1CK_jv6gemRdrhK75ZYa7qT0hoCACtkmcO_-pT0atYs8_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Sep 11, 2017 at 11:02 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> this fixes running 'make check-unit' without running 'make all' beforehan=
d:
>
> $ make check-unit
>   ...
>   GTESTER tests/test-qga
> **
> ERROR:tests/test-qga.c:73:fixture_setup: assertion failed (error =3D=3D N=
ULL):
> Failed to execute child process "/build/qemu/qemu-ga" (No such file or
> directory) (g-exec-error-quark, 8)
> make: *** [check-tests/test-qga] Error 1
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
> occured trying to split Travis jobs to run more/faster
>
>  tests/Makefile.include | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index fae5715e9c..59e027f6ea 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -832,7 +832,8 @@ endif
>  qtest-obj-y =3D tests/libqtest.o $(test-util-obj-y)
>  $(check-qtest-y): $(qtest-obj-y)
>
> -tests/test-qga: tests/test-qga.o $(qtest-obj-y)
> +tests/test-qga$(EXESUF): qemu-ga$(EXESUF)
> +tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
>
>  SPEED =3D quick
>  GTESTER_OPTIONS =3D -k $(if $(V),--verbose,-q)
> --
> 2.14.1
>
>
> --
Marc-Andr=C3=A9 Lureau
