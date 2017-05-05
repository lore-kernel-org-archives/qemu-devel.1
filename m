Received: from eggs.gnu.org ([2001:4830:134:3::10]:53915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6YZj-0007ok-TF
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6YZg-0000HV-ME
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:26:55 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d6YZg-0000HP-G4
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:26:52 -0400
Received: by mail-wr0-x231.google.com with SMTP id z52so19660130wrc.2
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 01:26:52 -0700 (PDT)
References: <20170505032340.26467-1-famz@redhat.com>
	<20170505032340.26467-5-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170505032340.26467-5-famz@redhat.com>
Date: Fri, 05 May 2017 09:27:31 +0100
Message-ID: <871ss3ogi4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/5] docker: Add libaio to fedora image
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

> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tests/docker/dockerfiles/fedora.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> index 39f6b58..4eaa8ed 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -2,7 +2,7 @@ FROM fedora:latest
>  ENV PACKAGES \
>      ccache git tar PyYAML sparse flex bison python2 bzip2 hostname \
>      glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
> -    gcc gcc-c++ clang make perl which bc findutils \
> +    gcc gcc-c++ clang make perl which bc findutils libaio-devel \
>      mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config \
>      mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1 \
>      mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2 \


--
Alex Bennée
