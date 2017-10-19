Received: from eggs.gnu.org ([2001:4830:134:3::10]:51857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e59s8-0005Cm-Cx
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 08:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e59s7-0000Hc-Hm
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 08:24:24 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <150841324224.31292.4012464539983692364.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <75a0ecaa-f45b-b4a8-131d-97b52fca2ccd@amsat.org>
Date: Thu, 19 Oct 2017 09:24:15 -0300
MIME-Version: 1.0
In-Reply-To: <150841324224.31292.4012464539983692364.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] docker: fix out-of-tree
 'make docker-test-build@debian-powerpc-cross'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/19/2017 08:40 AM, Greg Kurz wrote:
> Without this patch, it fails with:
> 
> IOError: [Errno 2] No such file or directory:
>  'tests/docker/dockerfiles/debian-apt-fake.sh'

Yes, my bad :)

I have the same fix in my CI-WIP branch which sadly lacks of love.

> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/Makefile.include |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 6f9ea196a7b8..5d54eca5d0b3 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -44,7 +44,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
>  		"BUILD","$*")
>  
> -docker-image-debian-powerpc-cross: EXTRA_FILES:=tests/docker/dockerfiles/debian-apt-fake.sh
> +docker-image-debian-powerpc-cross: EXTRA_FILES:=$(SRC_PATH)/tests/docker/dockerfiles/debian-apt-fake.sh
>  
>  # Enforce dependancies for composite images
>  docker-image-debian: docker-image-debian9
