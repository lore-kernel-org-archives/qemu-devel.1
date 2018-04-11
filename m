Received: from eggs.gnu.org ([2001:4830:134:3::10]:47060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f6HOB-0001hH-Gy
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f6HO7-0002Dd-B2
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:10:23 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f6HO7-0002CF-5l
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:10:19 -0400
Received: by mail-qk0-x242.google.com with SMTP id g7so2198957qkm.1
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 08:10:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-9-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f52515e3-9159-5c3c-d4e0-e3c7a117522d@amsat.org>
Date: Wed, 11 Apr 2018 12:10:12 -0300
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 08/24] docker: Makefile.include
 introduce DOCKER_SCRIPT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, famz@redhat.com, cota@braap.org

On 04/10/2018 04:39 PM, Alex Bennée wrote:
> Define this in one place to make it easy to re-use.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/Makefile.include | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index de87341528..6a5aa9ec71 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -14,6 +14,8 @@ DOCKER_TESTS := $(notdir $(shell \
>  
>  DOCKER_TOOLS := travis
>  
> +DOCKER_SCRIPT=$(SRC_PATH)/tests/docker/docker.py
> +
>  TESTS ?= %
>  IMAGES ?= %
>  
> @@ -37,7 +39,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  		echo WARNING: EXECUTABLE is not set, debootstrap may fail. 2>&1 ; \
>  	fi
>  	$(call quiet-command,\
> -		$(SRC_PATH)/tests/docker/docker.py build qemu:$* $< \
> +		$(DOCKER_SCRIPT) build qemu:$* $< \
>  		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
>  		$(if $(NOUSER),,--add-current-user) \
>  		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))\
> @@ -129,11 +131,11 @@ docker-run: docker-qemu-src
>  	fi
>  	$(if $(EXECUTABLE),						\
>  		$(call quiet-command,					\
> -			$(SRC_PATH)/tests/docker/docker.py update 	\
> +			$(DOCKER_SCRIPT) update 			\
>  			$(IMAGE) $(EXECUTABLE),				\
>  			"  COPYING $(EXECUTABLE) to $(IMAGE)"))
>  	$(call quiet-command,						\
> -		$(SRC_PATH)/tests/docker/docker.py run 			\
> +		$(DOCKER_SCRIPT) run 					\
>  			$(if $(NOUSER),,-u $(shell id -u)) 		\
>  			--security-opt seccomp=unconfined		\
>  			$(if $V,,--rm) 					\
> @@ -163,4 +165,4 @@ docker-run-%:
>  	@$(MAKE) docker-run TEST=$(CMD) IMAGE=qemu:$(IMAGE)
>  
>  docker-clean:
> -	$(call quiet-command, $(SRC_PATH)/tests/docker/docker.py clean)
> +	$(call quiet-command, $(DOCKER_SCRIPT) clean)
> 
