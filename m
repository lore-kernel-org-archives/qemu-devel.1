Received: from eggs.gnu.org ([209.51.188.92]:38266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ6hb-0003IR-CE
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ6QM-0000fI-DA
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:10:12 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ6QM-0000dQ-6u
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:10:10 -0400
Received: by mail-pf1-x444.google.com with SMTP id 8so8385342pfr.4
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 18:10:10 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-22-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8ab80d37-fc52-55ba-71b1-635a535f6c5a@linaro.org>
Date: Tue, 23 Apr 2019 18:10:05 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-22-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/26] target/arm: New function
 armv7m_nvic_set_pending_lazyfp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 4/16/19 5:57 AM, Peter Maydell wrote:
> In the v7M architecture, if an exception is generated in the process
> of doing the lazy stacking of FP registers, the handling of
> possible escalation to HardFault is treated differently to the normal
> approach: it works based on the saved information about exception
> readiness that was stored in the FPCCR when the stack frame was
> created. Provide a new function armv7m_nvic_set_pending_lazyfp()
> which pends exceptions during lazy stacking, and implements
> this logic.
> 
> This corresponds to the pseudocode TakePreserveFPException().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      | 12 ++++++
>  hw/intc/armv7m_nvic.c | 96 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
