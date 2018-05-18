Received: from eggs.gnu.org ([2001:4830:134:3::10]:52856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJgh5-0006eL-6z
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:49:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJgh4-00076f-5c
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:49:19 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:46127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJgh4-00076O-0r
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:49:18 -0400
Received: by mail-qt0-x241.google.com with SMTP id m16-v6so10558624qtg.13
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 07:49:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-36-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <740fd152-6fec-90c6-ab22-d949ded452dc@amsat.org>
Date: Fri, 18 May 2018 11:49:13 -0300
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-36-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 35/49] tests/tcg/mips: include common
 mips hello-mips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>

On 05/17/2018 02:47 PM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/mips/Makefile.target | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 tests/tcg/mips/Makefile.target
> 
> diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
> new file mode 100644
> index 0000000000..71f0c2dd53
> --- /dev/null
> +++ b/tests/tcg/mips/Makefile.target
> @@ -0,0 +1,19 @@
> +# -*- Mode: makefile -*-
> +#
> +# MIPS - included from tests/tcg/Makefile.target
> +#
> +
> +MIPS_SRC=$(SRC_PATH)/tests/tcg/mips
> +
> +# Set search path for all sources
> +VPATH 		+= $(MIPS_SRC)
> +
> +MIPS_TESTS=hello-mips
> +
> +TESTS += $(MIPS_TESTS)
> +
> +hello-mips: CFLAGS+=-ffreestanding
> +hello-mips: LDFLAGS+=-nostdlib
> +
> +# For MIPS32 and 64 we have a bunch of extra tests in sub-directories
> +# however they are intended for system tests.
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
