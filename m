Received: from eggs.gnu.org ([2001:4830:134:3::10]:41033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDN8J-0001sE-TN
	for qemu-devel@nongnu.org; Tue, 23 May 2017 23:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDN8F-00016k-Th
	for qemu-devel@nongnu.org; Tue, 23 May 2017 23:38:47 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDN8F-00016W-NM
	for qemu-devel@nongnu.org; Tue, 23 May 2017 23:38:43 -0400
Received: by mail-oi0-x243.google.com with SMTP id w10so30838101oif.1
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 20:38:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170524005206.31916-1-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f627af56-7371-be89-2ece-94d734150ab8@amsat.org>
Date: Wed, 24 May 2017 00:38:40 -0300
MIME-Version: 1.0
In-Reply-To: <20170524005206.31916-1-famz@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] docker: Add flex and bison to centos6 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, thuth@redhat.com

On 05/23/2017 09:52 PM, Fam Zheng wrote:
> Currently there are warnings about flex and bison being missing when
> building in the centos6 image:
>
>     make[1]: flex: Command not found
>              BISON dtc-parser.tab.c
>     make[1]: bison: Command not found
>
> Add them.

I had the same issue with debian based images :/

>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/dockerfiles/centos6.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/dockerfiles/centos6.docker b/tests/docker/dockerfiles/centos6.docker
> index 34e0d3b..17a4d24 100644
> --- a/tests/docker/dockerfiles/centos6.docker
> +++ b/tests/docker/dockerfiles/centos6.docker
> @@ -1,7 +1,7 @@
>  FROM centos:6
>  RUN yum install -y epel-release
>  ENV PACKAGES libfdt-devel ccache \
> -    tar git make gcc g++ \
> +    tar git make gcc g++ flex bison \
>      zlib-devel glib2-devel SDL-devel pixman-devel \
>      epel-release
>  RUN yum install -y $PACKAGES
>
