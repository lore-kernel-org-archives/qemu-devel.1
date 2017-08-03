Received: from eggs.gnu.org ([2001:4830:134:3::10]:56933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddODF-00083Y-Uw
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddODB-0007pg-RT
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:03:25 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-10-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <20ef352d-38d3-90bb-27ef-a6a644240b9b@twiddle.net>
Date: Thu, 3 Aug 2017 15:03:18 -0700
MIME-Version: 1.0
In-Reply-To: <1501692241-23310-10-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/15] target/arm: Don't store M profile
 PRIMASK and FAULTMASK in daif
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

On 08/02/2017 09:43 AM, Peter Maydell wrote:
> We currently store the M profile CPU register state PRIMASK and
> FAULTMASK in the daif field of the CPU state in its I and F
> bits. This is a legacy from the original implementation, which
> tried to share the cpu_exec_interrupt code between A profile
> and M profile. We've since separated out the two cases because
> they are significantly different, so now there is no common
> code between M and A profile which looks at env->daif: all the
> uses are either in A-only or M-only code paths. Sharing the state
> fields now is just confusing, and will make things awkward
> when we implement v8M, where the PRIMASK and FAULTMASK
> registers are banked between security states.
> 
> Switch M profile over to using v7m.faultmask and v7m.primask
> fields for these registers.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c |  4 ++--
>  target/arm/cpu.c      |  5 -----
>  target/arm/cpu.h      |  4 +++-
>  target/arm/helper.c   | 18 +++++-------------
>  target/arm/machine.c  | 33 +++++++++++++++++++++++++++++++++
>  5 files changed, 43 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
