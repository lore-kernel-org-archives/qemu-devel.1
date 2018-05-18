Received: from eggs.gnu.org ([2001:4830:134:3::10]:52838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJgh2-0006b0-EE
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJggy-00070r-GX
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:49:16 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:44956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJggy-00070R-Bl
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:49:12 -0400
Received: by mail-qk0-x242.google.com with SMTP id z23-v6so1271879qki.11
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 07:49:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-35-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9ab7e1b4-ee7c-7468-769b-3c0927e93594@amsat.org>
Date: Fri, 18 May 2018 11:49:06 -0300
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-35-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 34/49] tests/tcg: enable building for
 MIPS
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
> This doesn't add any additional tests but enables building the
> multiarch tests for MIPS using docker cross compilers. We don't have a
> cross compiler for mips64 big endian though.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/mips/Makefile.include | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 tests/tcg/mips/Makefile.include
> 
> diff --git a/tests/tcg/mips/Makefile.include b/tests/tcg/mips/Makefile.include
> new file mode 100644
> index 0000000000..a9beceb623
> --- /dev/null
> +++ b/tests/tcg/mips/Makefile.include
> @@ -0,0 +1,17 @@
> +#
> +# Makefile.include for all MIPs targets
> +#
> +# As Debian doesn't support mip64 in big endian mode the only way to
> +# build BE is to pass a working cross compiler to ./configure
> +#
> +
> +ifeq ($(TARGET_NAME),mips64el)
> +DOCKER_IMAGE=debian-mips64el-cross
> +DOCKER_CROSS_COMPILER=mips64el-linux-gnuabi64-gcc
> +else ifeq ($(TARGET_NAME),mipsel)
> +DOCKER_IMAGE=debian-mipsel-cross
> +DOCKER_CROSS_COMPILER=mipsel-linux-gnu-gcc
> +else ifeq ($(TARGET_NAME),mips)
> +DOCKER_IMAGE=debian-mips-cross
> +DOCKER_CROSS_COMPILER=mips-linux-gnu-gcc
> +endif
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
