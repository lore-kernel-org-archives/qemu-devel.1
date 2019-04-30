Received: from eggs.gnu.org ([209.51.188.92]:51327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLWkm-0006eu-A2
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLWkl-00044H-44
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:41:16 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:34279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLWkk-00043W-V7
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:41:15 -0400
Received: by mail-pf1-x431.google.com with SMTP id b3so7426894pfd.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 10:41:14 -0700 (PDT)
References: <20190430131439.25251-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <40ece7b0-e211-dda4-7734-7d714ab5b6d0@linaro.org>
Date: Tue, 30 Apr 2019 10:40:53 -0700
MIME-Version: 1.0
In-Reply-To: <20190430131439.25251-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] target/arm: four minor M-profile bug
 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 4/30/19 6:14 AM, Peter Maydell wrote:
> Peter Maydell (4):
>   hw/arm/armv7m_nvic: Check subpriority in nvic_recompute_state_secure()
>   hw/intc/armv7m_nvic: NS BFAR and BFSR are RAZ/WI if BFHFNMINS == 0
>   hw/intc/armv7m_nvic: Don't enable ARMV7M_EXCP_DEBUG from reset
>   target/arm: Implement XPSR GE bits

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
