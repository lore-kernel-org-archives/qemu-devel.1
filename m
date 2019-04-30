Received: from eggs.gnu.org ([209.51.188.92]:34750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPq7-0001Py-2D
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPc5-0002Ro-MD
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:03:50 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLPc5-0002RR-Gg
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:03:49 -0400
Received: by mail-ot1-x344.google.com with SMTP id 77so5193694otu.13
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 03:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-22-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-22-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 11:03:37 +0100
Message-ID: <CAFEAcA_6-1+Pk8k7Wr8bVjWsLnNwyVp4R0TyYiPvcBy_o8ZmWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 21/26] target/tricore: Convert to
 CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Wed, 3 Apr 2019 at 04:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/tricore/cpu.h       |  6 +++---
>  target/tricore/cpu.c       |  1 +
>  target/tricore/helper.c    | 27 +++++++++++++++++++--------
>  target/tricore/op_helper.c | 26 --------------------------
>  4 files changed, 23 insertions(+), 37 deletions(-)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
