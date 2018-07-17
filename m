Received: from eggs.gnu.org ([2001:4830:134:3::10]:36052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffQx8-0002rF-Ue
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffQx7-0001yI-VJ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:27:46 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:45630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffQx7-0001xu-Pn
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:27:45 -0400
Received: by mail-oi0-x242.google.com with SMTP id q11-v6so2344613oic.12
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 07:27:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180714171601.5734-17-luc.michel@greensocs.com>
References: <20180714171601.5734-1-luc.michel@greensocs.com>
	<20180714171601.5734-17-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 15:27:24 +0100
Message-ID: <CAFEAcA-FbMDNqWta1Vr0C=vh3CsxM9osVigQbE4rCYBBBQGTfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 16/20] intc/arm_gic: Implement
 gic_update_virt() function
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
> Add the gic_update_virt() function to update the vCPU interface states
> and raise vIRQ and vFIQ as needed. This commit renames gic_update() to
> gic_update_internal() and generalizes it to handle both cases, with a
> `virt' parameter to track whether we are updating the CPU or vCPU
> interfaces.
>
> The main difference between CPU and vCPU is the way we select the best
> IRQ. This part has been split into the gic_get_best_(v)irq functions.
> For the virt case, the LRs are iterated to find the best candidate.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  hw/intc/arm_gic.c | 186 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 146 insertions(+), 40 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
