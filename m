Received: from eggs.gnu.org ([2001:4830:134:3::10]:59672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa5JL-0003nl-PX
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa5JH-0006Pn-2S
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:20:35 -0400
Received: from mail-qk0-x22e.google.com ([2607:f8b0:400d:c09::22e]:34304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa5JG-0006PN-Tq
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:20:30 -0400
Received: by mail-qk0-x22e.google.com with SMTP id b66-v6so9351692qkj.1
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 13:20:30 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180702143021.18864-1-alex.bennee@linaro.org>
	<20180702143021.18864-17-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e27863dc-919e-1183-01d9-f4fdf1af052e@amsat.org>
Date: Mon, 2 Jul 2018 17:20:25 -0300
MIME-Version: 1.0
In-Reply-To: <20180702143021.18864-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 16/20] docker: drop QEMU build-dep from
 bootstrap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org

On 07/02/2018 11:30 AM, Alex Bennée wrote:
> This is best done with any child images that actually need it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/dockerfiles/debian-bootstrap.docker | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/debian-bootstrap.docker b/tests/docker/dockerfiles/debian-bootstrap.docker
> index 3a9125e497..14212b9cf4 100644
> --- a/tests/docker/dockerfiles/debian-bootstrap.docker
> +++ b/tests/docker/dockerfiles/debian-bootstrap.docker
> @@ -17,5 +17,3 @@ RUN /debootstrap/debootstrap --second-stage
>  # At this point we can install additional packages if we want
>  # Duplicate deb line as deb-src
>  RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
> -RUN apt-get update
> -RUN apt-get -y build-dep qemu
> 
