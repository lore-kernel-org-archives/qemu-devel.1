Received: from eggs.gnu.org ([209.51.188.92]:32886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwQ96-0008FJ-0P
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:34:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwQ94-0003lL-5t
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:34:35 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwQ8z-0002dK-W1
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:34:32 -0500
Received: by mail-wm1-x344.google.com with SMTP id v26so6081893wmh.3
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 03:34:23 -0800 (PST)
References: <20190220105131.23479-1-pbonzini@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190220105131.23479-1-pbonzini@redhat.com>
Date: Wed, 20 Feb 2019 11:34:20 +0000
Message-ID: <87y36a4rsz.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] travis: the xcode10 image seems to be
 hosed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org


Paolo Bonzini <pbonzini@redhat.com> writes:

> It fails to install homebrew.  Unfortunately we cannot mark
> it as an expected failure because Travis does not match
> allow_failures rows against include rows (only against the
> main test matrix, which we do not use at all), so just disable
> it.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Queued to testing/next (merged with v1), thanks.

> ---
>  .travis.yml | 15 ---------------
>  1 file changed, 15 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index a7ab72b43b..866a1872b1 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -174,13 +174,6 @@ matrix:
>        compiler: clang
>
>
> -    - env:
> -        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softm=
mu,m68k-softmmu,x86_64-softmmu"
> -      os: osx
> -      osx_image: xcode10
> -      compiler: clang
> -
> -
>      # Python builds
>      - env:
>          - CONFIG=3D"--target-list=3Dx86_64-softmmu"
> @@ -254,11 +247,3 @@ matrix:
>      - env:
>          - CONFIG=3D"--disable-system"
>          - TEST_CMD=3D"make -j3 check-tcg V=3D1"
> -
> -
> -  allow_failures:
> -    - env:
> -        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softm=
mu,m68k-softmmu,x86_64-softmmu"
> -      os: osx
> -      osx_image: xcode10
> -      compiler: clang


--
Alex Benn=C3=A9e
