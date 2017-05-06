Received: from eggs.gnu.org ([2001:4830:134:3::10]:48828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72fb-0002Bw-Uf
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72fX-00035n-A2
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:34:59 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72fX-00035N-6c
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:34:55 -0400
Received: by mail-qk0-x241.google.com with SMTP id y128so4832196qka.3
	for <qemu-devel@nongnu.org>; Sat, 06 May 2017 09:34:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170505032340.26467-1-famz@redhat.com>
	<20170505032340.26467-3-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6eb9d605-f19b-9075-32e7-cfd90ea3b2f3@amsat.org>
Date: Sat, 6 May 2017 13:34:48 -0300
MIME-Version: 1.0
In-Reply-To: <20170505032340.26467-3-famz@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/05/2017 12:23 AM, Fam Zheng wrote:
> It is used by qemu-iotests.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
>
