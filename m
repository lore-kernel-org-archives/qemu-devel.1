Received: from eggs.gnu.org ([2001:4830:134:3::10]:44173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eK9sk-00069D-Hd
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:27:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eK9sj-00041f-Ib
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:27:02 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:45878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1eK9sj-00040p-CJ
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:27:01 -0500
Received: by mail-pf0-x244.google.com with SMTP id u19so2135972pfa.12
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 13:27:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <30f5bb618b6b5dad168658fa78387ee641370bc8.1511908159.git.alistair.francis@xilinx.com>
References: <cover.1511908159.git.alistair.francis@xilinx.com>
	<30f5bb618b6b5dad168658fa78387ee641370bc8.1511908159.git.alistair.francis@xilinx.com>
From: francisco iglesias <frasse.iglesias@gmail.com>
Date: Wed, 29 Nov 2017 22:26:59 +0100
Message-ID: <CAAYMZQt0wNHEDnFYkrVHz5y2q8AxTQ+SckZNHWdCcriJYLUzcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH-2.12 v1 1/3] xilinx_spips: Update the QSPI
 Mod ID reset value
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

> Update the reset value to match the latest ZynqMP register spec.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>



> ---
>
>  hw/ssi/xilinx_spips.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index ad1b2ba79f..899db814ee 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -355,6 +355,7 @@ static void xlnx_zynqmp_qspips_reset(DeviceState *d)
>      s->regs[R_GQSPI_RX_THRESH] = 1;
>      s->regs[R_GQSPI_GFIFO_THRESH] = 1;
>      s->regs[R_GQSPI_IMR] = GQSPI_IXR_MASK;
> +    s->regs[R_MOD_ID] = 0x01090101;
>      s->man_start_com_g = false;
>      s->gqspi_irqline = 0;
>      xlnx_zynqmp_qspips_update_ixr(s);
> --
> 2.14.1
>
>
>
