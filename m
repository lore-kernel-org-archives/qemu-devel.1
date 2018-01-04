Received: from eggs.gnu.org ([2001:4830:134:3::10]:35350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX93K-0005GM-Ee
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX92x-0002hs-8d
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:11:38 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:37392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX92x-0002hR-1I
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:11:15 -0500
Received: by mail-qk0-x243.google.com with SMTP id p13so2742305qke.4
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 09:11:15 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
	<20180104160523.22995-6-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <45775c31-81e1-2fd5-b929-dacd1b434e0b@amsat.org>
Date: Thu, 4 Jan 2018 14:11:10 -0300
MIME-Version: 1.0
In-Reply-To: <20180104160523.22995-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 05/18] tests/docker: add some sanitizers
 to fedora dockerfile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 01/04/2018 01:05 PM, Marc-André Lureau wrote:
> Build fedora image with ASAN/UBSan support.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/dockerfiles/fedora.docker | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> index 4b26c3aded..32de731675 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -3,7 +3,7 @@ ENV PACKAGES \
>      ccache gettext git tar PyYAML sparse flex bison python2 bzip2 hostname \
>      glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
>      gcc gcc-c++ clang make perl which bc findutils libaio-devel \
> -    nettle-devel \
> +    nettle-devel libasan libubsan \
>      mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config \
>      mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1 \
>      mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2 \
> @@ -15,4 +15,4 @@ ENV PACKAGES \
>  
>  RUN dnf install -y $PACKAGES
>  RUN rpm -q $PACKAGES | sort > /packages.txt
> -ENV FEATURES mingw clang pyyaml
> +ENV FEATURES mingw clang pyyaml asan
> 
