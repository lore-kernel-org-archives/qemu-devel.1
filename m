Received: from eggs.gnu.org ([2001:4830:134:3::10]:59790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdFhT-0001J0-5h
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdFhQ-0005BQ-JA
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:02:35 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdFhQ-0005BD-FA
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:02:32 -0400
Received: by mail-qk0-x241.google.com with SMTP id a132-v6so13582226qkg.3
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 07:02:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180711065813.14894-1-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8abe9418-dcc9-4c0f-357f-5d26965e16b7@amsat.org>
Date: Wed, 11 Jul 2018 11:02:14 -0300
MIME-Version: 1.0
In-Reply-To: <20180711065813.14894-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] docker: Install more packages in centos7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 07/11/2018 03:58 AM, Fam Zheng wrote:
> This makes test-block work.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/dockerfiles/centos7.docker | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
> index 575de29a0a..83462b7205 100644
> --- a/tests/docker/dockerfiles/centos7.docker
> +++ b/tests/docker/dockerfiles/centos7.docker
> @@ -3,6 +3,7 @@ RUN yum install -y epel-release centos-release-xen
>  RUN yum -y update
>  ENV PACKAGES \
>      bison \
> +    bzip2 \
>      bzip2-devel \
>      ccache \
>      csnappy-devel \
> @@ -12,10 +13,12 @@ ENV PACKAGES \
>      gettext \
>      git \
>      glib2-devel \
> +    libaio-devel \
>      libepoxy-devel \
>      libfdt-devel \
>      librdmacm-devel \
>      lzo-devel \
> +    nettle-devel \
>      make \
>      mesa-libEGL-devel \
>      mesa-libgbm-devel \
> 
