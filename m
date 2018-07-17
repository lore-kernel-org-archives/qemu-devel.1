Received: from eggs.gnu.org ([2001:4830:134:3::10]:60443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffQlX-0006ey-3R
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffQlW-0003NI-8U
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:15:47 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:39812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffQlW-0003Mu-0X
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:15:46 -0400
Received: by mail-oi0-x241.google.com with SMTP id d189-v6so2287861oib.6
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 07:15:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180714171601.5734-3-luc.michel@greensocs.com>
References: <20180714171601.5734-1-luc.michel@greensocs.com>
	<20180714171601.5734-3-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 15:15:24 +0100
Message-ID: <CAFEAcA_qp5vF4DghFThBmOJ5HvfPdZWhi7cDOR98nUWgBvyOYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 02/20] intc/arm_gic: Implement
 GICD_ISACTIVERn and GICD_ICACTIVERn registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>

On 14 July 2018 at 18:15, Luc Michel <luc.michel@greensocs.com> wrote:
> Implement GICD_ISACTIVERn and GICD_ICACTIVERn registers in the GICv2.
> Those registers allow to set or clear the active state of an IRQ in the
> distributor.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  hw/intc/arm_gic.c | 61 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 57 insertions(+), 4 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
