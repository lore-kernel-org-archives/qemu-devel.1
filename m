Received: from eggs.gnu.org ([2001:4830:134:3::10]:43176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Czi-0001pG-2I
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Czh-0003zc-2a
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:05:13 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:41824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Czg-0003z0-U0
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:05:12 -0400
Received: by mail-qk0-x243.google.com with SMTP id s78so6007265qkl.8
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 10:05:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-32-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8ccf1143-5895-ca8b-eea5-c7d96c992455@amsat.org>
Date: Thu, 19 Apr 2018 14:05:07 -0300
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-32-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 31/43] tests/tcg: enable building for
 MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>

On 04/19/2018 10:58 AM, Alex Bennée wrote:
> This doesn't add any additional tests but enables building the
> multiarch tests for MIPS using docker cross compilers. We don't have a
> cross compiler for mips64 big endian though.

Oh we have one, using CFLAGS+=-EB

we don't have cross libraries although.

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
