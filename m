Received: from eggs.gnu.org ([209.51.188.92]:34761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIze7-0000Ca-Gf
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIzdv-0001DM-9l
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:55:46 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:35532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hIzdm-00010R-VO
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:55:38 -0400
Received: by mail-pg1-x530.google.com with SMTP id g8so7993594pgf.2
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 10:55:28 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ee47862f-a890-ad32-1fd1-974f09f19d8c@linaro.org>
Date: Tue, 23 Apr 2019 10:55:24 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/26] target/arm: Implement dummy versions
 of M-profile FP-related registers
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
> The M-profile floating point support has three associated config
> registers: FPCAR, FPCCR and FPDSCR. It also makes the registers
> CPACR and NSACR have behaviour other than reads-as-zero.
> Add support for all of these as simple reads-as-written registers.
> We will hook up actual functionality later.
> 
> The main complexity here is handling the FPCCR register, which
> has a mix of banked and unbanked bits.
> 
> Note that we don't share storage with the A-profile
> cpu->cp15.nsacr and cpu->cp15.cpacr_el1, though the behaviour
> is quite similar, for two reasons:
>  * the M profile CPACR is banked between security states
>  * it preserves the invariant that M profile uses no state
>    inside the cp15 substruct
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      |  34 ++++++++++++
>  hw/intc/armv7m_nvic.c | 125 ++++++++++++++++++++++++++++++++++++++++++
>  target/arm/cpu.c      |   5 ++
>  target/arm/machine.c  |  16 ++++++
>  4 files changed, 180 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
