Received: from eggs.gnu.org ([2001:4830:134:3::10]:39956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebdC4-0002qS-UN
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:11:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebdC0-0000os-0J
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:11:12 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1ebdBz-0000o6-RO
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:11:07 -0500
Received: by mail-pf0-f196.google.com with SMTP id k19so10710425pfj.5
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 18:11:07 -0800 (PST)
From: Fam Zheng <fzheng@redhat.com>
References: <20180112125000.27256-1-f4bug@amsat.org>
	<20180112125000.27256-3-f4bug@amsat.org>
Message-ID: <c90deebc-f06f-4d68-ed27-d210849eb5c0@redhat.com>
Date: Wed, 17 Jan 2018 10:10:54 +0800
MIME-Version: 1.0
In-Reply-To: <20180112125000.27256-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 2/7] docker: do not display deprecated
 images in 'make docker' help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org



On 01/12/2018 08:49 PM, Philippe Mathieu-Daudé wrote:
> the 'debian' base image is deprecated since 3e11974988d8
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   tests/docker/Makefile.include | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index ef95703cef..f0cd26c2b6 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -4,7 +4,8 @@
>   
>   DOCKER_SUFFIX := .docker
>   DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
> -DOCKER_IMAGES := $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker))))
> +DOCKER_DEPRECATED_IMAGES := debian
> +DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
>   DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>   # Use a global constant ccache directory to speed up repetitive builds
>   DOCKER_CCACHE_DIR := $$HOME/.cache/qemu-docker-ccache

While we are at it, could you please just spell out this list 
explicitly, consistent to how we build obj-y variables?
