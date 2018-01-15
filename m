Received: from eggs.gnu.org ([2001:4830:134:3::10]:59889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb2Ip-0002AT-5D
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:47:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb2Ig-0005J2-Aj
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:47:43 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:44638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb2Ig-0005Ih-5k
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:47:34 -0500
Received: by mail-qt0-x244.google.com with SMTP id m59so13604706qte.11
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 02:47:34 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180115102621.9183-1-berrange@redhat.com>
	<20180115102621.9183-14-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3ea0dbad-1ec3-3a0f-957d-36fa3e262cbe@amsat.org>
Date: Mon, 15 Jan 2018 07:47:29 -0300
MIME-Version: 1.0
In-Reply-To: <20180115102621.9183-14-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 13/13] docker: change Fedora images to
 run with python3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Hi Daniel,

On 01/15/2018 07:26 AM, Daniel P. Berrange wrote:
> Fedora has switched to Python 3 by default, so it makes sense to use that
> for testing QEMU builds, so we get testing of Python 3 compatibility.

I'd rather keep Fedora 25 with Python 2, and use Python 3 in Fedora 27.

If you agree, I can apply this patch once your series is merged, on top
of http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg02569.html

relevant patches:
http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg02574.html
http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg02575.html

> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/docker/dockerfiles/fedora.docker | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> index 4b26c3aded..a22fe16157 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -1,6 +1,6 @@
>  FROM fedora:latest
>  ENV PACKAGES \
> -    ccache gettext git tar PyYAML sparse flex bison python2 bzip2 hostname \
> +    ccache gettext git tar PyYAML sparse flex bison python3 bzip2 hostname \
>      glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
>      gcc gcc-c++ clang make perl which bc findutils libaio-devel \
>      nettle-devel \
> @@ -12,6 +12,7 @@ ENV PACKAGES \
>      mingw64-gtk2 mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1 \
>      mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2 \
>      mingw64-bzip2
> +ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
>  
>  RUN dnf install -y $PACKAGES
>  RUN rpm -q $PACKAGES | sort > /packages.txt
> 
