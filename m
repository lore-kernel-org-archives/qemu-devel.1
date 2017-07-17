Received: from eggs.gnu.org ([2001:4830:134:3::10]:45630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dXEnl-0001hA-JC
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dXEni-00075i-ET
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:47:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dXEni-00074l-5j
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:47:38 -0400
Date: Tue, 18 Jul 2017 06:47:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170717224734.GC2585@lemon>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
	<20170717144848.11793-6-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170717144848.11793-6-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 05/23] docker: rename debian stable -> 9
 (Stretch)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Mon, 07/17 15:48, Alex Benn=E9e wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Why?

>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include                              |  6 +++---
>  tests/docker/dockerfiles/debian-arm64-cross.docker         |  4 ++--
>  tests/docker/dockerfiles/debian-armhf-cross.docker         |  4 ++--
>  tests/docker/dockerfiles/debian-mipsel-cross.docker        |  4 ++--
>  tests/docker/dockerfiles/{debian.docker =3D> debian9.docker} | 13 ++++=
+++++----
>  5 files changed, 18 insertions(+), 13 deletions(-)
>  rename tests/docker/dockerfiles/{debian.docker =3D> debian9.docker} (6=
2%)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 012a2fc1af..72bb52ad7b 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -56,9 +56,9 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  		"BUILD","$*")
> =20
>  # Enforce dependancies for composite images
> -docker-image-debian-armhf-cross: docker-image-debian
> -docker-image-debian-arm64-cross: docker-image-debian
> -docker-image-debian-mipsel-cross: docker-image-debian
> +docker-image-debian-armhf-cross: docker-image-debian9
> +docker-image-debian-arm64-cross: docker-image-debian9
> +docker-image-debian-mipsel-cross: docker-image-debian9
> =20
>  # Expand all the pre-requistes for each docker image and test combinat=
ion
>  $(foreach i,$(DOCKER_IMAGES), \
> diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests=
/docker/dockerfiles/debian-arm64-cross.docker
> index 45b891d57a..f1bfa64160 100644
> --- a/tests/docker/dockerfiles/debian-arm64-cross.docker
> +++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
> @@ -1,9 +1,9 @@
>  #
>  # Docker arm64 cross-compiler target
>  #
> -# This docker target builds on the base debian image.
> +# This docker target builds on the debian Stretch base image.
>  #
> -FROM qemu:debian
> +FROM qemu:debian9
> =20
>  # Add the foreign architecture we want and install dependencies
>  RUN dpkg --add-architecture arm64
> diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests=
/docker/dockerfiles/debian-armhf-cross.docker
> index e67dfdccc5..2beacef49b 100644
> --- a/tests/docker/dockerfiles/debian-armhf-cross.docker
> +++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
> @@ -1,9 +1,9 @@
>  #
>  # Docker armhf cross-compiler target
>  #
> -# This docker target builds on the base debian image.
> +# This docker target builds on the debian Stretch base image.
>  #
> -FROM qemu:debian
> +FROM qemu:debian9
> =20
>  # Add the foreign architecture we want and install dependencies
>  RUN dpkg --add-architecture armhf
> diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/test=
s/docker/dockerfiles/debian-mipsel-cross.docker
> index 2156bdb28d..9ee997aa54 100644
> --- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
> +++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
> @@ -1,9 +1,9 @@
>  #
>  # Docker mipsel cross-compiler target
>  #
> -# This docker target builds on the base debian image.
> +# This docker target builds on the debian Stretch base image.
>  #
> -FROM qemu:debian
> +FROM qemu:debian9
>  MAINTAINER Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> =20
>  # Add the foreign architecture we want and install dependencies
> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dock=
erfiles/debian9.docker
> similarity index 62%
> rename from tests/docker/dockerfiles/debian.docker
> rename to tests/docker/dockerfiles/debian9.docker
> index 10953b2425..c74f71283c 100644
> --- a/tests/docker/dockerfiles/debian.docker
> +++ b/tests/docker/dockerfiles/debian9.docker
> @@ -1,13 +1,13 @@
>  #
>  # Docker multiarch cross-compiler target
>  #
> -# This docker target is builds on Debian and Emdebian's cross compiler=
 targets
> -# to build distro with a selection of cross compilers for building tes=
t binaries.
> +# This docker target is builds on Debian cross compiler targets to bui=
ld distro
> +# with a selection of cross compilers for building test binaries.
>  #
>  # On its own you can't build much but the docker-foo-cross targets
>  # build on top of the base debian image.
>  #
> -FROM debian:stable-slim
> +FROM debian:stretch-slim
> =20
>  # Duplicate deb line as deb-src
>  RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/s=
ources.list
> @@ -17,4 +17,9 @@ RUN apt update
>  RUN DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata
>  RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>      apt install -y --no-install-recommends \
> -    ca-certificates build-essential clang git bison flex
> +        bison \
> +        build-essential \
> +        ca-certificates \
> +        clang \
> +        flex \
> +        git
> --=20
> 2.13.0
>=20

Fam
