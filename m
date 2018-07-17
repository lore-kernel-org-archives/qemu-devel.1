Received: from eggs.gnu.org ([2001:4830:134:3::10]:50176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG8H-0004ND-BE
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG8D-00026N-Ey
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:54:33 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:39883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG8D-00026B-Ae
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:54:29 -0400
Received: by mail-vk0-x244.google.com with SMTP id e139-v6so21332728vkf.6
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 19:54:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180716020008.31468-1-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d89ffd4a-e1b1-984d-a87e-a0d265bea340@amsat.org>
Date: Mon, 16 Jul 2018 23:54:24 -0300
MIME-Version: 1.0
In-Reply-To: <20180716020008.31468-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests: vm: Add vm-clean-all
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

On 07/15/2018 11:00 PM, Fam Zheng wrote:
> The images are big. Add a rule to clean up easily.

Thanks :)

> 
> Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/vm/Makefile.include | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 5daa2a3b73..79e7866c8b 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -1,6 +1,6 @@
>  # Makefile for VM tests
>  
> -.PHONY: vm-build-all
> +.PHONY: vm-build-all vm-clean-all

Just noticed none of those are in the "vm-test" help message.

>  
>  IMAGES := ubuntu.i386 freebsd netbsd openbsd
>  IMAGE_FILES := $(patsubst %, tests/vm/%.img, $(IMAGES))
> @@ -17,6 +17,9 @@ vm-test:
>  
>  vm-build-all: $(addprefix vm-build-, $(IMAGES))
>  
> +vm-clean-all:
> +	rm -f $(IMAGE_FILES)
> +
>  tests/vm/%.img: $(SRC_PATH)/tests/vm/% \
>  		$(SRC_PATH)/tests/vm/basevm.py \
>  		$(SRC_PATH)/tests/vm/Makefile.include
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
