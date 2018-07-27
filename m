Received: from eggs.gnu.org ([2001:4830:134:3::10]:59589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fj1jj-0003z2-6e
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fj1jf-0000fT-Uo
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:20:47 -0400
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:41083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fj1jf-0000fI-Og
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:20:43 -0400
Received: by mail-ua0-x244.google.com with SMTP id h1-v6so878087uao.8
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 05:20:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180727083445.21436-1-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <932e2506-0d0b-03d1-6687-9cccebde8755@amsat.org>
Date: Fri, 27 Jul 2018 09:20:39 -0300
MIME-Version: 1.0
In-Reply-To: <20180727083445.21436-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests/vm: Add vm-build-all/vm-clean-all in
 help text
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

On 07/27/2018 05:34 AM, Fam Zheng wrote:
> Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/vm/Makefile.include | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 5daa2a3b73..9e19f8662f 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -14,6 +14,9 @@ vm-test:
>  	@echo "  vm-build-freebsd                - Build QEMU in FreeBSD VM"
>  	@echo "  vm-build-netbsd                 - Build QEMU in NetBSD VM"
>  	@echo "  vm-build-openbsd                - Build QEMU in OpenBSD VM"
> +	@echo ""
> +	@echo "  vm-build-all                    - Build QEMU in all VMs"
> +	@echo "  vm-clean-all                    - Clean up VM images"
>  
>  vm-build-all: $(addprefix vm-build-, $(IMAGES))
>  
> 
