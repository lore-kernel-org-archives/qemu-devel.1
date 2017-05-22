Received: from eggs.gnu.org ([2001:4830:134:3::10]:57849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCnhk-0002eE-No
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCnhi-0002oK-4p
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:49:00 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dCnhh-0002oG-Uz
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:48:58 -0400
Received: by mail-wm0-x236.google.com with SMTP id d127so152647251wmf.0
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 06:48:57 -0700 (PDT)
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-7-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170521032956.27446-7-f4bug@amsat.org>
Date: Mon, 22 May 2017 14:49:00 +0100
Message-ID: <87d1b13stv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 06/24] docker: create deb-src entry and
 setup Emdebian in the same layer
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tests/docker/dockerfiles/debian.docker | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
> index d08def6a8d..33ba686892 100644
> --- a/tests/docker/dockerfiles/debian.docker
> +++ b/tests/docker/dockerfiles/debian.docker
> @@ -13,13 +13,11 @@ FROM debian:stable-slim
>  RUN apt update
>  RUN apt install -yy aptitude ca-certificates curl
>
> -# Setup Emdebian
> -RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list
> -RUN curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
> -
> -# Duplicate deb line as deb-src
> -RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
> -
>  # Install common build utilities
>  RUN apt update
>  RUN apt install -yy build-essential clang
> +
> +# Duplicate deb line as deb-src, setup Emdebian
> +RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list && \
> +    echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list && \
> +    curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -


--
Alex Bennée
