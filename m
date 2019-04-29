Received: from eggs.gnu.org ([209.51.188.92]:46077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLANc-0002hJ-Jv
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLANb-00012d-Qk
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:47:52 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLANb-00012I-Jl
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:47:51 -0400
Received: by mail-ot1-x343.google.com with SMTP id u15so9403186otq.10
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-4-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:47:39 +0100
Message-ID: <CAFEAcA8tZwmzrvvEv+Gx=AzdtNs_S+5vBkVQ2hqExzBxeDk=vA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 03/26] target/alpha: Convert to
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
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 3 Apr 2019 at 04:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/alpha/cpu.h        |  5 ++--
>  target/alpha/cpu.c        |  5 ++--
>  target/alpha/helper.c     | 50 +++++++++++++++++++++++----------------
>  target/alpha/mem_helper.c | 16 -------------
>  4 files changed, 35 insertions(+), 41 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
