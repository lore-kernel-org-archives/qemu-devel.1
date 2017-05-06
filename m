Received: from eggs.gnu.org ([2001:4830:134:3::10]:46488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72Xo-0007PL-Ti
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72Xl-00089Z-MK
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:26:56 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72Xl-00089U-I7
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:26:53 -0400
Received: by mail-qk0-x244.google.com with SMTP id u75so4812816qka.1
	for <qemu-devel@nongnu.org>; Sat, 06 May 2017 09:26:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170505032340.26467-1-famz@redhat.com>
	<20170505032340.26467-5-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <97c7383d-d54a-6ff0-359b-9801c4e695d4@amsat.org>
Date: Sat, 6 May 2017 13:26:48 -0300
MIME-Version: 1.0
In-Reply-To: <20170505032340.26467-5-famz@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/05/2017 12:23 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
>
