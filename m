Received: from eggs.gnu.org ([2001:4830:134:3::10]:43741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewotM-0001t8-PO
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewotH-0004WW-RR
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:55:28 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:51419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewotH-0004WF-GK
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:55:23 -0400
Received: by mail-wm0-x241.google.com with SMTP id h21so2854103wmd.1
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 05:55:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180316122540.28409-1-pbonzini@redhat.com>
	<20180316122540.28409-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <872021d0-ff46-f5ec-833b-fce1557a5d8e@amsat.org>
Date: Fri, 16 Mar 2018 13:55:19 +0100
MIME-Version: 1.0
In-Reply-To: <20180316122540.28409-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] docker: test-mingw: use SDL2 and GTK+3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, famz@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com

On 03/16/2018 01:25 PM, Paolo Bonzini wrote:
> Do not test the deprecated API versions.  debian-win32-cross and debian-win64-cross
> are already using SDL2 (they do not cover GTK+ at all).

Good idea to start a doc/test/docker-coverage.txt with a matrix of
configs tested (for example debian-amd64 tests virgl and netmap).

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/docker/dockerfiles/fedora.docker | 8 ++++----
>  tests/docker/test-mingw                | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> index a00004319e..be3566325c 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -4,12 +4,12 @@ ENV PACKAGES \
>      glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
>      gcc gcc-c++ llvm clang make perl which bc findutils libaio-devel \
>      nettle-devel libasan libubsan \
> -    mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config \
> -    mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1 \
> +    mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL2 mingw32-pkg-config \
> +    mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1 \
>      mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2 \
>      mingw32-bzip2 \
> -    mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL mingw64-pkg-config \
> -    mingw64-gtk2 mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1 \
> +    mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL2 mingw64-pkg-config \
> +    mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1 \
>      mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2 \
>      mingw64-bzip2
>  ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
> diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
> index 503a6bc6f7..7cca7e16a6 100755
> --- a/tests/docker/test-mingw
> +++ b/tests/docker/test-mingw
> @@ -28,8 +28,8 @@ for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
>          --enable-vnc \
>          --enable-bzip2 \
>          --enable-guest-agent \
> -        --with-sdlabi=1.2 \
> -        --with-gtkabi=2.0
> +        --with-sdlabi=2.0 \
> +        --with-gtkabi=3.0
>      install_qemu
>      make clean
>  
> 
