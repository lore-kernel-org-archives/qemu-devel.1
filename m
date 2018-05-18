Received: from eggs.gnu.org ([2001:4830:134:3::10]:35977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJhJY-0001XB-Pw
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJhJX-00033h-To
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:29:04 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-28-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <13cbc8f7-ed4b-e302-3a6c-b8791a21047b@amsat.org>
Date: Fri, 18 May 2018 12:28:49 -0300
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-28-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 27/49] tests/tcg: enable building for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "open list:ARM" <qemu-arm@nongnu.org>

On 05/17/2018 02:46 PM, Alex Bennée wrote:
> This allows us to use the docker cross compiler image to build these
> tests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/arm/Makefile.include | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 tests/tcg/arm/Makefile.include
> 
> diff --git a/tests/tcg/arm/Makefile.include b/tests/tcg/arm/Makefile.include
> new file mode 100644
> index 0000000000..8e7eac008f
> --- /dev/null
> +++ b/tests/tcg/arm/Makefile.include
> @@ -0,0 +1,8 @@
> +# Makefile.include for all ARM targets
> +#
> +# We don't have any bigendian build tools so we only use this for armhf
> +
> +ifeq ($(TARGET_NAME),arm)
> +DOCKER_IMAGE=debian-armhf-cross

[Note for a later series:]
Since this image comes with ARMv7 libraries, I find clearer to rename as
arm32v7, following new Docker scheme. This will ease to add arm32v6 (and
arm32v5 if possible...)

> +DOCKER_CROSS_COMPILER=arm-linux-gnueabihf-gcc
> +endif
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
