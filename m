Received: from eggs.gnu.org ([2001:4830:134:3::10]:34311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCo08-0006II-1M
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCo06-0001Su-PJ
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:08:00 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:36136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dCo06-0001SY-J7
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:07:58 -0400
Received: by mail-wr0-x22f.google.com with SMTP id l50so39324867wrc.3
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 07:07:58 -0700 (PDT)
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-14-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170521032956.27446-14-f4bug@amsat.org>
Date: Mon, 22 May 2017 15:08:01 +0100
Message-ID: <871srh3ry6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 13/24] docker: add extra libs to s390x
 target to extend codebase coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tests/docker/dockerfiles/debian-s390x-cross.docker | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
> index 3a687feda0..cfc354ce5d 100644
> --- a/tests/docker/dockerfiles/debian-s390x-cross.docker
> +++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
> @@ -20,3 +20,13 @@ RUN apt install -yy gcc-multilib-s390x-linux-gnu binutils-multiarch
>
>  # Specify the cross prefix for this image (see tests/docker/common.rc)
>  ENV QEMU_CONFIGURE_OPTS --cross-prefix=s390x-linux-gnu-
> +
> +RUN DEBIAN_FRONTEND=noninteractive \
> +    apt-get install -y --no-install-recommends \
> +        glusterfs-common:s390x \
> +        libbz2-dev:s390x \
> +        liblzo2-dev:s390x \
> +        libncursesw5-dev:s390x \
> +        libnfs-dev:s390x \
> +        librdmacm-dev:s390x \
> +        libsnappy-dev:s390x


--
Alex Bennée
