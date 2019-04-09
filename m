Received: from eggs.gnu.org ([209.51.188.92]:36006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDtnk-0000aP-RX
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDtnj-0007Ox-Gk
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:40:48 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDtnj-0007OP-4k
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:40:47 -0400
Received: by mail-ot1-x341.google.com with SMTP id c16so16187210otn.4
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190409155635.10276-1-aruna.15@cse.mrt.ac.lk>
In-Reply-To: <20190409155635.10276-1-aruna.15@cse.mrt.ac.lk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 17:40:34 +0100
Message-ID: <CAFEAcA-k0KEsjb0VvbhhkpvTN7nFBDNtqKwx-Lai5uYbCkztJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/4] Header cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On Tue, 9 Apr 2019 at 16:58, Aruna Jayasena <aruna.15@cse.mrt.ac.lk> wrote:
>
> Removed unwanted includes from cpu-common.h
> This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks
>
> Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
>
> ---
>  include/exec/cpu-common.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index cef8b88a2a..a3594f3f50 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -7,8 +7,6 @@
>  #include "exec/hwaddr.h"
>  #endif
>
> -#include "qemu/bswap.h"
> -#include "qemu/queue.h"
>  #include "qemu/fprintf-fn.h"
>

I was surprised that no .c files are implicitly relying
on these includes, but apparently none are, so we can
safely remove them.

A couple of notes:
 * this doesn't need to go to qemu-stable as it's just a
   code cleanup
 * did something go wrong with your sending of this patch?
   Its subject is "PATCH 0/4" which would usually indicate
   a cover letter for a four-patch series, but this seems
   to be a stand-alone patch.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
