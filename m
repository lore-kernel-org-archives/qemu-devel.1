Received: from eggs.gnu.org ([209.51.188.92]:41878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLA6R-000588-6f
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLA6Q-0006Rk-Cs
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:30:07 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLA6Q-0006RO-8L
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:30:06 -0400
Received: by mail-ot1-x343.google.com with SMTP id w6so9374706otl.7
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-26-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-26-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:29:53 +0100
Message-ID: <CAFEAcA-FYom0R+LgxHKGUJUpKyb4xFJdWzjsgh8s+aO20P3Pag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 25/26] tcg: Remove
 CPUClass::handle_mmu_fault
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

On Wed, 3 Apr 2019 at 05:03, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This hook is now completely replaced by tlb_fill.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
