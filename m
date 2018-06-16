Received: from eggs.gnu.org ([2001:4830:134:3::10]:38927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fUJfu-0000b4-HP
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 18:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fUJfr-0001nd-Dy
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 18:28:02 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:42324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fUJfr-0001nQ-9E
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 18:27:59 -0400
Received: by mail-qk0-x244.google.com with SMTP id j80-v6so7565755qke.9
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 15:27:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
	<20180615194705.28019-30-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7012e6f7-8f67-0263-4f24-a62ed1086e96@amsat.org>
Date: Sat, 16 Jun 2018 19:27:51 -0300
MIME-Version: 1.0
In-Reply-To: <20180615194705.28019-30-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 29/54] tests/docker/Makefile.include:
 fix mipsel-cross dependancy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org

On 06/15/2018 04:46 PM, Alex Bennée wrote:
> This got broken in commit 4319db7 but generally only shows up when you
> try and do massive parallel builds on fresh machines.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/Makefile.include | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 8afb383478..4a2b028a3b 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -57,6 +57,7 @@ docker-image-debian-armel-cross: docker-image-debian9
>  docker-image-debian-armhf-cross: docker-image-debian9
>  docker-image-debian-arm64-cross: docker-image-debian9
>  docker-image-debian-mips-cross: docker-image-debian9
> +docker-image-debian-mipsel-cross: docker-image-debian9
>  docker-image-debian-mips64el-cross: docker-image-debian9
>  docker-image-debian-powerpc-cross: docker-image-debian8
>  docker-image-debian-ppc64el-cross: docker-image-debian9
> 
