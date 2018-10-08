Received: from eggs.gnu.org ([2001:4830:134:3::10]:53794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g9YaD-0000Xf-0A
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:40:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g9Ya9-0004m6-Tj
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:40:37 -0400
Received: from mail-yw1-f47.google.com ([209.85.161.47]:35757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g9Ya9-0004lx-Od
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:40:33 -0400
Received: by mail-yw1-f47.google.com with SMTP id y76-v6so8333674ywd.2
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 09:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181008152059.17503-1-alex.bennee@linaro.org>
In-Reply-To: <20181008152059.17503-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 8 Oct 2018 18:40:21 +0200
Message-ID: <CAAdtpL7gSaza9RVY4f_e4NbXCC+J1YKiR0AS4TRExgiTauw0kQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] .travis.yml: split MacOSX builds and
 reduce target list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>

Hi Alex,

On Mon, Oct 8, 2018 at 5:21 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
> We have reached the point where the MacOSX build was regularly timing
> out. So as before I've reduced the target list to "major"
> architectures to try and bring the build time down. I've added an
> additional MacOSX build with the latest XCode with a minimal list of
> "most likely" targets on MacOS.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .travis.yml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 95be6ec59f..13a09facd3 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -107,8 +107,14 @@ matrix:
>      - env: CONFIG=3D"--disable-tcg"
>             TEST_CMD=3D""
>        compiler: gcc
> -    - env: CONFIG=3D""
> +    # MacOSX builds
> +    - env: CONFIG=3D"--target-list=3Daarch64-softmmu,arm-softmmu,i386-so=
ftmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softm=
mu,x86_64-softmmu"
>        os: osx
> +      osx_image: xcode9.4
> +      compiler: clang
> +    - env: CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-soft=
mmu,m68k-softmmu,x86_64-softmmu"
> +      os: osx
> +      osx_image: xcode10

I'd also add another entry with --enable-user.

>        compiler: clang
>      # Python builds
>      - env: CONFIG=3D"--target-list=3Dx86_64-softmmu"
> --
> 2.17.1
>
