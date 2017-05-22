Received: from eggs.gnu.org ([2001:4830:134:3::10]:57671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCngr-0001yF-M6
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCngp-0002Xc-2i
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:48:05 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:34633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dCngo-0002W1-Sr
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:48:03 -0400
Received: by mail-wm0-x22f.google.com with SMTP id 123so12124393wmg.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 06:48:02 -0700 (PDT)
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-6-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170521032956.27446-6-f4bug@amsat.org>
Date: Mon, 22 May 2017 14:48:05 +0100
Message-ID: <87efvh3sve.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 05/24] docker: install ca-certificates
 package in base image
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

> Resolve SSL verification issue at shippable container's git_sync stage:
>
> shippable logs:
> --------------
> git_sync
> - ssh-agent bash -c 'ssh-add /tmp/ssh/01_deploy; git clone https://github.com/philmd/qemu.git /root/src/github.com/philmd/qemu'
> Identity added: /tmp/ssh/01_deploy (rsa w/o comment)
> Cloning into '/root/src/github.com/philmd/qemu'...
> fatal: unable to access 'https://github.com/philmd/qemu.git/': Problem with the SSL CA cert (path? access rights?)
> retrying 1 of 3 times...
>
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tests/docker/dockerfiles/debian.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
> index 52bd79938e..d08def6a8d 100644
> --- a/tests/docker/dockerfiles/debian.docker
> +++ b/tests/docker/dockerfiles/debian.docker
> @@ -11,7 +11,7 @@ FROM debian:stable-slim
>
>  # Setup some basic tools we need
>  RUN apt update
> -RUN apt install -yy curl aptitude
> +RUN apt install -yy aptitude ca-certificates curl
>
>  # Setup Emdebian
>  RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list


--
Alex Bennée
