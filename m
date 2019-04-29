Received: from eggs.gnu.org ([209.51.188.92]:41537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLA5D-0003o5-LR
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLA5C-0005vN-Tc
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:28:51 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLA5C-0005ur-PA
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:28:50 -0400
Received: by mail-oi1-x242.google.com with SMTP id k6so8976124oic.4
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-25-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:28:38 +0100
Message-ID: <CAFEAcA8qcQoBdYJFhZ9ka=MekSM8U=PfVr1+ZdogHk_K0PuxRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 24/26] tcg: Use CPUClass::tlb_fill in
 cputlb.c
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

On Wed, 3 Apr 2019 at 05:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We can now use the CPUClass hook instead of a named function.
>
> Create a static tlb_fill function to avoid other changes within
> cputlb.c.  This also which also isolates the asserts implied.

I'm not sure what this sentence is trying to say ?

> Remove the named tlb_fill function from all of the targets.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
