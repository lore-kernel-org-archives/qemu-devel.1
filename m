Received: from eggs.gnu.org ([2001:4830:134:3::10]:47175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebdT1-0001rA-2g
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:28:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebdSx-00038V-3K
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:28:43 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1ebdSw-000384-UR
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:28:39 -0500
Received: by mail-pl0-f65.google.com with SMTP id f4so6256374plr.10
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 18:28:38 -0800 (PST)
From: Fam Zheng <fzheng@redhat.com>
References: <20180115170243.24578-1-berrange@redhat.com>
	<20180115170243.24578-14-berrange@redhat.com>
Message-ID: <b3c087e5-af1a-23f8-3d1e-6870ecc76002@redhat.com>
Date: Wed, 17 Jan 2018 10:28:31 +0800
MIME-Version: 1.0
In-Reply-To: <20180115170243.24578-14-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 13/13] docker: change Fedora images to
 run with python3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 01/16/2018 01:02 AM, Daniel P. Berrange wrote:
> Fedora has switched to Python 3 by default, so it makes sense to use that
> for testing QEMU builds, so we get testing of Python 3 compatibility.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>   tests/docker/dockerfiles/fedora.docker | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> index 4b26c3aded..a22fe16157 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -1,6 +1,6 @@
>   FROM fedora:latest
>   ENV PACKAGES \
> -    ccache gettext git tar PyYAML sparse flex bison python2 bzip2 hostname \
> +    ccache gettext git tar PyYAML sparse flex bison python3 bzip2 hostname \
>       glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
>       gcc gcc-c++ clang make perl which bc findutils libaio-devel \
>       nettle-devel \
> @@ -12,6 +12,7 @@ ENV PACKAGES \
>       mingw64-gtk2 mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1 \
>       mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2 \
>       mingw64-bzip2
> +ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
>   
>   RUN dnf install -y $PACKAGES
>   RUN rpm -q $PACKAGES | sort > /packages.txt

QAPI changes stands out in the series' diffstat, so:

Reviewed-by: Fam Zheng <famz@redhat.com>
Acked-by: Fam Zheng <famz@redhat.com>
