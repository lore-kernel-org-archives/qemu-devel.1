Received: from eggs.gnu.org ([209.51.188.92]:53495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ghsR3-00015C-99
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ghsR2-0005LT-1Z
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:45:01 -0500
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:35315)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ghsR1-0005Jz-RL
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:44:59 -0500
Received: from player732.ha.ovh.net (unknown [10.109.143.145])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id D0AAD20E907
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 09:44:57 +0100 (CET)
Date: Fri, 11 Jan 2019 09:44:44 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190111094444.11ef8b47@bahia.lan>
In-Reply-To: <1547194672-24169-4-git-send-email-thuth@redhat.com>
References: <1547194672-24169-1-git-send-email-thuth@redhat.com>
	<1547194672-24169-4-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, pbonzini@redhat.com, qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 11 Jan 2019 09:17:52 +0100
Thomas Huth <thuth@redhat.com> wrote:

> Different versions of GCC and Clang use different versions of the C stand=
ard.
> This repeatedly caused problems already, e.g. with duplicated typedefs:
>=20
>  https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.html
>=20
> or with for-loop variable initializers:
>=20
>  https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00237.html
>=20
> To avoid these problems, we should enforce the C language version to the
> same level for all compilers. Since our minimum compiler versions is
> GCC v4.8, our best option is "gnu99" for C code right now ("gnu17" is not
> available there yet, and "gnu11" is marked as "experimental"), and "gnu++=
98"
> for the few C++ code that we have in the repository.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  configure | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
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
