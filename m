Received: from eggs.gnu.org ([209.51.188.92]:38990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghehA-0003yj-BI
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gheh8-0000Ot-Vy
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:04:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gheh7-0000NB-Fh
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:04:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so12436993wrt.7
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 10:04:41 -0800 (PST)
References: <20190110174516.21586-1-alex.bennee@linaro.org>
	<20190110174516.21586-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2cea5a8c-abe1-9e19-3ba5-5c27f431a37c@redhat.com>
Date: Thu, 10 Jan 2019 19:04:38 +0100
MIME-Version: 1.0
In-Reply-To: <20190110174516.21586-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 03/19] tests: remove obsolete 'debian'
 dockerfile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: ymankad@redhat.com

On 1/10/19 6:45 PM, Alex Bennée wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> The 'debian' dockerfile was deprecated in favour of versioned
> dockerfiles in July 2017. That is enough time for developers to
> be warned about the rename.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/docker/dockerfiles/debian.docker | 13 -------------
>  1 file changed, 13 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/debian.docker
> 
> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
> deleted file mode 100644
> index fd32e71b79..0000000000
> --- a/tests/docker/dockerfiles/debian.docker
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -# This template is deprecated and was previously based on Jessie on QEMU 2.9.
> -# Now than Stretch is out, please use qemu:debian8 as base for Jessie,
> -# and qemu:debian9 for Stretch.
> -#
> -FROM qemu:debian9
> -
> -MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
> -
> -RUN for n in $(seq 8); do echo; done && \
> -    echo "\n\t\tThis image is deprecated." && echo && \
> -    echo "\tUse 'FROM qemu:debian9' to use the stable Debian Stretch image" && \
> -    echo "\tor 'FROM qemu:debian8' to use old Debian Jessie." && \
> -    for n in $(seq 8); do echo; done
> 
