Received: from eggs.gnu.org ([2001:4830:134:3::10]:53282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBL5t-0006PS-G7
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBL5o-00018i-Lf
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:08:25 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:38518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBL5o-00018Y-H2
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:08:20 -0400
Received: by mail-qt0-x244.google.com with SMTP id z23-v6so26938860qti.5
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 07:08:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-39-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d29d9805-d1c0-d634-c009-8aee954740f0@amsat.org>
Date: Wed, 25 Apr 2018 11:08:13 -0300
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-39-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 38/46] tests/tcg: enable building for
 HPPA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/24/2018 12:23 PM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/Makefile.include                     |  1 +
>  tests/docker/dockerfiles/debian-hppa-cross.docker | 12 ++++++++++++
>  tests/tcg/hppa/Makefile.include                   |  2 ++
>  3 files changed, 15 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/debian-hppa-cross.docker
>  create mode 100644 tests/tcg/hppa/Makefile.include
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index bcf44e80c4..2471c4f30a 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -63,6 +63,7 @@ docker-image-debian-s390x-cross: docker-image-debian9
>  docker-image-debian-win32-cross: docker-image-debian8-mxe
>  docker-image-debian-win64-cross: docker-image-debian8-mxe
>  docker-image-debian-alpha-cross: docker-image-debian-sid
> +docker-image-debian-hppa-cross: docker-image-debian-sid
>  docker-image-travis: NOUSER=1
>  
>  # Expand all the pre-requistes for each docker image and test combination
> diff --git a/tests/docker/dockerfiles/debian-hppa-cross.docker b/tests/docker/dockerfiles/debian-hppa-cross.docker
> new file mode 100644
> index 0000000000..ad443defac
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-hppa-cross.docker
> @@ -0,0 +1,12 @@
> +#
> +# Docker cross-compiler target
> +#
> +# This docker target builds on the debian sid base image which
> +# contains cross compilers for Debian "ports" targets.
> +#
> +FROM qemu:debian-sid
> +
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        gcc-hppa-linux-gnu \
> +        libc6-dev-hppa-cross
> diff --git a/tests/tcg/hppa/Makefile.include b/tests/tcg/hppa/Makefile.include
> new file mode 100644
> index 0000000000..da2353430e
> --- /dev/null
> +++ b/tests/tcg/hppa/Makefile.include
> @@ -0,0 +1,2 @@
> +DOCKER_IMAGE=debian-hppa-cross
> +DOCKER_CROSS_COMPILER=hppa-linux-gnu-gcc
> 
