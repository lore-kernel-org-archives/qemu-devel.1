Received: from eggs.gnu.org ([2001:4830:134:3::10]:43269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFlZ-00076x-QF
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFlV-0007Ry-St
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:59:29 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:36709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekFlV-0007Qn-Ly
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:59:25 -0500
Received: by mail-it0-x241.google.com with SMTP id n206so12266332itg.1
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 12:59:25 -0800 (PST)
References: <20180209165810.6668-1-peter.maydell@linaro.org>
	<20180209165810.6668-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0982d2ff-9a74-3c96-7048-220bcfad241f@linaro.org>
Date: Fri, 9 Feb 2018 12:59:21 -0800
MIME-Version: 1.0
In-Reply-To: <20180209165810.6668-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/11] hw/intc/armv7m_nvic: Implement
 cache ID registers
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

On 02/09/2018 08:58 AM, Peter Maydell wrote:
> M profile cores have a similar setup for cache ID registers
> to A profile:
>  * Cache Level ID Register (CLIDR) is a fixed value
>  * Cache Type Register (CTR) is a fixed value
>  * Cache Size ID Registers (CCSIDR) are a bank of registers;
>    which one you see is selected by the Cache Size Selection
>    Register (CSSELR)
> 
> The only difference is that they're in the NVIC memory mapped
> register space rather than being coprocessor registers.
> Implement the M profile view of them.
> 
> Since neither Cortex-M3 nor Cortex-M4 implement caches,
> we don't need to update their init functions and can leave
> the ctr/clidr/ccsidr[] fields in their ARMCPU structs at zero.
> Newer cores (like the Cortex-M33) will want to be able to
> set these ID registers to non-zero values, though.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2 changes: use FIELD() to define some constants;
> add compile-time assert that we won't index outside cssidr[]
> ---
>  target/arm/cpu.h      | 26 ++++++++++++++++++++++++++
>  hw/intc/armv7m_nvic.c | 16 ++++++++++++++++
>  target/arm/machine.c  | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
