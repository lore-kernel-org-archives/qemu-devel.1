Received: from eggs.gnu.org ([2001:4830:134:3::10]:45378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e2wN5-0003uC-Uf
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e2wN1-0008Pa-Sl
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:35:11 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:52339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e2wN1-0008P8-MC
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:35:07 -0400
Received: by mail-wm0-x229.google.com with SMTP id k4so20106940wmc.1
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 02:35:07 -0700 (PDT)
References: <20171013011954.9975-1-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171013011954.9975-1-famz@redhat.com>
Date: Fri, 13 Oct 2017 10:35:04 +0100
Message-ID: <87mv4v9yrb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: Don't allocate tty unless DEBUG=1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


Fam Zheng <famz@redhat.com> writes:

> The existence of tty in the container seems to urge gcc into colorize
> the output, but the escape chars will clutter the report once turned
> into email replies on patchew. Move -t to debug mode.
>
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>

I certainly improves my Emacs compilation-mode buffer when applied:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/docker/Makefile.include | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 6f9ea196a7..ab939f2bec 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -134,10 +134,10 @@ docker-run: docker-qemu-src
>  			"  COPYING $(EXECUTABLE) to $(IMAGE)"))
>  	$(call quiet-command,						\
>  		$(SRC_PATH)/tests/docker/docker.py run 			\
> -			$(if $(NOUSER),,-u $(shell id -u)) -t 		\
> +			$(if $(NOUSER),,-u $(shell id -u)) 		\
>  			--security-opt seccomp=3Dunconfined		\
>  			$(if $V,,--rm) 					\
> -			$(if $(DEBUG),-i,)				\
> +			$(if $(DEBUG),-ti,)				\
>  			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),--net=3D$(NETWORK)),--net=
=3Dnone) \
>  			-e TARGET_LIST=3D$(TARGET_LIST) 			\
>  			-e EXTRA_CONFIGURE_OPTS=3D"$(EXTRA_CONFIGURE_OPTS)" \


--
Alex Benn=C3=A9e
