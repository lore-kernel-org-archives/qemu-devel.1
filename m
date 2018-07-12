Received: from eggs.gnu.org ([2001:4830:134:3::10]:53380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fdfq1-0003mF-IR
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 13:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fdfpx-0003sX-Cu
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 13:57:09 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:50982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fdfpx-0003sK-5q
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 13:57:05 -0400
Received: by mail-it0-x244.google.com with SMTP id w16-v6so8055334ita.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 10:57:04 -0700 (PDT)
References: <20180712154152.32183-1-peter.maydell@linaro.org>
	<20180712154152.32183-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4374f002-e934-05f2-12ea-45e3880d2973@linaro.org>
Date: Thu, 12 Jul 2018 12:57:01 -0500
MIME-Version: 1.0
In-Reply-To: <20180712154152.32183-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0 1/2] hw/intc/arm_gic: Check
 interrupt number in gic_deactivate_irq()
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
> In gic_deactivate_irq() the interrupt number comes from the guest
> (on a write to the GICC_DIR register), so we need to sanity check
> that it isn't out of range before we use it as an array index.
> Handle this in a similar manner to the check we do in
> gic_complete_irq() for the GICC_EOI register.
> 
> The array overrun is not disastrous because the calling code
> uses (value & 0x3ff) to extract the interrupt field, so the
> only out-of-range values possible are 1020..1023, which allow
> overrunning only from irq_state[] into the following
> irq_target[] array which the guest can already manipulate.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gic.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
