Received: from eggs.gnu.org ([2001:4830:134:3::10]:60212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCnrx-000052-Cu
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCnrt-00069s-Ax
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:59:33 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dCnrt-00069a-5n
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:59:29 -0400
Received: by mail-wm0-x235.google.com with SMTP id e127so39264033wmg.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 06:59:28 -0700 (PDT)
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-10-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170521032956.27446-10-f4bug@amsat.org>
Date: Mon, 22 May 2017 14:59:31 +0100
Message-ID: <878tlp3scc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 09/24] docker: use eatmydata in debian
 armhf image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tests/docker/dockerfiles/debian-armhf-cross.docker | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
> index 668d60aeb3..ba8d5a5167 100644
> --- a/tests/docker/dockerfiles/debian-armhf-cross.docker
> +++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
> @@ -8,8 +8,11 @@ FROM qemu:debian
>  # Add the foreign architecture we want and install dependencies
>  RUN dpkg --add-architecture armhf
>  RUN apt update
> -RUN apt install -yy crossbuild-essential-armhf
> -RUN apt-get build-dep -yy -a armhf qemu
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        crossbuild-essential-armhf
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt-get build-dep -yy -a armhf qemu
>
>  # Specify the cross prefix for this image (see tests/docker/common.rc)
>  ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabihf-


--
Alex Bennée
