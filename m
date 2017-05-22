Received: from eggs.gnu.org ([2001:4830:134:3::10]:60044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCnr8-0007qs-HQ
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCnr4-00060L-En
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:58:42 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dCnr4-00060D-77
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:58:38 -0400
Received: by mail-wm0-x22b.google.com with SMTP id 7so65248063wmo.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 06:58:38 -0700 (PDT)
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-9-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170521032956.27446-9-f4bug@amsat.org>
Date: Mon, 22 May 2017 14:58:40 +0100
Message-ID: <87a8653sdr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 08/24] docker: use eatmydata,
 install common build packages in base image
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

> The common build packages are: build-essential clang git bison flex
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tests/docker/dockerfiles/debian.docker | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
> index e5a10a5875..c62c87f205 100644
> --- a/tests/docker/dockerfiles/debian.docker
> +++ b/tests/docker/dockerfiles/debian.docker
> @@ -11,7 +11,11 @@ FROM debian:stable-slim
>
>  # Setup some basic tools we need
>  RUN apt update
> -RUN apt install -yy aptitude ca-certificates curl
> +RUN DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
> +RUN DEBIAN_FRONTEND=noninteractive \
> +    eatmydata apt install -y --no-install-recommends \
> +        aptitude ca-certificates curl \
> +        build-essential clang git bison flex
>
>  # Install common build utilities
>  RUN apt update


--
Alex Bennée
