Received: from eggs.gnu.org ([209.51.188.92]:56064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gwAM5-0007Oi-1P
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gwAM4-0001GE-0f
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:42:57 -0500
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:45546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gwAM3-0001G8-Ce
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:42:55 -0500
Received: by mail-yb1-xb42.google.com with SMTP id n134so5691464ybg.12
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 10:42:55 -0800 (PST)
MIME-Version: 1.0
References: <1550600059-5789-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1550600059-5789-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550600059-5789-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 19 Feb 2019 10:42:41 -0800
Message-ID: <CAMo8BfJxnZE=c6Co5UEi=W+ey=JQt4N70KEimr5YEbSQxQb9yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/9] tests/tcg: target/mips: Correct
 path to headers in some test source files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, arikalo@wavecomp.com, Peter Maydell <peter.maydell@linaro.org>, amarkovic@wavecomp.com, Aurelien Jarno <aurelien@aurel32.net>

On Tue, Feb 19, 2019 at 10:20 AM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Correct path to headers in tests/tcg/mips/user/ase/msa/bit-counting/*
> source files.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
> ---
>  tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_b.c | 6 +++---
>  tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_d.c | 6 +++---
>  tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_h.c | 6 +++---
>  tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_w.c | 6 +++---
>  tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_b.c | 6 +++---
>  tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_d.c | 6 +++---
>  tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_h.c | 6 +++---
>  tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_w.c | 6 +++---
>  tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_b.c | 6 +++---
>  tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_d.c | 6 +++---
>  tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_h.c | 6 +++---
>  tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_w.c | 6 +++---
>  12 files changed, 36 insertions(+), 36 deletions(-)
>
> diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_b.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_b.c
> index eb46290..d629431 100644
> --- a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_b.c
> +++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_b.c
> @@ -22,9 +22,9 @@
>  #include <sys/time.h>
>  #include <stdint.h>
>
> -#include "../../../include/wrappers_msa.h"
> -#include "../../../include/test_inputs.h"
> -#include "../../../include/test_utils.h"
> +#include "../../../../include/wrappers_msa.h"
> +#include "../../../../include/test_inputs.h"
> +#include "../../../../include/test_utils.h"

Wouldn't it be better to have path to include directory
somewhere in the CPPFLAGS, outside the test source code?

-- 
Thanks.
-- Max
