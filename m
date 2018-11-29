Received: from eggs.gnu.org ([2001:4830:134:3::10]:57857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gSVS1-0001dP-Qp
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 18:10:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gSVS1-00010j-14
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 18:10:29 -0500
MIME-Version: 1.0
References: <20181129163655.20370-1-edgar.iglesias@gmail.com>
	<20181129163655.20370-5-edgar.iglesias@gmail.com>
In-Reply-To: <20181129163655.20370-5-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 Nov 2018 15:10:00 -0800
Message-ID: <CAKmqyKOKwuBpdq-xWwmpGK0eTapX2QR8mYcWw09ESgTtZO1sQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 4/4] hw/arm: versal: Correct the nr of
 IRQs to 192
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Iglesias <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, KONRAD Frederic <frederic.konrad@adacore.com>, muhammad_bilal@mentor.com, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Luc Michel <luc.michel@greensocs.com>

On Thu, Nov 29, 2018 at 8:40 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Correct the nr of IRQs to 192.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/arm/xlnx-versal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 76fb9de391..ec7c859d08 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -22,7 +22,7 @@
>  #define XLNX_VERSAL_NR_ACPUS   2
>  #define XLNX_VERSAL_NR_UARTS   2
>  #define XLNX_VERSAL_NR_GEMS    2
> -#define XLNX_VERSAL_NR_IRQS    256
> +#define XLNX_VERSAL_NR_IRQS    192
>
>  typedef struct Versal {
>      /*< private >*/
> --
> 2.17.1
>
>
