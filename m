Received: from eggs.gnu.org ([209.51.188.92]:56238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwWEt-00027x-Ox
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwWEp-0005Yi-6N
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:04:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gwWEZ-0005Tf-7T
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:04:46 -0500
References: <20190220172811.10588-1-alex.bennee@linaro.org>
	<20190220172811.10588-6-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <99351b12-7597-ffec-b490-803a2f508b0c@redhat.com>
Date: Wed, 20 Feb 2019 19:04:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190220172811.10588-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 5/8] tests/docker: squash initial update
 and install step for docker9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Typo in subject, should be debian9

Paolo "no this is not top posting"


On 20/02/19 18:28, Alex Benn=C3=A9e wrote:
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/debian9.docker | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/doc=
kerfiles/debian9.docker
> index 154ae2a455..5f23a35404 100644
> --- a/tests/docker/dockerfiles/debian9.docker
> +++ b/tests/docker/dockerfiles/debian9.docker
> @@ -13,8 +13,8 @@ FROM debian:stretch-slim
>  RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/s=
ources.list
> =20
>  # Install common build utilities
> -RUN apt update
> -RUN DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata
> +RUN apt-get update && \
> +    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata
>  RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>      apt install -y --no-install-recommends \
>          bison \
>=20
