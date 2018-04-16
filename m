Received: from eggs.gnu.org ([2001:4830:134:3::10]:38767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rnO-00069O-7I
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 20:14:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rnL-0002sR-0a
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 20:14:58 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rnK-0002sK-Sb
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 20:14:54 -0400
Received: by mail-qt0-x243.google.com with SMTP id p9so11300956qtn.0
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 17:14:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-18-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f9ea467d-557e-b466-3e2a-f21c3f583fe0@amsat.org>
Date: Sun, 15 Apr 2018 21:14:51 -0300
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 17/24] tests/tcg: move ARM specific
 tests into subdir
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
> These only need to be built for ARM guests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/tcg/README                      |  9 ---------
>  tests/tcg/arm/README                  | 11 +++++++++++
>  tests/tcg/{ => arm}/hello-arm.c       |  0
>  tests/tcg/{ => arm}/test-arm-iwmmxt.s |  0
>  4 files changed, 11 insertions(+), 9 deletions(-)
>  create mode 100644 tests/tcg/arm/README
>  rename tests/tcg/{ => arm}/hello-arm.c (100%)
>  rename tests/tcg/{ => arm}/test-arm-iwmmxt.s (100%)
> 
> diff --git a/tests/tcg/README b/tests/tcg/README
> index 469504c4cb..625f2326e6 100644
> --- a/tests/tcg/README
> +++ b/tests/tcg/README
> @@ -5,15 +5,6 @@ or they are architecture specific.
>  
>  
>  
> -ARM
> -===
> -
> -hello-arm
> ----------
> -
> -test-arm-iwmmxt
> ----------------
> -
>  MIPS
>  ====
>  
> diff --git a/tests/tcg/arm/README b/tests/tcg/arm/README
> new file mode 100644
> index 0000000000..e6307116e2
> --- /dev/null
> +++ b/tests/tcg/arm/README
> @@ -0,0 +1,11 @@
> +These are ARM specific guest programs
> +
> +hello-arm
> +---------
> +
> +A very simple inline assembly, write syscall based hello world
> +
> +test-arm-iwmmxt
> +---------------
> +
> +A simple test case for older iwmmxt extended ARMs
> diff --git a/tests/tcg/hello-arm.c b/tests/tcg/arm/hello-arm.c
> similarity index 100%
> rename from tests/tcg/hello-arm.c
> rename to tests/tcg/arm/hello-arm.c
> diff --git a/tests/tcg/test-arm-iwmmxt.s b/tests/tcg/arm/test-arm-iwmmxt.s
> similarity index 100%
> rename from tests/tcg/test-arm-iwmmxt.s
> rename to tests/tcg/arm/test-arm-iwmmxt.s
> 
