Received: from eggs.gnu.org ([2001:4830:134:3::10]:49187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxYb7-0003zv-2i
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxYb6-0005oq-AJ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:39:09 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxYb6-0005og-3P
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:39:08 -0400
Received: by mail-wm0-x236.google.com with SMTP id u2so36227089wmu.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 05:39:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <227ffc41850ba81199b74570afde9b833fdfb4a6.1491349058.git.alistair.francis@xilinx.com>
References: <cover.1491349058.git.alistair.francis@xilinx.com>
	<227ffc41850ba81199b74570afde9b833fdfb4a6.1491349058.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 13:38:46 +0100
Message-ID: <CAFEAcA8shFQV_SttJu4R_6eQpjew0_CRpoe+6fMJGiVc4eYPaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v1 5/5] xlnx-zynqmp: Set the Cadence GEM
 revision
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>

On 5 April 2017 at 00:40, Alistair Francis <alistair.francis@xilinx.com> wrote:
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>
>  hw/arm/xlnx-zynqmp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index bc4e66b..e41b6fe 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -30,6 +30,8 @@
>  #define ARM_PHYS_TIMER_PPI  30
>  #define ARM_VIRT_TIMER_PPI  27
>
> +#define GEM_REVISION        0x40070106
> +
>  #define GIC_BASE_ADDR       0xf9000000
>  #define GIC_DIST_ADDR       0xf9010000
>  #define GIC_CPU_ADDR        0xf9020000
> @@ -334,8 +336,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>              qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
>              qdev_set_nic_properties(DEVICE(&s->gem[i]), nd);
>          }
> +        object_property_set_int(OBJECT(&s->gem[i]), GEM_REVISION, "revision",
> +                                &error_abort);
>          object_property_set_int(OBJECT(&s->gem[i]), 2, "num-priority-queues",
> -                                  &error_abort);
> +                                &error_abort);
>          object_property_set_bool(OBJECT(&s->gem[i]), true, "realized", &err);
>          if (err) {
>              error_propagate(errp, err);
> --
> 2.9.3

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
