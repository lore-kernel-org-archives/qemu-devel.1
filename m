Received: from eggs.gnu.org ([209.51.188.92]:42596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj4DQ-0006vT-1p
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:31:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj4DO-0002An-9Q
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:31:52 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:52445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj4DO-00029C-3L
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:31:50 -0500
Received: by mail-wm1-x335.google.com with SMTP id m1so9378121wml.2
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 07:31:50 -0800 (PST)
References: <20190114150129.1013-1-alex.bennee@linaro.org>
	<20190114150129.1013-22-alex.bennee@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190114150129.1013-22-alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 15:31:46 +0000
Message-ID: <874labp865.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 21/21] Revert "tests: Disable qht-bench
 parallel test when using gprof"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, =?utf-8?Q?Da?= =?utf-8?Q?niel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> This reverts commit ce2eefd7c21697fee87a0686353de881081d22c6. The
> underlying cause was fixed with eb4f8e100f.

A quick flurry of comments came just after I posted the PR. Should I
re-spin v2 without the last minute clean-up? I just worry this sticking
plaster is:

 a) a bit hacky, introducing a new build glag
 b) might end up masking stuff we want to catch

>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> diff --git a/configure b/configure
> index 4ea3f14883..f59d484f7a 100755
> --- a/configure
> +++ b/configure
> @@ -7487,7 +7487,6 @@ alpha)
>  esac
>
>  if test "$gprof" =3D "yes" ; then
> -  echo "CONFIG_GPROF=3Dy" >> $config_host_mak
>    echo "TARGET_GPROF=3Dy" >> $config_target_mak
>    if test "$target_linux_user" =3D "yes" ; then
>      cflags=3D"-p $cflags"
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 601ef4f64c..f403a6571d 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -88,8 +88,7 @@ check-unit-y +=3D tests/test-rcu-simpleq$(EXESUF)
>  check-unit-y +=3D tests/test-rcu-tailq$(EXESUF)
>  check-unit-y +=3D tests/test-qdist$(EXESUF)
>  check-unit-y +=3D tests/test-qht$(EXESUF)
> -# FIXME: {test-qht-par + gprof} often break on Travis CI
> -check-unit-$(call lnot,$(CONFIG_GPROF)) +=3D tests/test-qht-par$(EXESUF)
> +check-unit-y +=3D tests/test-qht-par$(EXESUF)
>  check-unit-y +=3D tests/test-bitops$(EXESUF)
>  check-unit-y +=3D tests/test-bitcnt$(EXESUF)
>  check-unit-y +=3D tests/test-qdev-global-props$(EXESUF)


--
Alex Benn=C3=A9e
