Received: from eggs.gnu.org ([2001:4830:134:3::10]:45908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ebkAM-0000oh-Ty
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ebkAK-0004rw-B9
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:37:54 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:41732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ebkAK-0004rJ-52
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:37:52 -0500
Received: by mail-wr0-x242.google.com with SMTP id o7so18147142wro.8
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 01:37:52 -0800 (PST)
References: <20180115143500.22631-1-f4bug@amsat.org>
	<20180115143500.22631-2-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180115143500.22631-2-f4bug@amsat.org>
Date: Wed, 17 Jan 2018 09:37:49 +0000
Message-ID: <878tcwomfm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/8] docker: sort images list displayed
 by 'make docker'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> we can now directly see different version sort consecutively.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

I of course meant:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  tests/docker/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index de87341528..ef95703cef 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -4,7 +4,7 @@
>
>  DOCKER_SUFFIX :=3D .docker
>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
> -DOCKER_IMAGES :=3D $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.=
docker)))
> +DOCKER_IMAGES :=3D $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_=
DIR)/*.docker))))
>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>  # Use a global constant ccache directory to speed up repetitive builds
>  DOCKER_CCACHE_DIR :=3D $$HOME/.cache/qemu-docker-ccache


--
Alex Benn=C3=A9e
