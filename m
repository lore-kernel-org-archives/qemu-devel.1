Received: from eggs.gnu.org ([2001:4830:134:3::10]:53646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6YY9-0006jw-L9
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6YY6-0008VD-F0
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:25:17 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d6YY6-0008V3-8C
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:25:14 -0400
Received: by mail-wr0-x22d.google.com with SMTP id l50so19674440wrc.3
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 01:25:14 -0700 (PDT)
References: <20170505032340.26467-1-famz@redhat.com>
	<20170505032340.26467-3-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170505032340.26467-3-famz@redhat.com>
Date: Fri, 05 May 2017 09:25:53 +0100
Message-ID: <874lwzogku.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/5] docker: Add bzip2 and hostname to
 fedora image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> It is used by qemu-iotests.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tests/docker/dockerfiles/fedora.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> index c4f80ad..39f6b58 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -1,6 +1,6 @@
>  FROM fedora:latest
>  ENV PACKAGES \
> -    ccache git tar PyYAML sparse flex bison python2 \
> +    ccache git tar PyYAML sparse flex bison python2 bzip2 hostname \
>      glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
>      gcc gcc-c++ clang make perl which bc findutils \
>      mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config \


--
Alex Bennée
