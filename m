Received: from eggs.gnu.org ([209.51.188.92]:38902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLkaa-00071J-Sm
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLkaX-0007Qb-RA
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:27:40 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLkaX-0007P0-K8
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:27:37 -0400
Received: by mail-wr1-x441.google.com with SMTP id s15so23804120wra.12
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 01:27:37 -0700 (PDT)
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-4-thuth@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190428155451.15653-4-thuth@redhat.com>
Date: Wed, 01 May 2019 09:27:34 +0100
Message-ID: <87ef5i7f61.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/8] tests/qemu-iotests/check: Pick a
 default machine if necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Ed Maste <emaste@freebsd.org>, Christophe Fergeau <cfergeau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>


Thomas Huth <thuth@redhat.com> writes:

> qemu-system-arm, qemu-system-aarch64 and qemu-system-tricore do not have
> a default machine, so when running the qemu-iotests with such a binary,
> lots of tests are failing. Fix it by picking a default machine in the
> "check" script instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/qemu-iotests/check | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index f9c24b6753..922c5d1d3d 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -130,7 +130,6 @@ export CACHEMODE=3D"writeback"
>  export QEMU_IO_OPTIONS=3D""
>  export QEMU_IO_OPTIONS_NO_FMT=3D""
>  export CACHEMODE_IS_DEFAULT=3Dtrue
> -export QEMU_OPTIONS=3D"-nodefaults -machine accel=3Dqtest"
>  export VALGRIND_QEMU=3D
>  export IMGKEYSECRET=3D
>  export IMGOPTSSYNTAX=3Dfalse
> @@ -564,6 +563,18 @@ then
>  fi
>  export QEMU_PROG=3D"$(type -p "$QEMU_PROG")"
>
> +case "$QEMU_PROG" in
> +    *qemu-system-arm|*qemu-system-aarch64)
> +        export QEMU_OPTIONS=3D"-nodefaults -machine virt,accel=3Dqtest"
> +        ;;
> +    *qemu-system-tricore)
> +        export QEMU_OPTIONS=3D"-nodefaults -machine tricore_testboard,ac=
cel=3Dqtest"
> +        ;;
> +    *)
> +        export QEMU_OPTIONS=3D"-nodefaults -machine accel=3Dqtest"
> +        ;;
> +esac
> +
>  if [ -z "$QEMU_IMG_PROG" ]; then
>      if [ -x "$build_iotests/qemu-img" ]; then
>          export QEMU_IMG_PROG=3D"$build_iotests/qemu-img"


--
Alex Benn=C3=A9e
