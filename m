Received: from eggs.gnu.org ([2001:4830:134:3::10]:51255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f9MFa-00076J-9r
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f9MFX-0002HR-96
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:58:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50738 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f9MFX-0002Gp-3P
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:58:11 -0400
Date: Fri, 20 Apr 2018 10:57:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180420025759.GD17690@lemon.usersys.redhat.com>
References: <20180420024005.30245-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180420024005.30245-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: Rename the amd64 image as
 amd64-cross
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Thu, 04/19 23:40, Philippe Mathieu-Daud=E9 wrote:
> Like the other images, this one is also used to cross-compile.
> Name it accordingly, matching directory pattern.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/docker/Makefile.include                                   | 2 +-
>  .../{debian-amd64.docker =3D> debian-amd64-cross.docker}          | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename tests/docker/dockerfiles/{debian-amd64.docker =3D> debian-amd64=
-cross.docker} (100%)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index de87341528..a113a15f77 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -49,7 +49,7 @@ docker-image-debian-powerpc-cross: EXTRA_FILES:=3D$(S=
RC_PATH)/tests/docker/dockerf
>  # Enforce dependancies for composite images
>  docker-image-debian: docker-image-debian9
>  docker-image-debian8-mxe: docker-image-debian8
> -docker-image-debian-amd64: docker-image-debian9
> +docker-image-debian-amd64-cross: docker-image-debian9
>  docker-image-debian-armel-cross: docker-image-debian9
>  docker-image-debian-armhf-cross: docker-image-debian9
>  docker-image-debian-arm64-cross: docker-image-debian9
> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docke=
r/dockerfiles/debian-amd64-cross.docker
> similarity index 100%
> rename from tests/docker/dockerfiles/debian-amd64.docker
> rename to tests/docker/dockerfiles/debian-amd64-cross.docker

But the dockerfile is written differently: it doesn't use the --cross-pre=
fix
configure option, plus, amd64 is usually the "native" arch making it non-=
cross
build.

What do you need this patch for beside the consistency?

Fam
