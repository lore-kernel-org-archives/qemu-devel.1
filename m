Received: from eggs.gnu.org ([2001:4830:134:3::10]:59498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1da0mK-00033q-Pp
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1da0mG-0001BG-Oi
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:25:40 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1da0mG-0001B6-KT
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:25:36 -0400
Received: by mail-qt0-x244.google.com with SMTP id t37so1362355qtg.2
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 07:25:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170725133425.436-1-alex.bennee@linaro.org>
	<20170725133425.436-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <47fa3289-1874-57f3-cc29-33e5697a22d1@amsat.org>
Date: Tue, 25 Jul 2017 11:25:32 -0300
MIME-Version: 1.0
In-Reply-To: <20170725133425.436-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 v2 6/6] docker: reduce noise when
 building travis.docker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org

On 07/25/2017 10:34 AM, Alex Bennée wrote:
> Set the DEBIAN_FRONTEND and locale env vars to stop apt complaining so
> much as we build the image.
> 
> Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/docker/dockerfiles/travis.docker | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dockerfiles/travis.docker
> index 57ac8e1419..605b6e429b 100644
> --- a/tests/docker/dockerfiles/travis.docker
> +++ b/tests/docker/dockerfiles/travis.docker
> @@ -1,4 +1,7 @@
>   FROM quay.io/travisci/travis-ruby
> +ENV DEBIAN_FRONTEND noninteractive
> +ENV LANG en_US.UTF-8
> +ENV LC_ALL en_US.UTF-8

can be one-lined:
ENV DEBIAN_FRONTEND=noninteractive LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
maybe add "default env vars set using travis (see [link])" in message?

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

(not a bugfix)

>   RUN apt-get update
>   RUN apt-get -y build-dep qemu
>   RUN apt-get -y install device-tree-compiler python2.7 python-yaml dh-autoreconf gdb strace lsof net-tools
> 
