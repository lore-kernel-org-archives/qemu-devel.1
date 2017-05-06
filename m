Received: from eggs.gnu.org ([2001:4830:134:3::10]:46287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72Wa-0006s3-Ne
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72WX-0007uy-Jj
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:25:40 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72WX-0007ur-E0
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:25:37 -0400
Received: by mail-qk0-x243.google.com with SMTP id y128so4811097qka.3
	for <qemu-devel@nongnu.org>; Sat, 06 May 2017 09:25:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170505032340.26467-1-famz@redhat.com>
	<20170505032340.26467-2-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a188cded-e79e-d980-8c1f-cfe6be87f056@amsat.org>
Date: Sat, 6 May 2017 13:25:31 -0300
MIME-Version: 1.0
In-Reply-To: <20170505032340.26467-2-famz@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/05/2017 12:23 AM, Fam Zheng wrote:
> We've used --add-current-user to create a user in the image, use it to
> run tests, because root has too much priviledge, and can surprise test
> cases.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
>
