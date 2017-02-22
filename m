Received: from eggs.gnu.org ([2001:4830:134:3::10]:41577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgSjA-0001Eu-Ff
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 03:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgSj7-0006nn-EI
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 03:56:48 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cgSj7-0006nR-7y
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 03:56:45 -0500
Received: by mail-wm0-x22c.google.com with SMTP id v186so134352813wmd.0
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 00:56:45 -0800 (PST)
References: <20170222021801.28658-1-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170222021801.28658-1-famz@redhat.com>
Date: Wed, 22 Feb 2017 08:56:50 +0000
Message-ID: <8760k2wqlp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Auger Eric <eric.auger@redhat.com>


Fam Zheng <famz@redhat.com> writes:

> Python is no longer installed implicitly, but the QEMU build system
> requires it. List it in PACKAGES.

Doesn't fedora have a similar system to dpkg's build-deps that we should
use to install dependencies?

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


--
Alex Bennée
