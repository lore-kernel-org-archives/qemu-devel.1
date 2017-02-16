Received: from eggs.gnu.org ([2001:4830:134:3::10]:58759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ceLy0-0006gY-6p
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:19:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ceLxx-0002if-2f
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:19:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ceLxw-0002hz-TG
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:19:21 -0500
Date: Thu, 16 Feb 2017 21:19:16 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170216131916.GB8817@lemon.lan>
References: <20170216123456.28621-1-alex.bennee@linaro.org>
	<20170216123456.28621-3-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170216123456.28621-3-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/4] new: debian docker targets for
 cross-compiling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On Thu, 02/16 12:34, Alex Benn=E9e wrote:
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 4778b27ca8..84bdcc944a 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -54,6 +54,10 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  		$(if $(EXECUTABLE),--include-executable=3D$(EXECUTABLE)),\
>  		"BUILD","$*")
> =20
> +# Enforce dependancies for composite images
> +docker-image-debian-armhf-cross: docker-image-debian
> +docker-image-debian-arm64-cross: docker-image-debian
> +

This is an interesting way to reuse parts, thanks!

Reviewed-by: Fam Zheng <famz@redhat.com>
