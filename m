Received: from eggs.gnu.org ([2001:4830:134:3::10]:44596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eK9tX-0007FI-VL
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:27:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eK9tX-0004Q8-0r
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:27:51 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:36431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1eK9tW-0004PH-Np
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:27:50 -0500
Received: by mail-pl0-x241.google.com with SMTP id b12so2874496plm.3
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 13:27:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ee595cb7408c5fce0f2ad6d33b721c7ae1fed283.1511908159.git.alistair.francis@xilinx.com>
References: <cover.1511908159.git.alistair.francis@xilinx.com>
	<ee595cb7408c5fce0f2ad6d33b721c7ae1fed283.1511908159.git.alistair.francis@xilinx.com>
From: francisco iglesias <frasse.iglesias@gmail.com>
Date: Wed, 29 Nov 2017 22:27:49 +0100
Message-ID: <CAAYMZQuX3qgPqgc01Bw0rieDkxs35hecCPuTg3KM1+VPv=Z9CQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH-2.12 v1 3/3] xilinx_spips: Use memset
 instead of a for loop to zero registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Edde <edgar.iglesias@gmail.com>, Alistair Francis <alistair23@gmail.com>

On 28 November 2017 at 23:31, Alistair Francis <alistair.francis@xilinx.com>
wrote:

> Use memset() instead of a for loop to zero all of the registers.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>



> ---
>
>  hw/ssi/xilinx_spips.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 1a37f9c7f5..82436e2f69 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -330,10 +330,7 @@ static void xilinx_spips_reset(DeviceState *d)
>  {
>      XilinxSPIPS *s = XILINX_SPIPS(d);
>
> -    int i;
> -    for (i = 0; i < XLNX_SPIPS_R_MAX; i++) {
> -        s->regs[i] = 0;
> -    }
> +    memset(s->regs, 0, sizeof(s->regs));
>
>      fifo8_reset(&s->rx_fifo);
>      fifo8_reset(&s->rx_fifo);
> @@ -358,13 +355,11 @@ static void xilinx_spips_reset(DeviceState *d)
>  static void xlnx_zynqmp_qspips_reset(DeviceState *d)
>  {
>      XlnxZynqMPQSPIPS *s = XLNX_ZYNQMP_QSPIPS(d);
> -    int i;
>
>      xilinx_spips_reset(d);
>
> -    for (i = 0; i < XLNX_ZYNQMP_SPIPS_R_MAX; i++) {
> -        s->regs[i] = 0;
> -    }
> +    memset(s->regs, 0, sizeof(s->regs));
> +
>      fifo8_reset(&s->rx_fifo_g);
>      fifo8_reset(&s->rx_fifo_g);
>      fifo32_reset(&s->fifo_g);
> --
> 2.14.1
>
>
>
