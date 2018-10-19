Received: from eggs.gnu.org ([2001:4830:134:3::10]:52571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDVby-0005Fa-Sa
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDVby-00010F-57
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:18:46 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDVbx-0000zM-M4
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:18:46 -0400
Received: by mail-oi1-x244.google.com with SMTP id e17-v6so26917925oib.4
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 07:18:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181017213932.19973-4-edgar.iglesias@gmail.com>
References: <20181017213932.19973-1-edgar.iglesias@gmail.com>
	<20181017213932.19973-4-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 15:18:24 +0100
Message-ID: <CAFEAcA9Dd3=52zReFVMgitYFeQsRA=guYsVMxy=0zHsLJ_+z_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 3/4] hw/arm: versal: Add a model of
 Xilinx Versal SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 17 October 2018 at 22:39, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add a model of Xilinx Versal SoC.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  default-configs/aarch64-softmmu.mak |   1 +
>  hw/arm/Makefile.objs                |   1 +
>  hw/arm/xlnx-versal.c                | 324 ++++++++++++++++++++++++++++
>  include/hw/arm/xlnx-versal.h        | 122 +++++++++++
>  4 files changed, 448 insertions(+)
>  create mode 100644 hw/arm/xlnx-versal.c
>  create mode 100644 include/hw/arm/xlnx-versal.h

> +    if (!kvm_irqchip_in_kernel()) {
> +        qdev_prop_set_bit(gicdev, "has-security-extensions", true);
> +    }

Do you really support KVM for this board/SoC ?

thanks
-- PMM
