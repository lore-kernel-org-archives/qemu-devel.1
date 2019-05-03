Received: from eggs.gnu.org ([209.51.188.92]:54259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMbGa-0003UO-5T
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMbGZ-0002Tu-1f
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:42:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMbGY-0002Sy-Oo
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:42:30 -0400
Received: by mail-wr1-x441.google.com with SMTP id e28so8700542wra.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 09:42:30 -0700 (PDT)
References: <20190503070241.24786-1-kraxel@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190503070241.24786-1-kraxel@redhat.com>
Date: Fri, 03 May 2019 17:42:28 +0100
Message-ID: <87a7g34hhn.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/docker: add ubuntu 18.04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Fam Zheng <fam@euphon.net>


Gerd Hoffmann <kraxel@redhat.com> writes:

> Based on the ubuntu.docker file.
> Used to reproduce the build failure Peter was seeing.
> Others might find this useful too ;)
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  tests/docker/dockerfiles/ubuntu1804.docker | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/ubuntu1804.docker
>
> diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/do=
ckerfiles/ubuntu1804.docker
> new file mode 100644
> index 000000000000..2e2900150b09
> --- /dev/null
> +++ b/tests/docker/dockerfiles/ubuntu1804.docker
> @@ -0,0 +1,57 @@
> +FROM ubuntu:18.04
> +ENV PACKAGES flex bison \
> +    ccache \
> +    clang \
> +    gcc \
> +    gettext \
> +    git \
> +    glusterfs-common \
> +    libaio-dev \
> +    libattr1-dev \
> +    libbluetooth-dev \
> +    libbrlapi-dev \
> +    libbz2-dev \
> +    libcacard-dev \
> +    libcap-dev \
> +    libcap-ng-dev \
> +    libcurl4-gnutls-dev \
> +    libdrm-dev \
> +    libepoxy-dev \
> +    libfdt-dev \
> +    libgbm-dev \
> +    libgtk-3-dev \
> +    libibverbs-dev \
> +    libiscsi-dev \
> +    libjemalloc-dev \
> +    libjpeg-turbo8-dev \
> +    liblzo2-dev \
> +    libncurses5-dev \
> +    libncursesw5-dev \
> +    libnfs-dev \
> +    libnss3-dev \
> +    libnuma-dev \
> +    libpixman-1-dev \
> +    librados-dev \
> +    librbd-dev \
> +    librdmacm-dev \
> +    libsasl2-dev \
> +    libsdl2-dev \
> +    libseccomp-dev \
> +    libsnappy-dev \
> +    libspice-protocol-dev \
> +    libspice-server-dev \
> +    libssh2-1-dev \
> +    libusb-1.0-0-dev \
> +    libusbredirhost-dev \
> +    libvdeplug-dev \
> +    libvte-2.91-dev \
> +    libxen-dev \
> +    make \
> +    python-yaml \
> +    sparse \
> +    texinfo \
> +    xfslibs-dev
> +RUN apt-get update && \
> +    apt-get -y install $PACKAGES
> +RUN dpkg -l $PACKAGES | sort > /packages.txt
> +ENV FEATURES clang pyyaml sdl2

Queued to testing/next, thanks.

--
Alex Benn=C3=A9e
