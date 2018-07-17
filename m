Received: from eggs.gnu.org ([2001:4830:134:3::10]:34154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffQrN-0001Dw-FY
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffQrM-00071R-EC
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:21:49 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:40212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffQrM-00070R-8l
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:21:48 -0400
Received: by mail-oi0-x242.google.com with SMTP id w126-v6so2325294oie.7
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 07:21:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180714171601.5734-11-luc.michel@greensocs.com>
References: <20180714171601.5734-1-luc.michel@greensocs.com>
	<20180714171601.5734-11-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 15:21:27 +0100
Message-ID: <CAFEAcA-_EXpj+G=eoW5wptnkU6s3OfeT25Kadzr_mWP7hf6x4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 10/20] intc/arm_gic: Implement
 virtualization extensions in gic_(activate_irq|drop_prio)
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
> Implement virtualization extensions in gic_activate_irq() and
> gic_drop_prio() and in gic_get_prio_from_apr_bits() called by
> gic_drop_prio().
>
> When the current CPU is a vCPU:
>   - Use GIC_VIRT_MIN_BPR and GIC_VIRT_NR_APRS instead of their non-virt
>   counterparts,
>   - the vCPU APR is stored in the virtual interface, in h_apr.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
