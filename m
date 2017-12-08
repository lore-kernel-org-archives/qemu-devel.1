Received: from eggs.gnu.org ([2001:4830:134:3::10]:39824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eN6Xr-0005Mk-DQ
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:29:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eN6Xo-0004RA-Ab
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:29:39 -0500
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:44123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eN6Xo-0004PW-3g
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:29:36 -0500
Received: by mail-pg0-x22c.google.com with SMTP id j9so5641979pgc.11
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 16:29:35 -0800 (PST)
References: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2c0e18f3-f719-4a23-627e-b6bde8211a6e@linaro.org>
Date: Thu, 7 Dec 2017 16:29:31 -0800
MIME-Version: 1.0
In-Reply-To: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/12] Refactor get_phys_addr() not to
 return FSR values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Stefano Stabellini <sstabellini@kernel.org>, patches@linaro.org

On 12/05/2017 11:46 AM, Peter Maydell wrote:
> Edgar E. Iglesias (1):
>   target/arm: Extend PAR format determination
> 
> Peter Maydell (11):
>   target/arm: Provide fault type enum and FSR conversion functions
>   target/arm: Remove fsr argument from arm_ld*_ptw()
>   target/arm: Convert get_phys_addr_v5() to not return FSC values
>   target/arm: Convert get_phys_addr_v6() to not return FSC values
>   target/arm: Convert get_phys_addr_lpae() to not return FSC values
>   target/arm: Convert get_phys_addr_pmsav5() to not return FSC values
>   target/arm: Convert get_phys_addr_pmsav7() to not return FSC values
>   target/arm: Convert get_phys_addr_pmsav8() to not return FSC values
>   target/arm: Use ARMMMUFaultInfo in deliver_fault()
>   target/arm: Ignore fsr from get_phys_addr() in do_ats_write()
>   target/arm: Remove fsr argument from get_phys_addr() and
>     arm_tlb_fill()

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
