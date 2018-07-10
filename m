Received: from eggs.gnu.org ([2001:4830:134:3::10]:41525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcwBj-0007Pi-HK
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcwBi-0002C7-HI
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:12:31 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:42512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcwBi-0002Be-CW
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:12:30 -0400
Received: by mail-oi0-x243.google.com with SMTP id n84-v6so44036300oib.9
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 10:12:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629132954.24269-6-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-6-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jul 2018 18:12:09 +0100
Message-ID: <CAFEAcA8xpsuCP7eM=tCxzH5kf6xw2GrPWaEVw6hdhUwMzhSHXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 05/20] intc/arm_gic: Add the
 virtualization extensions to the GIC state
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
> Add the necessary parts of the virtualization extensions state to the
> GIC state. We choose to increase the size of the CPU interfaces state to
> add space for the vCPU interfaces (the GIC_NCPU_VCPU macro). This way,
> we'll be able to reuse most of the CPU interface code for the vCPUs.
>
> The only exception is the APR value, which is stored in h_apr in the
> virtual interface state for vCPUs. This is due to some complications
> with the GIC VMState, for which we don't want to break backward
> compatibility. APRs being stored in 2D arrays, increasing the second
> dimension would lead to some ugly VMState description. To avoid
> that, we keep it in h_apr for vCPUs.
>
> The vCPUs are numbered from GIC_NCPU to (GIC_NCPU * 2) - 1. The
> `gic_is_vcpu` function help to determine if a given CPU id correspond to
> a physical CPU or a virtual one.
>
> For the in-kernel KVM VGIC, since the exposed VGIC does not implement
> the virtualization extensions, we report an error if the corresponding
> property is set to true.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
