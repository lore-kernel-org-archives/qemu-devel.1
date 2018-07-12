Received: from eggs.gnu.org ([2001:4830:134:3::10]:54627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fdfuo-0005Z2-Or
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 14:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fdful-0007ln-OW
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 14:02:06 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:52582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fdful-0007kS-H2
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 14:02:03 -0400
Received: by mail-it0-x243.google.com with SMTP id p4-v6so8063337itf.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 11:02:03 -0700 (PDT)
References: <20180712154152.32183-1-peter.maydell@linaro.org>
	<20180712154152.32183-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <995c9d02-e2d3-0f91-d135-56b25a694819@linaro.org>
Date: Thu, 12 Jul 2018 13:01:59 -0500
MIME-Version: 1.0
In-Reply-To: <20180712154152.32183-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0 2/2] hw/intc/arm_gic: Fix handling
 of GICD_ITARGETSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@web.de>, Luc Michel <luc.michel@greensocs.com>, patches@linaro.org

On 07/12/2018 10:41 AM, Peter Maydell wrote:
> The GICD_ITARGETSR implementation still has some 11MPCore behaviour
> that we were incorrectly using in our GICv1 and GICv2 implementations
> for the case where the interrupt number is less than GIC_INTERNAL.
> The desired behaviour here is:
>  * for 11MPCore: RAZ/WI for irqs 0..28; read a number matching the
>    CPU doing the read for irqs 29..31
>  * for GICv1 and v2: RAZ/WI if uniprocessor; otherwise read a
>    number matching the CPU doing the read for all irqs < 32
> 
> Stop squashing GICD_ITARGETSR to 0 for IRQs 0..28 unless this
> is an 11MPCore GIC.
> 
> Reported-by: Jan Kiszka <jan.kiszka@web.de>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gic.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
