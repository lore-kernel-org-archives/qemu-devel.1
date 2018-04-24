Received: from eggs.gnu.org ([2001:4830:134:3::10]:50623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fB6zI-0004Yl-83
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 19:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fB6zF-0003xl-0A
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 19:04:40 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fB6zE-0003x2-Qb
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 19:04:36 -0400
Received: by mail-qt0-x244.google.com with SMTP id a25-v6so24511288qtm.1
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 16:04:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-18-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1f0aeb03-f524-fe8b-c051-1bfc9c01e05f@amsat.org>
Date: Tue, 24 Apr 2018 20:04:29 -0300
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 17/46] docker: Add fedora-i386-cross
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/24/2018 12:23 PM, Alex Bennée wrote:
> From: Fam Zheng <famz@redhat.com>
> 
> It has some basic *-devel.i686 packages to be used with "gcc -m32" as a
> 32 bit cross build environment.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> [AJB: add glibc-static]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> ---
> v2
>   - include static glibc package as well
> ---
>  tests/docker/dockerfiles/fedora-i386-cross.docker | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/fedora-i386-cross.docker
> 
> diff --git a/tests/docker/dockerfiles/fedora-i386-cross.docker b/tests/docker/dockerfiles/fedora-i386-cross.docker
> new file mode 100644
> index 0000000000..8fbef2fa53
> --- /dev/null
> +++ b/tests/docker/dockerfiles/fedora-i386-cross.docker
> @@ -0,0 +1,14 @@
> +FROM fedora:latest
> +ENV PACKAGES \
> +    gcc \
> +    glibc-static.i686 \
> +    glibc-devel.i686 \
> +    glib2-devel.i686 \
> +    zlib-devel.i686 \
> +    glib2-devel.i686 \
> +    nettle-devel.i686 \
> +    pixman-devel.i686 \
> +    gnutls-devel.i686
> +
> +RUN dnf install -y $PACKAGES
> +RUN rpm -q $PACKAGES | sort > /packages.txt
> 
