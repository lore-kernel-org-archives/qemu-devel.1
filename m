Received: from eggs.gnu.org ([2001:4830:134:3::10]:50495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gZjUC-0003nU-5c
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 16:34:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gZjU7-0006Bt-LI
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 16:34:36 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gZjU7-0006Bh-Gi
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 16:34:31 -0500
Received: by mail-yb1-f194.google.com with SMTP id d2so8472434ybs.11
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 13:34:31 -0800 (PST)
MIME-Version: 1.0
References: <20170809202712.6951-1-f4bug@amsat.org>
	<20170809202712.6951-13-f4bug@amsat.org>
In-Reply-To: <20170809202712.6951-13-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 19 Dec 2018 22:34:19 +0100
Message-ID: <CAAdtpL7UE2dGie9zYOx3=L98vFr16dyrk2cdLZi1Nu58i+9DOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11 v3 12/16] travis/osx: silent
 texinfo warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Hey Alex, Peter, what do you think about this patch?

On Wed, Aug 9, 2017 at 10:27 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
>   $ make info
>     GEN     qemu-doc.html
>   qemu-doc.texi:8: warning: unrecognized encoding name `UTF-8'.
>     GEN     qemu-doc.txt
>   qemu-doc.texi:8: warning: unrecognized encoding name `UTF-8'.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  .travis.yml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 4bf69b0116..24f62fb7cf 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -74,9 +74,11 @@ git:
>    # we want to do this ourselves
>    submodules: false
>  before_install:
> +  # silent texinfo warnings (https://github.com/xiaohanyu/oh-my-emacs/bl=
ob/c664894e2f1c1cb0f95a9f2da88d41b00f190856/core/ome-basic.org#homebrew)
>    - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ]; then
>          brew update ;
> -        brew install libffi gettext glib pixman ;
> +        brew install libffi gettext glib pixman texinfo ;
> +        brew link texinfo --force ;
>      fi
>    - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-s=
eed.tar.xz | tar -xvJ
>    - travis_retry git submodule update --init --recursive
> --
> 2.13.3
>
