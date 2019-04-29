Received: from eggs.gnu.org ([209.51.188.92]:46898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7Or-0005fG-9s
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7Oq-00049H-Gx
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:36:57 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL7Oq-00048i-2U
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:36:56 -0400
Received: by mail-oi1-x243.google.com with SMTP id k6so8471983oic.4
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-29-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-29-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:36:44 +0100
Message-ID: <CAFEAcA8=Tq4txdRkv2x04ZaaHBUnc1DCvvXOwdjOZj4JiQNVgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 28/36] target/xtensa: Use
 env_cpu, env_archcpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 28 Mar 2019 at 23:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> @@ -712,10 +707,15 @@ static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
>  #define XTENSA_CSBASE_LBEG_OFF_MASK 0x00ff0000
>  #define XTENSA_CSBASE_LBEG_OFF_SHIFT 16
>
> +typedef CPUXtensaState CPUArchState;
> +typedef XtensaCPU ArchCPU;
> +
> +#include "exec/cpu-all.h"

Shouldn't this bit be in an earlier patch ?

thanks
-- PMM
