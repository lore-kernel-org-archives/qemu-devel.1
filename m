Received: from eggs.gnu.org ([2001:4830:134:3::10]:53605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6YXt-0006Vu-5o
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6YXp-0008FJ-VG
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:25:01 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d6YXp-0008Dr-NQ
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:24:57 -0400
Received: by mail-wr0-x22d.google.com with SMTP id l50so19670360wrc.3
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 01:24:57 -0700 (PDT)
References: <20170505032340.26467-1-famz@redhat.com>
	<20170505032340.26467-2-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170505032340.26467-2-famz@redhat.com>
Date: Fri, 05 May 2017 09:25:36 +0100
Message-ID: <8760hfoglb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/5] docker: Run tests with current user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> We've used --add-current-user to create a user in the image, use it to
> run tests, because root has too much priviledge, and can surprise test
> cases.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tests/docker/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 03eda37..0ed8c3d 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -126,7 +126,7 @@ docker-run: docker-qemu-src
>  			"  COPYING $(EXECUTABLE) to $(IMAGE)"))
>  	$(call quiet-command,						\
>  		$(SRC_PATH)/tests/docker/docker.py run 			\
> -			-t 						\
> +			$(if $(NOUSER),,-u $(shell id -u)) -t 		\
>  			$(if $V,,--rm) 					\
>  			$(if $(DEBUG),-i,--net=none) 			\
>  			-e TARGET_LIST=$(TARGET_LIST) 			\


--
Alex Bennée
