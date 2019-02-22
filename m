Received: from eggs.gnu.org ([209.51.188.92]:35502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxInb-0003ai-H0
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 16:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxIna-0003IC-Lm
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 16:56:03 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxIna-0002kR-Bd
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 16:56:02 -0500
Received: by mail-pg1-x542.google.com with SMTP id j3so1683130pgm.11
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 13:55:54 -0800 (PST)
References: <20190222170936.13268-1-peter.maydell@linaro.org>
	<20190222170936.13268-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ce67ed48-a67a-de30-944b-a793c46d2a5c@linaro.org>
Date: Fri, 22 Feb 2019 13:55:50 -0800
MIME-Version: 1.0
In-Reply-To: <20190222170936.13268-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] target/arm: Use MVFR1 feature bits to
 gate A32/T32 FP16 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 2/22/19 9:09 AM, Peter Maydell wrote:
> Instead of gating the A32/T32 FP16 conversion instructions on
> the ARM_FEATURE_VFP_FP16 flag, switch to our new approach of
> looking at ID register bits. In this case MVFR1 fields FPHP
> and SIMDHP indicate the presence of these insns.
> 
> This change doesn't alter behaviour for any of our CPUs.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       | 37 ++++++++++++++++++++++++++++++++++++-
>  target/arm/cpu.c       |  2 --
>  target/arm/kvm32.c     |  3 ---
>  target/arm/translate.c | 26 ++++++++++++++++++--------
>  4 files changed, 54 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
