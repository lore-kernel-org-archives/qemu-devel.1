Received: from eggs.gnu.org ([2001:4830:134:3::10]:58735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCnly-0004cY-Am
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCnlu-0003p9-7x
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:53:22 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:37291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dCnlu-0003on-1A
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:53:18 -0400
Received: by mail-wm0-x22a.google.com with SMTP id d127so152773984wmf.0
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 06:53:17 -0700 (PDT)
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-8-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170521032956.27446-8-f4bug@amsat.org>
Date: Mon, 22 May 2017 14:53:21 +0100
Message-ID: <87bmql3smm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 07/24] docker: use better regex to
 generate deb-src entries
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
>  tests/docker/dockerfiles/debian.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
> index 33ba686892..e5a10a5875 100644
> --- a/tests/docker/dockerfiles/debian.docker
> +++ b/tests/docker/dockerfiles/debian.docker
> @@ -18,6 +18,6 @@ RUN apt update
>  RUN apt install -yy build-essential clang
>
>  # Duplicate deb line as deb-src, setup Emdebian
> -RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list && \
> +RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list && \
>      echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list && \
>      curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -


--
Alex Bennée
