Received: from eggs.gnu.org ([2001:4830:134:3::10]:59701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eblNI-0006HX-4m
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:55:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eblNF-0004em-0A
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:55:20 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:42954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eblNE-0004c0-Lw
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:55:16 -0500
Received: by mail-wr0-x241.google.com with SMTP id e41so18030112wre.9
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 02:55:16 -0800 (PST)
References: <20180115143500.22631-1-f4bug@amsat.org>
	<20180115143500.22631-8-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180115143500.22631-8-f4bug@amsat.org>
Date: Wed, 17 Jan 2018 10:55:13 +0000
Message-ID: <877esgoium.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/8] docker: warn users to use newer
 fedora25/fedora27 base image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> deprecate the generic 'fedora' image, but stay backward incompatible
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

What clashed with this?

> ---
>  tests/docker/Makefile.include            |  3 ++-
>  tests/docker/dockerfiles/fedora.docker   | 29 ++++++++++++--------------=
---
>  tests/docker/dockerfiles/fedora25.docker | 18 ++++++++++++++++++
>  3 files changed, 32 insertions(+), 18 deletions(-)
>  create mode 100644 tests/docker/dockerfiles/fedora25.docker
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 1adea40499..950ef51d35 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -4,7 +4,7 @@
>
>  DOCKER_SUFFIX :=3D .docker
>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
> -DOCKER_DEPRECATED_IMAGES :=3D debian ubuntu
> +DOCKER_DEPRECATED_IMAGES :=3D debian fedora ubuntu
>  DOCKER_IMAGES :=3D $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(not=
dir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>  # Use a global constant ccache directory to speed up repetitive builds
> @@ -61,6 +61,7 @@ docker-image-debian-ppc64el-cross: docker-image-debian9
>  docker-image-debian-s390x-cross: docker-image-debian9
>  docker-image-debian-win32-cross: docker-image-debian8-mxe
>  docker-image-debian-win64-cross: docker-image-debian8-mxe
> +docker-image-fedora: docker-image-fedora25
>  docker-image-ubuntu: docker-image-ubuntu16.04
>  docker-image-travis: NOUSER=3D1
>
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docker=
files/fedora.docker
> index 4b26c3aded..961534275f 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -1,18 +1,13 @@
> -FROM fedora:latest
> -ENV PACKAGES \
> -    ccache gettext git tar PyYAML sparse flex bison python2 bzip2 hostna=
me \
> -    glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
> -    gcc gcc-c++ clang make perl which bc findutils libaio-devel \
> -    nettle-devel \
> -    mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-con=
fig \
> -    mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libt=
asn1 \
> -    mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2 \
> -    mingw32-bzip2 \
> -    mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL mingw64-pkg-con=
fig \
> -    mingw64-gtk2 mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libt=
asn1 \
> -    mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2 \
> -    mingw64-bzip2
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# This template is deprecated, it was previously based on Fedora 25 on Q=
EMU 2.9.
> +# Now than more recent releases are out, please use qemu:fedora25 as bas=
e for
> +# Fedora 25.
> +#
> +FROM qemu:fedora25
>
> -RUN dnf install -y $PACKAGES
> -RUN rpm -q $PACKAGES | sort > /packages.txt
> -ENV FEATURES mingw clang pyyaml
> +RUN for n in $(seq 8); do echo; done && \
> +    echo "\n\t\tThis image is deprecated." && echo && \
> +    echo "\tUse 'FROM qemu:fedora27' to use the Fedora 27 image" && \
> +    echo "\tor 'FROM qemu:fedora25' to use the old Fedora 25." && \
> +    for n in $(seq 8); do echo; done
> diff --git a/tests/docker/dockerfiles/fedora25.docker b/tests/docker/dock=
erfiles/fedora25.docker
> new file mode 100644
> index 0000000000..b53fe63b5c
> --- /dev/null
> +++ b/tests/docker/dockerfiles/fedora25.docker
> @@ -0,0 +1,18 @@
> +FROM fedora:25
> +ENV PACKAGES \
> +    ccache gettext git tar PyYAML sparse flex bison python2 bzip2 hostna=
me \
> +    glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
> +    gcc gcc-c++ clang make perl which bc findutils libaio-devel \
> +    nettle-devel \
> +    mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-con=
fig \
> +    mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libt=
asn1 \
> +    mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2 \
> +    mingw32-bzip2 \
> +    mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL mingw64-pkg-con=
fig \
> +    mingw64-gtk2 mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libt=
asn1 \
> +    mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2 \
> +    mingw64-bzip2
> +
> +RUN dnf install -y $PACKAGES
> +RUN rpm -q $PACKAGES | sort > /packages.txt
> +ENV FEATURES mingw clang pyyaml


--
Alex Benn=C3=A9e
