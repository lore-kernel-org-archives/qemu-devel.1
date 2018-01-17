Received: from eggs.gnu.org ([2001:4830:134:3::10]:38347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ebmYk-0000Nm-TW
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 07:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ebmYh-0001Hv-OH
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 07:11:14 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:39701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ebmYh-0001HF-F9
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 07:11:11 -0500
Received: by mail-wr0-x243.google.com with SMTP id z48so18579839wrz.6
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 04:11:11 -0800 (PST)
References: <20180115143500.22631-1-f4bug@amsat.org>
	<20180115143500.22631-6-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180115143500.22631-6-f4bug@amsat.org>
Date: Wed, 17 Jan 2018 12:11:08 +0000
Message-ID: <871sioofc3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/8] docker: warn users to use
 ubuntu16.04 for the LTS Xenial image
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

> deprecate the generic 'ubuntu' image, but stay backward incompatible
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/docker/Makefile.include               |  3 ++-
>  tests/docker/dockerfiles/ubuntu.docker      | 26 ++++++++++-------------=
---
>  tests/docker/dockerfiles/ubuntu16.04.docker | 16 ++++++++++++++++
>  3 files changed, 28 insertions(+), 17 deletions(-)
>  create mode 100644 tests/docker/dockerfiles/ubuntu16.04.docker
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index d5cf896966..1adea40499 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -4,7 +4,7 @@
>
>  DOCKER_SUFFIX :=3D .docker
>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
> -DOCKER_DEPRECATED_IMAGES :=3D debian
> +DOCKER_DEPRECATED_IMAGES :=3D debian ubuntu
>  DOCKER_IMAGES :=3D $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(not=
dir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>  # Use a global constant ccache directory to speed up repetitive builds
> @@ -61,6 +61,7 @@ docker-image-debian-ppc64el-cross: docker-image-debian9
>  docker-image-debian-s390x-cross: docker-image-debian9
>  docker-image-debian-win32-cross: docker-image-debian8-mxe
>  docker-image-debian-win64-cross: docker-image-debian8-mxe
> +docker-image-ubuntu: docker-image-ubuntu16.04
>  docker-image-travis: NOUSER=3D1
>
>  # Expand all the pre-requistes for each docker image and test combination
> diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/docker=
files/ubuntu.docker
> index 686d90ae8c..808ea2bf38 100644
> --- a/tests/docker/dockerfiles/ubuntu.docker
> +++ b/tests/docker/dockerfiles/ubuntu.docker
> @@ -1,16 +1,10 @@
> -FROM ubuntu:16.04
> -RUN apt-get update
> -ENV PACKAGES flex bison \
> -    libusb-1.0-0-dev libiscsi-dev librados-dev libncurses5-dev libncurse=
sw5-dev \
> -    libseccomp-dev libgnutls-dev libssh2-1-dev  libspice-server-dev \
> -    libspice-protocol-dev libnss3-dev libfdt-dev \
> -    libgtk-3-dev libvte-2.91-dev libsdl1.2-dev libpng12-dev libpixman-1-=
dev \
> -    libvdeplug-dev liblzo2-dev libsnappy-dev libbz2-dev libxen-dev librd=
macm-dev libibverbs-dev \
> -    libsasl2-dev libjpeg-turbo8-dev xfslibs-dev libcap-ng-dev libbrlapi-=
dev libcurl4-gnutls-dev \
> -    libbluetooth-dev librbd-dev libaio-dev glusterfs-common libnuma-dev =
libepoxy-dev libdrm-dev libgbm-dev \
> -    libjemalloc-dev libcacard-dev libusbredirhost-dev libnfs-dev libcap-=
dev libattr1-dev \
> -    texinfo \
> -    gettext git make ccache python-yaml gcc clang sparse
> -RUN apt-get -y install $PACKAGES
> -RUN dpkg -l $PACKAGES | sort > /packages.txt
> -ENV FEATURES clang pyyaml
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# This template is deprecated, it was previously based on Xenial on QEMU=
 2.11.
> +#
> +FROM qemu:ubuntu16.04
> +
> +RUN for n in $(seq 8); do echo; done && \
> +    echo "\n\t\tThis image is deprecated." && echo && \
> +    echo "\tUse 'FROM qemu:ubuntu16.04' to use the Ubuntu Xenial LTS ima=
ge" && \
> +    for n in $(seq 8); do echo; done
> diff --git a/tests/docker/dockerfiles/ubuntu16.04.docker b/tests/docker/d=
ockerfiles/ubuntu16.04.docker
> new file mode 100644
> index 0000000000..ce7c5d3d33
> --- /dev/null
> +++ b/tests/docker/dockerfiles/ubuntu16.04.docker
> @@ -0,0 +1,16 @@
> +FROM ubuntu:16.04
> +RUN apt-get update
> +ENV PACKAGES flex bison \
> +    libusb-1.0-0-dev libiscsi-dev librados-dev libncurses5-dev libncurse=
sw5-dev \
> +    libseccomp-dev libgnutls-dev libssh2-1-dev  libspice-server-dev \
> +    libspice-protocol-dev libnss3-dev libfdt-dev \
> +    libgtk-3-dev libvte-2.91-dev libsdl1.2-dev libpng12-dev libpixman-1-=
dev \
> +    libvdeplug-dev liblzo2-dev libsnappy-dev libbz2-dev libxen-dev librd=
macm-dev libibverbs-dev \
> +    libsasl2-dev libjpeg-turbo8-dev xfslibs-dev libcap-ng-dev libbrlapi-=
dev libcurl4-gnutls-dev \
> +    libbluetooth-dev librbd-dev libaio-dev glusterfs-common libnuma-dev =
libepoxy-dev libdrm-dev libgbm-dev \
> +    libjemalloc-dev libcacard-dev libusbredirhost-dev libnfs-dev libcap-=
dev libattr1-dev \
> +    texinfo \
> +    gettext git make ccache python-yaml gcc clang sparse
> +RUN DEBIAN_FRONTEND=3Dnoninteractive apt-get -y --no-install-recommends =
install $PACKAGES
> +RUN dpkg -l $PACKAGES | sort > /packages.txt
> +ENV FEATURES clang pyyaml


--
Alex Benn=C3=A9e
