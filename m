Received: from eggs.gnu.org ([2001:4830:134:3::10]:35628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eblSw-0001Q7-E2
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 06:01:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eblSq-00038F-Jp
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 06:01:10 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:44258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eblSq-00037F-Dh
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 06:01:04 -0500
Received: by mail-wm0-x244.google.com with SMTP id t74so14411565wme.3
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 03:01:04 -0800 (PST)
References: <20180115143500.22631-1-f4bug@amsat.org>
	<20180115143500.22631-3-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180115143500.22631-3-f4bug@amsat.org>
Date: Wed, 17 Jan 2018 11:01:01 +0000
Message-ID: <876080oiky.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/8] docker: do not display deprecated
 images in 'make docker' help
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

> the 'debian' base image is deprecated since 3e11974988d8
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/docker/Makefile.include | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index ef95703cef..d5cf896966 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -4,7 +4,8 @@
>
>  DOCKER_SUFFIX :=3D .docker
>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
> -DOCKER_IMAGES :=3D $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_=
DIR)/*.docker))))
> +DOCKER_DEPRECATED_IMAGES :=3D debian
> +DOCKER_IMAGES :=3D $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(not=
dir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>  # Use a global constant ccache directory to speed up repetitive builds
>  DOCKER_CCACHE_DIR :=3D $$HOME/.cache/qemu-docker-ccache
> @@ -63,7 +64,7 @@ docker-image-debian-win64-cross: docker-image-debian8-m=
xe
>  docker-image-travis: NOUSER=3D1
>
>  # Expand all the pre-requistes for each docker image and test combination
> -$(foreach i,$(DOCKER_IMAGES), \
> +$(foreach i,$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES), \
>  	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
>  		$(eval .PHONY: docker-$t@$i) \
>  		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \


--
Alex Benn=C3=A9e
