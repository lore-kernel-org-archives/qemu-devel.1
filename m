Received: from eggs.gnu.org ([209.51.188.92]:54268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ghHF6-0001ik-D8
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ghHEz-0008Qk-1a
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:02:12 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ghHEs-0008Mq-UE
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:01:59 -0500
Received: by mail-wm1-x341.google.com with SMTP id f188so9038102wmf.5
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 09:01:55 -0800 (PST)
References: <20190109163114.17010-1-berrange@redhat.com>
	<20190109163114.17010-10-berrange@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190109163114.17010-10-berrange@redhat.com>
Date: Wed, 09 Jan 2019 17:01:53 +0000
Message-ID: <87zhs9vk72.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/13] travis: move macOS brew setup into
 the macOS matrix entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Fam Zheng <fam@euphon.net>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> There is no need to use shell conditionals to run commands when they can
> simply be listed under the appropriate matrix entry.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  .travis.yml | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index fa70429459..b5f520034f 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -68,9 +68,6 @@ git:
>    submodules: false
>
>
> -before_install:
> -  - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ]; then brew update ; fi
> -  - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ]; then brew install libffi gett=
ext glib pixman ; fi
>  before_script:
>    - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>    - ${SRC_DIR}/configure ${CONFIG} || { cat config.log && exit 1; }
> @@ -171,6 +168,8 @@ matrix:
>        os: osx
>        osx_image: xcode9.4
>        compiler: clang
> +      before_install:
> +        - brew update && brew install libffi gettext glib pixman
>
>
>      - env:
> @@ -178,6 +177,8 @@ matrix:
>        os: osx
>        osx_image: xcode10
>        compiler: clang
> +      before_install:
> +        - brew update && brew install libffi gettext glib pixman

Does this override the global before_install:? I appreciate we've just
cleaned that up but if we add it again....

Regardless there is a homebrew add-ons now we can use.

>
>
>      # Python builds


--
Alex Benn=C3=A9e
