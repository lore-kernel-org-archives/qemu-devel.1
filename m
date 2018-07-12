Received: from eggs.gnu.org ([2001:4830:134:3::10]:54657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdbW8-0006EG-UC
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdbW8-0001T7-4f
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:20:20 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdbW7-0001Sf-UN
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:20:20 -0400
Received: by mail-oi0-x241.google.com with SMTP id i12-v6so55714262oik.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 06:20:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629132954.24269-12-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-12-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 14:19:58 +0100
Message-ID: <CAFEAcA_c34WEGeG5OnRZhxhMFLf0AX68RtS__kjo+OJqEWUbMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 11/20] intc/arm_gic: Implement
 virtualization extensions in gic_acknowledge_irq
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

On 29 June 2018 at 14:29, Luc Michel <luc.michel@greensocs.com> wrote:
> Implement virtualization extensions in the gic_acknowledge_irq()
> function. This function changes the state of the highest priority IRQ
> from pending to active.
>
> When the current CPU is a vCPU, modifying the state of an IRQ modifies
> the corresponding LR entry. However if we clear the pending flag before
> setting the active one, we lose track of the LR entry as it becomes
> invalid. The next call to gic_get_lr_entry() will fail.
>
> To overcome this issue, we call gic_activate_irq() before
> gic_clear_pending(). This does not change the general behaviour of
> gic_acknowledge_irq.
>
> We also move the SGI case in gic_clear_pending_sgi() to enhance
> code readability as the virtualization extensions support adds a if-else
> level.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
