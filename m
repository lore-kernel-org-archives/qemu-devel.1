Received: from eggs.gnu.org ([2001:4830:134:3::10]:58214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAdZ0-00069O-Vm
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAdYx-00025J-QI
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:39:35 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fAdYx-00024x-Id
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:39:31 -0400
Received: by mail-wr0-x242.google.com with SMTP id w3-v6so42553436wrg.2
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 08:39:31 -0700 (PDT)
References: <20180423144837.16710-1-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180423144837.16710-1-f4bug@amsat.org>
Date: Mon, 23 Apr 2018 16:39:29 +0100
Message-ID: <87po2qkk3y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: add debian/alpha image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> This image is not enough to cross-build QEMU,
> but it is useful enough to cross-compile TCG tests.
>
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/docker/dockerfiles/debian-alpha-cross.docker | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/debian-alpha-cross.docker
>
> diff --git a/tests/docker/dockerfiles/debian-alpha-cross.docker b/tests/d=
ocker/dockerfiles/debian-alpha-cross.docker
> new file mode 100644
> index 0000000000..dce1d2e719
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-alpha-cross.docker
> @@ -0,0 +1,13 @@
> +#
> +# Docker alpha cross-compiler target
> +#
> +# This docker target builds on the debian Stretch base image.
> +#
> +FROM qemu:debian9

I should have noticed this. However I'm currently enabling a bunch of
additional cross compilers which SID has for the benefit of the various
ports.

> +
> +# Add the foreign architecture we want and install dependencies
> +RUN dpkg --add-architecture alpha
> +RUN apt update
> +RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        gcc-alpha-linux-gnu


--
Alex Benn=C3=A9e
