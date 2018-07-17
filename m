Received: from eggs.gnu.org ([2001:4830:134:3::10]:41961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffREn-0001Rm-LN
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffREk-0005rY-GT
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:46:01 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffREk-0005qz-94
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:45:58 -0400
Received: by mail-wr1-x444.google.com with SMTP id c4-v6so1524715wrs.12
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 07:45:58 -0700 (PDT)
References: <20180717022924.25428-1-f4bug@amsat.org>
	<20180717022924.25428-4-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180717022924.25428-4-f4bug@amsat.org>
Date: Tue, 17 Jul 2018 15:45:55 +0100
Message-ID: <8736wh6huk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 3/4] docker: Rename 'amd64' image as
 'host-cross'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  .shippable.yml                                           | 4 ++--
>  tests/docker/Makefile.include                            | 2 +-
>  .../{debian-amd64.docker =3D> debian-host-cross.docker}    | 9
> ++++++---

I'd prefer debian-amd64->debian-host as it's not really a cross
compiler.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>  3 files changed, 9 insertions(+), 6 deletions(-)
>  rename tests/docker/dockerfiles/{debian-amd64.docker =3D> debian-host-cr=
oss.docker} (82%)
>
> diff --git a/.shippable.yml b/.shippable.yml
> index f74a3de3ff..7625ba8f27 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -5,8 +5,8 @@ env:
>    global:
>      - LC_ALL=3DC
>    matrix:
> -    - IMAGE=3Ddebian-amd64
> -      TARGET_LIST=3Dx86_64-softmmu,x86_64-linux-user
> +    - IMAGE=3Ddebian-host-cross
> +      TARGET_LIST=3Daarch64-softmmu,x86_64-softmmu,x86_64-linux-user
>      - IMAGE=3Ddebian-win32-cross
>        TARGET_LIST=3Darm-softmmu,i386-softmmu,lm32-softmmu
>      - IMAGE=3Ddebian-win64-cross
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index b2a7e761cc..2db4190b4c 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -83,7 +83,7 @@ endif
>  # Enforce dependencies for composite images
>  docker-image-debian: docker-image-debian9
>  docker-image-debian8-mxe: docker-image-debian8
> -docker-image-debian-amd64: docker-image-debian9
> +docker-image-debian-host-cross: docker-image-debian9
>  docker-image-debian-armel-cross: docker-image-debian9
>  docker-image-debian-armhf-cross: docker-image-debian9
>  docker-image-debian-arm64-cross: docker-image-debian9
> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/=
dockerfiles/debian-host-cross.docker
> similarity index 82%
> rename from tests/docker/dockerfiles/debian-amd64.docker
> rename to tests/docker/dockerfiles/debian-host-cross.docker
> index d79a599a0d..17d937efc9 100644
> --- a/tests/docker/dockerfiles/debian-amd64.docker
> +++ b/tests/docker/dockerfiles/debian-host-cross.docker
> @@ -1,8 +1,11 @@
>  #
> -# Docker x86_64 target
> +# Docker 'host' target (same architecture than the host)
>  #
> -# This docker target builds on the debian Stretch base image. Further
> -# libraries which are not widely available are installed by hand.
> +# This docker target builds on the debian Stretch base image.
> +#
> +# It is intented to build the host architecture, with as much
> +# features as possible (libraries which are not widely available
> +# are installed by hand).
>  #
>  FROM qemu:debian9
>  MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>


--
Alex Benn=C3=A9e
