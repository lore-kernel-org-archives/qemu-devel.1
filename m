Received: from eggs.gnu.org ([2001:4830:134:3::10]:56937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJgpL-0004WG-IW
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJgpH-0006yP-M9
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:57:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-31-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a21256f7-d319-11c2-9b81-f422008f0cab@amsat.org>
Date: Fri, 18 May 2018 11:57:20 -0300
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-31-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 30/49] tests/tcg: enable building for
 AArch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 05/17/2018 02:46 PM, Alex Bennée wrote:
> We only have compilers for the (default) little endian variants.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> ---
> v4
>   - update MAINTAINERS
> ---
>  MAINTAINERS                        | 1 +
>  tests/tcg/aarch64/Makefile.include | 8 ++++++++
>  2 files changed, 9 insertions(+)
>  create mode 100644 tests/tcg/aarch64/Makefile.include
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4e331c4db4..ee7f101890 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -136,6 +136,7 @@ L: qemu-arm@nongnu.org
>  S: Maintained
>  F: target/arm/
>  F: tests/tcg/arm/
> +F: tests/tcg/aarch64/
>  F: hw/arm/
>  F: hw/cpu/a*mpcore.c
>  F: include/hw/cpu/a*mpcore.h
> diff --git a/tests/tcg/aarch64/Makefile.include b/tests/tcg/aarch64/Makefile.include
> new file mode 100644
> index 0000000000..de32c91235
> --- /dev/null
> +++ b/tests/tcg/aarch64/Makefile.include
> @@ -0,0 +1,8 @@
> +# Makefile.include for AArch64 targets
> +#
> +# We don't have any bigendian build tools so we only use this for AArch64
> +
> +ifeq ($(TARGET_NAME),aarch64)
> +DOCKER_IMAGE=debian-arm64-cross
> +DOCKER_CROSS_COMPILER=aarch64-linux-gnu-gcc
> +endif
> 
