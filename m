Received: from eggs.gnu.org ([2001:4830:134:3::10]:46640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dDSBa-0004yk-CF
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:02:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dDSBX-0001P5-67
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:02:30 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dDSBX-0001OZ-0Y
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:02:27 -0400
Received: by mail-wm0-x22c.google.com with SMTP id e127so64624935wmg.1
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 02:02:26 -0700 (PDT)
References: <20170524005206.31916-1-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170524005206.31916-1-famz@redhat.com>
Date: Wed, 24 May 2017 10:02:32 +0100
Message-ID: <87k25639w7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com


Fam Zheng <famz@redhat.com> writes:

> Currently there are warnings about flex and bison being missing when
> building in the centos6 image:
>
>     make[1]: flex: Command not found
>              BISON dtc-parser.tab.c
>     make[1]: bison: Command not found
>
> Add them.
>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

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


--
Alex Bennée
