Received: from eggs.gnu.org ([2001:4830:134:3::10]:47416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fG8ny-0000le-HQ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fG8nx-0002TG-Nn
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:01:46 -0400
References: <20180508144358.13530-1-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a7107f6c-0e51-3c9a-ff64-524d0be6d28a@vivier.eu>
Date: Tue, 8 May 2018 22:01:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180508144358.13530-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] docker: Fix trivial typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, "open list:Trivial patches" <qemu-trivial@nongnu.org>

Le 08/05/2018 à 16:43, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/docker/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index de87341528..ef1a3e62eb 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -46,7 +46,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  
>  docker-image-debian-powerpc-cross: EXTRA_FILES:=$(SRC_PATH)/tests/docker/dockerfiles/debian-apt-fake.sh
>  
> -# Enforce dependancies for composite images
> +# Enforce dependencies for composite images
>  docker-image-debian: docker-image-debian9
>  docker-image-debian8-mxe: docker-image-debian8
>  docker-image-debian-amd64: docker-image-debian9
> 
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
