Received: from eggs.gnu.org ([2001:4830:134:3::10]:33508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCnwc-0003qc-GJ
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCnwZ-0008N6-QO
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:04:22 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dCnwZ-0008Mk-KX
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:04:19 -0400
Received: by mail-wr0-x22a.google.com with SMTP id l50so39254419wrc.3
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 07:04:19 -0700 (PDT)
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-13-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170521032956.27446-13-f4bug@amsat.org>
Date: Mon, 22 May 2017 15:04:22 +0100
Message-ID: <874lwd3s49.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 12/24] docker: add extra libs to arm64
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
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tests/docker/dockerfiles/debian-arm64-cross.docker | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
> index f3db7f4f55..45b891d57a 100644
> --- a/tests/docker/dockerfiles/debian-arm64-cross.docker
> +++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
> @@ -16,3 +16,14 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>
>  # Specify the cross prefix for this image (see tests/docker/common.rc)
>  ENV QEMU_CONFIGURE_OPTS --cross-prefix=aarch64-linux-gnu-
> +
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        glusterfs-common:arm64 \
> +        libbz2-dev:arm64 \
> +        liblzo2-dev:arm64 \
> +        libncursesw5-dev:arm64 \
> +        libnfs-dev:arm64 \
> +        librdmacm-dev:arm64 \
> +        libsnappy-dev:arm64 \
> +        libxen-dev:arm64


--
Alex Bennée
