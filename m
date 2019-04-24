Received: from eggs.gnu.org ([209.51.188.92]:42638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ5Nd-0001DV-CJ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:03:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ5Km-0004Ib-81
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:00:21 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:43713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ5Kl-0004Ht-Vi
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:00:20 -0400
Received: by mail-pl1-x634.google.com with SMTP id n8so8289698plp.10
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 17:00:19 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-19-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6b4ad736-36eb-a459-1510-09fb50b2afb6@linaro.org>
Date: Tue, 23 Apr 2019 17:00:15 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-19-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/26] target/arm: Set FPCCR.S when
 executing M-profile floating point insns
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
> The M-profile FPCCR.S bit indicates the security status of
> the floating point context. In the pseudocode ExecuteFPCheck()
> function it is unconditionally set to match the current
> security state whenever a floating point instruction is
> executed.
> 
> Implement this by adding a new TB flag which tracks whether
> FPCCR.S is different from the current security state, so
> that we only need to emit the code to update it in the
> less-common case when it is not already set correctly.
> 
> Note that we will add the handling for the other work done
> by ExecuteFPCheck() in later commits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       |  2 ++
>  target/arm/translate.h |  1 +
>  target/arm/helper.c    |  5 +++++
>  target/arm/translate.c | 20 ++++++++++++++++++++
>  4 files changed, 28 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
