Received: from eggs.gnu.org ([2001:4830:134:3::10]:53430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cgRok-0001Uh-PY
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 02:58:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cgRog-0006qO-0K
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 02:58:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1cgRof-0006qD-Qa
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 02:58:25 -0500
References: <20170222021801.28658-1-famz@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3c05ba9c-a83b-ddfb-cc13-627dcd9b9e56@redhat.com>
Date: Wed, 22 Feb 2017 08:58:21 +0100
MIME-Version: 1.0
In-Reply-To: <20170222021801.28658-1-famz@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] docker: Install python2 explicitly in
 docker image
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

Hi Fam,

On 22/02/2017 03:18, Fam Zheng wrote:
> Python is no longer installed implicitly, but the QEMU build system
> requires it. List it in PACKAGES.
> 
> Reported-by: Auger Eric <eric.auger@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks!

Eric

> ---
>  tests/docker/dockerfiles/fedora.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> index 478163b..c4f80ad 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -1,6 +1,6 @@
>  FROM fedora:latest
>  ENV PACKAGES \
> -    ccache git tar PyYAML sparse flex bison \
> +    ccache git tar PyYAML sparse flex bison python2 \
>      glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
>      gcc gcc-c++ clang make perl which bc findutils \
>      mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config \
> 
