Received: from eggs.gnu.org ([2001:4830:134:3::10]:38367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rmZ-0005PC-CR
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 20:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rmY-0002Yw-LB
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 20:14:07 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:43593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rmY-0002Yi-Gg
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 20:14:06 -0400
Received: by mail-qk0-x243.google.com with SMTP id v2so14821205qkh.10
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 17:14:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-16-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b0479262-7f30-6c36-c9c1-775e36b4afd6@amsat.org>
Date: Sun, 15 Apr 2018 21:14:03 -0300
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 15/24] tests/tcg/i368: fix hello-i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: famz@redhat.com, cota@braap.org

On 04/10/2018 04:39 PM, Alex Bennée wrote:
> This is a direct syscall test so needs additional CFLAGS and LDFLAGS.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/tcg/i386/Makefile.target | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
> index 1df69e0dab..44803c0382 100644
> --- a/tests/tcg/i386/Makefile.target
> +++ b/tests/tcg/i386/Makefile.target
> @@ -9,6 +9,12 @@ CFLAGS+=$(CROSS_CC_GUEST_CFLAGS)
>  endif
>  endif
>  
> +#
> +# hello-i386 is a barebones app
> +#
> +hello-i386: CFLAGS+=-ffreestanding
> +hello-i386: LDFLAGS+=-nostdlib
> +
>  #
>  # test-386 includes a couple of additional objects that need to be linked together
>  #
> 
