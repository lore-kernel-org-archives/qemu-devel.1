Received: from eggs.gnu.org ([209.51.188.92]:44262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ5SJ-0003Pu-Fb
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ5SI-0001IU-IS
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:08:07 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:40625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ5SI-0001Hp-Ad
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:08:06 -0400
Received: by mail-pg1-x532.google.com with SMTP id d31so8417864pgl.7
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 17:08:06 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-20-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b888f650-cf17-b249-ecb9-7a9b9c2ae258@linaro.org>
Date: Tue, 23 Apr 2019 17:08:01 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-20-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/26] target/arm: Activate M-profile
 floating point context when FPCCR.ASPEN is set
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
> The M-profile FPCCR.ASPEN bit indicates that automatic floating-point
> context preservation is enabled. Before executing any floating-point
> instruction, if FPCCR.ASPEN is set and the CONTROL FPCA/SFPA bits
> indicate that there is no active floating point context then we
> must create a new context (by initializing FPSCR and setting
> FPCA/SFPA to indicate that the context is now active). In the
> pseudocode this is handled by ExecuteFPCheck().
> 
> Implement this with a new TB flag which tracks whether we
> need to create a new FP context.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       |  2 ++
>  target/arm/translate.h |  1 +
>  target/arm/helper.c    | 13 +++++++++++++
>  target/arm/translate.c | 29 +++++++++++++++++++++++++++++
>  4 files changed, 45 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
