Received: from eggs.gnu.org ([209.51.188.92]:45577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ5WQ-0004Zp-Tl
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ5WQ-0004O8-1J
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:12:22 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ5WP-0004NV-Rj
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:12:21 -0400
Received: by mail-pg1-x543.google.com with SMTP id v2so5995580pge.13
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 17:12:21 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-21-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fa60ed75-12a1-7a82-ba34-32117f8d5a18@linaro.org>
Date: Tue, 23 Apr 2019 17:12:17 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-21-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/26] target/arm: New helper function
 arm_v7m_mmu_idx_all()
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
> Add a new helper function which returns the MMU index to use
> for v7M, where the caller specifies all of the security
> state, privilege level and whether the execution priority
> is negative, and reimplement the existing
> arm_v7m_mmu_idx_for_secstate_and_priv() in terms of it.
> 
> We are going to need this for the lazy-FP-stacking code.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Suggestions for better function name welcome.
> arm_v7m_mmu_idx_for_secstate_and_priv_and_negpri()
> just seems way too long and unwieldy...

Seems fine.

> ---
>  target/arm/cpu.h    |  7 +++++++
>  target/arm/helper.c | 14 +++++++++++---
>  2 files changed, 18 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
