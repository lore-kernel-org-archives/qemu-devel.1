Received: from eggs.gnu.org ([2001:4830:134:3::10]:60361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fi2TA-0003u1-Qu
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fi2TA-0007DY-40
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:55:36 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fi2T9-0007Bd-TV
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:55:36 -0400
Received: by mail-pf1-x441.google.com with SMTP id j26-v6so1058935pfi.10
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 11:55:35 -0700 (PDT)
References: <20180724115950.17316-1-peter.maydell@linaro.org>
	<20180724115950.17316-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <81cef169-daf8-a25a-faee-033f58ea0da3@linaro.org>
Date: Tue, 24 Jul 2018 11:55:31 -0700
MIME-Version: 1.0
In-Reply-To: <20180724115950.17316-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] target/arm: Provide accessor functions
 for HCR_EL2.{IMO, FMO, AMO}
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

On 07/24/2018 04:59 AM, Peter Maydell wrote:
> The IMO, FMO and AMO bits in HCR_EL2 are defined to "behave as
> 1 for all purposes other than direct reads" if HCR_EL2.TGE
> is set and HCR_EL2.E2H is 0, and to "behave as 0 for all
> purposes other than direct reads" if HCR_EL2.TGE is set
> and HRC_EL2.E2H is 1.
> 
> To avoid having to check E2H and TGE everywhere where we test IMO and
> FMO, provide accessors arm_hcr_el2_imo(), arm_hcr_el2_fmo()and
> arm_hcr_el2_amo().  We don't implement ARMv8.1-VHE yet, so the E2H
> case will never be true, but we include the logic to save effort when
> we eventually do get to that.
> 
> (Note that in several of these callsites the change doesn't
> actually make a difference as either the callsite is handling
> TGE specially anyway, or the CPU can't get into that situation
> with TGE set; we change everywhere for consistency.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h          | 64 +++++++++++++++++++++++++++++++++++----
>  hw/intc/arm_gicv3_cpuif.c | 19 ++++++------
>  target/arm/helper.c       |  6 ++--
>  3 files changed, 71 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
