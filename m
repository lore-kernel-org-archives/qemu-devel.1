Received: from eggs.gnu.org ([2001:4830:134:3::10]:40908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ch9Bf-00020K-3w
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ch9Bb-0004sr-44
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:17:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ch9Ba-0004rx-Ty
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:16:59 -0500
Date: Fri, 24 Feb 2017 14:16:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170224061655.GA32354@lemon.lan>
References: <20170222021801.28658-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170222021801.28658-1-famz@redhat.com>
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
To: qemu-devel@nongnu.org
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Auger Eric <eric.auger@redhat.com>

On Wed, 02/22 10:18, Fam Zheng wrote:
> Python is no longer installed implicitly, but the QEMU build system
> requires it. List it in PACKAGES.
> 
> Reported-by: Auger Eric <eric.auger@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
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
> -- 
> 2.9.3
> 

Applied to my staging tree.

Fam
