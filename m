Received: from eggs.gnu.org ([2001:4830:134:3::10]:42559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cGnIG-0000H2-Jo
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cGnIC-00054F-OK
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:38:56 -0500
Received: from mail-wj0-f177.google.com ([209.85.210.177]:32945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cGnIC-00053v-Av
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:38:52 -0500
Received: by mail-wj0-f177.google.com with SMTP id xy5so100785837wjc.0
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 05:38:52 -0800 (PST)
References: <20161201051433.17168-1-bobby.prani@gmail.com>
	<20161201051433.17168-17-bobby.prani@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20161201051433.17168-17-bobby.prani@gmail.com>
Date: Tue, 13 Dec 2016 13:37:49 +0000
Message-ID: <87a8c0t0eq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 16/19] tests/tcg: Fix compilation of
 linux-test.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net


Pranith Kumar <bobby.prani@gmail.com> writes:

> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  tests/tcg/linux-test.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/tcg/linux-test.c b/tests/tcg/linux-test.c
> index 24fce2b..e676e39 100644
> --- a/tests/tcg/linux-test.c
> +++ b/tests/tcg/linux-test.c
> @@ -41,6 +41,8 @@
>  #include <dirent.h>
>  #include <setjmp.h>
>  #include <sys/shm.h>
> +#include <stdbool.h>
> +#include <sys/resource.h>
>  #include "qemu/compiler.h"
>  #include "qemu/cutils.h"

Should this be merged with patch 6/19?

--
Alex Bennée
