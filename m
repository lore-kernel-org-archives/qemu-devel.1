Received: from eggs.gnu.org ([209.51.188.92]:53356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gn26Z-0007CQ-T2
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gn26Y-0002z5-Uc
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:05:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gn26Y-0002uw-Li
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:05:10 -0500
References: <20190125140017.6092-1-alex.bennee@linaro.org>
	<20190125140017.6092-6-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6dca2f29-427b-82af-0750-f066f6da8be3@redhat.com>
Date: Fri, 25 Jan 2019 15:04:55 +0100
MIME-Version: 1.0
In-Reply-To: <20190125140017.6092-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 05/14] docker: disable Xen on CentOS 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 25/01/19 15:00, Alex Benn=C3=A9e wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
>=20
> The Xen repository is failing to install, disable it.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

A better version:

--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -1,5 +1,6 @@
 FROM centos:7
-RUN yum install -y epel-release centos-release-xen
+RUN yum install -y epel-release centos-release-xen-48
+
 RUN yum -y update
 ENV PACKAGES \
     bison \


I can include it in my pull request too.

Paolo

> ---
>  tests/docker/dockerfiles/centos7.docker | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/doc=
kerfiles/centos7.docker
> index e0f18f5a41..e6fcbf4bcd 100644
> --- a/tests/docker/dockerfiles/centos7.docker
> +++ b/tests/docker/dockerfiles/centos7.docker
> @@ -1,5 +1,5 @@
>  FROM centos:7
> -RUN yum install -y epel-release centos-release-xen
> +RUN yum install -y epel-release
>  RUN yum -y update
>  ENV PACKAGES \
>      bison \
> @@ -8,7 +8,7 @@ ENV PACKAGES \
>      ccache \
>      csnappy-devel \
>      flex \
> -    g++ \
> +    gcc-c++ \
>      gcc \
>      gettext \
>      git \
> @@ -29,7 +29,6 @@ ENV PACKAGES \
>      spice-server-devel \
>      tar \
>      vte-devel \
> -    xen-devel \
>      zlib-devel
>  RUN yum install -y $PACKAGES
>  RUN rpm -q $PACKAGES | sort > /packages.txt
>=20
