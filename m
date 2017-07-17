Received: from eggs.gnu.org ([2001:4830:134:3::10]:49492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX2S0-00068b-R0
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX2Rw-0007ji-NZ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:36:24 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dX2Rw-0007iw-H1
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:36:20 -0400
Received: by mail-wr0-x22c.google.com with SMTP id 12so3790383wrb.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 02:36:18 -0700 (PDT)
References: <20170711031000.24844-1-f4bug@amsat.org>
	<20170711031000.24844-8-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170711031000.24844-8-f4bug@amsat.org>
Date: Mon, 17 Jul 2017 10:36:16 +0100
Message-ID: <87h8yb8kxb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 07/18] docker: add debian/amd64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/docker/Makefile.include                      |  1 +
>  tests/docker/dockerfiles/debian-amd64-cross.docker | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/debian-amd64-cross.docker

I'm not sure I'll take this one as it is a) not really cross compiling,
b) adding to coverage much (if at all).

>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 59b08b4aca..d2a81b0d71 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -62,6 +62,7 @@ docker-image-debian-arm64-cross: docker-image-debian9
>  docker-image-debian-mipsel-cross: docker-image-debian9
>  docker-image-debian-ppc64el-cross: docker-image-debian9
>  docker-image-debian-s390x-cross: docker-image-debian9
> +docker-image-debian-amd64-cross: docker-image-debian9
>
>  # Expand all the pre-requistes for each docker image and test combination
>  $(foreach i,$(DOCKER_IMAGES), \
> diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
> new file mode 100644
> index 0000000000..9d10a886df
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
> @@ -0,0 +1,18 @@
> +#
> +# Docker x86_64 cross-compiler target
> +#
> +# This docker target builds on the debian Stretch base image.
> +#
> +FROM qemu:debian9
> +MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
> +
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt-get build-dep -yy qemu
> +
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        libbz2-dev \
> +        liblzo2-dev \
> +        librdmacm-dev \
> +        libsnappy-dev \
> +        libvte-dev


--
Alex Bennée
