Received: from eggs.gnu.org ([209.51.188.92]:37323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ0Ir-0007od-Fi
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ0Io-0000NH-7t
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:38:00 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ0In-000081-81
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:37:57 -0400
Received: by mail-pg1-x543.google.com with SMTP id y3so8018907pgk.12
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 11:37:31 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <db9ceec5-3297-bbcd-be28-b4bdbd0f6b5d@linaro.org>
Date: Tue, 23 Apr 2019 11:37:27 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/26] target/arm: Decode FP instructions
 for M profile
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
> Correct the decode of the M-profile "coprocessor and
> floating-point instructions" space:
>  * op0 == 0b11 is always unallocated
>  * if the CPU has an FPU then all insns with op1 == 0b101
>    are floating point and go to disas_vfp_insn()
> 
> For the moment we leave VLLDM and VLSTM as NOPs; in
> a later commit we will fill in the proper implementation
> for the case where an FPU is present.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
