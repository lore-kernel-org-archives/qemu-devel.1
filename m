Received: from eggs.gnu.org ([209.51.188.92]:51531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ghuTh-0004Cj-NJ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:55:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ghuTg-0005Yw-NM
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:55:53 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ghuTe-0005Y4-TN
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:55:52 -0500
Received: by mail-wm1-x342.google.com with SMTP id m1so1949061wml.2
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 02:55:50 -0800 (PST)
References: <1547194672-24169-1-git-send-email-thuth@redhat.com>
	<1547194672-24169-4-git-send-email-thuth@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1547194672-24169-4-git-send-email-thuth@redhat.com>
Date: Fri, 11 Jan 2019 10:55:47 +0000
Message-ID: <87tvifv4y4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/3] configure: Force the C standard to
 gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>


Thomas Huth <thuth@redhat.com> writes:

> Different versions of GCC and Clang use different versions of the C stand=
ard.
> This repeatedly caused problems already, e.g. with duplicated typedefs:
>
>  https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.html
>
> or with for-loop variable initializers:
>
>  https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00237.html
>
> To avoid these problems, we should enforce the C language version to the
> same level for all compilers. Since our minimum compiler versions is
> GCC v4.8, our best option is "gnu99" for C code right now ("gnu17" is not
> available there yet, and "gnu11" is marked as "experimental"), and "gnu++=
98"
> for the few C++ code that we have in the repository.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index cf763d4..f0b5dcd 100755
> --- a/configure
> +++ b/configure
> @@ -107,6 +107,9 @@ update_cxxflags() {
>              -Wstrict-prototypes|-Wmissing-prototypes|-Wnested-externs|\
>              -Wold-style-declaration|-Wold-style-definition|-Wredundant-d=
ecls)
>                  ;;
> +            -std=3Dgnu99)
> +                QEMU_CXXFLAGS=3D${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }"-std=
=3Dgnu++98"
> +                ;;
>              *)
>                  QEMU_CXXFLAGS=3D${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }$arg
>                  ;;
> @@ -585,7 +588,7 @@ ARFLAGS=3D"${ARFLAGS-rv}"
>  # left shift of signed integers is well defined and has the expected
>  # 2s-complement style results. (Both clang and gcc agree that it
>  # provides these semantics.)
> -QEMU_CFLAGS=3D"-fno-strict-aliasing -fno-common -fwrapv $QEMU_CFLAGS"
> +QEMU_CFLAGS=3D"-fno-strict-aliasing -fno-common -fwrapv -std=3Dgnu99 $QE=
MU_CFLAGS"
>  QEMU_CFLAGS=3D"-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_=
CFLAGS"
>  QEMU_CFLAGS=3D"-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
>  QEMU_CFLAGS=3D"-D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURC=
E $QEMU_CFLAGS"


Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
