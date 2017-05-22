Received: from eggs.gnu.org ([2001:4830:134:3::10]:33341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCnwD-0003e7-DM
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCnw9-00086v-Ba
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:03:57 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:34386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dCnw9-00086O-5X
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:03:53 -0400
Received: by mail-wm0-x233.google.com with SMTP id 123so12225627wmg.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 07:03:52 -0700 (PDT)
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-12-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170521032956.27446-12-f4bug@amsat.org>
Date: Mon, 22 May 2017 15:03:55 +0100
Message-ID: <8760gt3s50.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 11/24] docker: add extra libs to armhf
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
>  tests/docker/dockerfiles/debian-armhf-cross.docker | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
> index ba8d5a5167..e67dfdccc5 100644
> --- a/tests/docker/dockerfiles/debian-armhf-cross.docker
> +++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
> @@ -16,3 +16,14 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>
>  # Specify the cross prefix for this image (see tests/docker/common.rc)
>  ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabihf-
> +
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        glusterfs-common:armhf \
> +        libbz2-dev:armhf \
> +        liblzo2-dev:armhf \
> +        libncursesw5-dev:armhf \
> +        libnfs-dev:armhf \
> +        librdmacm-dev:armhf \
> +        libsnappy-dev:armhf \
> +        libxen-dev:armhf


--
Alex Bennée
